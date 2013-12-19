<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="TrusteeNPD.aspx.cs" Inherits="APT2012.TrusteeNPD" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<%@ Register src="../controls/TrusteeReportNav2.ascx" tagname="TrusteeReportNav" tagprefix="uc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolderHead" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolderPageTitle" runat="server">
<asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
                        <div class="reporting">
                            <! -- Change for Specific Icons -->
                            <h2>
                                <asp:Label runat="server" ID="lblPageHeader" Text="Normal Pension Date" /></h2>
                            <p>
                                <asp:Label runat="server" ID="lblPageHeaderByline" 
                                    Text="The normal pension date of all members in this scheme."/></p>
                        </div>
</asp:Content>
<asp:Content ID="cntMain" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="fullbox clear">    
    <h3>
        <asp:Label ID="Label1" runat="server" Text="Normal Pension Date"></asp:Label></h3>
    <rsweb:ReportViewer Width="100%" ID="ReportViewer1" runat="server" ProcessingMode="Remote"
        ShowCredentialPrompts="False" Font-Names="Verdana" Font-Size="8pt" Height="400px">
    </rsweb:ReportViewer></div>
    <uc1:TrusteeReportNav ID="TrusteeReportNav1" runat="server" />
</asp:Content>
