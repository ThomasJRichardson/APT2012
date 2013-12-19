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
    public partial class PRSASORPNewBusiness : APTBasePage // System.Web.UI.Page
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

                    List<ReportParameter> rp = new List<ReportParameter>();
                    rp.Add(new ReportParameter("Currency", Employer.GetCurrency(selectedEmployeeId)));
                    rp.Add(new ReportParameter("MemberId", selectedMemberId.ToString()));
                    rp.Add(new ReportParameter("RunDate", ms.DateJoined.ToString("yyyy MMM dd")));
                    rp.Add(new ReportParameter("LastRenewalDate", ms.DateJoined.ToString("yyyy MMM dd")));
                    rp.Add(new ReportParameter("isNewBusinessSRP", "true"));

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
    }
}
