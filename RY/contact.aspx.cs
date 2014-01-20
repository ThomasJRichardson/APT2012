using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Net.Mail;
using System.Configuration;
using System.Web.Profile;
using APT.Model;
using System.Web.Security;
using APT.UTIL;
using System.Diagnostics;

namespace APT2012.RY
{
    public partial class contact : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void btnSendEmail_Click(object sender, EventArgs e)
        {
            try
            {
                string name = txtName.Text;
                string email = txtEmail.Text;
                string msg = txtMessage.Text;
                string body = Utility.GetEmailTemplate("/RY/Template/contactus.htm");
                body = string.Format(body, User.Identity.Name, name, email, msg);

                MailMessage message = new MailMessage();
                message.To.Add(ConfigurationManager.AppSettings["toemail"]);
                message.Subject = "Enquiry from APT (IP) Online - " + DateTime.Now.ToShortDateString();
                message.Body = body;
                message.IsBodyHtml = true;
                message.From = new MailAddress( ConfigurationManager.AppSettings["fromemail"], 
                                                ConfigurationManager.AppSettings["fromemailname"]);

                SmtpClient client = new SmtpClient(ConfigurationManager.AppSettings["smtpserver"]);
                client.Send(message);

		        hdnMsg.Value = Utility.GetAppSettingValue("EmailSuccess");
            }
            catch (Exception ex)
            {
                hdnMsg.Value = "Error Occured " + ex.Message;
            }

        }
    }
}