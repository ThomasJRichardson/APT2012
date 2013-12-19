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
    public partial class ARFInvestmentStatement : System.Web.UI.Page // System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (!IsPostBack)
                {
                    int selectedMemberId = (int)Session["SelectedMemberId"];

                    txtFromDate.Text =  "01/01/2012";
                    txtToDate.Text =  DateTime.Now.ToString("dd/MM/yyyy");
                    LoadReport(selectedMemberId, txtFromDate.Text, txtToDate.Text);
                }
            }
            catch (Exception ex)
            {
                StackTrace stackTrace = new StackTrace();
                APTLog.LogException(ex, stackTrace.GetFrame(0).GetMethod().Name, APT2012AssemblyInfo.AssemblyInfo, APT2012AssemblyInfo.SUBSYSTEM);
                //throw ex;
            }
        }
        protected void btnReport_Click(object sender, EventArgs e)
        {
            int selectedMemberId = (int)Session["SelectedMemberId"];
            LoadReport(selectedMemberId, txtFromDate.Text, txtToDate.Text);
        }
        private void LoadReport(int memberid, string fromDate, string toDate)
        {
            try
            {
                List<ReportParameter> rp = new List<ReportParameter>();
                rp.Add(new ReportParameter("MemberID", memberid.ToString()));
                rp.Add(new ReportParameter("StartDate", fromDate));
                rp.Add(new ReportParameter("RunDate", toDate));

                //ReportViewer1.ServerReport.ReportPath = "/APT.Reports/BenefitStatement";
                ReportViewer1.ServerReport.ReportPath = "/APT.Reports/APTARFInvestmentStatementWeb";
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
