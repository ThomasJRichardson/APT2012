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

namespace APT2012
{
    public partial class ContactUs : APTBasePage //System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (!IsPostBack)
                {
                    Member member = Member.GetMemberById(Convert.ToInt32(Session["SelectedMemberId"]));
                    //if (member != null)
                    //{
                    //    lblName.Text = member.Forename + " " + member.Surname;
                    //}
                    MembershipUser mu = Membership.GetUser(User.Identity.Name);

                    ProfileBase userProfile = ProfileBase.Create(User.Identity.Name);

                    lblFax.Text = userProfile.GetPropertyValue("Fax").ToString();
                    lblHome.Text = userProfile.GetPropertyValue("PhoneHome").ToString();
                    lblEmail.Text = mu.Email;
                    lblMobile.Text = userProfile.GetPropertyValue("PhoneMobile").ToString();
                    lblOffice.Text = userProfile.GetPropertyValue("PhoneOffice").ToString();
                    lblPrefContact.Text = userProfile.GetPropertyValue("ContactMethod").ToString();
                    lblName.Text = userProfile.GetPropertyValue("FirstName").ToString() + " " + userProfile.GetPropertyValue("LastName").ToString();
                }
            }
            catch (Exception ex)
            {
                StackTrace stackTrace = new StackTrace();
                APTLog.LogException(ex, stackTrace.GetFrame(0).GetMethod().Name, APT2012AssemblyInfo.AssemblyInfo, APT2012AssemblyInfo.SUBSYSTEM);
                //throw ex;
            }
        }

        protected void btnSend_Click(object sender, EventArgs e)
        {
            try
            {
                System.Text.StringBuilder sb = new System.Text.StringBuilder();
                sb.Append("<p>The following form was submitted from APT Online.</p>");
                sb.Append("<table cellspacing=0 cellpadding=3 border=1 width=90%>");
                sb.Append("<tr><td>" + "Logged In User:        " + "</td><td>" + User.Identity.Name + "</td></tr>");
                sb.Append("<tr><td>" + "From:        " + "</td><td>" + lblName.Text + "</td></tr>");
                sb.Append("<tr><td>" + "Email:       " + "</td><td>" + lblEmail.Text + "</td></tr>");
                sb.Append("<tr><td>" + "Home:        " + "</td><td>" + lblHome.Text + "</td></tr>");
                sb.Append("<tr><td>" + "Office:      " + "</td><td>" + lblOffice.Text + "</td></tr>");
                sb.Append("<tr><td>" + "Mobile:      " + "</td><td>" + lblMobile.Text + "</td></tr>");
                sb.Append("<tr><td>" + "Fax:         " + "</td><td>" + lblFax.Text + "</td></tr>");
                sb.Append("<tr><td>" + "Contact via: " + "</td><td>" + lblPrefContact.Text + "</td></tr>");
                sb.Append("<tr><td>" + "Topic:       " + "</td><td>" + ddlTopic.SelectedValue + "</td></tr>");
                sb.Append("<tr><td>" + "Comments:    " + "</td><td>" + txtQuery.Text + "</td></tr>");
                sb.Append("</table>");

                MailMessage message = new MailMessage();
                message.To.Add(ConfigurationManager.AppSettings["toemail"]);
                message.Subject = "Enquiry from APT Online - " + DateTime.Now.ToShortDateString();
                message.Body = sb.ToString();
                message.IsBodyHtml = true;
                message.From = new MailAddress( ConfigurationManager.AppSettings["fromemail"], 
                                                ConfigurationManager.AppSettings["fromemailname"]);

                SmtpClient client = new SmtpClient(ConfigurationManager.AppSettings["smtpserver"]);
#if DEBUG
                client.Credentials = new System.Net.NetworkCredential(ConfigurationManager.AppSettings["emailUsername"], 
                                                                      ConfigurationManager.AppSettings["emailPassword"]);
#endif
                client.Send(message);
               

                ddlTopic.SelectedIndex = 0;
                txtQuery.Text = "";

                pnlInfo.Visible = true;
                lblInfo.Text = "Your message has been successfully sent to our administrators.";
            }
            catch (Exception ex)
            {
                StackTrace stackTrace = new StackTrace();
                APTLog.LogException(ex, stackTrace.GetFrame(0).GetMethod().Name, APT2012AssemblyInfo.AssemblyInfo, APT2012AssemblyInfo.SUBSYSTEM);
             
                pnlInfo.Visible = true;
                pnlInfo.CssClass = "panel-error";
                lblInfo.Text = "There was a problem sending your message.  Please contact APT by phone on: (01) 2063010";
            }
        }
    }
}
