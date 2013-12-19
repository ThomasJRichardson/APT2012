<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="TrusteeLeavers.aspx.cs" Inherits="APT2012.TrusteeLeavers" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<%@ Register Src="../controls/TrusteeReportNav2.ascx" TagName="TrusteeReportNav" TagPrefix="uc1" %>

<asp:Content ID="cntHead" ContentPlaceHolderID="ContentPlaceHolderHead" runat="server">
</asp:Content>
<asp:Content ID="cntTitle" ContentPlaceHolderID="ContentPlaceHolderPageTitle" runat="server">
<asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <div class="reporting">
        <! -- Change for Specific Icons -->
        <h2>
            <asp:Label runat="server" ID="lblPageHeader" Text="Normal Pension Date" /></h2>
        <p>
            <asp:Label runat="server" ID="lblPageHeaderByline" Text="Report for Normal Pension Date" /></p>
    </div>
</asp:Content>
<asp:Content ID="cntMain" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    
    <div class="fullbox clear">
        <h3>
            <asp:Label ID="Label1" runat="server" Text="Leavers"></asp:Label></h3>
        <rsweb:ReportViewer Width="100%" ID="ReportViewer1" runat="server" ProcessingMode="Remote"
            ShowCredentialPrompts="False" Font-Names="Verdana" Font-Size="8pt" Height="400px">
        </rsweb:ReportViewer>
    </div>

    <uc1:TrusteeReportNav ID="TrusteeReportNav1" runat="server" />
</asp:Content>
