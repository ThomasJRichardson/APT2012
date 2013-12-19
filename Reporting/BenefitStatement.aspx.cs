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
using APT2012.DATES;

namespace APT2012
{
    public partial class BenefitStatement : APTBasePage // System.Web.UI.Page
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
                                       
                    GenerateBenefitStatementReport(calendarButtonExtender.SelectedDate.Value); 
                }
            }            
            catch (Exception ex)
            {
                StackTrace stackTrace = new StackTrace();
                APTLog.LogException(ex, stackTrace.GetFrame(0).GetMethod().Name, APT2012AssemblyInfo.AssemblyInfo, APT2012AssemblyInfo.SUBSYSTEM);
                //throw ex;
            }         
        }
 
        //
        private void GenerateBenefitStatementReport(DateTime runDate)
        {
            try
            {
                int selectedSchemeId = (int)Session["SelectedSchemeId"];
                int selectedMemberId = (int)Session["SelectedMemberId"];
                int selectedEmployeeId = (int)Session["SelectedEmployeeId"];


                // Run the stored procedure that will cache the data used by the report. The ID returned is
                // the unique ID associated with the member, rundate, cached benefit statement id. 
                //                                
                int iCacheBenefitStatementId = APT.Model.Report.CacheAPTBenefitStatement(selectedMemberId, runDate);
                
                List<ReportParameter> rp = new List<ReportParameter>();
                rp.Add(new ReportParameter("MemberId", selectedMemberId.ToString()));
                rp.Add(new ReportParameter("RunDate", runDate.ToShortDateString()));
                rp.Add(new ReportParameter("CachedBenefitStatementId", iCacheBenefitStatementId.ToString()));
                rp.Add(new ReportParameter("DisplayAPTLogo", "True"));
                rp.Add(new ReportParameter("Currency", Employer.GetCurrency(selectedEmployeeId)));
                
                ReportViewer1.ServerReport.ReportPath = "/APT.Reports/APTBenefitStatement";
                ReportViewer1.ServerReport.ReportServerUrl = new Uri(ConfigurationManager.AppSettings["ReportServerUrl"]);
                ReportViewer1.ServerReport.ReportServerCredentials = new ReportCredentials(ConfigurationManager.AppSettings["ReportServerUser"],
                                            ConfigurationManager.AppSettings["ReportServerPassword"], ConfigurationManager.AppSettings["ReportServerDomain"]);
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

        //
        protected void RunDateChanged(object sender, EventArgs e)
        {
            try
            {                             
                GenerateBenefitStatementReport(APT2012.DATES.DateManager.GetRunDate(txtRunDate.Text));               
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