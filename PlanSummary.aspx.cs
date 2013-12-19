using System;
using System.Data;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using APT.Model;
using System.Web.Caching;
using System.Drawing;
using APT.UTIL;
using System.Diagnostics;

namespace APT2012
{
    public partial class PlanSummary : APTBasePage // System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (HttpContext.Current.Session["SelectedEmployeeID"] != null)
                {
                    double totalContributions = 0;
                    int selectedMemberId = (int)Session["SelectedMemberId"];
                    int selectedSchemeId = (int)Session["SelectedSchemeId"];
                    int selectedEmployeeId = (int)Session["SelectedEmployeeId"];

                    //DataTable dt = Contribution.GetContributionsVsInvestments(selectedEmployeeId);

                    if (!IsPostBack)
                    {
                        ddlContributionYears.DataSource = Contribution.GetContributionYears((int)HttpContext.Current.Session["SelectedEmployeeID"]);
                        ddlContributionYears.DataValueField = "Year";
                        ddlContributionYears.DataTextField = "Year";
                        ddlContributionYears.DataBind();
                        ListItem listItem1 = new ListItem("All", "-1");
                        ddlContributionYears.Items.Insert(0, listItem1);
                        ddlContributionYears.Items[0].Selected = true;
                    }

                    DataTable fundChartData = Fund.GetFundValuesPieChart(selectedMemberId, selectedSchemeId);
                    if (fundChartData.Rows.Count != 0)
                    {
                        uctInvestments.DataSource = fundChartData;
                        uctInvestments.PieChart.ColumnIndex = -1;
                        uctInvestments.DataBind();
                    }

                    List<FundMemberValues> dsInvestmentDetails = Fund.GetFundValues(selectedMemberId, selectedSchemeId);
                    double totalInvestmentsValue = 0;


                    Benefit benefit = Benefit.GetDetails(selectedMemberId);
                    if (benefit.IsARF == 1)
                    {
                        uctContribution.Visible = false;
                        lblContributionsOverTime.Visible = false;
                        ddlContributionYears.Visible = false;

                        lblInitialCapitalInvested.Visible = true;
                        lblInitialCapitalInvestedValue.Visible = true;
                        lblAdditionalIncomeInvested.Visible = true;
                        lblAdditionalIncomeInvestedValue.Visible = true;
                        lblTotalContributionsReceived.Visible = true;
                        lblTotalContributionsReceivedValue.Visible = true;
                        lblTotalWithdrawalsAdjustments.Visible = true;
                        lblTotalWithdrawalsAdjustmentsValue.Visible = true;

                        lblInvestmentReturn.Visible = false;
                        lblInvestmentReturnValue.Visible = false;
                        lblPercentageReturn.Visible = false;
                        lblPercentageReturnValue.Visible = false;
                        lblTotalValueAsAt.Visible = false;
                        lblTotalValueAsAtValue.Visible = false;
                        lblTotalContributionsReceived.Visible = false;
                        lblTotalContributionsReceivedValue.Visible = false;
                        pnlSchemeInformation.Visible = false;

                        double initialCapitalInvested = Convert.ToDouble(Contribution.GetContributionTransferIn(selectedEmployeeId));
                        double additionalIncomeInvested = Contribution.GetContributionTotal(selectedEmployeeId) - initialCapitalInvested;
                        lblInitialCapitalInvestedValue.Text = initialCapitalInvested.ToString("c");
                        lblAdditionalIncomeInvestedValue.Text = additionalIncomeInvested.ToString("c");
                        lblTotalWithdrawalsAdjustmentsValue.Text = InvestmentUnits.getAdjustments(selectedMemberId);
                    }
                    else
                    {
                        DataTable dtContributions = Contribution.GetContributionsChartData((int)HttpContext.Current.Session["SelectedEmployeeID"]);
                        uctContribution.DataSource = dtContributions;
                        uctContribution.DataBind();
                        uctContribution.Axis.X.TickmarkInterval = dtContributions.Columns.Count / 8;

                        lblTotalWithdrawalsAdjustments.Visible = false;
                        lblTotalWithdrawalsAdjustmentsValue.Visible = false;
                        Scheme scheme = Scheme.GetSchemeDetails(selectedSchemeId);
                        lblSchemeNameValue.Text = scheme.Description;
                        lblSchemeStatusValue.Text = scheme.SchemeStatus;
                        lblSchemeTypeValue.Text = scheme.SchemeType;

                        MemberScheme memberScheme = MemberScheme.GetMemberSchemeDetails(selectedMemberId, selectedSchemeId);
                        if (memberScheme.DateLeft == null)
                        {
                            lblMembershipValue.Text = "Active";
                        }
                        else
                        {
                            lblMembershipValue.Text = "Inactive";
                        }
                        if (dsInvestmentDetails.Count != 0)
                        {
                            totalInvestmentsValue = dsInvestmentDetails.Sum(x => x.Value);
                            lblTotalValueAsAtValue.Text = totalInvestmentsValue.ToString("c");
                            lblTotalValueAsAt.Text = "Total Value as at " + DateTime.Parse(DateTime.Now.ToString()).ToString("dd/MM/yyyy");
                            totalContributions = Contribution.GetContributionTotal(selectedEmployeeId);
                            lblTotalContributionsReceivedValue.Text = totalContributions.ToString("c");

                            if (totalContributions != 0)
                            {
                                lblPercentageReturnValue.Text = (((totalInvestmentsValue - totalContributions) / totalContributions * 100)).ToString("0.00") + "%";
                            }
                            lblInvestmentReturnValue.Text = (totalInvestmentsValue - totalContributions).ToString("c");
                        }
                    }

                    //***Commenting this out, but may be implemented by APT in the future
                    //lblEmployeeValue.Text = ContributionRates.getEmployeeRate(selectedMemberId).ToString() + "%";
                    //Benefit benefit = Benefit.GetDetails(selectedMemberId);
                    //if (benefit.IsARF != null)
                    //{
                    //    lblEmployer.Visible = false;
                    //    lblEmployerValue.Visible = false;
                    //}
                    //else
                    //{
                    //    lblEmployerValue.Text = ContributionRates.getEmployerRate(selectedMemberId).ToString() + "%";
                    //}


                    /*
                    DataTable dtInvestments;
                    int memberId = (int)HttpContext.Current.Session["SelectedMemberID"];
                    string cacheName = "uctInvestmentValuesOverTime" + memberId;
                    object cachedFund = HttpRuntime.Cache.Get(cacheName);
                    if (cachedFund == null)
                    {
                        DataTable dtToCache = InvestmentUnits.getInvestmentsValueOverTime(memberId);
                        HttpRuntime.Cache.Insert(cacheName, dtToCache, null, DateTime.Now.AddMinutes(30), Cache.NoSlidingExpiration);
                        dtInvestments = dtToCache.Copy();
                    }
                    else
                    {
                        dtInvestments = ((DataTable)cachedFund).Copy();
                    }

                    dtInvestments.Merge(dtContributions);
                    uctInvestments.DataSource = dtInvestments;
                    uctInvestments.DataBind();
                    uctInvestments.Axis.X.TickmarkInterval = dtInvestments.Columns.Count / 15;*/
                }
                else
                {
                    //uctInvestments.Visible = false;
                    //uctContribution.Visible = false;
                }
            }             
            catch (Exception ex)
            {
                StackTrace stackTrace = new StackTrace();
                APTLog.LogException(ex, stackTrace.GetFrame(0).GetMethod().Name, APT2012AssemblyInfo.AssemblyInfo, APT2012AssemblyInfo.SUBSYSTEM);
                //throw ex;
            }
        }

        protected void ddlContributionYears_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                if (HttpContext.Current.Session["SelectedMemberID"] != null)
                {
                    int selectedMemberId = (int)Session["SelectedMemberId"];
                    int selectedSchemeId = (int)Session["SelectedSchemeId"];
                    int selectedEmployeeId = (int)Session["SelectedEmployeeId"];

                    if (ddlContributionYears.SelectedValue == "-1")
                    {
                        DataTable dtContributions = Contribution.GetContributionsChartData((int)HttpContext.Current.Session["SelectedEmployeeID"]);
                        uctContribution.DataSource = dtContributions;
                        uctContribution.DataBind();
                        uctContribution.Axis.X.TickmarkInterval = dtContributions.Columns.Count / 8;
                    }
                    else
                    {
                        DataTable dtContributions = Contribution.GetContributions(selectedEmployeeId, Convert.ToInt32(ddlContributionYears.SelectedValue));
                        uctContribution.DataSource = dtContributions;
                        uctContribution.DataBind();
                        if (dtContributions.Columns.Count > 8)
                            uctContribution.Axis.X.TickmarkInterval = 2;
                        else
                            uctContribution.Axis.X.TickmarkInterval = 1;

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
