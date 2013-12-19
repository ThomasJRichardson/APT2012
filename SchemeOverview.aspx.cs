using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using APT.Model;
using APT.UTIL;
using System.Diagnostics;
 
namespace APT2012
{
    public partial class SchemeOverview : APTBasePage // System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (!IsPostBack)
                {
                    if (HttpContext.Current.Session["SelectedSchemeId"] == null)
                    {
                        return;
                    }
                    double totalSchemeInvestmentsValue = 0;
                    double totalContributions = 0;
                    int schemeId = (int)HttpContext.Current.Session["SelectedSchemeId"];

                    DataTable dtSchemeInvestmentDetails = Fund.GetFundValuesNoZeros(schemeId);
                    if (dtSchemeInvestmentDetails.Rows.Count != 0)
                    {
                        totalSchemeInvestmentsValue = (double)dtSchemeInvestmentDetails.Compute("Sum(Value)", "");
                    }
                    gvInvestmentSummary.DataSource = dtSchemeInvestmentDetails;
                    gvInvestmentSummary.DataBind();

                    lblTotalInvestmentsValue.Text = totalSchemeInvestmentsValue.ToString("c");
                    lblSchemeTotalValueAsAtValue.Text = totalSchemeInvestmentsValue.ToString("c");
                    lblSchemeTotalValueAsAt.Text = "Total Value as at " + DateTime.Parse(DateTime.Now.ToString()).ToString("dd/MM/yyyy");

                    totalContributions = Contribution.GetSchemeContributionTotal(schemeId);
                    lblSchemeTotalContributionsValue.Text = totalContributions.ToString("c");
                    lblSchemeTotalContributionsReceivedValue.Text = totalContributions.ToString("c");

                    lblSchemeEmployeeContributionsValue.Text = Contribution.GetSchemeContributionEmployee(schemeId).ToString("c");
                    lblSchemeEmployerContributionsValue.Text = Contribution.GetSchemeContributionEmployer(schemeId).ToString("c");
                    lblSchemeAVCsValue.Text = Contribution.GetSchemeContributionAVC(schemeId).ToString("c");
                    lblSchemeTransferInValue.Text = Contribution.GetSchemeContributionTransferIn(schemeId).ToString("c");


                    if (totalContributions != 0)
                    {
                        lblSchemePercentageReturnValue.Text = (((totalSchemeInvestmentsValue - totalContributions) / totalContributions * 100)).ToString("0.00") + "%";
                    }
                    lblSchemeInvestmentReturnValue.Text = (totalSchemeInvestmentsValue - totalContributions).ToString("c");
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
