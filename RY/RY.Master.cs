using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using APT.UTIL;

namespace APT2012.RY
{
    public partial class RY : System.Web.UI.MasterPage
    {


        protected void Page_Load(object sender, EventArgs e)
        {
            SetHeaderText();
        }


        public string GetMenuActiveClass(string menuurl)
        {
            string cssClass = string.Empty;
            string currenturl = Request.Url.LocalPath;
            if (currenturl.ToLower().Contains(menuurl.ToLower()))
                cssClass = "current";
            return cssClass;
        }

        public void SetHeaderText()
        {
            string currenturl = Request.Url.LocalPath.ToLower();
            lblHead2.Visible = true;
            if (currenturl.Contains("index.aspx"))
            {
                lblHead1.Text = "Introduction";
                lblHead2.Visible = false;
            }
            if (currenturl.Contains("confirmdetails.aspx"))
            {
                lblHead1.Text = "Please";
                lblHead2.Text = " Confirm Your Details";
            }
            if (currenturl.Contains("contact.aspx"))
            {
                lblHead1.Text = "Contact";
                lblHead2.Text = " Us";
            }
            if (currenturl.Contains("faq.aspx"))
            {
                lblHead1.Text = "Frequently";
                lblHead2.Text = " Asked Questions";
            }
            if (currenturl.Contains("aboutthescheme.aspx"))
            {
                lblHead1.Text = "About";
                lblHead2.Text = " The Scheme";
            } if (currenturl.Contains("youroptions.aspx"))
            {
                lblHead1.Text = "Your";
                lblHead2.Text = " Options";
            }
        }

        public void ShowPopUp(string message)
        {
            System.Web.UI.ScriptManager.RegisterStartupScript(this,
                           this.GetType(),
                           Guid.NewGuid().ToString(),
                           String.Format("ShowPopUp('{0}');", message),
                           true);
        }

        protected void hlLogOut_Click(object sender, EventArgs e)
        {
            string redirectURl = Utility.GetAppSettingValue("LogOutURL");
            Response.Redirect(redirectURl);
        }
    }
}