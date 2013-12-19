using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using APT.Model;
using APT.UTIL;
using System.Diagnostics;

namespace APT2012
{
    public partial class Reporting : APTBasePage // System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (!IsPostBack)
                {
                    if (HttpContext.Current.Session["SelectedMemberId"] == null
                        || HttpContext.Current.Session["SelectedSchemeId"] == null)
                    {
                        return;
                    }

                    int memberId = (int)HttpContext.Current.Session["SelectedMemberId"];
                    int schemeId = (int)HttpContext.Current.Session["SelectedSchemeId"];

                    Document doc = new Document();
                    rptMemberDocuments.DataSource = doc.GetMemberDocuments(memberId);
                    rptMemberDocuments.DataBind();

                    rptSchemeDocuments.DataSource = doc.GetSchemeDocuments(schemeId);
                    rptSchemeDocuments.DataBind();

                    rptFundDocuments.DataSource = Member.GetFundDocuments(memberId);
                    rptFundDocuments.DataBind();

                    rptBenefitDocuments.DataSource = Member.GetBenefitDocuments(memberId);
                    rptBenefitDocuments.DataBind();
                }
            }
            catch (Exception ex)
            {
                StackTrace stackTrace = new StackTrace();
                APTLog.LogException(ex, stackTrace.GetFrame(0).GetMethod().Name, APT2012AssemblyInfo.AssemblyInfo, APT2012AssemblyInfo.SUBSYSTEM);
                //throw ex;
            }
        }

        protected string getIcon(string filename)
        {
            try
            {
                string iconClass = "icon-file-default";

                switch (filename.Substring(filename.LastIndexOf('.') + 1).ToLower())
                {
                    case "docx":
                    case "doc":
                        iconClass = "icon-file-doc";
                        break;
                    case "xlsx":
                    case "xls":
                        iconClass = "icon-file-xls";
                        break;
                    case "pdf":
                        iconClass = "icon-file-pdf";
                        break;
                }

                return iconClass;
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
}
