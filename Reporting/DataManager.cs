using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using APT.UTIL;
using System.Diagnostics;
using APT.Model;

namespace APT2012.DATES
{
    public class DateManager
    {
        public static void SetDefaultDate(AjaxControlToolkit.CalendarExtender calExt,int selectedSchemeId,int selectedMemberId)
        {
            // Min date is 01/01/2012
            DateTime minDate = new DateTime(2012, 1, 1);
            calExt.StartDate = minDate;

            //// Max date is today.
            DateTime maxDate = DateTime.Today;
            calExt.EndDate = maxDate;

            //// Default setting is the last renewal date  // eg. for LUND => 01/12/2011  
            DateTime lastRenewalDate = MemberModelViewReporting.GetSchemeLastRenewalDate(selectedSchemeId, selectedMemberId);

            if (lastRenewalDate < minDate)
            {
                 calExt.SelectedDate = minDate;
            }
            else
            {
                calExt.SelectedDate = lastRenewalDate;
            }
        }

        public static DateTime GetRunDate(string sSelectedDate)
        {
            DateTime runDate = new DateTime(2012, 1, 1);
            DateTime runDefaultDate = new DateTime(2012, 1, 1);
            try
            {
                int result1 = 0;
                string s = sSelectedDate; // txtRunDate.Text;
                string[] tokens = s.Split(new char[] { '\\', '/' });
                int.TryParse(tokens[2], out result1);
                int year = result1;
                int.TryParse(tokens[1], out result1);
                int Month = result1;
                int.TryParse(tokens[0], out result1);
                int day = result1;
                runDate = new DateTime(year, Month, day);

                if (runDate > DateTime.Today)
                    runDate = DateTime.Today;
            }
            catch (Exception ex)
            {
                runDate = runDefaultDate;                
                StackTrace stackTrace = new StackTrace();
                APTLog.LogException(ex, stackTrace.GetFrame(0).GetMethod().Name, APT2012AssemblyInfo.AssemblyInfo, APT2012AssemblyInfo.SUBSYSTEM);
            }
            return runDate;
        }
    }
}