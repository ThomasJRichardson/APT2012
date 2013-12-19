using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using APT.Model;
using System.Data;
using System.Collections;
using APT.UTIL;
using System.Diagnostics;

namespace APT2012
{
    public partial class Contributions : APTBasePage //System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (ScriptManager1.IsInAsyncPostBack)
                {
                    string eventTarget = Request.Params.Get("__EVENTTARGET");
                    if (eventTarget == "udpContributionDetails")
                    {
                        string passedArgument = Request.Params.Get("__EVENTARGUMENT");
                        DateTime date = DateTime.Parse(passedArgument);
                        gvContributionDetails.DataSource = Contribution.GetContributions((int)HttpContext.Current.Session["SelectedEmployeeID"], date);
                        gvContributionDetails.DataBind();

                        udpContributionDetails.Update();
                    }
                    if (eventTarget == "udpInvestmentDetails")
                    {
                        string passedArguments = Request.Params.Get("__EVENTARGUMENT");
                        int contributionType = Convert.ToInt32(passedArguments.Split(',')[0]);
                        DateTime contributionRecievedDate = DateTime.Parse(passedArguments.Split(',')[1]);
                        int contributionSource = Convert.ToInt32(passedArguments.Split(',')[2]);
                        gvInvestmentDetails.DataSource = InvestmentUnits.GetInvestments((int)HttpContext.Current.Session["SelectedMemberId"],
                            contributionRecievedDate, contributionType, contributionSource);
                        gvInvestmentDetails.DataBind();

                        udpInvestmentDetails.Update();
                    }
                }
                if (!IsPostBack)
                {
                    if (HttpContext.Current.Session["SelectedEmployeeID"] != null)
                    {
                        gvContributions.DataSource = Contribution.GetContributions((int)HttpContext.Current.Session["SelectedEmployeeID"]);
                        gvContributions.DataBind();
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

        protected void gvContributions_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            try
            {
                if (e.Row.RowType != DataControlRowType.Header)
                {
                    DataRowView drv = e.Row.DataItem as DataRowView;
                    if (drv != null)
                    {
                        Object dateVal = drv["DateReceived"];
                        if (!Convert.IsDBNull(dateVal))
                        {
                            e.Row.Attributes.Add("onclick", "GetContributions('" + dateVal.ToString() + "');");
                        }
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

        protected void gvContributionDetails_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            try
            {
                if (e.Row.RowType != DataControlRowType.Header)
                {
                    DataRowView drv = e.Row.DataItem as DataRowView;
                    if (drv != null)
                    {
                        Object contSource = drv["ContributionSourceId"];
                        Object contType = drv["ContributionTypeId"];
                        Object contDateReceived = drv["DateReceived"];
                        if (!Convert.IsDBNull(contSource))
                        {
                            e.Row.Attributes.Add("onclick", "GetInvestments('" + contType + "," + contDateReceived + "," + contSource + "');");
                        }
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


        protected void udpContributionDetails_OnLoad(object sender, EventArgs e)
        {
            
        }
        protected void udpInvestmentDetails_OnLoad(object sender, EventArgs e)
        {
            
        }
    }
}
