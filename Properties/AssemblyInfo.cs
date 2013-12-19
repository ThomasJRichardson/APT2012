using System.Reflection;
using System.Runtime.CompilerServices;
using System.Runtime.InteropServices;
using System;
using System.Diagnostics;
using APT.UTIL;

// General Information about an assembly is controlled through the following 
// set of attributes. Change these attribute values to modify the information
// associated with an assembly.
[assembly: AssemblyTitle("APT2012")]
[assembly: AssemblyDescription("Allied Pensions Trustees")]
[assembly: AssemblyConfiguration("")]
[assembly: AssemblyCompany("Allied Pension Trustees")]
[assembly: AssemblyProduct("APT2012")]
[assembly: AssemblyCopyright("APT Copyright ©  2012")]
[assembly: AssemblyTrademark("")]
[assembly: AssemblyCulture("")]

// Setting ComVisible to false makes the types in this assembly not visible 
// to COM components.  If you need to access a type in this assembly from 
// COM, set the ComVisible attribute to true on that type.
[assembly: ComVisible(false)]

// The following GUID is for the ID of the typelib if this project is exposed to COM
[assembly: Guid("6862CBD3-703D-4DF4-8AB7-FE749AA14795")]

// Version information for an assembly consists of the following four values:
//
//      Major Version
//      Minor Version 
//      Build Number
//      Revision
//
// You can specify all the values or you can default the Revision and Build Numbers 
// by using the '*' as shown below:
[assembly: AssemblyVersion("2.0.0.0")]
[assembly: AssemblyFileVersion("2.0.0.0")]

public class APT2012AssemblyInfo
{
    public static string SUBSYSTEM { get { return "APT2012"; } }

    public static string AssemblyInfo
    {
        get
        {
            string sAssemblyDetails = "APT2012";
            try
            {
                Version v = System.Reflection.Assembly.GetExecutingAssembly().GetName().Version;
                Assembly a = System.Reflection.Assembly.GetExecutingAssembly();
                sAssemblyDetails = a.FullName + " - " + a.CodeBase + " - " + v.ToString();               
            }
            catch (Exception ex)
            {
                StackTrace StackTrace = new StackTrace();
                APTLog.LogException(ex, StackTrace.GetFrame(0).GetMethod().Name, "APT2012", APT2012AssemblyInfo.SUBSYSTEM);
                //throw ex;
            }
            return sAssemblyDetails;
        }
    }
}