using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using APT.UTIL;

namespace APT2012.RY
{
    public partial class youroptions : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnOptA_Click(object sender, EventArgs e)
        {
            try
            {
                string option = Utility.GetAppSettingValue("RY_Options_Email_A");
                SendMail(option);
                hdnMsg.Value = Utility.GetAppSettingValue("EmailSuccess");
            }
            catch (Exception ex)
            {
                hdnMsg.Value = "Error Message: " + ex.Message;
            }
        }

        private void SendMail(string option)
        {
            string body = Utility.GetEmailTemplate("/RY/Template/youroptions.htm");
            body = string.Format(body, User.Identity.Name, option);

            Email objEmail = new Email();
            objEmail.EmailBody = body;
            objEmail.EmailSubject = Utility.GetAppSettingValue("RY_Options_Email_Subject");
            objEmail.EmailTo = Utility.GetAppSettingValue("RY_Options_Recipient_Email");
            objEmail.SendEmail();
        }

        protected void btnOptB_Click(object sender, EventArgs e)
        {
            try
            {
                string option = Utility.GetAppSettingValue("RY_Options_Email_B");
                SendMail(option);
                hdnMsg.Value = Utility.GetAppSettingValue("EmailSuccess");
            }
            catch (Exception ex)
            {
                hdnMsg.Value = "Error Message: " + ex.Message;
            }
        }

        protected void btnOptD_Click(object sender, EventArgs e)
        {
            try
            {
                string option = Utility.GetAppSettingValue("RY_Options_Email_D");
                SendMail(option);
                hdnMsg.Value = Utility.GetAppSettingValue("EmailSuccess");
            }
            catch (Exception ex)
            {
                hdnMsg.Value = "Error Message: " + ex.Message;
            }
        }

        protected void btnOptC_Click(object sender, EventArgs e)
        {
            try
            {
                string option = Utility.GetAppSettingValue("RY_Options_Email_C");
                SendMail(option);
                hdnMsg.Value = Utility.GetAppSettingValue("EmailSuccess");
            }
            catch (Exception ex)
            {
                hdnMsg.Value = "Error Message: " + ex.Message;
            }
        }



    }
}