<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ARFInvestmentStatement.aspx.cs" Inherits="APT2012.ARFInvestmentStatement" meta:resourcekey="PageResource1" %>
<%@ Register assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a" namespace="Microsoft.Reporting.WebForms" tagprefix="rsweb" %>
<asp:Content ID="ContentHead" ContentPlaceHolderID="ContentPlaceHolderHead" runat="server">    
    <link rel="stylesheet" type="text/css" media="screen,print" href="~/APTTHEME/APT01/APTStyleContent.css" />    
    <link rel="stylesheet" type="text/css" media="print" href="~/APTTHEME/APT01/APTStylePrint.css" />
    <link href="../APTTHEME/APT01/jquery-ui.css" rel="stylesheet" type="text/css" />
    <script src="../js/jquery/jengine.js" type="text/javascript"></script>
    <script src="../js/ui.dropdownchecklist-1.4-min.js" type="text/javascript"></script>

    <script type="text/javascript">


        $(document).ready(function () {

            $("#<%=btnReport.ClientID%>").click(function (e) {

                //e.preventDefault();
                //Validate From Date
                var txtFromDate = $('#<%=txtFromDate.ClientID%>').val();
                //get the date value
                if (txtFromDate != "") {
                    //Validate Date
                    if (!isDate(txtFromDate)) {
                        alert("Please enter a valid date in 'dd/mm/yyyy' format.");
                        $('#<%=txtFromDate.ClientID%>').focus();
                        return false;
                    }
                }
                else {

                    alert("Please enter a Start Date");
                    $('#<%=txtFromDate.ClientID%>').focus();
                    return false;
                }

                //Validate To Date
                var txtToDate = $('#<%=txtToDate.ClientID%>').val();
                //get the date value
                if (txtToDate != "") {
                    //Validate Date
                    if (!isDate(txtToDate)) {
                        alert("Please enter a valid date in 'dd/mm/yyyy' format.");
                        $('#<%=txtToDate.ClientID%>').focus();
                        return false;
                    }
                }
                else {

                    alert("Please enter an End Date");
                    $('#<%=txtToDate.ClientID%>').focus();
                    return false;
                }


                if ((txtFromDate != "") && (txtToDate != "")) {

                    //Check the date Validations Compare the dates
                    if ((new Date(txtFromDate).getTime() > new Date(txtToDate).getTime())) {
                        alert("Please enter a Start Date less than the End Date.");
                        $('#<%=txtFromDate.ClientID%>').focus();
                        return false;
                    }

                    //Check the year Validation
                    var currentYear = (new Date).getFullYear();
                    var MinYear = 2012;
                    var startyear = new Date(txtFromDate).getFullYear();
                    var endyear = new Date(txtToDate).getFullYear();

                    if (startyear < MinYear) {
                        alert("Please enter a Start Date starting from the year - '" + MinYear + "'");
                        $('#<%=txtFromDate.ClientID%>').focus();
                        return false;
                    }

                    if (endyear < MinYear) {
                        alert("Please enter an End Date starting from the year - '" + MinYear + "'");
                        $('#<%=txtToDate.ClientID%>').focus();
                        return false;
                    }

                }

            });

            function isDate(txtDate) {
                var currVal = txtDate;
                if (currVal == '')
                    return false;
                //Declare Regex 
                var rxDatePattern = /^(\d{1,2})(\/|-)(\d{1,2})(\/|-)(\d{4})$/;
                var dtArray = currVal.match(rxDatePattern); // is format OK?

                if (dtArray == null)
                    return false;

                //Checks for dd/mm/yyyy format.
                dtDay = dtArray[1];
                dtMonth = dtArray[3];
                dtYear = dtArray[5];

                //Do the Checking
                if (dtMonth < 1 || dtMonth > 12)
                    return false;
                else if (dtDay < 1 || dtDay > 31)
                    return false;
                else if ((dtMonth == 4 || dtMonth == 6 || dtMonth == 9 || dtMonth == 11) && dtDay == 31)
                    return false;
                else if (dtMonth == 2) {
                    var isleap = (dtYear % 4 == 0 && (dtYear % 100 != 0 || dtYear % 400 == 0));
                    if (dtDay > 29 || (dtDay == 29 && !isleap))
                        return false;
                }
                return true;
            }

        });
             
    </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolderPageTitle" runat="server">
<asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
<script type="text/javascript">
    Sys.Application.add_init(function () {

        $(function () {
           
            $("#<%=txtFromDate.ClientID%>").datepicker({ dateFormat: "dd/mm/yy", changeYear: true, changeMonth: true });
            $("#<%=txtToDate.ClientID%>").datepicker({ dateFormat: "dd/mm/yy", changeYear: true, changeMonth: true });
        });

    }); 
    </script>
                 
        

    <div class="reporting">
        <! -- Change for Specific Icons -->
        <h2>
            <asp:Label runat="server" ID="lblPageHeader" Text="ARF Investment Statement" 
                meta:resourcekey="lblPageHeaderResource1" /></h2>
        <p class="h2-line">
            <asp:Label runat="server" ID="lblPageHeaderByline" 
                Text="ARF Investment Statement" 
                meta:resourcekey="lblPageHeaderBylineResource1" /></p>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server"> 
    
    <table cellpadding=3 cellspacing=2 border=0 >
            <td align=left nowrap colspan=3 >
                <b>Start Date:</b>                              
                <asp:TextBox MaxLength=10  runat="server" ID="txtFromDate" width="200px"  />    
                &nbsp;&nbsp;<b>End Date:</b>                                                        
                <asp:TextBox MaxLength=10 runat="server" ID="txtToDate" width="200px" />
                <td align=right nowrap  >
                <asp:Button ID="btnReport" runat="server" Text="View Report" 
                    onclick="btnReport_Click" />
            </td>
            </td>                                 
        </tr>              
        <tr>
                            
        </tr>
    </table>      

    <div class="clear">    
      <rsweb:ReportViewer Width="800px" ID="ReportViewer1" runat="server" ProcessingMode="Remote" 
    ShowCredentialPrompts="False" Font-Names="Verdana" Font-Size="8pt" 
          Height="400px" meta:resourcekey="ReportViewer1Resource1">
    </rsweb:ReportViewer>
    </div>    
</asp:Content>
