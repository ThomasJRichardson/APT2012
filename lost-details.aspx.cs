using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace APT2012
{
    public partial class lost_details : System.Web.UI.Page
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
    }
}