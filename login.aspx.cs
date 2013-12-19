using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;
using System.Web.Profile;
using APT.Model;
using System.Data.Objects;
using APT.UTIL;
using System.Diagnostics;
using System.Net.Mail;
using System.Configuration;
using System.Text;

namespace APT2012
{
    public partial class login : APTBasePage //System.Web.UI.Page
    {
        private void RememberUserDetails(string sUserName, string sPassword)
        {
            CheckBox chkBox = (CheckBox)Page.FindControl("chbxRememberMe");
            if (chkBox.Checked == true)
            {
                Response.Cookies["UName"].Value = sUserName;
                Response.Cookies["PWD"].Value = sPassword;
                Response.Cookies["UName"].Expires = DateTime.Now.AddMonths(2);
                Response.Cookies["PWD"].Expires = DateTime.Now.AddMonths(2);
            }
            else
            {
                Response.Cookies["UName"].Expires = DateTime.Now.AddMonths(-1);
                Response.Cookies["PWD"].Expires = DateTime.Now.AddMonths(-1);
            }
        }

        protected void Page_Init(object sender, EventArgs e)
        {
            //string username = "", password = "";
            TextBox tbAccount_id = (TextBox)Page.FindControl("account_id");
            TextBox tbPassword = (TextBox)Page.FindControl("password");
            CheckBox chkBox = (CheckBox)Page.FindControl("chbxRememberMe");

            if (!IsPostBack)
            {
                if (Request.Cookies["UName"] != null)
                    tbAccount_id.Text = Request.Cookies["UName"].Value;

                if (Request.Cookies["PWD"] != null)
                    tbPassword.Attributes.Add("value", Request.Cookies["PWD"].Value);

                if (Request.Cookies["UName"] != null && Request.Cookies["PWD"] != null)
                {
                    chkBox.Checked = true;
                }
                else
                {
                    chkBox.Checked = false;
                }
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            string eventTarget = (this.Request["__EVENTTARGET"] == null ? string.Empty : this.Request["__EVENTTARGET"]);
            string eventArgument = (this.Request["__EVENTARGUMENT"] == null ? string.Empty : this.Request["__EVENTARGUMENT"]);

            string username = "", password = "";
            TextBox tbAccount_id = (TextBox)Page.FindControl("account_id");
            TextBox tbPassword = (TextBox)Page.FindControl("password");
            CheckBox chkBox = (CheckBox)Page.FindControl("chbxRememberMe");
           
            if (IsPostBack)
            {
                if (tbAccount_id != null)
                    username = tbAccount_id.Text;

                if (password != null)
                    password = tbPassword.Text;

                if (username != null && username != "" && password != null && password != "")
                {
                    Login_Authenticate(username, password);
                }

                // Redirect will have occured or else the login will have failed for the user. 
                Panel loginresults = (Panel)Page.FindControl("APTLoginResult");
                loginresults.Visible = true;               
            }
            else
            {
                // Redirect will have occured or else the login will have failed for the user. 
                Panel loginresults = (Panel)Page.FindControl("APTLoginResult");
                loginresults.Visible = false;
            }
        }

        private bool ValidateRole(string LoginUserName)
        {
            string[] roles;
            //If this is a member, check that the member record exists in the Member table
            roles = Roles.GetRolesForUser(LoginUserName);

            bool bRolesAuthenticated = false;

            if (roles[0] == "Member")
            {
                return Member.MemberExists(LoginUserName);                 
            }
            else if (roles[0] == "Scheme Admin" )
            {
                if (Scheme.FirstSchemeForUser(LoginUserName) == null)
                {
                    APTLog.LogMessage("Login failed: No schemes have been defined for this user; UserName=" + LoginUserName);
                    return false;
                }
                else
                {
                    return true;
                }
            }
            else
            {
                bRolesAuthenticated = true;
            }

            // Check for other roles. 
            return bRolesAuthenticated;
        }

        private void LoginFailed(string LoginUserName)
        {            
            APTLog.LogMessage("WARNING: User=" + LoginUserName + " FAILED Validation!");

            Session["AlreadyAuthenticated"] = false; 

            Panel loginresults = (Panel)Page.FindControl("APTLoginResult");
            loginresults.Visible = true;

            // Track the number of login attempts
            int loginCount = (int)Session["LoginCount"];
            loginCount += 1;
            Session["LoginCount"] = loginCount;

            TextBox txtAccount_id = (TextBox)Page.FindControl("account_id");
            txtAccount_id.Text = "";

            TextBox txtpassword = (TextBox)Page.FindControl("password");
            txtpassword.Attributes["Value"] = "";
            txtpassword.TextMode = TextBoxMode.Password;

            CheckBox chkBox = (CheckBox)Page.FindControl("chbxRememberMe");
            chkBox.Checked = false;
        }

        protected void Login_Authenticate(string LoginUserName, string LoginPassword)
        {          
            try
            {              
                int maxLoginAttempts = (int)Session["MaxLoginAttempts"];
                
                if (Member.IsValidUserName(LoginUserName) == false)
                {                                      
                    LoginFailed(LoginUserName);           
                }
                else
                {
                     // Member session exceed or member locked out. 
                    if (Member.IsMemberLockedOut(LoginUserName) || ValidateRole(LoginUserName) == false ||
                        Session["LoginCount"].Equals(maxLoginAttempts))
                    {
                        APTLog.LogMessage("WARNING: LOGIN FAILED 3 times FOR User=" + LoginUserName + " - ACCOUNT SUSPENDED.");

                        Member.LockUnlockMemberUserAccount(LoginUserName, true);
                        Session["LoginCount"] = 0;

                        Response.Redirect("~/Account-Suspended.aspx");
                        return;
                    }

                    if (Membership.ValidateUser(LoginUserName, LoginPassword))
                    {
                        RememberUserDetails(LoginUserName, LoginPassword);

                        ASPProfile.UpdateLastLogonDate(LoginUserName, DateTime.Now);
                        UserLogonHistory.Add(APT.Model.User.GetUserId(LoginUserName), DateTime.Now);

                        Session["LoginUserName"] = LoginUserName;
                        Session["AlreadyAuthenticated"] = true;

                        Global.setSessionContext(LoginUserName);

                        // Success, create non-persistent authentication cookie.
                        FormsAuthentication.SetAuthCookie(LoginUserName, false);

                        APTLog.LogMessage("INFO: User=" + LoginUserName + " SUCCESSFULLY Validated!");

                        Response.Redirect("~/Default.aspx", false);
                        return;
                    }
                    else
                    {
                        LoginFailed(LoginUserName);                         
                    }
                }                                
            }
            catch (Exception ex)
            {
                StackTrace stackTrace = new StackTrace();
                APTLog.LogException(ex, stackTrace.GetFrame(0).GetMethod().Name, APT2012AssemblyInfo.AssemblyInfo, APT2012AssemblyInfo.SUBSYSTEM);
                //throw ex;
            }
        }
    }
}



//if (Session["AlreadyAuthenticated"] != null)
//{
//    Session.Remove("AlreadyAuthenticated");
//}