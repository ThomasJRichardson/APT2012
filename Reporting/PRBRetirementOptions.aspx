<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PRBRetirementOptions.aspx.cs" Inherits="APT2012.PRBRetirementOptions" MasterPageFile="~/Site.Master" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
            Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>


<asp:Content ID="cntHead" ContentPlaceHolderID="ContentPlaceHolderHead" runat="server">
</asp:Content>

<asp:Content ID="cntTitle" runat="server" contentplaceholderid="ContentPlaceHolderPageTitle">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <div class="reporting">
        <! -- Change for Specific Icons -->
        <h2>
            <asp:Label runat="server" ID="lblPageHeader" Text="Retirement Options" meta:resourcekey="lblPageHeaderResource1" /></h2>
        <p class="h2-line">
            <asp:Label runat="server" ID="lblPageHeaderByline" Text="Retirement Options" meta:resourcekey="lblPageHeaderBylineResource1" /></p>
    </div>                    
</asp:Content>
<asp:Content ID="cntMain" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="clear">
        <asp:Label ForeColor="red"  runat="server" ID="Label1" Text="*Please save the report to PDF using the export options on the report." meta:resourcekey="lblPageHeaderBylineResource1" />        
        <rsweb:ReportViewer Width="100%" ID="ReportViewer1" runat="server" ProcessingMode="Remote" ShowExportControls=true     
                            ShowCredentialPrompts="False" Font-Names="Verdana" Font-Size="8pt" Height="450px">
        </rsweb:ReportViewer>    
    </div>
</asp:Content>
