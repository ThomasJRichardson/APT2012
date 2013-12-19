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
    public partial class PRSABenefitStatement : APTBasePage // System.Web.UI.Page
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
                    DateTime now = DateTime.Now;
                    DateTime dateJoined = new DateTime(now.Year, ms.DateJoined.Month, ms.DateJoined.Day);
                    if (ms.DateJoined.Month > now.Month)
                    {
                        dateJoined = dateJoined.AddYears(-1);
                    }
                    else if (ms.DateJoined.Month == now.Month && ms.DateJoined.Day > now.Day)
                    {
                        dateJoined = dateJoined.AddYears(-1);
                    }

                    List<ReportParameter> rp = new List<ReportParameter>();
                    rp.Add(new ReportParameter("Currency", Employer.GetCurrency(selectedEmployeeId)));
                    rp.Add(new ReportParameter("MemberId", selectedMemberId.ToString()));
                    rp.Add(new ReportParameter("StartDate", dateJoined.ToString("yyyy MMM dd")));
                    rp.Add(new ReportParameter("EndDate", DateTime.Now.ToString("yyyy MMM dd")));
                    rp.Add(new ReportParameter("isPRSA", "true"));

                    ReportViewer1.ServerReport.ReportPath = "/APT.Reports/BenefitStatement";
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
