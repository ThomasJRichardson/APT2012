<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="PRSASORP.aspx.cs" Inherits="APT2012.PRSASORP" %>    

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<asp:Content ID="cntHead" ContentPlaceHolderID="ContentPlaceHolderHead" runat="server">
</asp:Content>
<asp:Content ID="cntTitle" ContentPlaceHolderID="ContentPlaceHolderPageTitle" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <div class="reporting">
        <! -- Change for Specific Icons -->
        <h2>
            <asp:Label runat="server" ID="lblPageHeader" Text="Annual PRSA SRP" /></h2>
        <p>
            <asp:Label runat="server" ID="lblPageHeaderByline" Text="Report for Annual PRSA SRP" /></p>
    </div>
</asp:Content>
<asp:Content ID="cntMain" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:Label ID="lblYear" runat="server" Text="Year:" class="label"></asp:Label>
    <asp:DropDownList ID="ddlYear" runat="server" AutoPostBack="true" onselectedindexchanged="ddlYear_SelectedIndexChanged">
    </asp:DropDownList>
    <div class="fullbox clear">        
        <rsweb:ReportViewer Width="100%" ID="ReportViewer1" runat="server" ProcessingMode="Remote"
            ShowCredentialPrompts="False" Font-Names="Verdana" Font-Size="8pt" Height="450px">
        </rsweb:ReportViewer>
    </div>
</asp:Content>
