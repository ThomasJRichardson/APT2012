using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using APT.Model;
using System.Data;
using Infragistics.UltraGauge.Resources;
using Infragistics.WebUI.UltraWebGauge;
using System.Drawing;
using APT.UTIL;
using System.Diagnostics;

namespace APT2012
{
    public partial class PensionCalculator : APTBasePage // System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                RadialGaugeScale scale = ((RadialGauge)this.iggRAMGauge.Gauges[0]).Scales[0];
                scale.Markers[0].Value = scale.MapInverse(new Point(0, 90));

                int memberId = (int)HttpContext.Current.Session["SelectedMemberId"];
                int schemeId = (int)HttpContext.Current.Session["SelectedSchemeId"];
                if (!IsPostBack)
                {
                    EmploymentSalaryHistory salHistory = EmploymentSalaryHistory.getLatestSalary((int)Session["SelectedEmployeeId"]);
                    if (salHistory == null)
                    {
                        txtCurrentSalary.Text = ("37000");
                    }
                    else
                    {
                        txtCurrentSalary.Text = (Convert.ToDouble(salHistory.Salary)).ToString();
                    }

                    Member member1 = Member.GetMemberById((int)Session["SelectedMemberId"]);
                    MemberScheme ms = MemberScheme.GetMemberSchemeDetails(memberId, schemeId);

                    DateTime retirementDate = ms.NormalPensionDate.Value;
                    int retirementAge = retirementDate.Year - member1.DateOfBirth.Value.Year;
                    if (retirementDate < member1.DateOfBirth.Value.AddYears(retirementAge)) { retirementAge--; };
                    if (retirementAge >= 50 && retirementAge <= 65)
                    {
                        this.sliderRetirementAge.Value = retirementAge;
                    }
                    else
                    {
                        this.sliderRetirementAge.Value = 60;
                    }

                    sliderContributions.Value = 5;

                    double inflationRate = GlobalValueHistory.GetPensionCalculatorInflationRate(DateTime.Now.Year);
                    double investmentReturn = GlobalValueHistory.GetPensionCalculatorInvestmentReturn(DateTime.Now.Year);
                    lblInflationRate.Text = inflationRate.ToString();
                    lblInvestmentReturn.Text = investmentReturn.ToString();


                    DateTime now = DateTime.Now;
                    int age = now.Year - member1.DateOfBirth.Value.Year;
                    if (now < member1.DateOfBirth.Value.AddYears(age)) { age--; };
                    this.ddlNextAge.SelectedValue = (age + 1).ToString();


                    double totalInvestmentsValue = 0;
                    List<FundMemberValues> dsInvestmentDetails = Fund.GetFundValuesNoZeros((int)Session["SelectedMemberId"], (int)Session["SelectedSchemeId"]);
                    if (dsInvestmentDetails.Count != 0)
                    {
                        totalInvestmentsValue = dsInvestmentDetails.Sum(x => x.Value);
                    }
                    txtPensionValue.Text = totalInvestmentsValue.ToString("0");
                }
            }
            catch (Exception ex)
            {
                StackTrace stackTrace = new StackTrace();
                APTLog.LogException(ex, stackTrace.GetFrame(0).GetMethod().Name, APT2012AssemblyInfo.AssemblyInfo, APT2012AssemblyInfo.SUBSYSTEM);
                //throw ex;
            }
        }

        protected void slider_valuechanged(object sender, Infragistics.Web.UI.EditorControls.SliderValueChangedEventArgs e)
        {
            try
            {
                RadialGauge rad = this.iggRAMGauge.Gauges[0] as RadialGauge;
                rad.Scales[0].Markers[0].Value = double.Parse(this.iggRAMGauge.ValueFromClient);
            }
            catch (Exception ex)
            {
                StackTrace stackTrace = new StackTrace();
                APTLog.LogException(ex, stackTrace.GetFrame(0).GetMethod().Name, APT2012AssemblyInfo.AssemblyInfo, APT2012AssemblyInfo.SUBSYSTEM);
                //throw ex;
            }
        }

        protected void iggRAMGauge_AsyncRefresh(object sender, RefreshEventArgs e)
        {
            try
            {
                RadialGauge rad = this.iggRAMGauge.Gauges[0] as RadialGauge;
                rad.Scales[0].Markers[0].Value = double.Parse(this.iggRAMGauge.ValueFromClient);
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
