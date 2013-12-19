<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="PRSABenefitStatement.aspx.cs" Inherits="APT2012.PRSABenefitStatement" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<asp:Content ID="cntHead" ContentPlaceHolderID="ContentPlaceHolderHead" runat="server">
    <script type="text/javascript" src="../js/jquery-ui.datepicker.js"></script>
    <script type="text/javascript">
        $(document).ready(function() {
            $(".datepicker").datepicker({ dateFormat: 'dd M yy' });
        });
    </script>
</asp:Content>
<asp:Content ID="cntTitle" ContentPlaceHolderID="ContentPlaceHolderPageTitle" runat="server">
<asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <div class="reporting">
        <! -- Change for Specific Icons -->
        <h2>
            <asp:Label runat="server" ID="lblPageHeader" Text="PRSA Statement of Account" /></h2>
        <p>
            <asp:Label runat="server" ID="lblPageHeaderByline" Text="" /></p>
    </div>
</asp:Content>
<asp:Content ID="cntMain" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="fullbox clear">
        <rsweb:ReportViewer Width="100%" ID="ReportViewer1" runat="server" ProcessingMode="Remote"
            ShowCredentialPrompts="False" Font-Names="Verdana" Font-Size="8pt" Height="400px">
        </rsweb:ReportViewer>
    </div>
</asp:Content>
