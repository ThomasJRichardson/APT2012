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
using System.Web.Security;

namespace APT2012
{
    public partial class Default : APTBasePage //System.Web.UI.Page
    {
        internal class ResxResourceManager : ResourceManager
        {
            public ResxResourceManager(string baseName, string resourceDir)
            {
                try
                {
                    BaseNameField = baseName;
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
                // Prevent caching, so can't be viewed offline
                Response.Cache.SetCacheability(HttpCacheability.NoCache);

                string username = Session["LoginUserName"].ToString();

                var ip_usernameprefix = Utility.GetAppSettingValue("IPPP_UserNamePrefix");
                if (username.ToUpper().StartsWith(ip_usernameprefix.ToUpper()))
                {
                    Response.Redirect("~/IPPP/Index.aspx", false);
                }
                else
                {
                    var ry_usernameprefix = Utility.GetAppSettingValue("RY_UserNamePrefix");
                    if (username.ToUpper().StartsWith(ry_usernameprefix.ToUpper()))
                    {
                        Response.Redirect("~/RY/Index.aspx", false);
                    }
                    else
                    {
                        string[] roles = Roles.GetRolesForUser(username);

                        if (roles.Contains("Scheme Admin") || roles.Contains("HR Admin") || roles.Contains("APT Admin"))
                        {
                            Response.Redirect("~/SchemeOverview.aspx", false);
                        }
                        else
                        {
                            Response.Redirect("~/MemberOverview.aspx", false);
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                StackTrace stackTrace = new StackTrace();
                APTLog.LogException(ex, stackTrace.GetFrame(0).GetMethod().Name, APT2012AssemblyInfo.AssemblyInfo, APT2012AssemblyInfo.SUBSYSTEM);
                //throw ex;
                // If irregular error occurs with Session LoginUserName, default to Memberoverview.aspx 
                Response.Redirect("~/MemberOverview.aspx", false);
            }
        }
    }
}
//FormsAuthentication.SetAuthCookie(value, false);