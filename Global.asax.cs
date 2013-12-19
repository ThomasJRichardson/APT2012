using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.SessionState;
using System.Web.Profile;
using System.Data.Objects;
using System.Data.SqlClient;
using System.Configuration;
using System.Threading;
using System.Globalization;
using System.Web.Configuration;
using System.Diagnostics;
using APT.Model;
using APT.UTIL;

[assembly: log4net.Config.XmlConfigurator(ConfigFileExtension = "log4net", Watch = true)]

namespace APT2012
{
    public partial class APTBasePage : System.Web.UI.Page
    {
        protected void Page_Init(object sender, EventArgs e)
        {
            Global.SetThreadCulture();
            MaintenanceWindow();           
        }

        protected void MaintenanceWindow()
        {
            if (Sysmgmt.IsInMaintenanceMode()) 
            {
                Response.Redirect("~/Maintenance.aspx");
            }
        }
    }

    public class Global : System.Web.HttpApplication
    {    
        protected void Application_Start(object sender, EventArgs e)
        {
            try
            {                
                string log4NetFile = ConfigurationManager.AppSettings["log4netFile"];

                log4net.Config.XmlConfigurator.Configure(new System.IO.FileInfo(log4NetFile));

                string sPath = "~/";

                APTLog.LogMessage("Logging initialised!");

                APTLog.LogMessage("APT OpenWebConfig for path= " + sPath);

                // Set 
                //
                Configuration config = WebConfigurationManager.OpenWebConfiguration(sPath);
                if (config != null)
                {
                    ConnectionStringSettings ConnectionString = config.ConnectionStrings.ConnectionStrings["LocalSqlServer"];
                    APTLog.LogMessage("Using LocalSqlServer connection string = " + ConnectionString.ConnectionString);

                    string sLogToDB = (string)config.AppSettings.Settings["LogToDB"].Value;
                    bool bresult = false;
                    bool.TryParse(sLogToDB, out bresult);
                    APTLog.LogToDB = bresult;

                    APTLog.LogExceptionToDB(new APTExceptionEventArgs(new Exception("APPLICATION-STARTUP-INITIALISE - " + System.DateTime.Now),
                                            "-Application_Start-", "DEFAULT STARTUP MESSAGE FOR APT2012 WebSite" , APT2012AssemblyInfo.SUBSYSTEM));
                }            
            }
            catch (Exception ex)
            {
                APTLog.LogException(ex, "Application_Start", ex.Message.ToString(), APTUtilAssemblyInfo.SUBSYSTEM);
                //throw ex;
            }
        }

        protected void Session_Start(object sender, EventArgs e)
        {
            try
            {
                // Administrator will only be allowed a certain number of login attempts
                Session["MaxLoginAttempts"] = 3;
                Session["LoginCount"] = 0;


                //This will be called if the user has a cookie for Remember Me
                if (User.Identity.Name != "")
                {
                    setSessionContext(User.Identity.Name);
                }
            }
            catch (Exception ex)
            {
                StackTrace stackTrace = new StackTrace();
                APTLog.LogException(ex, stackTrace.GetFrame(0).GetMethod().Name, APT2012AssemblyInfo.AssemblyInfo, APT2012AssemblyInfo.SUBSYSTEM);
                //throw ex;
            }
        }

        protected void Application_BeginRequest(object sender, EventArgs e)
        {

        }

        void Application_AcquireRequestState(object sender, EventArgs e)
        {
           
        }
    
        protected void Application_Error(object sender, EventArgs e)
        {

        }

        protected void Session_End(object sender, EventArgs e)
        {
        }

        protected void Application_End(object sender, EventArgs e)
        {

        }

        public static void setSessionContext(string userName)
        {
            //TODO: Create Default Information for "Scheme Admin"

            // **ROLES**
            //APT Admin (Full access to all pages, schemes, members)
            //ARF Member (Not in use)
            //Scheme Admin (Full access to X schemes, members, pages)
            //HR Admin (Access to X schemes, member. Partial access to pages)
            //Member (Access to own member information)

            try
            {
                //Get User Role
                string[] roles = Roles.GetRolesForUser(userName);

                switch (roles[0])
                {
                    case "APT Admin":
                        loadAptAdminRole();
                        break;
                    case "Scheme Admin":
                    case "HR Admin":
                        loadAdminRole(userName);
                        break;
                    case "Member":
                        loadMemberRole(userName);
                        break;
                }
            }
            catch (Exception ex)
            {
                //Response.Redirect("~/Default.aspx");
                StackTrace stackTrace = new StackTrace();
                APTLog.LogException(ex, stackTrace.GetFrame(0).GetMethod().Name, APT2012AssemblyInfo.AssemblyInfo, APT2012AssemblyInfo.SUBSYSTEM);
                //throw ex;                
            }
        }

        private static void loadAptAdminRole()
        {
            try
            {
                // 1. Get First Scheme with Members
                // 2. Set Session["SelectedSchemeId"]
                // 3. Set Session["SelectedMemberId"] from first member in scheme
                // 4. See Session["SelectedEmployeeId"] from selected member

                int FirstAvailSchemeId = Scheme.FirstSchemeForAdmin().Id;
                int FirstAvailMemberId = Scheme.GetFirstMember(FirstAvailSchemeId);
                int FirstAvailEmployeeId = Employment.GetEmployeeId(FirstAvailMemberId, FirstAvailSchemeId);
                HttpContext.Current.Session.Add("SelectedSchemeId", FirstAvailSchemeId);
                HttpContext.Current.Session.Add("SelectedMemberId", FirstAvailMemberId);
                HttpContext.Current.Session.Add("SelectedEmployeeId", FirstAvailEmployeeId);

                string currency = Employer.GetCurrency((int)HttpContext.Current.Session["SelectedEmployeeId"]);
                Thread.CurrentThread.CurrentCulture = new CultureInfo(currency);
                HttpContext.Current.Session["MemberCurrency"] = currency;
            }
            catch (Exception ex)
            {
                StackTrace stackTrace = new StackTrace();
                APTLog.LogException(ex, stackTrace.GetFrame(0).GetMethod().Name, APT2012AssemblyInfo.AssemblyInfo, APT2012AssemblyInfo.SUBSYSTEM);
                //throw ex;
            }
        }

        private static void loadAdminRole(string username)
        {
            try
            {
                // 1. Get First Scheme with Members which this Role is associated
                // 2. Set Session["SelectedSchemeId"]
                // 3. Set Session["SelectedMemberId"] from first member in scheme
                // 4. See Session["SelectedEmployeeId"] from selected member

                int FirstAvailSchemeId = Scheme.FirstSchemeForUser(username).Id;
                int FirstAvailMemberId = Scheme.GetFirstMember(FirstAvailSchemeId);
                int FirstAvailEmployeeId = Employment.GetEmployeeId(FirstAvailMemberId, FirstAvailSchemeId);
                HttpContext.Current.Session.Add("SelectedSchemeId", FirstAvailSchemeId);
                HttpContext.Current.Session.Add("SelectedMemberId", FirstAvailMemberId);
                HttpContext.Current.Session.Add("SelectedEmployeeId", FirstAvailEmployeeId);

                string currency = Employer.GetCurrency((int)HttpContext.Current.Session["SelectedEmployeeId"]);
                Thread.CurrentThread.CurrentCulture = new CultureInfo(currency);
                HttpContext.Current.Session["MemberCurrency"] = currency;
            }
            catch (Exception ex)
            {
                StackTrace stackTrace = new StackTrace();
                APTLog.LogException(ex, stackTrace.GetFrame(0).GetMethod().Name, APT2012AssemblyInfo.AssemblyInfo, APT2012AssemblyInfo.SUBSYSTEM);
                //throw ex;
            }
        }

        public static void SetThreadCulture()
        {          
            //Set the currency (CurrentCulture)
            try
            {
                if (HttpContext.Current.Session["MemberCurrency"] == null)
                {
                    if (HttpContext.Current.Session["SelectedEmployeeId"] == null)
                    {
                        Thread.CurrentThread.CurrentCulture = new CultureInfo("en-IE");
                        HttpContext.Current.Session["MemberCurrency"] = "en-IE";
                    }
                    else
                    {
                        string currency = Employer.GetCurrency((int)HttpContext.Current.Session["SelectedEmployeeId"]);
                        Thread.CurrentThread.CurrentCulture = new CultureInfo(currency);
                        HttpContext.Current.Session["MemberCurrency"] = currency;
                    }
                }
                else if (HttpContext.Current.Session["MemberCurrency"] == "en-IE")
                {                    
                    Thread.CurrentThread.CurrentCulture = new CultureInfo("en-IE");                    
                }
                else if (HttpContext.Current.Session["MemberCurrency"] == "en-GB")
                {
                    Thread.CurrentThread.CurrentCulture = new CultureInfo("en-GB");
                }
            }
            catch (Exception ex)
            {
                Thread.CurrentThread.CurrentCulture = new CultureInfo("en-IE");

                StackTrace stackTrace = new StackTrace();
                APTLog.LogException(ex, stackTrace.GetFrame(0).GetMethod().Name, APT2012AssemblyInfo.AssemblyInfo, APT2012AssemblyInfo.SUBSYSTEM);
            }

            Thread.CurrentThread.CurrentUICulture = Thread.CurrentThread.CurrentCulture;

            //APTLog.LogMessage("CurrentCulture=" + Thread.CurrentThread.CurrentCulture.Name);
            //APTLog.LogMessage("CurrentUICulture=" + Thread.CurrentThread.CurrentUICulture.Name);
        }

        private static void loadMemberRole(string username)
        {
            try
            {
                // 1. Get MemberId from User Profile
                // 2. Set Session["SelectedMemberId"]
                // 3. Set Session["SelectedSchemeId"]
                // 4. See Session["SelectedEmployeeId"] from selected member

                int memberId = (int)ProfileBase.Create(username).GetPropertyValue("MemberId");
                using (APT2012Entities APTEntities = new APT2012Entities())
                {
                    ObjectQuery<MemberScheme> memberScheme = APTEntities.MemberScheme;
                    var schemeResults = from ms in memberScheme
                                        where ms.MemberId.Equals(memberId)
                                        orderby ms.Scheme.Description
                                        select ms;

                    if (schemeResults.Count() > 0)
                    {
                        int schemeId = schemeResults.First().SchemeId;
                        HttpContext.Current.Session.Add("SelectedSchemeId", schemeId);
                        int employeeId = Employment.GetEmployeeId(memberId, schemeId);
                        if (employeeId != -1)
                        {
                            HttpContext.Current.Session.Add("SelectedEmployeeId", employeeId);
                        }
                    }

                    HttpContext.Current.Session.Add("SelectedMemberId", memberId);
                }

                string currency = Employer.GetCurrency((int)HttpContext.Current.Session["SelectedEmployeeId"]);
                Thread.CurrentThread.CurrentCulture = new CultureInfo(currency);
                HttpContext.Current.Session["MemberCurrency"] = currency;

                  ////Set the members language
                if (Member.GetLanguageSpoken(memberId) == "RUS")
                {
                    HttpContext.Current.Session["MemberLanguage"] = "ru-RU";
                    Thread.CurrentThread.CurrentUICulture = new CultureInfo("ru-RU");
                }

                // Set the active threads culture and UICulture. 
                SetThreadCulture();
            }
            catch (Exception ex)
            {
                StackTrace stackTrace = new StackTrace();
                APTLog.LogException(ex, stackTrace.GetFrame(0).GetMethod().Name, APT2012AssemblyInfo.AssemblyInfo, APT2012AssemblyInfo.SUBSYSTEM);
                //throw ex;
            }
        }

        //protected void Application_AuthenticateRequest(object sender, EventArgs e)
        //{

        //}

        //protected void Application_AuthorizeRequest(object sender, EventArgs e)
        //{

        //}
    }
}






//////Set the language (CurrentUICulture)
//try
//{
//    if (HttpContext.Current.Session["MemberLanguage"] != null)
//    {
//        if ((string)HttpContext.Current.Session["MemberLanguage"] == "ru-RU")
//        {
//            Thread.CurrentThread.CurrentUICulture = new CultureInfo("ru-RU");
//        }
//    }
//}
//catch (Exception ex)
//{
//    StackTrace stackTrace = new StackTrace();
//    APTLog.LogException(ex, stackTrace.GetFrame(0).GetMethod().Name, APT2012AssemblyInfo.AssemblyInfo, APT2012AssemblyInfo.SUBSYSTEM);
//    //throw ex;
//}