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
    public partial class TrusteeUnitPriceHistory : APTBasePage // System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (!IsPostBack)
                {
                    ddlFunds.DataSource = Scheme.GetFunds((int)Session["SelectedSchemeId"]);
                    ddlFunds.DataTextField = "Description";
                    ddlFunds.DataValueField = "Id";
                    ddlFunds.DataBind();

                    GenerateUnitPriceHistory(ddlFunds.SelectedValue);
                }
            }
            catch (Exception ex)
            {
                StackTrace stackTrace = new StackTrace();
                APTLog.LogException(ex, stackTrace.GetFrame(0).GetMethod().Name, APT2012AssemblyInfo.AssemblyInfo, APT2012AssemblyInfo.SUBSYSTEM);
                //throw ex;
            }
        }

        protected void GenerateUnitPriceHistory(string sFundId)
        {
            try
            {
                int selectedEmployeeId = (int)Session["SelectedEmployeeId"];

                List<ReportParameter> rp = new List<ReportParameter>();
                rp.Add(new ReportParameter("FundId", ddlFunds.SelectedValue));
                rp.Add(new ReportParameter("Currency", Employer.GetCurrency(selectedEmployeeId)));

                ReportViewer1.ServerReport.ReportPath = "/APT.Reports/TrusteeUnitPriceHistory";
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


        protected void FundChanged(object sender, EventArgs e)
        {
            try
            {
                GenerateUnitPriceHistory(ddlFunds.SelectedValue);
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
