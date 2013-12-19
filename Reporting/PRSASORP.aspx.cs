using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.Reporting.WebForms;
using System.Configuration;
using APT.Model;
using APT.UTIL;
using System.Diagnostics;

namespace APT2012
{
    public partial class PRSASORP : APTBasePage // System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (!IsPostBack)
                {
                    int selectedSchemeId = (int)Session["SelectedSchemeId"];
                    int selectedMemberId = (int)Session["SelectedMemberId"];
                    int selectedEmployeeId = (int)Session["SelectedEmployeeId"];

                    MemberScheme ms = MemberScheme.GetMemberSchemeDetails(selectedMemberId, selectedSchemeId);
                    DateTime dateJoined = new DateTime();
                    DateTime now = DateTime.Now;

                    int i = 0;
                    while (ms.DateJoined.AddYears(i) <= now)
                    {
                        ddlYear.Items.Insert(0, ms.DateJoined.AddYears(i).Year.ToString());
                        i++;
                    }
                    if (i <= 1)
                    {
                        ddlYear.Visible = false;
                        lblYear.Visible = false;
                        dateJoined = ms.DateJoined;
                    }
                    else
                    {
                        ddlYear.SelectedIndex = 0;
                        dateJoined = new DateTime(Convert.ToInt32(ddlYear.SelectedValue), ms.DateJoined.Month, ms.DateJoined.Day);
                    }

                    List<ReportParameter> rp = new List<ReportParameter>();
                    rp.Add(new ReportParameter("Currency", Employer.GetCurrency(selectedEmployeeId)));
                    rp.Add(new ReportParameter("MemberId", selectedMemberId.ToString()));
                    rp.Add(new ReportParameter("RunDate", dateJoined.ToString("yyyy MMM dd")));
                    rp.Add(new ReportParameter("LastRenewalDate", dateJoined.ToString("yyyy MMM dd")));
                    rp.Add(new ReportParameter("isNewBusinessSRP", "false"));

                    ReportViewer1.ServerReport.ReportPath = "/APT.Reports/PRSASORP";
                    ReportViewer1.ServerReport.ReportServerUrl = new Uri(ConfigurationManager.AppSettings["ReportServerUrl"]);
                    ReportViewer1.ServerReport.ReportServerCredentials = new ReportCredentials(ConfigurationManager.AppSettings["ReportServerUser"], ConfigurationManager.AppSettings["ReportServerPassword"], ConfigurationManager.AppSettings["ReportServerDomain"]);
                    ReportViewer1.ServerReport.SetParameters(rp);
                    ReportViewer1.ShowParameterPrompts = false;
                    ReportViewer1.ServerReport.Refresh();
                }
            }
            catch (Exception ex)
            {
                StackTrace stackTrace = new StackTrace();
                APTLog.LogException(ex, stackTrace.GetFrame(0).GetMethod().Name, APT2012AssemblyInfo.AssemblyInfo, APT2012AssemblyInfo.SUBSYSTEM);
                //throw ex;
            }
        }

        protected void ddlYear_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                int selectedSchemeId = (int)Session["SelectedSchemeId"];
                int selectedMemberId = (int)Session["SelectedMemberId"];
                int selectedEmployeeId = (int)Session["SelectedEmployeeId"];

                MemberScheme ms = MemberScheme.GetMemberSchemeDetails(selectedMemberId, selectedSchemeId);
                DateTime runDate = new DateTime(Convert.ToInt32(ddlYear.SelectedValue), ms.DateJoined.Month, ms.DateJoined.Day);

                List<ReportParameter> rp = new List<ReportParameter>();
                rp.Add(new ReportParameter("Currency", Employer.GetCurrency(selectedEmployeeId)));
                rp.Add(new ReportParameter("MemberId", selectedMemberId.ToString()));
                rp.Add(new ReportParameter("RunDate", runDate.ToString("yyyy MMM dd")));
                rp.Add(new ReportParameter("LastRenewalDate", runDate.ToString("yyyy MMM dd")));
                rp.Add(new ReportParameter("isNewBusinessSRP", "false"));

                ReportViewer1.ServerReport.ReportPath = "/APT.Reports/PRSASORP";
                ReportViewer1.ServerReport.ReportServerUrl = new Uri(ConfigurationManager.AppSettings["ReportServerUrl"]);
                ReportViewer1.ServerReport.ReportServerCredentials = new ReportCredentials(ConfigurationManager.AppSettings["ReportServerUser"], ConfigurationManager.AppSettings["ReportServerPassword"], ConfigurationManager.AppSettings["ReportServerDomain"]);
                ReportViewer1.ServerReport.SetParameters(rp);
                ReportViewer1.ShowParameterPrompts = false;
                ReportViewer1.ServerReport.Refresh();
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
