<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="SchemeActivity.aspx.cs" Inherits="APT2012.SchemeActivity" %>

<%@ Register src="../controls/TrusteeReportNav2.ascx" tagname="TrusteeReportNav" tagprefix="uc1" %>    
<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolderHead" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolderPageTitle" runat="server">
<asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <div class="reporting">
        <! -- Change for Specific Icons -->
        <h2>
            <asp:Label runat="server" ID="lblPageHeader" Text="Member Activity" /></h2>
        <p>
            <asp:Label runat="server" ID="lblPageHeaderByline" Text="Report for members activity on site" /></p>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">         
    <div class="fullbox clear">        
        <rsweb:ReportViewer Width="100%" ID="rpvMain" runat="server" ProcessingMode="Remote"
            ShowCredentialPrompts="False" Font-Names="Verdana" Font-Size="8pt" Height="450px">
        </rsweb:ReportViewer>
    </div>

    <uc1:trusteereportnav id="TrusteeReportNav1" runat="server" />
    
</asp:Content>
