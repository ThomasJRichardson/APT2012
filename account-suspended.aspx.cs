using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using APT.Model;
using System.Text;
using System.Diagnostics;
using APT.UTIL;
using System.Net.Mail;
using System.Configuration;

namespace APT2012
{
    public partial class account_suspended : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack)
            {
                TextBox tbAccount_id = (TextBox)Page.FindControl("account_id");
                TextBox tbEmail = (TextBox)Page.FindControl("email");
                TextBox tbPhone = (TextBox)Page.FindControl("phone");

                string username = "", email = "", phone = "";
                if (tbAccount_id != null)
                    username = tbAccount_id.Text;

                if (tbEmail != null)
                    email = tbEmail.Text;

                if (tbEmail != null)
                    phone = tbPhone.Text;

                if (account_suspended.PasswordResetRequest(username, email, phone) == true)
                {
                    Response.Redirect("~/RequestComplete.aspx");
                }
                else
                {
                    Response.Redirect("~/Account-Suspended.aspx");
                }
            }
        }

        #region reset_functionality        
        public static bool PasswordResetRequest(string sUserName, string sEmail, string sPhone)
        {
            try
            {
                string sUniqueReference = RandomString(6);
                string sGUID = System.Guid.NewGuid().ToString();

                if (sUserName.Length > 20)
                {                                    
                    return false;
                }

                string sFullName = Member.GetMemberFullName(sUserName);

                if (sFullName == null || sFullName == "")
                {
                    sFullName = "No MemberProfile";
                }
                
                if (sUserName.Length > 20 || sEmail.Length > 50 || sPhone.Length > 30)
                {                       
                    return false;
                }
                else
                {                                            
                    Member.SaveMemberPasswordResetRequest(sUniqueReference, sUserName.Trim(), sFullName, sPhone.Trim(), sEmail.Trim(), sGUID);                        
                }

                SendSubmitSuccessEmail(sFullName, sUniqueReference, sEmail, sGUID);                  
                return true;                
            }
            catch (Exception ex)
            {
                StackTrace stackTrace = new StackTrace();
                APTLog.LogException(ex, stackTrace.GetFrame(0).GetMethod().Name, APT2012AssemblyInfo.AssemblyInfo, APT2012AssemblyInfo.SUBSYSTEM);           
            }
            
            return false;
        }
        public static string RandomString(int size)
        {
            StringBuilder builder = new StringBuilder();
            Random random = new Random();
            char ch;
            for (int i = 0; i < size; i++)
            {
                ch = Convert.ToChar(Convert.ToInt32(Math.Floor(26 * random.NextDouble() + 65)));
                builder.Append(ch);
            }

            return builder.ToString();
        }
        public static bool SendSubmitSuccessEmail(string FullUserName, string sUniqueReference, string sUserEmailAddress, string sGUID)
        {
            try
            {
                if (FullUserName == "")
                    FullUserName = "APT Online Member";

                System.Text.StringBuilder sb = new System.Text.StringBuilder();
                sb.Append("<p>Dear " + FullUserName + ", </p>");
                sb.Append("<p>Thank you for contacting Allied Pensions Trustees Limited regarding your password reset request.</p>");
                sb.Append("<p>If you are unable to access your account can I ask you to please reply to confirm your postal address?</p>");
                sb.Append("<p>Once confirmed we will post out your new password.</p>");
                sb.Append("<p>Should you require prompt access please contact our internet security team at 01-2063010.</p>");                                  
                sb.Append("<p>Kind regards</p>");
                sb.Append("<p>Allied Pensions Trustees Administration team.</p>");

                MailMessage message = new MailMessage();
                message.To.Add(sUserEmailAddress);
                message.Subject = "APT Password Reset Request " + DateTime.Now.ToShortDateString();
                message.Body = sb.ToString();
                message.IsBodyHtml = true;
                message.From = new MailAddress(ConfigurationManager.AppSettings["fromemail"],
                                                ConfigurationManager.AppSettings["fromemailname"]);

                SmtpClient client = new SmtpClient(ConfigurationManager.AppSettings["smtpserver"]);
#if DEBUG
                client.Credentials = new System.Net.NetworkCredential(ConfigurationManager.AppSettings["emailUsername"],
                                                                      ConfigurationManager.AppSettings["emailPassword"]);
#endif
                client.Send(message);

                return true;
            }
            catch (Exception ex)
            {
                StackTrace stackTrace = new StackTrace();
                APTLog.LogException(ex, stackTrace.GetFrame(0).GetMethod().Name, APT2012AssemblyInfo.AssemblyInfo, APT2012AssemblyInfo.SUBSYSTEM);
            }
            return false;
        }
        #endregion
    }
}