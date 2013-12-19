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

namespace APT2012
{
    public partial class ContributionSchedule : APTBasePage // System.Web.UI.Page
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

                    // eg. Lund 01/12/2011
                    DateTime schemeRenewalDate = MemberModelViewReporting.GetSchemeLastRenewalDate(selectedSchemeId, selectedMemberId);

                    // eg. Lund 01/12/2010
                    DateTime previousRenewalDate = schemeRenewalDate.AddYears(-1);

                    GenerateContributionSchedule(calendarButtonExtender.SelectedDate.Value, previousRenewalDate);
                }
            }
            catch (Exception ex)
            {
                StackTrace stackTrace = new StackTrace();
                APTLog.LogException(ex, stackTrace.GetFrame(0).GetMethod().Name, APT2012AssemblyInfo.AssemblyInfo, APT2012AssemblyInfo.SUBSYSTEM);
                //throw ex;
            }
        }

        private void GenerateContributionSchedule(DateTime runDate, DateTime lastRenewalDate)
        {
            try
            {
                int selectedSchemeId = (int)Session["SelectedSchemeId"];
                int selectedMemberId = (int)Session["SelectedMemberId"];
                int selectedEmployeeId = (int)Session["SelectedEmployeeId"];


                List<ReportParameter> rp = new List<ReportParameter>();
                rp.Add(new ReportParameter("MemberId", selectedMemberId.ToString()));
                rp.Add(new ReportParameter("RunDate", runDate.ToString("yyyy MMM dd")));                
                rp.Add(new ReportParameter("LastRenewalDate", lastRenewalDate.ToShortDateString()));
                rp.Add(new ReportParameter("DisplayAPTLogo", "True"));
                rp.Add(new ReportParameter("Currency", Employer.GetCurrency(selectedEmployeeId)));       
               
                ReportViewer1.ServerReport.ReportPath = "/APT.Reports/ContributionSchedule";
                ReportViewer1.ServerReport.ReportServerUrl = new Uri(ConfigurationManager.AppSettings["ReportServerUrl"]);
                ReportViewer1.ServerReport.ReportServerCredentials = new ReportCredentials(ConfigurationManager.AppSettings["ReportServerUser"], ConfigurationManager.AppSettings["ReportServerPassword"], ConfigurationManager.AppSettings["ReportServerDomain"]);
                ReportViewer1.ServerReport.SetParameters(rp);
                ReportViewer1.ShowParameterPrompts = false;
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
                int selectedSchemeId = (int)Session["SelectedSchemeId"];
                int selectedMemberId = (int)Session["SelectedMemberId"];
                int selectedEmployeeId = (int)Session["SelectedEmployeeId"];

                // Eg LUND => 01/12/2012
                DateTime schemeRenewalDate = MemberModelViewReporting.GetSchemeLastRenewalDate(selectedSchemeId, selectedMemberId);

                DateTime previousRenewalDate = schemeRenewalDate.AddYears(-1);

                GenerateContributionSchedule(DateManager.GetRunDate(txtRunDate.Text.ToString()), previousRenewalDate);               
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
