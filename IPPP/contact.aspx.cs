using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using APT.UTIL;

namespace APT2012.IPPP
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
                string message = txtMessage.Text;
                string body = Utility.GetEmailTemplate("/IPPP/Template/contactus.htm");
                body = string.Format(body, User.Identity.Name, name, email, message, Utility.GetAppSettingValue("IPPP_Options_Email_A"), Utility.GetAppSettingValue("IPPP_Options_Email_B"), Utility.GetAppSettingValue("IPPP_Options_Email_C"), Utility.GetAppSettingValue("IPPP_Options_Email_D"));

                Email objEmail = new Email();
                objEmail.EmailBody = body;
                objEmail.EmailSubject = Utility.GetAppSettingValue("IPPP_Contact_Subject");
                objEmail.EmailTo = Utility.GetAppSettingValue("IPPP_Contact_Email");
                objEmail.SendEmail();
                hdnMsg.Value = Utility.GetAppSettingValue("EmailSuccess");
            }
            catch (Exception ex)
            {
                hdnMsg.Value = "Error Occured " + ex.Message;
            }

        }
    }
}