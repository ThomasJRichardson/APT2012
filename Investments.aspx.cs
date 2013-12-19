using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using APT.Model;
using System.Data;
using System.Web.Caching;
using System.Drawing;
using APT.UTIL;
using System.Diagnostics;

namespace APT2012
{
    public partial class Investments : APTBasePage // System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (ScriptManager1.IsInAsyncPostBack)
                {
                    string eventTarget = Request.Params.Get("__EVENTTARGET");
                    if (eventTarget == "udpInvestmentDetails")
                    {
                        string passedArgument = Request.Params.Get("__EVENTARGUMENT");
                        int fundId = Convert.ToInt32(passedArgument);
                        gvInvestmentDetails.DataSource = InvestmentUnits.GetInvestments((int)HttpContext.Current.Session["SelectedMemberId"], fundId);
                        gvInvestmentDetails.DataBind();

                        udpInvestmentDetails.Update();
                    }
                }
                else
                {
                    int memberId = (int)HttpContext.Current.Session["SelectedMemberId"];
                    int schemeId = -1;
                    if (HttpContext.Current.Session["SelectedSchemeId"] != null)
                        schemeId = (int)HttpContext.Current.Session["SelectedSchemeId"];

                    List<FundMemberValues> dsFundDetails = Fund.GetFundValues(memberId, schemeId);

                    gvInvestments.DataSource = dsFundDetails;
                    gvInvestments.DataBind();

                    DataTable dtFunds = new DataTable();
                    bool isFirst = true;
                    foreach (FundMemberValues fmv in dsFundDetails)
                    {
                        if (isFirst == true)
                        {
                            dtFunds = Fund.GetFundOverLastYear(fmv.FundId);
                            isFirst = false;
                        }
                        else
                        {
                            DataTable dt = Fund.GetFundOverLastYear(fmv.FundId);
                            if (dt != null)
                            {
                                if (dtFunds == null)
                                {
                                    dtFunds = dt;
                                }
                                else
                                {
                                    dtFunds.Merge(dt, false);
                                }
                            }
                        }
                    }


                    DataTable fundChartData = dtFunds;
                    if (fundChartData.Rows.Count != 0)
                    {
                        if (fundChartData.Rows.Count > 4)
                        {
                            uctFund.Legend.SpanPercentage = 35;
                        }
                        uctFund.Visible = true;
                        uctFund.DataSource = fundChartData;
                        uctFund.PieChart.ColumnIndex = -1;
                        uctFund.DataBind();
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

        protected void gvInvestments_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            try
            {
                if (e.Row.RowType != DataControlRowType.Header)
                {
                    FundMemberValues fmv = e.Row.DataItem as FundMemberValues;
                    if (fmv != null)
                    {
                        int fundId = fmv.FundId;
                        e.Row.Attributes.Add("onclick", "GetInvestments('" + fundId + "');");

                    }
                    e.Row.Attributes.Add("onmouseover", "highlight(this, true);");
                    e.Row.Attributes.Add("onmouseout", "highlight(this, false);");
                    e.Row.Attributes.Add("onmouseup", "selectedRow(this);");
                }
            }
            catch (Exception ex)
            {
                StackTrace stackTrace = new StackTrace();
                APTLog.LogException(ex, stackTrace.GetFrame(0).GetMethod().Name, APT2012AssemblyInfo.AssemblyInfo, APT2012AssemblyInfo.SUBSYSTEM);
                //throw ex;
            }
        }

        protected void udpInvestmentDetails_OnLoad(object sender, EventArgs e)
        {

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

        protected void BtnEnlarge_Click(object sender, EventArgs e)
        {
            uctFund.Height = 800;
            btnShrink.Visible = true;
            BtnEnlarge.Visible = false;
        }

        protected void BtnShrink_Click(object sender, EventArgs e)
        {
            uctFund.Height = 250;
            btnShrink.Visible = false;
            BtnEnlarge.Visible = true;
        }
    }
}
