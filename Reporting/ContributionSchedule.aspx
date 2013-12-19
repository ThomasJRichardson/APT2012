﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ContributionSchedule.aspx.cs" Inherits="APT2012.ContributionSchedule" meta:resourcekey="PageResource1" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
<%@ Register assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a" namespace="Microsoft.Reporting.WebForms" tagprefix="rsweb" %>


<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolderHead" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="clear">
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
    </div>
</asp:Content>
<asp:Content ID="Content4" runat="server" contentplaceholderid="ContentPlaceHolderPageTitle">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
                    <div class="reporting"> <! -- Change for Specific Icons -->
                        <h2>
                            <asp:Label runat="server" ID="lblPageHeader" Text="Contribution Schedule" 
                                meta:resourcekey="lblPageHeaderResource1" /></h2>
                        <p class="h2-line">
                            <asp:Label runat="server" ID="lblPageHeaderByline" Text="Contribution Schedule" 
                                meta:resourcekey="lblPageHeaderBylineResource1" /></p>
                    </div>
                   
</asp:Content>

