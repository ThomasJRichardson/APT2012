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
    public partial class GroupDCSORP : APTBasePage // System.Web.UI.Page
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
                    
                    GenerateGroupDCSORP(calendarButtonExtender.SelectedDate.Value);            
                }
            }             
            catch (Exception ex)
            {
                StackTrace stackTrace = new StackTrace();
                APTLog.LogException(ex, stackTrace.GetFrame(0).GetMethod().Name, APT2012AssemblyInfo.AssemblyInfo, APT2012AssemblyInfo.SUBSYSTEM);
                //throw ex;
            }
        }

        // Default run date should be the scheme renewal date. 
        private void GenerateGroupDCSORP(DateTime runDate)
        {
            try
            {
                int selectedSchemeId = (int)Session["SelectedSchemeId"];
                int selectedMemberId = (int)Session["SelectedMemberId"];
                int selectedEmployeeId = (int)Session["SelectedEmployeeId"];


                List<ReportParameter> rp = new List<ReportParameter>();
                rp.Add(new ReportParameter("MemberId", selectedMemberId.ToString()));
                rp.Add(new ReportParameter("RunDate", runDate.ToString("yyyy MMM dd")));
                rp.Add(new ReportParameter("DisplayAPTLogo", "True"));
                rp.Add(new ReportParameter("Currency", Employer.GetCurrency(selectedEmployeeId)));             

                ReportViewer1.ServerReport.ReportPath = "/APT.Reports/GroupDCSORP";
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
                GenerateGroupDCSORP(DateManager.GetRunDate(txtRunDate.Text.ToString()));
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
