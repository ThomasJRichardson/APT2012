using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data;
using APT.Model;
using System.Drawing;
using APT.UTIL;
using System.Diagnostics;


namespace APT2012
{
    public partial class ChartInvestmentValueOverTime : APTBasePage //System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (!IsPostBack)
                {
                    if (HttpContext.Current.Session["SelectedMemberId"] != null)
                    {
                        int memberId = -1;
                        if (HttpContext.Current.Session["SelectedMemberId"] != null)
                            memberId = (int)HttpContext.Current.Session["SelectedMemberId"];
                        int schemeId = -1;
                        if (HttpContext.Current.Session["SelectedSchemeId"] != null)
                            schemeId = (int)HttpContext.Current.Session["SelectedSchemeId"];
                        if (schemeId == -1 || memberId == -1)
                        {
                            return;
                        }

                        object employeeDetails = Employment.GetDetails(memberId, schemeId);
                        if (employeeDetails != null)
                        {
                            //TODO: Fix Chart Code (Its taking too long to process)
                            //Chart Removed until performance is improved.
                            DataTable investmentValueOverTime = Fund.GetInvestmentValue(memberId, schemeId, ConfigurationManager.ConnectionStrings["LocalSqlServer"].ConnectionString);
                            if (investmentValueOverTime != null)
                            {
                                uctInvestment.DataSource = investmentValueOverTime;
                                uctInvestment.DataBind();
                                uctInvestment.Axis.X.TickmarkInterval = investmentValueOverTime.Columns.Count / 10;
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                StackTrace stackTrace = new StackTrace();
                APTLog.LogException(ex, stackTrace.GetFrame(0).GetMethod().Name, APT2012AssemblyInfo.AssemblyInfo, APT2012AssemblyInfo.SUBSYSTEM);
                //throw ex;
            }
        }

        protected void SetEmptyChartData(object sender, Infragistics.UltraChart.Shared.Events.ChartDataInvalidEventArgs e)
        {
            try
            {
                e.Text = "We have not collected sufficient information to create this graph.";
                System.Drawing.Color colour = System.Drawing.ColorTranslator.FromHtml("#0071B3");
                e.LabelStyle.FontColor = colour;

                e.LabelStyle.FontSizeBestFit = false;
                e.LabelStyle.Font = new Font("arial", 12, FontStyle.Regular);
                e.LabelStyle.HorizontalAlign = StringAlignment.Center;

                e.LabelStyle.VerticalAlign = StringAlignment.Center;
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
