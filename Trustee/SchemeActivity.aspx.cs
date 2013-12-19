using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.Reporting.WebForms;
using System.Configuration;
using APT.UTIL;
using System.Diagnostics;
 

namespace APT2012
{
    public partial class SchemeActivity : APTBasePage // System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (!IsPostBack)
                {
                    int selectedSchemeId = (int)Session["SelectedSchemeId"];

                    List<ReportParameter> rp = new List<ReportParameter>();
                    rp.Add(new ReportParameter("SchemeId", selectedSchemeId.ToString()));
                    rp.Add(new ReportParameter("RunDate", DateTime.Now.ToShortDateString()));

                    rpvMain.ServerReport.ReportPath = "/APT.Reports/SchemeActivity";
                    rpvMain.ServerReport.ReportServerUrl = new Uri(ConfigurationManager.AppSettings["ReportServerUrl"]);
                    rpvMain.ServerReport.ReportServerCredentials = new ReportCredentials(ConfigurationManager.AppSettings["ReportServerUser"], ConfigurationManager.AppSettings["ReportServerPassword"], ConfigurationManager.AppSettings["ReportServerDomain"]);
                    rpvMain.ServerReport.SetParameters(rp);
                    rpvMain.ShowParameterPrompts = false;

                    rpvMain.ServerReport.Refresh();
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