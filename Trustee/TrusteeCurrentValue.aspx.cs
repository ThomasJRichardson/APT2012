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
    public partial class TrusteeCurrentValue : APTBasePage // System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                int selectedSchemeId = (int)Session["SelectedSchemeId"];
                int selectedMemberId = (int)Session["SelectedMemberId"];
                int selectedEmployeeId = (int)Session["SelectedEmployeeId"];

                if (!IsPostBack)
                {
                    APT2012.DATES.DateManager.SetDefaultDate(calendarButtonExtender, selectedSchemeId, selectedMemberId);
                    GenerateTrusteeSchemeMembersCurrentValue(calendarButtonExtender.SelectedDate.Value);
                }
            }             
            catch (Exception ex)
            {
                StackTrace stackTrace = new StackTrace();
                APTLog.LogException(ex, stackTrace.GetFrame(0).GetMethod().Name, APT2012AssemblyInfo.AssemblyInfo, APT2012AssemblyInfo.SUBSYSTEM);
                //throw ex;
            }
        }

        private void GenerateTrusteeSchemeMembersCurrentValue(DateTime runDate)
        {

            int selectedSchemeId = (int)Session["SelectedSchemeId"];
            int selectedEmployeeId = (int)Session["SelectedEmployeeId"];


            List<ReportParameter> rp = new List<ReportParameter>();
            rp.Add(new ReportParameter("SchemeId", selectedSchemeId.ToString()));
            rp.Add(new ReportParameter("RunDate", runDate.ToShortDateString()));
            rp.Add(new ReportParameter("Currency", Employer.GetCurrency(selectedEmployeeId)));

            ReportViewer1.ServerReport.ReportPath = "/APT.Reports/TrusteeSchemeMembersCurrentValue";
            ReportViewer1.ServerReport.ReportServerUrl = new Uri(ConfigurationManager.AppSettings["ReportServerUrl"]);
            ReportViewer1.ServerReport.ReportServerCredentials = new ReportCredentials(ConfigurationManager.AppSettings["ReportServerUser"], ConfigurationManager.AppSettings["ReportServerPassword"], ConfigurationManager.AppSettings["ReportServerDomain"]);
            ReportViewer1.ServerReport.SetParameters(rp);
            ReportViewer1.ShowParameterPrompts = false;

            ReportViewer1.ServerReport.Refresh();
        }

        protected void RunDateChanged(object sender, EventArgs e)
        {
            try
            {
                GenerateTrusteeSchemeMembersCurrentValue(APT2012.DATES.DateManager.GetRunDate(txtRunDate.Text));
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
