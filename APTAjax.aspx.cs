using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Web;
using System.Web.Script.Services;
using System.Collections.Generic;
using System.Web.Security;
using System.Threading;
using System.Globalization;
using APT.Model;
using APT.UTIL;
using System.Diagnostics;

namespace APT2012
{
    public partial class APTAjax : APTBasePage // System.Web.UI.Page
    {
        [System.Web.Script.Services.ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        [System.Web.Services.WebMethod]
        public static Dictionary<string, object> SchemeGetMembers(int SchemeId)
        {
            DataSet dsReturn = new DataSet();
            try
            {              
                dsReturn.Tables.Add(Scheme.GetMembers(SchemeId));              
            }
            catch (Exception ex)
            {
                StackTrace stackTrace = new StackTrace();
                APTLog.LogException(ex, stackTrace.GetFrame(0).GetMethod().Name, APT2012AssemblyInfo.AssemblyInfo, APT2012AssemblyInfo.SUBSYSTEM);
                //throw ex;
            }
            return JsonMethods.ToJson(dsReturn);
        }

        [System.Web.Script.Services.ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        [System.Web.Services.WebMethod]
        public static Dictionary<string, object> SchemeGet()
        {
            // Scheme List Depends on Users Role
            // APT Admin - can see all Schemes
            // Scheme Admin, HR Admin - can only see associated schemes

            DataSet dsReturn = new DataSet();

            try
            {              
                // Get Users First Role (all users SHOULD only have 1 role)
                string[] roles = Roles.GetRolesForUser(HttpContext.Current.User.Identity.Name);

                switch (roles[0])
                {
                    case "APT Admin":
                        dsReturn.Tables.Add(Scheme.SchemesForAdmin());
                        break;
                    case "Scheme Admin":
                    case "HR Admin":
                        dsReturn.Tables.Add(Scheme.SchemesForUser(HttpContext.Current.User.Identity.Name));
                        break;
                }               
            }
            catch (Exception ex)
            {
                StackTrace stackTrace = new StackTrace();
                APTLog.LogException(ex, stackTrace.GetFrame(0).GetMethod().Name, APT2012AssemblyInfo.AssemblyInfo, APT2012AssemblyInfo.SUBSYSTEM);
                //throw ex;
            }

            return JsonMethods.ToJson(dsReturn);
        }

        [System.Web.Script.Services.ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        [System.Web.Services.WebMethod]
        public static Dictionary<string, object> SchemeMemberGet()
        {
            // Scheme List Depends on Users Role
            // APT Admin - can see all Schemes
            // Scheme Admin, HR Admin - can only see associated schemes

            DataSet dsReturn = new DataSet();

            try
            {                
                // Get Users First Role (all users SHOULD only have 1 role)
                string[] roles = Roles.GetRolesForUser(HttpContext.Current.User.Identity.Name);

                switch (roles[0])
                {
                    case "APT Admin":
                    case "Scheme Admin":
                    case "HR Admin":
                        dsReturn.Tables.Add(Scheme.GetMemberList(Convert.ToInt32(HttpContext.Current.Session["SelectedSchemeId"])));
                        break;
                }              
            }
            catch (Exception ex)
            {
                StackTrace stackTrace = new StackTrace();
                APTLog.LogException(ex, stackTrace.GetFrame(0).GetMethod().Name, APT2012AssemblyInfo.AssemblyInfo, APT2012AssemblyInfo.SUBSYSTEM);
                //throw ex;
            }

            return JsonMethods.ToJson(dsReturn);
        }

        [System.Web.Services.WebMethod]
        public static string SchemeSelect(int schemeid)
        {
            try
            {
                HttpContext.Current.Session["SelectedSchemeId"] = schemeid;
                HttpContext.Current.Session["SelectedMemberId"] = Scheme.GetFirstMember(schemeid);
                HttpContext.Current.Session["SelectedEmployeeId"] = Employment.GetEmployeeId(Scheme.GetFirstMember(schemeid), schemeid);
                string currency = Employer.GetCurrency((int)HttpContext.Current.Session["SelectedEmployeeId"]);
                Thread.CurrentThread.CurrentCulture = new CultureInfo(currency);
                HttpContext.Current.Session["MemberCurrency"] = currency;

                return "true";
            }
            catch (Exception ex)
            {
                StackTrace stackTrace = new StackTrace();
                APTLog.LogException(ex, stackTrace.GetFrame(0).GetMethod().Name, APT2012AssemblyInfo.AssemblyInfo, APT2012AssemblyInfo.SUBSYSTEM);
                
                return "false";
            }
        }

        [System.Web.Services.WebMethod]
        public static string SchemeMemberSelect(int memberid)
        {
            try
            {
                HttpContext.Current.Session["SelectedMemberId"] = memberid;
                HttpContext.Current.Session["SelectedEmployeeId"] = Employment.GetEmployeeId(memberid, Convert.ToInt32(HttpContext.Current.Session["SelectedSchemeId"]));
                string currency = Employer.GetCurrency((int)HttpContext.Current.Session["SelectedEmployeeId"]);
                Thread.CurrentThread.CurrentCulture = new CultureInfo(currency);
                HttpContext.Current.Session["MemberCurrency"] = currency;

                return "true";
            }
            catch (Exception ex)
            {
                StackTrace stackTrace = new StackTrace();
                APTLog.LogException(ex, stackTrace.GetFrame(0).GetMethod().Name, APT2012AssemblyInfo.AssemblyInfo, APT2012AssemblyInfo.SUBSYSTEM);
            
                return "false";
            }
        }

        /// <summary>
        /// Returns a DataSet with a single row of values based on pension criteria
        /// </summary>
        /// <returns></returns>
        [System.Web.Script.Services.ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        [System.Web.Services.WebMethod]
        public static Dictionary<string, object> PensionCalculate( int nextage,
                                                                    double contributionpercent,
                                                                    double currentsalary,
                                                                    double existingpension,
                                                                    int retirementage,
                                                                    double targetpension,
                                                                    double taxfreelumpsum,
                                                                    double inflationpercent)
        {            
            try
            {
                Global.SetThreadCulture();

                DataSet dsReturn = new DataSet();
                dsReturn.Tables.Add();
                dsReturn.Tables[0].Columns.Add("EstimatedPensionFund");
                dsReturn.Tables[0].Columns.Add("EstimateSalary");
                dsReturn.Tables[0].Columns.Add("MemberPercentOfFinalSalary");
                dsReturn.Tables[0].Columns.Add("MembersPension");
                dsReturn.Tables[0].Columns.Add("PercentOfTaxFreeSum");
                dsReturn.Tables[0].Columns.Add("ReducedPension");
                dsReturn.Tables[0].Columns.Add("ReducedPensionPercent");
                dsReturn.Tables[0].Columns.Add("TargetBenefit");
                dsReturn.Tables[0].Columns.Add("TargetPensionEuros");
                dsReturn.Tables[0].Columns.Add("TaxFreeLumpSum");
                dsReturn.Tables[0].Columns.Add("CurrencySymbol");
                dsReturn.Tables[0].Columns.Add("FundShortfallValue");
                dsReturn.Tables[0].Columns.Add("FundShortfallPercent");

                double inflation = 100 + inflationpercent;

                PensionData pensiondata = new PensionData();
                APT.Model.PensionCalculator pensionCalc = new APT.Model.PensionCalculator(  nextage,
                                                                                            (inflation / 100.00),
                                                                                            retirementage,
                                                                                            currentsalary,
                                                                                            "M",
                                                                                            contributionpercent,
                                                                                            DateTime.Now,
                                                                                            existingpension,
                                                                                            0,
                                                                                            0.02,
                                                                                            targetpension,
                                                                                            taxfreelumpsum);

                pensiondata.Age = nextage;
                pensiondata.ContributionPercent = contributionpercent;
                pensiondata.CurrentSalary = currentsalary;
                pensiondata.ExistingPension = existingpension;
                pensiondata.RetirementAge = retirementage;
                pensiondata.TargetPension = targetpension;
                pensiondata.TaxFreeLumpSum = taxfreelumpsum;

                string currencySymbol = Thread.CurrentThread.CurrentCulture.NumberFormat.CurrencySymbol;
                //Calculator calc = new Calculator(pensiondata);
                double ar = (double)pensiondata.RetirementAge / 1000;

                dsReturn.Tables[0].Rows.Add(pensionCalc.GetTotalContributions(),
                                            pensionCalc.GetEstimatedSalary(),
                                            pensionCalc.GetTotalPensionAsPercentOfSalary() * 100,
                                            pensionCalc.GetTotalPensionPA(),
                                            pensionCalc.PercentOfTaxFreeSum() * 100,
                                            pensionCalc.GetReducedPension(),
                                            pensionCalc.GetReducedPensionPercent(),
                                            pensionCalc.TargetPensionPercent * 100,
                                            pensionCalc.TargetPension(),
                                            pensionCalc.TaxFreeLumpSum * pensionCalc.GetEstimatedSalary(),
                                            currencySymbol,
                                            pensionCalc.GetShortfall(),
                                            pensionCalc.GetShortfallPercent());

                return JsonMethods.ToJson(dsReturn);
            }
            catch (Exception ex)
            {
                StackTrace stackTrace = new StackTrace();
                APTLog.LogException(ex, stackTrace.GetFrame(0).GetMethod().Name, APT2012AssemblyInfo.AssemblyInfo, APT2012AssemblyInfo.SUBSYSTEM);
                //throw ex;
            }
            return null;
        }
    }

    /// <summary>
    /// JSON Methods object, required to convert DataTable and DataSet objects to JSON formatted Lists
    /// </summary>
    public class JsonMethods
    {
        private static List<Dictionary<string, object>> RowsToDictionary(DataTable table)
        {
            List<Dictionary<string, object>> objs = new List<Dictionary<string, object>>();
            try
            {               
                foreach (DataRow dr in table.Rows)
                {
                    Dictionary<string, object> drow = new Dictionary<string, object>();
                    for (int i = 0; i < table.Columns.Count; i++)
                    {
                        drow.Add(table.Columns[i].ColumnName, dr[i]);
                    }
                    objs.Add(drow);
                }
            }
            catch (Exception ex)
            {
                StackTrace stackTrace = new StackTrace();
                APTLog.LogException(ex, stackTrace.GetFrame(0).GetMethod().Name, APT2012AssemblyInfo.AssemblyInfo, APT2012AssemblyInfo.SUBSYSTEM);
                //throw ex;
            }

            return objs;
        }

        public static Dictionary<string, object> ToJson(DataTable table)
        {
            Dictionary<string, object> d = new Dictionary<string, object>();
            try
            {             
                if (table != null)
                    d.Add(table.TableName, RowsToDictionary(table));              
            }
            catch (Exception ex)
            {
                StackTrace stackTrace = new StackTrace();
                APTLog.LogException(ex, stackTrace.GetFrame(0).GetMethod().Name, APT2012AssemblyInfo.AssemblyInfo, APT2012AssemblyInfo.SUBSYSTEM);
                //throw ex;
            }

            return d;
        }

        public static Dictionary<string, object> ToJson(DataSet data)
        {
            Dictionary<string, object> d = new Dictionary<string, object>();
            try
            {               
                foreach (DataTable table in data.Tables)
                {
                    d.Add(table.TableName, RowsToDictionary(table));
                }               
            }
            catch (Exception ex)
            {
                StackTrace stackTrace = new StackTrace();
                APTLog.LogException(ex, stackTrace.GetFrame(0).GetMethod().Name, APT2012AssemblyInfo.AssemblyInfo, APT2012AssemblyInfo.SUBSYSTEM);
                //throw ex;
            }
            return d;
        }
    }
}
