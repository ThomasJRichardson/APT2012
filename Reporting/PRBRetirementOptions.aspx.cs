using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using Microsoft.Reporting.WebForms;
using APT.Model;
using APT.UTIL;
using System.Diagnostics;
using APT2012.DATES;
using System.Web.Configuration;
using System.Data;

namespace APT2012
{
    public partial class PRBRetirementOptions : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                int selectedSchemeId = (int)Session["SelectedSchemeId"];
                int selectedMemberId = (int)Session["SelectedMemberId"];
                int selectedEmployeeId = (int)Session["SelectedEmployeeId"];
                int MemberAge = 0;
                if (!IsPostBack)
                {
                    if (Session["SelectedMemberId"] != null)
                    {
                        Benefit benefit = Benefit.GetDetails(selectedMemberId);
                        DataTable dtMemberAge = Member.GetMemberAge(Convert.ToInt32(selectedMemberId));                        
                        MemberAge= int.Parse(dtMemberAge.Rows[0]["Age"].ToString());
                        if (benefit != null)
                        {
                            if ((benefit.IsARF != null) || (MemberAge < 50))
                            {
                                Response.Redirect("~/SchemeOverview.aspx");
                            }
                        }
                    }

                    //DateManager.SetDefaultDate(calendarButtonExtender, selectedSchemeId, selectedMemberId);

                    //GenerateLeavingServiceOptions(calendarButtonExtender.SelectedDate.Value, APTUtil.GetSigningName());        
                    GenerateLeavingServiceOptions();
                }


            }
            catch (Exception ex)
            {
                StackTrace stackTrace = new StackTrace();
                APTLog.LogException(ex, stackTrace.GetFrame(0).GetMethod().Name, APT2012AssemblyInfo.AssemblyInfo, APT2012AssemblyInfo.SUBSYSTEM);
                //throw ex;
            }
        }


        //private void GenerateLeavingServiceOptions(DateTime runDate, string sSigningName)
        private void GenerateLeavingServiceOptions()
        {
            try
            {
                int selectedSchemeId = (int)Session["SelectedSchemeId"];
                int selectedMemberId = (int)Session["SelectedMemberId"];
                int selectedEmployeeId = (int)Session["SelectedEmployeeId"];

                List<ReportParameter> rp = new List<ReportParameter>();
                rp.Add(new ReportParameter("MemberID", selectedMemberId.ToString()));
                //rp.Add(new ReportParameter("RunDate", runDate.ToString("yyyy MMM dd")));
                //rp.Add(new ReportParameter("LetterSigningName", sSigningName));
                //rp.Add(new ReportParameter("IsAPTREPORTING", "false"));
                rp.Add(new ReportParameter("DisplayAPTLogo", "True"));
                rp.Add(new ReportParameter("Currency", Employer.GetCurrency(selectedEmployeeId)));

                ReportViewer1.ServerReport.ReportPath = "/APT.Reports/APTRetirementOptions";
                ReportViewer1.ServerReport.ReportServerUrl = new Uri(ConfigurationManager.AppSettings["ReportServerUrl"]);
                ReportViewer1.ServerReport.ReportServerCredentials = new ReportCredentials(ConfigurationManager.AppSettings["ReportServerUser"], ConfigurationManager.AppSettings["ReportServerPassword"], ConfigurationManager.AppSettings["ReportServerDomain"]);
                ReportViewer1.ServerReport.SetParameters(rp);
                ReportViewer1.ShowParameterPrompts = false;
                ReportViewer1.ServerReport.Refresh();
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