<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Performance.aspx.cs" Inherits="APT2012.Performance" MaintainScrollPositionOnPostback="true" MasterPageFile="~/Site.Master" %>
<%@ Register assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a" namespace="Microsoft.Reporting.WebForms" tagprefix="rsweb" %>
<asp:Content ID="ContentHead" ContentPlaceHolderID="ContentPlaceHolderHead" runat="server">
    <link href="APTTHEME/APT01/ui.dropdownchecklist.standalone.css" rel="stylesheet" type="text/css" />    
    <link rel="stylesheet" type="text/css" media="screen,print" href="~/APTTHEME/APT01/APTStyleContent.css" />    
    <link rel="stylesheet" type="text/css" media="print" href="~/APTTHEME/APT01/APTStylePrint.css" />
    <link href="APTTHEME/APT01/jquery-ui.css" rel="stylesheet" type="text/css" />

<%--    <script src="js/jquery-1.7.2.js" type="text/javascript"></script>
    <script src="js/jquery-ui.min.js" type="text/javascript"></script>--%>
    <script src="js/jquery/jengine.js" type="text/javascript"></script>
    <script src="js/ui.dropdownchecklist-1.4-min.js" type="text/javascript"></script>

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
                    var MinYear = currentYear - 5;
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

                //get the Funds
                var lstFunds = "";
                $("#selFundsDiv option:selected").each(function () {
                    if (lstFunds != "")
                        lstFunds += ",";
                    lstFunds += $(this).val();
                });                
                if (lstFunds != "") {
                    $("#<%=pHidFunds.ClientID%>").val(lstFunds);
                }
                else {

                    alert("Please select atleast one fund for the report.")
                    return false;
                }

                //return true;

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
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
  <asp:ScriptManager ID="ScriptManager1" runat="server" ></asp:ScriptManager> 
    
    <script type="text/javascript">
        Sys.Application.add_init(function () {

            $(function () {
                //                alert($("#txtPageLoad").val());
                //                if ($("#txtPageLoad").val() == "1") {
                //                   
                $("#<%=txtFromDate.ClientID%>").datepicker({ dateFormat: "dd/mm/yy", changeYear: true, changeMonth: true });
                $("#<%=txtToDate.ClientID%>").datepicker({ dateFormat: "dd/mm/yy", changeYear: true, changeMonth: true });

                var ct = "application/json; charset=utf-8";
                var ws = "ws/Performance.asmx/";
                var lstFunds = "";

                var flm = ws + 'loadFunds';

                $.ajax({
                    type: "POST",
                    url: flm,
                    data: "{'strFunds': '" + $("#<%=pHidFunds.ClientID%>").val() + "'}",
                    processData: false,
                    contentType: ct,
                    async: false,
                    dataType: "json",
                    success: function (o) {
                        returnValue = o.d;
                        $$("selFundsDiv").innerHTML = "<select id=\"ddlFunds\" class=\"selFunds\" multiple=\"multiple\" \">" + returnValue + "</select>";

                        $(".selFunds").dropdownchecklist({ icon: { placement: 'right',
                            toOpen: 'ui-icon-arrowthick-1-s',
                            toClose: 'ui-icon-arrowthick-1-n'
                        }, maxDropHeight: 180, width: 390, onItemClick: function (checkbox, selector) {
                            if (checkbox.prop("checked")) { lstFunds += "|" + checkbox.val() + "|"; }
                            if (!checkbox.prop("checked")) { lstFunds = lstFunds.replace("|" + checkbox.val() + "|", ""); }
                        }
                        });

                    },
                    error: function (request, status, error) {
                        alert('error');
                    }
                });

                //                }
            });

        }); 
    </script>
       
    <input type="hidden" name="pHidTest" id="pHidTest" runat=server />  
    <table cellpadding=0 cellspacing=0 border=0 runat=server id="tblReports" >
        <tr>
            <td>                 
                    <table cellpadding=3 cellspacing=2 border=0 >
                        <tr>
                            <td align=left  nowrap  >
                                <b>Report Type:</b>
                            </td> 
                            <td align=left  nowrap  >
                                <asp:DropDownList ID="ddlReportType" runat="server" Width="200px">
                                    <asp:ListItem Value="Monthly" >Monthly</asp:ListItem>
                                    <asp:ListItem Value="Quarterly">Quarterly</asp:ListItem>
                                    <asp:ListItem Value="Yearly">Yearly</asp:ListItem>
                                    <asp:ListItem Value="DatetoDate">Date to Date</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                            <td align=left nowrap colspan=3 >
                                <b>Start Date:</b>                              
                                <asp:TextBox MaxLength=10  runat="server" ID="txtFromDate" width="200px"  />    
                                &nbsp;&nbsp;<b>End Date:</b>                                                        
                                <asp:TextBox MaxLength=10 runat="server" ID="txtToDate" width="200px" />
                            </td>                                 
                        </tr>              
                        <tr>
                             <td align=left  nowrap  >
                                <b>Report View:</b>            
                            </td>
                            <td align=left nowrap valign=top >
                                <asp:RadioButtonList ID="optReportType" runat="server" RepeatDirection=Horizontal >
                                     <asp:ListItem Value="FundUnitPriceGraph_Monthly" Selected=True>Graphical</asp:ListItem> 
                                     <asp:ListItem Value="FundUnitPriceTabular" >Tabular</asp:ListItem> 
                                </asp:RadioButtonList>
                            </td> 
                             <td align=left nowrap >
                                <b>Funds:</b>
                            </td>
                            <td align=left nowrap >
                               <div id="selFundsDiv">

                               </div>
                            </td>
                            <td align=right nowrap  >
                                <asp:Button ID="btnReport" runat="server" Text="View Report" 
                                    onclick="btnReport_Click" />
                            </td>
                        </tr>
                    </table>                 
            </td>
        </tr>
        <tr>
            <td>
                <rsweb:ReportViewer Width="100%" ID="ReportViewer1" runat="server" ProcessingMode="Remote"
                    ShowCredentialPrompts="False" Font-Names="Verdana" Font-Size="8pt" Height="550px" >
                </rsweb:ReportViewer>                
            </td>
        </tr>
    </table>
    <table runat=server id="tblUnderConstruction" visible=false>
        <tr>
            <td><img src="Graphics/under_construction.jpg" runat=server border=0 /></td>
        </tr>
    </table>
     <input type="hidden" name="pHidMemberID" id="pHidMemberID" runat=server />  
     <input type="hidden" name="pHidFunds" id="pHidFunds" runat=server />  
    <div style="display: none">
        <asp:textbox id="txtSelectedSchemeId" runat="server"></asp:textbox>
        <asp:textbox id="txtSelectedEmployeeId" runat="server"></asp:textbox>  
        <asp:TextBox id="txtPageLoad" runat=server ></asp:TextBox>
           
    </div>   


</asp:Content>
<asp:Content ID="Content2" runat="server" ContentPlaceHolderID="ContentPlaceHolderPageTitle">
    <div class="coins">
        <! -- Change for Specific Icons -->
        <h2>
            <asp:Label runat="server" ID="lblPageHeader" Text="Investment Performance Statistics" 
                meta:resourcekey="lblPageHeaderResource1" /></h2>
        <p class="h2-line">
            <asp:Label runat="server" ID="lblPageHeaderByline" 
                Text="Your Investment Performance" 
                meta:resourcekey="lblPageHeaderBylineResource1" /></p>
        <asp:Panel runat="server" ID="pnlInfo3" Visible="False" CssClass="panel-info" 
            meta:resourcekey="pnlInfo3Resource1">
            <asp:Label runat="server" ID="lblInfo3" meta:resourcekey="lblInfo3Resource1" />
        </asp:Panel>
    </div>
</asp:Content>
