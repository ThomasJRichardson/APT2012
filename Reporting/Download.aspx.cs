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
    public partial class Download : APTBasePage // System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                byte[] file = Document.GetFile(Convert.ToInt32(Request.QueryString["fileid"]), Request.QueryString["filename"]);
                if (file == null)
                {
                    APTLog.LogMessage("File not found , FileId=" + Convert.ToInt32(Request.QueryString["fileid"]) + ", Filename" + Request.QueryString["filename"]);
                    Response.Write("File not found");
                }
                else
                {
                    Response.ClearContent();
                    Response.ClearHeaders();
                    Response.AddHeader("ContentType", "application/octet-stream");
                    Response.AddHeader("Content-Disposition", "attachment;filename=" + Request.QueryString["filename"]);

                    Response.BinaryWrite(file);
                    Response.End();
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
