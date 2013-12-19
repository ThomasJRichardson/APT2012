using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using APT.Model;
using System.Data;
using System.Data.Objects;
using System.Web.Caching;
using System.Configuration;
using System.Resources;
using System.Reflection;
using System.Globalization;
using System.Threading;
using System.Collections;
using APT.UTIL;
using System.Diagnostics;

namespace APT2012
{
    public partial class MemberOverview : APTBasePage //System.Web.UI.Page
    {
        internal class ResxResourceManager : ResourceManager
        {
            public ResxResourceManager(string baseName, string resourceDir)
            {
                try
                {
                    BaseNameField = baseName;
                    //ResourceSets = new Hashtable();

                    Type baseType = GetType().BaseType;
                    BindingFlags flags = BindingFlags.Instance | BindingFlags.NonPublic | BindingFlags.SetField;

                    baseType.InvokeMember("moduleDir", flags, null, this, new object[] { resourceDir });
                    baseType.InvokeMember("_userResourceSet", flags, null, this, new object[] { typeof(ResXResourceSet) });
                    baseType.InvokeMember("UseManifest", flags, null, this, new object[] { false });
                }
                catch (Exception ex)
                {
                    StackTrace stackTrace = new StackTrace();
                    APTLog.LogException(ex, stackTrace.GetFrame(0).GetMethod().Name, APT2012AssemblyInfo.AssemblyInfo, APT2012AssemblyInfo.SUBSYSTEM);
                    //throw ex;
                }
            }

            protected override string GetResourceFileName(CultureInfo culture)
            {
                try
                {
                    string resourceFileName = base.GetResourceFileName(culture);
                    return resourceFileName.Replace(".resources", ".resx");
                }
                catch (Exception ex)
                {
                    StackTrace stackTrace = new StackTrace();
                    APTLog.LogException(ex, stackTrace.GetFrame(0).GetMethod().Name, APT2012AssemblyInfo.AssemblyInfo, APT2012AssemblyInfo.SUBSYSTEM);
                    //throw ex;
                }
                return "";
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (!IsPostBack)
                {
                    if (HttpContext.Current.Session["SelectedMemberId"] != null)
                    {
                        double totalInvestmentsValue = 0;
                        double totalContributions = 0;
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

                        List<FundMemberValues> dsInvestmentDetails = Fund.GetFundValuesNoZeros(memberId, schemeId);
                        if (dsInvestmentDetails.Count != 0)
                        {
                            totalInvestmentsValue = dsInvestmentDetails.Sum(x => x.Value);
                        }
                        gvInvestmentSummary.DataSource = dsInvestmentDetails;
                        gvInvestmentSummary.DataBind();


                        lblTotalInvestmentsValue.Text = totalInvestmentsValue.ToString("c");
                        lblTotalValueAsAtValue.Text = totalInvestmentsValue.ToString("c");
                        lblTotalValueAsAtDate.Text = DateTime.Parse(DateTime.Now.ToString()).ToString("dd/MM/yyyy");

                        lblTotalWithdrawalsAdjustmentsValue.Text = InvestmentUnits.getAdjustments(memberId);

                        Member member1 = Member.GetMemberById(memberId);
                        if (member1 != null)
                        {
                            lblNameValue.Text = member1.Forename + " " + member1.Surname;
                            lblDateOfBirthValue.Text = DateTime.Parse(member1.DateOfBirth.ToString()).ToString("dd/MM/yyyy");
                        }

                        object employeeDetails = Employment.GetDetails(memberId, schemeId);
                        if (employeeDetails != null)
                        {
                            //TODO: Fix Chart Code (Its taking too long to process)
                            //Chart Removed until performance is improved.
                            //DataTable investmentValueOverTime = Fund.GetInvestmentValue(memberId, schemeId, ConfigurationManager.ConnectionStrings["LocalSqlServer"].ConnectionString);
                            //if (investmentValueOverTime == null)
                            //{
                            //    pnlInvVsCont.Visible = false;
                            //}else
                            //{
                            //    uctInvestment.DataSource = investmentValueOverTime;
                            //    uctInvestment.DataBind();
                            //    uctInvestment.Axis.X.TickmarkInterval = investmentValueOverTime.Columns.Count / 10;
                            //}

                            Employment ee = (Employment)employeeDetails;
                            lblDateJoinedCompanyValue.Text = DateTime.Parse(ee.DateJoined.ToString()).ToString("dd/MM/yyyy");
                            totalContributions = Contribution.GetContributionTotal(ee.Id);
                            lblTotalContributionsValue.Text = totalContributions.ToString("c");
                            lblTotalContributionsReceivedValue.Text = totalContributions.ToString("c");
                            lblEmployeeContributionsValue.Text = Contribution.GetContributionEmployee(ee.Id).ToString("c");
                            lblAVCsValue.Text = Contribution.GetContributionAVC(ee.Id).ToString("c");
                            lblTransferInValue.Text = Contribution.GetContributionTransferIn(ee.Id).ToString("c");

                            MemberScheme ms = MemberScheme.GetMemberSchemeDetails(memberId, schemeId);
                            Scheme scheme = Scheme.GetSchemeDetails(schemeId);
                            Benefit benefit = Benefit.GetDetails(memberId);
                            if (benefit.IsARF == 1)
                            {
                                lblDateJoinedCompany.Visible = false;
                                lblDateJoinedCompanyValue.Visible = false;
                                lblNormalPensionDate.Visible = false;
                                lblNormalPensionDateValue.Visible = false;
                                lblBasicSalary.Visible = false;
                                lblBasicSalaryValue.Visible = false;
                                lblScheme.Visible = false;
                                lblSchemeValue.Visible = false;
                                lblSchemeStartDate.Visible = false;
                                lblSchemeStartDateValue.Visible = false;
                                lblInvestmentReturn.Visible = false;
                                lblInvestmentReturnValue.Visible = false;
                                lblPercentageReturn.Visible = false;
                                lblPercentageReturnValue.Visible = false;
                                lblEmployerContributions.Visible = false;
                                lblEmployerContributionsValue.Visible = false;

                                String initialCapitalInvested = "";
                                try
                                {
                                    ResxResourceManager resourceManager = new ResxResourceManager("GlobalLocalizations", "App_GlobalResources");
                                    initialCapitalInvested = resourceManager.GetString("InitialCapitalInvested");
                                }
                                catch (Exception) { initialCapitalInvested = "Initial Capital Invested"; }
                                lblTransferIn.Text = initialCapitalInvested;

                                String additionalIncomeInvested = "";
                                try
                                {
                                    ResxResourceManager resourceManager = new ResxResourceManager("GlobalLocalizations", "App_GlobalResources");
                                    additionalIncomeInvested = resourceManager.GetString("AdditionalIncomeInvested");
                                }
                                catch (Exception) { additionalIncomeInvested = "Additional Income Invested"; }
                                lblEmployeeContributions.Text = additionalIncomeInvested;

                                lblTotalWithdrawalsAdjustments.Visible = false;
                                lblTotalWithdrawalsAdjustmentsValue.Visible = false;
                            }
                            else if (benefit.IsPRSA == 1)
                            {
                                lblDateJoinedCompany.Visible = false;
                                lblDateJoinedCompanyValue.Visible = false;
                                lblBasicSalary.Visible = false;
                                lblBasicSalaryValue.Visible = false;
                                lblSchemeStartDate.Visible = false;
                                lblSchemeStartDateValue.Visible = false;
                                lblInvestmentReturn.Visible = false;
                                lblInvestmentReturnValue.Visible = false;
                                lblPercentageReturn.Visible = false;
                                lblPercentageReturnValue.Visible = false;
                                lblEmployerContributions.Visible = true;
                                lblEmployerContributionsValue.Visible = true;
                                lblNameOfPRSAProvider.Visible = true;
                                lblNameOfPRSAProviderValue.Visible = true;
                                lblAVCs.Visible = false;
                                lblAVCsValue.Visible = false;


                                ResxResourceManager resourceManager = new ResxResourceManager("GlobalLocalizations", "App_GlobalResources");
                                String datePRSASignature = "";
                                try
                                {
                                    datePRSASignature = resourceManager.GetString("DatePRSASignature");
                                }
                                catch (Exception) { datePRSASignature = "Date of PRSA signature"; }
                                lblDateJoinedPlan.Text = datePRSASignature;

                                String nameOfPRSA = "";
                                try
                                {
                                    nameOfPRSA = resourceManager.GetString("NameOfPRSA");
                                }
                                catch (Exception) { nameOfPRSA = "Name of PRSA"; }
                                lblScheme.Text = nameOfPRSA;
                                lblSchemeValue.Text = scheme.Description;

                                String projectedRetirementDate = "";
                                try
                                {
                                    projectedRetirementDate = resourceManager.GetString("ProjectedRetirementDate");
                                }
                                catch (Exception) { projectedRetirementDate = "Projected Retirement Date"; }
                                lblNormalPensionDate.Text = projectedRetirementDate;
                                if (ms.NormalPensionDate != null)
                                {
                                    lblNormalPensionDateValue.Text = DateTime.Parse(ms.NormalPensionDate.ToString()).ToString("dd/MM/yyyy");
                                }
                                String prsaAssetValue = "";
                                try
                                {
                                    prsaAssetValue = resourceManager.GetString("PRSAAssetValue");
                                }
                                catch (Exception) { prsaAssetValue = "PRSA Asset Value"; }
                                lblTotalValueAsAt.Text = prsaAssetValue;

                                lblEmployerContributionsValue.Text = Contribution.GetContributionEmployer(ee.Id).ToString("c");

                            }
                            else
                            {
                                lblSchemeValue.Text = scheme.Description;
                                if (scheme.StartDate != null)
                                {
                                    lblSchemeStartDateValue.Text = DateTime.Parse(scheme.StartDate.ToString()).ToString("dd/MM/yyyy");
                                }

                                lblEmployerContributionsValue.Text = Contribution.GetContributionEmployer(ee.Id).ToString("c");

                                if (ms.NormalPensionDate != null)
                                {
                                    lblNormalPensionDateValue.Text = DateTime.Parse(ms.NormalPensionDate.ToString()).ToString("dd/MM/yyyy");
                                }
                                EmploymentSalaryHistory salHistory = EmploymentSalaryHistory.getLatestSalary(ee.Id);
                                if (salHistory != null)
                                {
                                    if (salHistory.Salary != 0)
                                    {
                                        lblBasicSalaryValue.Visible = true;
                                        lblBasicSalary.Visible = true;
                                        lblBasicSalaryDate.Visible = true;                                      
                                        lblBasicSalaryValue.Text = (Convert.ToDouble(salHistory.Salary)).ToString("c");
                                        lblBasicSalaryDate.Text = DateTime.Parse(salHistory.EffectiveDate.ToString()).ToString("dd/MM/yyyy");
                                    }
                                }
                            }
                            if (ms.DateJoined != null)
                            {
                                lblDateJoinedPlanValue.Text = DateTime.Parse(ms.DateJoined.ToString()).ToString("dd/MM/yyyy");
                            }
                        }
                        if (totalContributions != 0)
                        {
                            lblPercentageReturnValue.Text = (((totalInvestmentsValue - totalContributions) / totalContributions * 100)).ToString("0.00") + "%";
                        }
                        lblInvestmentReturnValue.Text = (totalInvestmentsValue - totalContributions).ToString("c");
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
    }
}
