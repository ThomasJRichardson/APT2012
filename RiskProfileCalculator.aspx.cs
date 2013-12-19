using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using APT.UTIL;
using System.Diagnostics;

namespace APT2012
{
    public partial class RiskProfileCalculator : APTBasePage // System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            { 
                chkTerms.Attributes.Add("onclick", "chkTermsCheckedChanged()");
            }
            catch (Exception ex)
            {
                StackTrace stackTrace = new StackTrace();
                APTLog.LogException(ex, stackTrace.GetFrame(0).GetMethod().Name, APT2012AssemblyInfo.AssemblyInfo, APT2012AssemblyInfo.SUBSYSTEM);
                //throw ex;
            }
        }

        protected void btnSubmitRiskProfileCalculator_Click(object sender, EventArgs e)
        {
            try
            {
                int sectionAScore = int.Parse(rblSectionA1.SelectedValue) +
                    int.Parse(rblSectionA2.SelectedValue);
                int sectionBScore = int.Parse(rblSectionB1.SelectedValue) +
                    int.Parse(rblSectionB2.SelectedValue);
                int sectionCScore = int.Parse(rblSectionC1.SelectedValue);

                int totalScore = sectionAScore + sectionBScore + sectionCScore;

                Session["RiskProfileSectionAScore"] = sectionAScore.ToString();
                Session["RiskProfileSectionBScore"] = sectionBScore.ToString();
                Session["RiskProfileSectionCScore"] = sectionCScore.ToString();
                Session["RiskProfileTotalScore"] = totalScore.ToString();

                Response.Redirect("~/RiskProfileCalculatorResults.aspx");
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