using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using Microsoft.Reporting.WebForms;
using APT.Model;
using APT.UTIL;
using System.Diagnostics;
using APT2012.DATES;
using System.Web.Configuration;


namespace APT2012
{
    public partial class LeavingServiceOptions : APTBasePage // System.Web.UI.Page
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
                    DateManager.SetDefaultDate(calendarButtonExtender, selectedSchemeId, selectedMemberId);

                    GenerateLeavingServiceOptions(calendarButtonExtender.SelectedDate.Value, APTUtil.GetSigningName());
                }
            }
            catch (Exception ex)
            {
                StackTrace stackTrace = new StackTrace();
                APTLog.LogException(ex, stackTrace.GetFrame(0).GetMethod().Name, APT2012AssemblyInfo.AssemblyInfo, APT2012AssemblyInfo.SUBSYSTEM);
                //throw ex;
            }
        }


        private void GenerateLeavingServiceOptions(DateTime runDate, string sSigningName)
        {
            try
            {
                int selectedSchemeId = (int)Session["SelectedSchemeId"];
                int selectedMemberId = (int)Session["SelectedMemberId"];
                int selectedEmployeeId = (int)Session["SelectedEmployeeId"];

                List<ReportParameter> rp = new List<ReportParameter>();
                rp.Add(new ReportParameter("MemberId", selectedMemberId.ToString()));
                rp.Add(new ReportParameter("RunDate", runDate.ToString("yyyy MMM dd")));
                rp.Add(new ReportParameter("LetterSigningName", sSigningName));
                rp.Add(new ReportParameter("IsAPTREPORTING", "false"));
                rp.Add(new ReportParameter("DisplayAPTLogo", "True"));
                rp.Add(new ReportParameter("Currency", Employer.GetCurrency(selectedEmployeeId)));

                ReportViewer1.ServerReport.ReportPath = "/APT.Reports/LeavingServiceOptions";
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

        protected void RunDateChanged(object sender, EventArgs e)
        {
            try
            {
                GenerateLeavingServiceOptions(DateManager.GetRunDate(txtRunDate.Text), APTUtil.GetSigningName());
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


//rp.Add(new ReportParameter("LoggedInUser", User.Identity.Name));