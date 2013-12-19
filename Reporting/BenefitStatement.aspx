<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="BenefitStatement.aspx.cs" Inherits="APT2012.BenefitStatement" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
                Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>

<asp:Content ID="cntHead" ContentPlaceHolderID="ContentPlaceHolderHead" runat="server">
</asp:Content>
<asp:Content ID="cntTitle" ContentPlaceHolderID="ContentPlaceHolderPageTitle" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <div class="reporting">
        <! -- Change for Specific Icons -->
        <h2>
            <asp:Label runat="server" ID="lblPageHeader" Text="Benefit Statement" /></h2>
        <p>
            <asp:Label runat="server" ID="lblPageHeaderByline" Text="Report for Benefit Statement Projection" /></p>
    </div>
</asp:Content>
<asp:Content ID="cntMain" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:Label ID="lblYear" runat="server" Text="RunDate" class="label"></asp:Label>
      
    <asp:TextBox  runat="server" ID="txtRunDate" Text='' AutoPostBack="true"  OnTextChanged="RunDateChanged" /> 
    <asp:ImageButton runat="Server" ID="Image1" ImageUrl="~/APTTHEME/APT01/images/Calendar_scheduleHS.png" AlternateText="Click to show calendar" /><br />
    <ajaxToolkit:CalendarExtender ID="calendarButtonExtender" runat="server" TargetControlID="txtRunDate"  PopupButtonID="Image1" Format="dd/MM/yyyy"/>

    <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional"> 
    <Triggers><asp:AsyncPostBackTrigger ControlID="txtRunDate" EventName="TextChanged" />
    </Triggers>    
    <ContentTemplate>    
    
     <div class="fullbox clear">        
        <rsweb:ReportViewer Width="100%" ID="ReportViewer1" runat="server" ProcessingMode="Remote"
                            ShowCredentialPrompts="False" Font-Names="Verdana" Font-Size="8pt" Height="450px">
        </rsweb:ReportViewer>
    </div>
    </ContentTemplate>
    </asp:UpdatePanel>   
</asp:Content>
