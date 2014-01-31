using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.Objects;
using System.Configuration;
using APT.Model;
using APT.UTIL;
using System.Diagnostics;
using System.Collections.Specialized;
using System.Data;

namespace APT2012
{
    public partial class Site : System.Web.UI.MasterPage
    {
        SiteMapDataSource ds = new SiteMapDataSource();
        SiteMapDataSource ds2 = new SiteMapDataSource();

        private void LoadSiteMap()
        {

        }

        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (!IsPostBack)
                {
                    if (ds == null || ds2 == null)
                    {
                        APTLog.LogMessage("ERROR: ds or ds2 is NULL. web.sitemap will not be read! ***");
                    }

                    if (rptSideNav == null)
                    {
                        APTLog.LogMessage("ERROR: rptSideNav is NULL. web.sitemap will not be read! ***");
                    }

                    ds2.StartingNodeOffset = 1;
                    ds2.ShowStartingNode = false;
                    rptSideNav.DataSource = ds2;
                    rptSideNav.DataBind();

                    if (SiteMap.Provider == null)
                    {
                        APTLog.LogMessage("ERROR: SiteMap.Provider  is NULL!!!");
                       
                    }

                    if (SiteMap.Provider.Description != null)
                        APTLog.LogMessage("SiteMap.Provider.Description =" + SiteMap.Provider.Description);

                    if (SiteMap.Provider.Name != null)
                        APTLog.LogMessage("SiteMap.Provider.Name =" + SiteMap.Provider.Name);

                    try
                    {
                        this.Page.Header.DataBind(); //Binds absolute javascript urls depending on application path
                    
                        APTLog.LogMessage("Current Node = " + SiteMap.CurrentNode.Title.ToString());
                        this.Page.Title = SiteMap.CurrentNode.Title + " - " + ConfigurationManager.AppSettings["SiteTitle"];
                    }
                    catch (Exception ex)
                    {
                        StackTrace stackTrace = new StackTrace();
                        APTLog.LogException(ex, stackTrace.GetFrame(0).GetMethod().Name, APT2012AssemblyInfo.AssemblyInfo, APT2012AssemblyInfo.SUBSYSTEM);
                    }

                    
                    int MemberId = Convert.ToInt32(Session["SelectedMemberId"]);

                    Member member1 = Member.GetMemberById(MemberId);
                    if (member1 != null)
                    {
                        lblMemberNameValue.Text = member1.Forename + " " + member1.Surname;
                    }

                    lblActiveSchemesValue.Text = Scheme.GetSchemeDetails(Convert.ToInt32(Session["SelectedSchemeId"])).Description;

                    string companyImageUrl = Scheme.getSchemeImage(Convert.ToInt32(Session["SelectedSchemeId"]));
                    if (companyImageUrl != null && companyImageUrl.Trim() != "")
                    {
                        imgCompanyLogo.ImageUrl = "Graphics/" + companyImageUrl;
                    }

                    // Default a logo if the file is not present or database misconfigured.
                    String AbsRootPath = Server.MapPath("~");
                    AbsRootPath = AbsRootPath + "/" + imgCompanyLogo.ImageUrl;
                   
                    System.IO.FileInfo fs = new System.IO.FileInfo(AbsRootPath);
                    if (!fs.Exists)
                    {
                        APTLog.LogMessage("WARNING: Logo Image Path not found. Path=" + AbsRootPath);
                        imgCompanyLogo.ImageUrl = "Graphics/APT.gif";     // Default a logo if the file is not present or database misconfigured.
                    } 

                    Response.CacheControl = "no-cache";
                    Response.Expires = -1;

                    if (HttpContext.Current.User.IsInRole("APT Admin")
                        || HttpContext.Current.User.IsInRole("Scheme Admin")
                        || HttpContext.Current.User.IsInRole("HR Admin"))
                    {
                        litMemberChange.Text = "(<a href=\"javascript:apt();\" id=\"member-change\">Change</a>)";
                        litSchemeChange.Text = "(<a href=\"javascript:apt();\" id=\"scheme-change\">Change</a>)";
                    }

                    ds.ShowStartingNode = false;
                    siteMapAsBulletedList.DataSource = ds;
                    siteMapAsBulletedList.DataBind();

                    if (HttpContext.Current.User != null)
                    {
                        lblFullName.Text = HttpContext.Current.User.Identity.Name;
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

        protected string checkNode(string url)
        {
            try
            {
                APTLog.LogMessage("URL BEING CHECKED = " + url);

                if (SiteMap.CurrentNode.Url == url)
                {
                    APTLog.LogMessage("SiteMap.CurrentNode.Url = " + SiteMap.CurrentNode.Url.ToString());
                    return "active";
                }
                else if (SiteMap.CurrentNode.ParentNode.Url == url)
                {
                    APTLog.LogMessage("SiteMap.CurrentNode.ParentNode.Url = " + SiteMap.CurrentNode.ParentNode.Url.ToString());
                    return "active";
                }
                else if (SiteMap.CurrentNode.ParentNode.ParentNode.Url == url)
                {
                    APTLog.LogMessage("SiteMap.CurrentNode.ParentNode.ParentNode.Url = " + SiteMap.CurrentNode.ParentNode.ParentNode.Url.ToString());
                    return "active";
                }
                else if (SiteMap.CurrentNode.Url == url + "#")
                {
                    APTLog.LogMessage("SiteMap.CurrentNode.Url" + SiteMap.CurrentNode.Url.ToString());
                    return "active";
                }
                else
                {
                    APTLog.LogMessage("SiteMap.CurrentNode.Url is blank!!!");
                    return "";
                }
            }
            catch(Exception ex)
            {
                APTLog.LogException(ex, "checkNote", "Error in CheckNote function", "APT2012");
                return "";
            }

        }

        protected void RemoveNonVisibleItemsRpt(object sender, RepeaterItemEventArgs e)
        {
            SiteMapNode node = (SiteMapNode)e.Item.DataItem;
            string strNodeName = "";
            bool blnARF = false;

            if (node != null)
            {
                blnARF = false;
                strNodeName = node.Title.Trim().ToUpper();

                if (!string.IsNullOrEmpty(node["visible"]))
                {
                    e.Item.Visible = false;
                    //Menu1.Items.Remove(e.Item);
                }

                int selectedMemberId = 0;

                if (node.Url.Contains("PRBSchedule") || node.Url.Contains("/Reporting/PRB"))
                {
                    if (HttpContext.Current.Session["SelectedSchemeId"] != null)
                    {
                        int SchemeId = (int)HttpContext.Current.Session["SelectedSchemeId"];
                        string currency = Employer.GetCurrency((int)HttpContext.Current.Session["SelectedEmployeeId"]);

                        if (Report.IsVisibleForScheme(Convert.ToInt32(node["ReportId"]), SchemeId, currency))
                        {
                            e.Item.Visible = true;
                            return;
                        }
                        else
                        {
                            e.Item.Visible = false;
                        }
                    }
                }
                //if (node.Url.Contains("PRBSchedule") || node.Url.Contains("/Reporting/PRB"))

                if (node.Url.Contains("/Contributions.aspx") || node.Url.Contains("/InvestmentStrategy.aspx"))
                {
                    if (HttpContext.Current.Session["SelectedMemberId"] != null)
                    {
                        selectedMemberId = (int)HttpContext.Current.Session["SelectedMemberId"];
                        Benefit benefit = Benefit.GetDetails(selectedMemberId);
                        if (benefit != null)
                        {
                            if (benefit.IsARF != null)
                            {
                                e.Item.Visible = false;
                                //Menu1.Items.Remove(e.Item);
                            }
                        }
                    }
                }
                //if (node.Url.Contains("/Contributions.aspx") || node.Url.Contains("/InvestmentStrategy.aspx"))

                if (node.Url.Contains("/Reporting/") && !(node.Url.Contains("PRBSchedule") || node.Url.Contains("/Reporting/PRB")))
                {
                    if (HttpContext.Current.Session["SelectedMemberId"] != null)
                    {
                        selectedMemberId = (int)HttpContext.Current.Session["SelectedMemberId"];
                        Benefit benefit = Benefit.GetDetails(selectedMemberId);

                        if (!node.Url.Contains("/Reporting/Reporting.aspx"))
                        {
                            if (benefit != null)
                            {
                                if (benefit.IsARF != null)
                                {
                                    blnARF = true;
                                    if (!node.Url.Contains("/Reporting/ARFInvestmentStatement.aspx"))
                                    {
                                        e.Item.Visible = false;
                                        //Menu1.Items.Remove(e.Item);
                                    }
                                    if (node.Url.Contains("/Reporting/LeavingServiceOptions.aspx"))
                                    {
                                        e.Item.Visible = false;
                                        //Menu1.Items.Remove(e.Item);
                                    }

                                }
                                else
                                {
                                    if (node.Url.Contains("/Reporting/ARFInvestmentStatement.aspx"))
                                    {
                                        //rptSideNav.Items[ e.Item.Visible=false; ItemIndex].Controls.Clear();
                                        e.Item.Visible=false;
                                        //Menu1.Items.Remove(e.Item);
                                    }
                                }

                            }
                        }
                        //if (!node.Url.Contains("/Reporting/Reporting.aspx"))

                        if (node.Url.Contains("BenefitStatement"))
                        {
                            if (!string.IsNullOrEmpty(node["ReportId"]))
                            {
                                if (HttpContext.Current.Session["SelectedSchemeId"] != null)
                                {
                                    int SchemeId = (int)HttpContext.Current.Session["SelectedSchemeId"];
                                    string currency = Employer.GetCurrency((int)HttpContext.Current.Session["SelectedEmployeeId"]);

                                    if (Report.IsVisibleForScheme(Convert.ToInt32(node["ReportId"]), SchemeId, currency) &&
                                        Report.IsValidMemberBenefitStatus(selectedMemberId))
                                    {
                                        e.Item.Visible = true;
                                        return;
                                    }
                                    else
                                    {
                                        e.Item.Visible = false;
                                    }
                                }
                            }
                        }
                        //if (node.Url.Contains("BenefitStatement"))

                    }
                    //if (HttpContext.Current.Session["SelectedMemberId"] != null)

                }
                //if (node.Url.Contains("/Reporting/") && !(node.Url.Contains("PRBSchedule") || node.Url.Contains("/Reporting/PRB")))

                if ((!string.IsNullOrEmpty(node["ReportId"])) && (strNodeName.ToUpper() != "LEAVING SERVICE OPTIONS") && (!blnARF))
                {
                    if (HttpContext.Current.Session["SelectedSchemeId"] != null)
                    {
                        string currency = Employer.GetCurrency((int)HttpContext.Current.Session["SelectedEmployeeId"]);                        

                        int SchemeId = (int)HttpContext.Current.Session["SelectedSchemeId"];
                        if (Report.IsVisibleForScheme(Convert.ToInt32(node["ReportId"]), SchemeId, currency))
                        {
                            e.Item.Visible = true;
                            //Menu1.Items.Remove(e.Item);
                        }
                        else
                        {
                            e.Item.Visible = false;
                        }
                    }
                }
                //if ((!string.IsNullOrEmpty(node["ReportId"])) && (strNodeName.ToUpper() != "LEAVING SERVICE OPTIONS") && (!blnARF))

                //PRB LEAVING SERVICE OPTIONS
                if (strNodeName.ToUpper() == "LEAVING SERVICE OPTIONS")
                {
                    if (HttpContext.Current.Session["SelectedMemberId"] != null)
                    {
                        selectedMemberId = (int)HttpContext.Current.Session["SelectedMemberId"];
                        Benefit benefit = Benefit.GetDetails(selectedMemberId);
                        if (benefit != null)
                        {
                            if (benefit.Description == "APT PRB")                        
                                e.Item.Visible = false;
                        }
                    }
                }

                //PRB LEAVING SERVICE OPTIONS
                if (strNodeName.ToUpper() == "RETIREMENT OPTIONS")
                {
                    if (HttpContext.Current.Session["SelectedMemberId"] != null)
                    {
                        selectedMemberId = (int)HttpContext.Current.Session["SelectedMemberId"];
                        int MemberAge = 0;
                        DataTable dtMemberAge = Member.GetMemberAge(Convert.ToInt32(selectedMemberId));
                        MemberAge = int.Parse(dtMemberAge.Rows[0]["Age"].ToString());
                        if (MemberAge < 50)                        
                            e.Item.Visible = false;
                        else
                            e.Item.Visible = true;
                    }
                }


            }
        }

     

        protected void logout_LoggedOut(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();
        }
    }
}






//if (SiteMap.CurrentNode == null)
//{
//    //// Create an instance of the XmlSiteMapProvider class.
//    //XmlSiteMapProvider testXmlProvider = new XmlSiteMapProvider();
//    //NameValueCollection providerAttributes = new NameValueCollection(1);
//    //providerAttributes.Add("siteMapFile", "~/web.sitemap");

//    //// Initialize the provider with a provider name and file name.
//    //testXmlProvider.Initialize("testProvider", providerAttributes);

//    //// Call the BuildSiteMap to load the site map information into memory.
//    //testXmlProvider.BuildSiteMap();                        
//}





//protected void RemoveNonVisibleItems(object sender, MenuEventArgs e)
//{
//    SiteMapNode node = e.Item.DataItem as SiteMapNode;
//    if (!string.IsNullOrEmpty(node["visible"]))
//    {
//        Menu1.Items.Remove(e.Item);
//    }
//    int selectedMemberId = 0;

//    if (node.Url.Contains("/Contributions.aspx") || node.Url.Contains("/InvestmentStrategy.aspx"))
//    {
//        if (HttpContext.Current.Session["SelectedMemberId"] != null)
//        {
//            selectedMemberId = (int)HttpContext.Current.Session["SelectedMemberId"];
//            Benefit benefit = Benefit.GetDetails(selectedMemberId);
//            if (benefit != null)
//            {
//                if (benefit.IsARF != null)
//                {
//                    Menu1.Items.Remove(e.Item);
//                }
//            }
//        }
//    }
//    if (node.Url.Contains("/Reporting/"))
//    {
//        if (HttpContext.Current.Session["SelectedMemberId"] != null)
//        {
//            selectedMemberId = (int)HttpContext.Current.Session["SelectedMemberId"];
//            Benefit benefit = Benefit.GetDetails(selectedMemberId);
//            if (!node.Url.Contains("/Reporting/Reporting.aspx"))
//            {
//                if (benefit != null)
//                {
//                    if (benefit.IsARF != null)
//                    {
//                        if (!node.Url.Contains("/Reporting/ARFInvestmentStatement.aspx"))
//                        {
//                            Menu1.Items.Remove(e.Item);
//                        }
//                    }
//                    else
//                    {
//                        if (node.Url.Contains("/Reporting/ARFInvestmentStatement.aspx"))
//                        {
//                            Menu1.Items.Remove(e.Item);
//                        }
//                    }

//                }
//            }
//        }

//    }

//    if (!string.IsNullOrEmpty(node["ReportId"]))
//    {
//        if (HttpContext.Current.Session["SelectedSchemeId"] != null)
//        {
//            int SchemeId = (int)HttpContext.Current.Session["SelectedSchemeId"];
//            if (!Report.IsVisibleForScheme(Convert.ToInt32(node["ReportId"]), SchemeId))
//            {
//                Menu1.Items.Remove(e.Item);
//            }
//        }
//    }
//}