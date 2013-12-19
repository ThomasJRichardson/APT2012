<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="TrusteeUnitPriceHistory.aspx.cs" Inherits="APT2012.TrusteeUnitPriceHistory" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<%@ Register Src="../controls/TrusteeReportNav2.ascx" TagName="TrusteeReportNav" TagPrefix="uc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolderHead" runat="server">
</asp:Content>
<asp:Content ID="Content2" runat="server" ContentPlaceHolderID="ContentPlaceHolderPageTitle">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <div class="reporting">
        <! -- Change for Specific Icons -->
        <h2>
            <asp:Label runat="server" ID="lblPageHeader" Text="Unit Price History" /></h2>
        <p>
            <asp:Label runat="server" ID="lblPageHeaderByline" Text="The unit price history for the selected fund." /></p>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
   
    <h3>
    <asp:Label ID="lblChooseFund" runat="server" Text="Choose Fund: " class="label"></asp:Label>
    <asp:DropDownList  ID="ddlFunds" runat="server" AutoPostBack="true" OnTextChanged="FundChanged">
    </asp:DropDownList></h3>

    <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional"> 
    <Triggers><asp:AsyncPostBackTrigger ControlID="ddlFunds"  EventName="TextChanged" />
    </Triggers>    
    <ContentTemplate>    

    <div class="fullbox clear">
        
        
        <rsweb:ReportViewer Width="100%" ID="ReportViewer1" runat="server" ProcessingMode="Remote"
            ShowCredentialPrompts="False" Font-Names="Verdana" Font-Size="8pt" Height="400px">
        </rsweb:ReportViewer>
    </div>

    </ContentTemplate>
    </asp:UpdatePanel>  

     <uc1:TrusteeReportNav ID="TrusteeReportNav1" runat="server" />
</asp:Content>

