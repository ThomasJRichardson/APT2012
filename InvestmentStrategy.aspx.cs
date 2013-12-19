using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using APT.Model;
using System.Web.Caching;
using System.Net.Mail;
using System.Configuration;
using System.Drawing;
using System.Web.Profile;
using System.Web.Security;
using APT.UTIL;
using System.Diagnostics;

namespace APT2012
{
    public partial class InvestmentStrategy : APTBasePage // System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            { 
                pnlInfo.Visible = false;
                pnlInfo2.Visible = false;

                if (!IsPostBack)
                {
                    int memberId = -1;
                    if (HttpContext.Current.Session["SelectedSchemeId"] != null)
                        memberId = (int)HttpContext.Current.Session["SelectedMemberId"];
                    int schemeId = -1;
                    if (HttpContext.Current.Session["SelectedSchemeId"] != null)
                        schemeId = (int)HttpContext.Current.Session["SelectedSchemeId"];
                    int employeeId = -1;
                    if (HttpContext.Current.Session["SelectedEmployeeId"] != null)
                        employeeId = (int)HttpContext.Current.Session["SelectedEmployeeId"];

                    if (!(memberId == -1 || employeeId == -1 || employeeId == -1))
                    {
                        IEnumerable<ContributionAllocation> contributionAllocations = Fund.GetContributionInvestment(memberId, employeeId);
                        gvContributionInvestment.DataSource = contributionAllocations;
                        gvContributionInvestment.DataBind();

                        if (contributionAllocations.Count() > 0)
                        {
                            if (contributionAllocations.FirstOrDefault().IsFixedInvestmentAllocation == true)
                            {
                                btnSubmitContributionInvestment.Enabled = false;
                            }
                        }

                        gvAccumulatedAssets.DataSource = Fund.GetAccumulatedAssets(memberId, schemeId);
                        gvAccumulatedAssets.DataBind();
                    }
                    Benefit b = Benefit.GetDetails(memberId);

                    if (b.HasLifestyleOption != null)
                    {
                        pnlLifestyle.Visible = true;
                        string inLifestyleOption = Member.GetInLifestyleOption(memberId);
                        if (inLifestyleOption != "0")
                        {
                            //Member in Lifestyle strategy, select relevant radio button and display message
                            radLifestyle.Items[0].Selected = true;
                            hdnOriginalLifestyleOption.Value = "1";
                            pnlLifestyleMessage.Visible = true;
                            btnSubmitAccumulatedAssets.Enabled = false;
                            btnSubmitContributionInvestment.Enabled = false;
                            //gvContributionInvestment.Enabled = false;
                            //gvAccumulatedAssets.Enabled = false;
                        }
                        else
                        {
                            radLifestyle.Items[1].Selected = true;
                            hdnOriginalLifestyleOption.Value = "0";
                            btnSubmitAccumulatedAssets.Enabled = true;
                            btnSubmitContributionInvestment.Enabled = true;
                        }
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

        protected void btnSubmitContributionInvestment_Click(object sender, EventArgs e)
        {
            try
            {
                double tot = 0;
                for (int i = 0; i < gvContributionInvestment.Rows.Count; i++)
                {
                    TextBox tb = (TextBox)gvContributionInvestment.Rows[i].FindControl("txtContributionInvestment");
                    if (!tb.Text.Equals(""))
                    {
                        try
                        {
                            tot = tot + double.Parse(tb.Text);
                        }
                        catch
                        {
                            lblInfo.Text = "You may only enter numbers.";
                            pnlInfo.CssClass = "panel-error";
                            pnlInfo.Visible = true;
                        }
                    }
                }

                bool isUserEmailEmpty;
                bool isAdmin;
                string[] roles;
                string selectedUserName = ASPProfile.getSelectedUserName((int)HttpContext.Current.Session["SelectedMemberId"]);
                bool isWebsiteEmailBoxEmpty = string.IsNullOrEmpty(txtEmailAddress.Text);

                roles = Roles.GetAllRoles();

                if (selectedUserName == null)
                {
                    isUserEmailEmpty = true;
                }
                else
                {
                    isUserEmailEmpty = string.IsNullOrEmpty(Membership.GetUser(selectedUserName).Email);
                }


                if (roles.Contains("HR Admin") || roles.Contains("Scheme Admin"))
                {
                    isAdmin = true;
                }
                else
                {
                    isAdmin = false;
                }


                if (tot == 100)
                {

                    if (isUserEmailEmpty && isWebsiteEmailBoxEmpty)
                    {
                        lblEmail.Text = "The system does not currently contain your email address. Please enter your address and re-submit.";
                        lblEmail.Visible = true;
                        txtEmailAddress.Visible = true;
                    }
                    else
                    {
                        string email = "";

                        if (!isWebsiteEmailBoxEmpty && !isAdmin)
                        {
                            // no email and is not admin
                            MembershipUser mu = Membership.GetUser(selectedUserName);
                            mu.Email = txtEmailAddress.Text;
                            Membership.UpdateUser(mu);
                            email = txtEmailAddress.Text;
                        }
                        else if (isWebsiteEmailBoxEmpty)
                        {
                            // has email and is admin
                            email = Membership.GetUser(selectedUserName).Email;
                        }
                        else if (!isWebsiteEmailBoxEmpty && isAdmin)
                        {
                            // no email and is admin
                            email = txtEmailAddress.Text;
                        }


                        lblInfo.Text = "Your change has been submitted. An email has been sent to your address \"" + email + "\"";
                        pnlInfo.CssClass = "panel-info";
                        pnlInfo.Visible = true;
                        Member mem = Member.GetMemberById(Convert.ToInt32(Session["SelectedMemberId"]));
                        Scheme sch = Scheme.GetSchemeDetails(Convert.ToInt32(Session["SelectedSchemeId"]));

                        System.Text.StringBuilder sb = new System.Text.StringBuilder();

                        sb.Append("<p><b>The following change request was submitted by " + User.Identity.Name + ".</b></p><hr/>");
                        sb.Append("<table border='1' cellspacing='0' cellpadding='3' width='90%'><tr><td width='110px'>Member Name:</td><td>" + mem.Forename + " " + mem.Surname + "</td></tr>");
                        sb.Append("<tr><td width='110px'>PPS:</td><td>" + mem.PPSN + "</td></tr>");
                        sb.Append("<tr><td width='110px'>Scheme:</td><td>" + sch.Description + "</td></tr></table><hr/>");

                        sb.Append("<table border='1' cellspacing='0' cellpadding='3' width='90%'>");
                        sb.Append("<tr><td>Fund</td><td>Old Percentage</td><td>New Percentage</td></tr>");
                        for (int z = 0; z < gvContributionInvestment.Rows.Count; z++)
                        {
                            TextBox tb = (TextBox)gvContributionInvestment.Rows[z].FindControl("txtContributionInvestment");
                            sb.Append("<tr><td>" + gvContributionInvestment.Rows[z].Cells[0].Text + "</td>");
                            sb.Append("<td>" + gvContributionInvestment.Rows[z].Cells[1].Text + "</td>");
                            sb.Append("<td>" + tb.Text + "</td></tr>");
                        }
                        sb.Append("</table>");
                        sendMail("Contribution Investment", sb.ToString(), email);

                        lblEmail.Text = "";
                        lblEmail.Visible = false;
                        txtEmailAddress.Visible = false;
                        txtEmailAddress.Text = "";
                    }

                }
                else
                {
                    lblInfo.Text = "Values must total to 100%.";
                    pnlInfo.CssClass = "panel-error";
                    pnlInfo.Visible = true;
                }
            }
            catch (Exception ex)
            {
                StackTrace stackTrace = new StackTrace();
                APTLog.LogException(ex, stackTrace.GetFrame(0).GetMethod().Name, APT2012AssemblyInfo.AssemblyInfo, APT2012AssemblyInfo.SUBSYSTEM);
                //throw ex;
            }
        }

        protected void btnSubmitAccumulatedAssets_Click(object sender, EventArgs e)
        {
            try
            {
                double tot = 0;
                for (int i = 0; i < gvAccumulatedAssets.Rows.Count; i++)
                {
                    TextBox tb = (TextBox)gvAccumulatedAssets.Rows[i].FindControl("txtAccumulatedAssets");
                    if (!tb.Text.Equals(""))
                    {
                        try
                        {
                            tot = tot + double.Parse(tb.Text);
                        }
                        catch
                        {
                            lblInfo2.Text = "You may only enter numbers.";
                            pnlInfo2.CssClass = "panel-error";
                            pnlInfo2.Visible = true;
                        }
                    }
                }

                bool isUserEmailEmpty;
                bool isAdmin;
                string[] roles;
                string selectedUserName = ASPProfile.getSelectedUserName((int)HttpContext.Current.Session["SelectedMemberId"]);
                bool isWebsiteEmailBoxEmpty = string.IsNullOrEmpty(txtAccuEmailAddress.Text);

                roles = Roles.GetAllRoles();

                if (selectedUserName == null)
                {
                    isUserEmailEmpty = true;
                }
                else
                {
                    isUserEmailEmpty = string.IsNullOrEmpty(Membership.GetUser(selectedUserName).Email);
                }


                if (roles.Contains("HR Admin") || roles.Contains("Scheme Admin"))
                {
                    isAdmin = true;
                }
                else
                {
                    isAdmin = false;
                }


                if (tot == 100)
                {

                    if (isUserEmailEmpty && isWebsiteEmailBoxEmpty)
                    {
                        lblAccuEmail.Text = "The system does not currently contain your email address. Please enter your address and re-submit.";
                        lblAccuEmail.Visible = true;
                        txtAccuEmailAddress.Visible = true;
                    }
                    else
                    {
                        string email = "";

                        if (!isWebsiteEmailBoxEmpty && !isAdmin)
                        {
                            // no email and is not admin
                            MembershipUser mu = Membership.GetUser(selectedUserName);
                            mu.Email = txtAccuEmailAddress.Text;
                            Membership.UpdateUser(mu);
                            email = txtAccuEmailAddress.Text;
                        }
                        else if (isWebsiteEmailBoxEmpty)
                        {
                            // has email and is admin
                            email = Membership.GetUser(selectedUserName).Email;
                        }
                        else if (!isWebsiteEmailBoxEmpty && isAdmin)
                        {
                            // no email and is admin
                            email = txtAccuEmailAddress.Text;
                        }


                        lblInfo2.Text = "Your change has been submitted. An email has been sent to your address \"" + email + "\"";
                        pnlInfo2.CssClass = "panel-info";
                        pnlInfo2.Visible = true;

                        Member mem = Member.GetMemberById(Convert.ToInt32(Session["SelectedMemberId"]));
                        Scheme sch = Scheme.GetSchemeDetails(Convert.ToInt32(Session["SelectedSchemeId"]));

                        System.Text.StringBuilder sb = new System.Text.StringBuilder();

                        sb.Append("<p><b>The following change request was submitted by " + User.Identity.Name + ".</b></p><hr/>");
                        sb.Append("<table border='1' cellspacing='0' cellpadding='3' width='90%'><tr><td width='110px'>Member Name:</td><td>" + mem.Forename + " " + mem.Surname + "</td></tr>");
                        sb.Append("<tr><td width='110px'>PPS:</td><td>" + mem.PPSN + "</td></tr>");
                        sb.Append("<tr><td width='110px'>Scheme:</td><td>" + sch.Description + "</td></tr></table><hr/>");

                        sb.Append("<table border='1' cellspacing='0' cellpadding='3' width='90%'>");
                        sb.Append("<tr><td>Fund</td><td>Old Percentage</td><td>New Percentage</td></tr>");

                        for (int z = 0; z < gvAccumulatedAssets.Rows.Count; z++)
                        {
                            TextBox tb = (TextBox)gvAccumulatedAssets.Rows[z].FindControl("txtAccumulatedAssets");
                            sb.Append("<tr><td>" + gvAccumulatedAssets.Rows[z].Cells[0].Text + "</td>");
                            sb.Append("<td>" + gvAccumulatedAssets.Rows[z].Cells[2].Text + "</td>");
                            sb.Append("<td>" + tb.Text + "</td></tr>");
                        }
                        sb.Append("</table>");
                        sendMail("Accumulated Strategy", sb.ToString(), email);

                        lblAccuEmail.Text = "";
                        lblAccuEmail.Visible = false;
                        txtAccuEmailAddress.Visible = false;
                        txtAccuEmailAddress.Text = "";
                    }
                }
                else
                {
                    lblInfo2.Text = "Values must total to 100%.";
                    pnlInfo2.CssClass = "panel-error";
                    pnlInfo2.Visible = true;
                }
            }
            catch (Exception ex)
            {
                StackTrace stackTrace = new StackTrace();
                APTLog.LogException(ex, stackTrace.GetFrame(0).GetMethod().Name, APT2012AssemblyInfo.AssemblyInfo, APT2012AssemblyInfo.SUBSYSTEM);
                //throw ex;
            }
        }

        protected void sendMail(string subject, string body, string email)
        {
            try
            {
                // TODO remove comemnted code
                //string selectedUserName = ASPProfile.getSelectedUserName((int)HttpContext.Current.Session["SelectedMemberId"]);
                //string userEmail = Membership.GetUser(selectedUserName).Email;

                string userEmail = email;

                MailMessage message = new MailMessage();
                message.To.Add(ConfigurationManager.AppSettings["toemail"]);
                message.Subject = "Investment Strategy Change Request - " + subject + " - " + DateTime.Now.ToShortDateString();
                message.Body = body;
                message.IsBodyHtml = true;
                message.CC.Add(userEmail);
                message.Headers.Add("Reply-To", userEmail);
                message.From = new MailAddress(ConfigurationManager.AppSettings["fromemail"], ConfigurationManager.AppSettings["fromemailname"]);
                SmtpClient client = new SmtpClient(ConfigurationManager.AppSettings["smtpserver"]);
                client.Send(message);
            }
            catch (Exception ex)
            {
                StackTrace stackTrace = new StackTrace();
                APTLog.LogException(ex, stackTrace.GetFrame(0).GetMethod().Name, APT2012AssemblyInfo.AssemblyInfo, APT2012AssemblyInfo.SUBSYSTEM);
                //throw ex;
            }
        }

        protected void btnSubmitLifestyleChange_Click(object sender, EventArgs e)
        {
            try
            {
                bool isUserEmailEmpty;
                bool isAdmin;
                string[] roles;
                string selectedUserName = ASPProfile.getSelectedUserName((int)HttpContext.Current.Session["SelectedMemberId"]);
                bool isWebsiteEmailBoxEmpty = string.IsNullOrEmpty(txtLifeEmailAddress.Text);

                roles = Roles.GetAllRoles();

                if (selectedUserName == null)
                {
                    isUserEmailEmpty = true;
                }
                else
                {
                    isUserEmailEmpty = string.IsNullOrEmpty(Membership.GetUser(selectedUserName).Email);
                }


                if (roles.Contains("HR Admin") || roles.Contains("Scheme Admin"))
                {
                    isAdmin = true;
                }
                else
                {
                    isAdmin = false;
                }


                if (isUserEmailEmpty && isWebsiteEmailBoxEmpty)
                {
                    lblLifeEmail.Text = "The system does not currently contain your email address. Please enter your address and re-submit.";
                    lblLifeEmail.Visible = true;
                    txtLifeEmailAddress.Visible = true;
                }
                else
                {
                    string email = "";

                    if (!isWebsiteEmailBoxEmpty && !isAdmin)
                    {
                        // no email and is not admin
                        MembershipUser mu = Membership.GetUser(selectedUserName);
                        mu.Email = txtLifeEmailAddress.Text;
                        Membership.UpdateUser(mu);
                        email = txtLifeEmailAddress.Text;
                    }
                    else if (isWebsiteEmailBoxEmpty)
                    {
                        // has email and is admin
                        email = Membership.GetUser(selectedUserName).Email;
                    }
                    else if (!isWebsiteEmailBoxEmpty && isAdmin)
                    {
                        // no email and is admin
                        email = txtLifeEmailAddress.Text;
                    }

                    lblInfo3.Text = "Your change has been submitted. (Note: this will take up to 3 working days to process.) An email has been sent to your address \"" + email + "\"";
                    pnlInfo3.CssClass = "panel-info";
                    pnlInfo3.Visible = true;

                    Member mem = Member.GetMemberById(Convert.ToInt32(Session["SelectedMemberId"]));
                    Scheme sch = Scheme.GetSchemeDetails(Convert.ToInt32(Session["SelectedSchemeId"]));

                    string strSelectedStrategy;
                    if (radLifestyle.SelectedValue.ToString() == "0")
                    {
                        strSelectedStrategy = "Standard Profile";
                    }
                    else
                    {
                        strSelectedStrategy = "Lifestyle Profile";
                    }
                    System.Text.StringBuilder sb = new System.Text.StringBuilder();

                    sb.Append("<p><b>The following change request was submitted by " + User.Identity.Name + ".</b></p><hr/>");
                    sb.Append("<table border='1' cellspacing='0' cellpadding='3' width='90%'><tr><td width='110px'>Member Name:</td><td>" + mem.Forename + " " + mem.Surname + "</td></tr>");
                    sb.Append("<tr><td width='110px'>PPS:</td><td>" + mem.PPSN + "</td></tr>");
                    sb.Append("<tr><td width='110px'>Scheme:</td><td>" + sch.Description + "</td></tr></table><hr/>");

                    sb.Append("<table border='1' cellspacing='0' cellpadding='3' width='90%'>");
                    sb.Append("<tr><td>" + mem.Forename + " " + mem.Surname + "  has opted to change their Investment strategy to a " + strSelectedStrategy + " strategy.</td></tr>");
                    sb.Append("</table>");
                    sendMail("Lifestyle Strategy", sb.ToString(), email);
                    //btnSubmitLifestyleChange.Visible = false;

                    lblLifeEmail.Text = "";
                    lblLifeEmail.Visible = false;
                    txtLifeEmailAddress.Visible = false;
                    txtLifeEmailAddress.Text = "";
                }
            }
            catch (Exception ex)
            {
                StackTrace stackTrace = new StackTrace();
                APTLog.LogException(ex, stackTrace.GetFrame(0).GetMethod().Name, APT2012AssemblyInfo.AssemblyInfo, APT2012AssemblyInfo.SUBSYSTEM);
                //throw ex;
            }
        }

        protected void radLifestyle_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void gvAccumulatedAssets_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            try
            {
                if (e.Row.RowType == DataControlRowType.DataRow)
                {
                    bool froozen =
                     Convert.ToBoolean(DataBinder.Eval(e.Row.DataItem,
                     "IsFroozen"));
                    if (froozen == true)
                    {
                        //e.Row.Attributes.Add("class", "read-only");
                        foreach (TableCell item in e.Row.Cells)
                        {
                            item.Attributes.Add("class", "read-only");
                        }
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

        protected void gvContributionInvestment_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            try
            {
                if (e.Row.RowType == DataControlRowType.DataRow)
                {
                    bool fixedInvestment = Convert.ToBoolean(DataBinder.Eval(e.Row.DataItem, "IsFixedInvestmentAllocation"));
                    if (fixedInvestment == true)
                    {
                        //e.Row.Attributes.Add("class", "read-only");
                        foreach (TableCell item in e.Row.Cells)
                        {
                            item.Attributes.Add("class", "read-only");
                        }
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
