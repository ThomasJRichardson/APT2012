using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Configuration;
using APT.UTIL;
using System.Diagnostics;
using System.Data;
using APT.Model;
using System.Web.Script.Services;
using System.Text;


namespace APT2012.ws
{
    /// <summary>
    /// Summary description for Performance
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    [System.Web.Script.Services.ScriptService]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    // [System.Web.Script.Services.ScriptService]
    public class Performance : System.Web.Services.WebService
    {

        [WebMethod(true)]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public string loadFunds(string strFunds)
        {
            StringBuilder s = new StringBuilder();
            string sel = "";
            int memberId = -1;
            if (HttpContext.Current.Session["SelectedMemberId"] != null)
                memberId = (int)HttpContext.Current.Session["SelectedMemberId"];

            DataTable dt = Fund.GetMemberFunds(memberId);
            if (dt != null)
            {
                if (dt.Rows.Count > 0)
                {
                    foreach (DataRow dr in dt.Rows)
                    {
                        if (strFunds != "")
                        {
                            if (strFunds.IndexOf(dr["FundId"].ToString()) != -1)
                            {
                                sel = " selected";
                            }
                            else
                            {
                                sel = "";
                            }
                        }

                        s.Append("<option " + sel + " value=\"" + dr["FundId"].ToString() + "\" >" + dr["FundDesc"].ToString() + "</option>");
                    }
                }
            }
            return s.ToString();
        }

    }
}
