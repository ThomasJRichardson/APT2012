<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PRBSchedule.aspx.cs" Inherits="APT2012.PRBSchedule" MaintainScrollPositionOnPostback="true" MasterPageFile="~/Site.Master" %>
<%@ Register assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a" namespace="Microsoft.Reporting.WebForms" tagprefix="rsweb" %>
<asp:Content ID="ContentHead" ContentPlaceHolderID="ContentPlaceHolderHead" runat="server">
    <link href="~/APTTHEME/APT01/ui.dropdownchecklist.standalone.css" rel="stylesheet" type="text/css" />    
    <link rel="stylesheet" type="text/css" media="screen,print" href="~/APTTHEME/APT01/APTStyleContent.css" />    
    <link rel="stylesheet" type="text/css" media="print" href="~/APTTHEME/APT01/APTStylePrint.css" />
    <link href="APTTHEME/APT01/jquery-ui.css" rel="stylesheet" type="text/css" />

<%--    <script src="js/jquery-1.7.2.js" type="text/javascript"></script>
    <script src="js/jquery-ui.min.js" type="text/javascript"></script>--%>
    <script src="js/jquery/jengine.js" type="text/javascript"></script>
    <script src="js/ui.dropdownchecklist-1.4-min.js" type="text/javascript"></script>


    <style type="text/css">
        .style1
        {
            width: 438px;
        }
        .style2
        {
            width: 204px;
        }
        .style3
        {
            width: 76px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
  <asp:ScriptManager ID="ScriptManager1" runat="server" ></asp:ScriptManager> 
       
    <input type="hidden" name="pHidTest" id="pHidTest" runat=server />  
    <table cellpadding=0 cellspacing=0 border=0 runat=server id="tblReports" >
        <tr>
            <td>                 
                    <table cellpadding=3 cellspacing=2 border=0 >
                        <tr>
                            <td align=left  nowrap class="style3"  >
                                &nbsp;</td> 
                            <td align=left  nowrap class="style2"  >
                            </td>
                            <td align=left nowrap colspan=2 >
                                &nbsp;</td>                                 
                        </tr>              
                        <tr>
                             <td align=left  nowrap class="style3"  >
                                 &nbsp;</td>
                            <td align=left nowrap valign=top class="style2" >
                                &nbsp;</td> 
                             <td align=left nowrap class="style1" >
                                 &nbsp;</td>
                            <td align=right nowrap  >
                                &nbsp;</td>
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
            <td><img id="Img1" src="Graphics/under_construction.jpg" runat=server border=0 /></td>
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
            <asp:Label runat="server" ID="lblPageHeader" Text="PRB Schedule" 
                meta:resourcekey="lblPageHeaderResource1" /></h2>
        <p class="h2-line">
            <asp:Label runat="server" ID="lblPageHeaderByline" 
                Text="Schedule of Investment Contribution" 
                meta:resourcekey="lblPageHeaderBylineResource1" /></p>
        <asp:Panel runat="server" ID="pnlInfo3" Visible="False" CssClass="panel-info" 
            meta:resourcekey="pnlInfo3Resource1">
            <asp:Label runat="server" ID="lblInfo3" meta:resourcekey="lblInfo3Resource1" />
        </asp:Panel>
    </div>
</asp:Content>
