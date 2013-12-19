using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using APT.Model;
using Infragistics.UltraGauge.Resources;
using System.Drawing;
using APT.UTIL;
using System.Diagnostics;

namespace APT2012
{
    public partial class RiskProfileCalculatorResults : APTBasePage // System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                lblSectionATotals.Text = (string)Session["RiskProfileSectionAScore"];
                lblSectionBTotals.Text = (string)Session["RiskProfileSectionBScore"];
                lblSectionCTotals.Text = (string)Session["RiskProfileSectionCScore"];
                lblRiskTotal.Text = (string)Session["RiskProfileTotalScore"];

                Session.Remove("RiskProfileSectionAScore");
                Session.Remove("RiskProfileSectionBScore");
                Session.Remove("RiskProfileSectionCScore");
                Session.Remove("RiskProfileTotalScore");


                if (lblRiskTotal.Text != "")
                {
                    int total = int.Parse(lblRiskTotal.Text);
                    if (total >= 12)
                    {
                        total = 17;
                    }
                    else if (total <= 7)
                    {
                        total = 3;
                    }
                    else
                    {
                        total = 10;
                    }

                    LinearGaugeScale scale = ((LinearGauge)this.iggRiskGauge.Gauges[0]).Scales[0];
                    scale.Markers[0].Value = total;
                }
                else
                {
                    Response.Redirect("~/RiskProfileCalculator.aspx");
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