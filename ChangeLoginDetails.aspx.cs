using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using APT.Model;
using System.Web.Security;
using APT.UTIL;
using System.Diagnostics;

namespace APT2012
{
    public partial class ChangeLoginDetails : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (HttpContext.Current.Session["SelectedMemberId"] == null)
                {
                    return;
                }
                int selectedMemberId = (int)HttpContext.Current.Session["SelectedMemberId"];
                string selectedUserName = ASPProfile.getSelectedUserName(selectedMemberId);
                lblUsernameValue.Text = selectedUserName;
                Member member = Member.GetMemberById(selectedMemberId);
                if (member == null)
                {
                    return;
                }

                lblNameValue.Text = member.Forename + " " + member.Surname;

                if (HttpContext.Current.User.IsInRole("APT Admin") || HttpContext.Current.User.IsInRole("Scheme Admin"))
                {
                    pnlAdminChangePassword.Visible = true;
                }
                else if (HttpContext.Current.User.IsInRole("Member"))
                {
                    pnlUserChangePassword.Visible = true;
                }              

                if (selectedUserName == null)
                {
                    pnlNoUser.Visible = true;
                    pnlUserChangePassword.Visible = false;                    
                    pnlAdminChangePassword.Visible = false;
                }
            }
            catch (Exception ex)
            {
                StackTrace stackTrace = new StackTrace();
                APTLog.LogException(ex, stackTrace.GetFrame(0).GetMethod().Name, APT2012AssemblyInfo.AssemblyInfo, APT2012AssemblyInfo.SUBSYSTEM);
                //throw ex;
            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            try
            {
                lblInfo.Visible = false;
                lblInfo.ControlStyle.ForeColor = System.Drawing.Color.Green;

                if (txtPassword.Text != txtConfirmPassword.Text)
                {
                    lblInfo.Visible = true;
                    lblInfo.ControlStyle.ForeColor = System.Drawing.Color.Red;
                    lblInfo.Text = "The passwords do not match.";
                    return;
                }

                int selectedMemberId = (int)HttpContext.Current.Session["SelectedMemberId"];
                string selectedUserName = ASPProfile.getSelectedUserName(selectedMemberId);
                MembershipUser mu = Membership.GetUser(selectedUserName);
                if (mu.IsLockedOut)
                {
                    mu.UnlockUser();
                }
                string newPassword = mu.ResetPassword();
                try
                {
                    mu.ChangePassword(newPassword, txtPassword.Text);
                }
                catch (Exception ex)
                {
                    lblInfo.Visible = true;
                    lblInfo.Text = ex.Message;
                    lblInfo.ControlStyle.ForeColor = System.Drawing.Color.Red;
                    return;
                }


                lblInfo.Visible = true;
                lblInfo.ControlStyle.ForeColor = System.Drawing.Color.Green;
                lblInfo.Text = "The users password has been changed.";
            }
            catch (Exception ex)
            {
                StackTrace stackTrace = new StackTrace();
                APTLog.LogException(ex, stackTrace.GetFrame(0).GetMethod().Name, APT2012AssemblyInfo.AssemblyInfo, APT2012AssemblyInfo.SUBSYSTEM);
                //throw ex;
            }
        }

        //protected void btnSubmitUserNameChange_Click(object sender, EventArgs e)
        //{
        //    try
        //    {
        //        Boolean userNameExists = APT.Model.User.userExists(txtNewUserName.Text);
        //        if (!userNameExists)
        //        {
        //            APT.Model.User.updateUsername(lblCurrentUserNameValue.Text, txtNewUserName.Text);
        //            if (User.IsInRole("Member"))
        //            {
        //                Session.Clear();
        //                Session.Abandon();
        //                FormsAuthentication.SignOut();
        //                Response.Redirect("~/Login.aspx");
        //            }
        //            else
        //            {
        //                Response.Redirect("~/ChangeLoginDetails.aspx");
        //            }
        //        }
        //    }
        //    catch (Exception ex)
        //    {
        //        StackTrace stackTrace = new StackTrace();
        //        APTLog.LogException(ex, stackTrace.GetFrame(0).GetMethod().Name, APT2012AssemblyInfo.AssemblyInfo, APT2012AssemblyInfo.SUBSYSTEM);
        //        //throw ex;
        //    }
        //}
    }
}
