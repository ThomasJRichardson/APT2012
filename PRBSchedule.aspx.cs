using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.Reporting.WebForms;
using System.Configuration;
using APT.UTIL;
using System.Diagnostics;
using System.Data;
using APT.Model;
using System.Web.Services;

namespace APT2012
{
    public partial class PRBSchedule : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                //if (Session["LoginUserName"].ToString().ToUpper() == "APTDEMOADMIN")
                //{
                tblReports.Visible = true;
                tblUnderConstruction.Visible = false;

                if (HttpContext.Current.Session["SelectedMemberId"] != null)
                    pHidMemberID.Value = HttpContext.Current.Session["SelectedMemberId"].ToString();

                //DateTime dt = DateTime.Now;
                //DateTime fromDT = new DateTime(dt.Year-1,1,1);
                //DateTime toDT = dt;

                //txtSelectedSchemeId.Text = Session["SelectedSchemeId"].ToString();
                //txtSelectedEmployeeId.Text = Session["SelectedEmployeeId"].ToString();
                //txtPageLoad.Text = "1";

                //Load the Default Report.
                //LoadReport("FundUnitPriceGraph_Monthly", fromDT.ToShortDateString(), toDT.ToShortDateString(), pHidFunds.Value.ToString(), txtSelectedSchemeId.Text, (int)HttpContext.Current.Session["SelectedMemberId"], "MONTHLY");
                LoadReport("APTPRBSchedule",  (int)HttpContext.Current.Session["SelectedMemberId"]);
                //}
                //else
                //{
                //    tblReports.Visible = false;
                //    tblUnderConstruction.Visible = true;  
                //}
            }
            else
            {
                txtPageLoad.Text = "0";
            }
        }
        DateTime LastDayOfQuarter(DateTime today)
        {
            int quarter = (today.Month - 1) / 3;
            int lastMonthInQuarter = (quarter + 1) * 3;
            int lastDayInMonth = DateTime.DaysInMonth(today.Year, lastMonthInQuarter);
            return new DateTime(today.Year, lastMonthInQuarter, lastDayInMonth);
        }

        //private void LoadReport(string ReportName, string fromDate, string ToDate, string Funds, string selectedSchemeId, int memberid, string strReportType)
        private void LoadReport(string ReportName, int memberid)
        {
            List<ReportParameter> rp = new List<ReportParameter>();
            //rp.Add(new ReportParameter("SchemeID", selectedSchemeId));
            //rp.Add(new ReportParameter("StartDate", fromDate));
            //rp.Add(new ReportParameter("EndDate", ToDate));
            //if (Funds == "")
            //{
            //    rp.Add(new ReportParameter("FundIDs", ""));
            //}
            //else
            //{
            //    rp.Add(new ReportParameter("FundIDs", Funds));
            //}
            if (memberid > 0)
            {
                rp.Add(new ReportParameter("MemberID", memberid.ToString()));
            }
            //rp.Add(new ReportParameter("ReportType", ddlReportType.SelectedValue.ToString().ToUpper() ));
            //if (ReportName == "FundUnitPriceGraph_Monthly" && strReportType == "DATETODATE")
            //{
            //    strReportType = "MONTHLY";
            //}

            //rp.Add(new ReportParameter("ReportType", strReportType));

            //rp.Add(new ReportParameter("SchemeID", "1907534"));
            //rp.Add(new ReportParameter("StartDate", "01/01/2007"));
            //rp.Add(new ReportParameter("EndDate", "31/12/2012"));
            //rp.Add(new ReportParameter("FundIDs", "1261128,1265328,1270002,1283961,1258204"));

            ReportViewer1.ServerReport.ReportPath = "/APT.Reports/" + ReportName;

            ReportViewer1.ServerReport.ReportServerUrl = new Uri(ConfigurationManager.AppSettings["ReportServerUrl"]);
            ReportViewer1.ServerReport.ReportServerCredentials = new ReportCredentials(ConfigurationManager.AppSettings["ReportServerUser"], ConfigurationManager.AppSettings["ReportServerPassword"], ConfigurationManager.AppSettings["ReportServerDomain"]);
            ReportViewer1.ServerReport.SetParameters(rp);
            ReportViewer1.ShowParameterPrompts = false;
            //ReportViewer1.ShowParameterPrompts = (ReportName == "FundUnitPriceGraph_Monthly");

            ReportViewer1.ServerReport.Refresh();
        }

        protected void btnReport_Click(object sender, EventArgs e)
        {
            //string Reporttype = "";
            //Reporttype = "MONTHLY";
            //DateTime dt = DateTime.Now;
            //DateTime fromDT = new DateTime(dt.Year - 1, 1, 1);
            //DateTime toDT = dt;

            //Load the Default Report.
            //LoadReport("APTPRBSchedule", fromDT.ToShortDateString(), toDT.ToShortDateString(), pHidFunds.Value.ToString(), Session["SelectedSchemeId"].ToString(), (int)HttpContext.Current.Session["SelectedMemberId"], Reporttype);
            LoadReport("APTPRBSchedule", (int)HttpContext.Current.Session["SelectedMemberId"]);
        }

    }
}