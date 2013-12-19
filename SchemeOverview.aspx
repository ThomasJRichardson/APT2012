<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" 
        CodeBehind="SchemeOverview.aspx.cs" Inherits="APT2012.SchemeOverview" meta:resourcekey="PageResource1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolderHead" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="clear">
    <div class="leftbox">
        <h3><asp:Label ID="lblSchemePlanSummary" Text="Scheme Summary" runat="server" 
                meta:resourcekey="lblSchemePlanSummaryResource1"/></h3>
        <table cellpadding="0" cellspacing="0" class="summarytable">
            <tr>
                <td>
                    <asp:Label ID="lblSchemeTotalValueAsAt" runat="server" Text="Total Value as at" 
                        meta:resourcekey="lblSchemeTotalValueAsAtResource1"></asp:Label>
                </td>
                <td>    
                    <asp:Label ID="lblSchemeTotalValueAsAtValue" runat="server" 
                        meta:resourcekey="lblSchemeTotalValueAsAtValueResource1"></asp:Label>
                </td>    
            </tr>
            <tr>
                <td>
                    <asp:Label ID="lblSchemeTotalContributionsReceived" runat="server" 
                        Text="Total Contributions Received" 
                        meta:resourcekey="lblSchemeTotalContributionsReceivedResource1"></asp:Label>
                </td>
                <td>
                    <asp:Label ID="lblSchemeTotalContributionsReceivedValue" runat="server" 
                        meta:resourcekey="lblSchemeTotalContributionsReceivedValueResource1"></asp:Label>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="lblSchemeTotalWithdrawalsAdjustments" runat="server" 
                        Text="Total Withdrawals/Adjustments" Visible="False" 
                        meta:resourcekey="lblSchemeTotalWithdrawalsAdjustmentsResource1"></asp:Label>&nbsp;
                </td>
                <td>
                    <asp:Label ID="lblSchemeTotalWithdrawalsAdjustmentsValue" runat="server"  
                        Visible="False" 
                        meta:resourcekey="lblSchemeTotalWithdrawalsAdjustmentsValueResource1">&nbsp;</asp:Label>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="lblSchemeInvestmentReturn" runat="server" 
                        Text="Investment Return" meta:resourcekey="lblSchemeInvestmentReturnResource1"></asp:Label>
                </td>
                <td>
                    <asp:Label ID="lblSchemeInvestmentReturnValue" runat="server" 
                        meta:resourcekey="lblSchemeInvestmentReturnValueResource1"></asp:Label>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="lblSchemePercentageReturn" runat="server" 
                        Text="Percentage Return" meta:resourcekey="lblSchemePercentageReturnResource1"></asp:Label>
                </td>
                <td>
                    <asp:Label ID="lblSchemePercentageReturnValue" runat="server" 
                        meta:resourcekey="lblSchemePercentageReturnValueResource1"></asp:Label>
                </td>
            </tr>
        </table>
    </div>
    <div class="rightbox">
        <h3><asp:Label ID="lblSchemeContributionsSummary" 
                Text="Scheme Contributions Summary" runat="server" 
                meta:resourcekey="lblSchemeContributionsSummaryResource1"/></h3>
        <table cellpadding="0" cellspacing="0" class="summarytable">
            <tr>
                <td>
                    <asp:Label ID="lblSchemeEmployeeContributions" runat="server" 
                        Text="Employee Contributions" 
                        meta:resourcekey="lblSchemeEmployeeContributionsResource1"></asp:Label>
                </td>
                <td>
                    <asp:Label ID="lblSchemeEmployeeContributionsValue" runat="server" 
                        meta:resourcekey="lblSchemeEmployeeContributionsValueResource1"></asp:Label>
                </td>    
            </tr>
            <tr>
                <td>
                    <asp:Label ID="lblSchemeEmployerContributions" runat="server" 
                        Text="Employer Contributions" 
                        meta:resourcekey="lblSchemeEmployerContributionsResource1"></asp:Label>
                </td>
                <td>
                    <asp:Label ID="lblSchemeEmployerContributionsValue" runat="server" 
                        meta:resourcekey="lblSchemeEmployerContributionsValueResource1"></asp:Label>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="lblSchemeAVCs" runat="server" Text="AVC's" 
                        meta:resourcekey="lblSchemeAVCsResource1"></asp:Label>
                </td>
                <td>
                    <asp:Label ID="lblSchemeAVCsValue" runat="server" 
                        meta:resourcekey="lblSchemeAVCsValueResource1"></asp:Label>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="lblSchemeTransferIn" runat="server" Text="Transfer in" 
                        meta:resourcekey="lblSchemeTransferInResource1"></asp:Label>
                </td>
                <td>
                    <asp:Label ID="lblSchemeTransferInValue" runat="server" 
                        meta:resourcekey="lblSchemeTransferInValueResource1"></asp:Label>
                </td>
            </tr>
            <tr class="bold">
                <td>
                    <asp:Label ID="lblSchemeTotalContributions" runat="server" 
                        Text="Total Contributions" 
                        meta:resourcekey="lblSchemeTotalContributionsResource1"></asp:Label>
                </td>
                <td>
                    <asp:Label ID="lblSchemeTotalContributionsValue" runat="server" 
                        meta:resourcekey="lblSchemeTotalContributionsValueResource1"></asp:Label>
                </td>
            </tr>
        </table>
    </div>
 </div>
 
   
 
 <div class="fullbox clear">
    <h3><asp:Label ID="lblInvestmentsSummary" Text="Investments Summary" runat="server" 
            meta:resourcekey="lblInvestmentsSummaryResource1"/></h3>
        
        <asp:GridView CssClass="investmentsSummary" ID="gvInvestmentSummary" 
         runat="server" AutoGenerateColumns="False" 
         meta:resourcekey="gvInvestmentSummaryResource1">
            <Columns>
                <asp:BoundField DataField="FundDescription" HeaderText="Fund" 
                    meta:resourcekey="BoundFieldResource1" />
                <asp:BoundField DataField="EffectiveFrom" HeaderText="Unit Price at" 
                    meta:resourcekey="BoundFieldResource2"/>
                <asp:BoundField DataField="Price" HeaderText="Unit Price" 
                    DataFormatString="{0:c}" meta:resourcekey="BoundFieldResource3" />
                <asp:BoundField DataField="Units" HeaderText="Units Held" 
                    meta:resourcekey="BoundFieldResource4" />
                <asp:BoundField DataField="Value" HeaderText="Value"  DataFormatString="{0:c}" 
                    meta:resourcekey="BoundFieldResource5" />
            </Columns>
            <EmptyDataTemplate>
                <asp:Label ID="lblInvestmentSummaryEmpty" runat="server" 
                    Text="Currently you do not have any investments." 
                    meta:resourcekey="lblInvestmentSummaryEmptyResource1"></asp:Label>
            </EmptyDataTemplate>
        </asp:GridView>
        
        <table class="investmentsSummary">
            <tbody>
                <tr>
                    <td style="font-weight:bold; font-style: italic; text-align:right;">
                        <asp:Label ID="lblTotalInvestments" runat="server" Text="Total Investments:" 
                            meta:resourcekey="lblTotalInvestmentsResource1" /> 
                        <asp:Label ID="lblTotalInvestmentsValue" runat="server" 
                            meta:resourcekey="lblTotalInvestmentsValueResource1" /></td>
                </tr>
            </tbody>
        </table>
    </div>
    
     <div class="fullbox clear" id="TrusteeReportID">
        <h3>
            Trustee Reports
        </h3>
        <div style="padding: 5px 5px 10px 5px;" class="clear">
            <div class="report-link">
                <span class="title"><a href="Trustee/TrusteeUnitPriceHistory.aspx">Unit Price History Report</a></span>
                <span class="description">The unit price for individual funds over time within the scheme.</span>
            </div>
            <div class="report-link">
                <span class="title"><a href="Trustee/TrusteeSchemeMemberDetails.aspx">Member Details</a></span>
                <span class="description">The most common Member information for all members of the
                    scheme.</span>
            </div>
            <div class="report-link">
                <span class="title"><a href="Trustee/TrusteeLeavers.aspx">Leavers</a></span> <span class="description">
                    Members who have left the scheme.</span>
            </div>
            <div class="report-link">
                <span class="title"><a href="Trustee/TrusteeNPD.aspx">Normal Pension Date</a></span> <span
                    class="description">Normal pension date for each member of the scheme.</span>
            </div>
            <div class="report-link">
                <span class="title"><a href="Trustee/TrusteeTransferIn.aspx">Transfer In</a></span> <span
                    class="description">Breakdown of all Transfer In contributions for each member over
                    time.</span>
            </div>
            <div class="report-link">
                <span class="title"><a href="Trustee/TrusteeContributionRates.aspx">Member Contribution Rates</a></span>
                <span class="description">Employee and Employer contribution rates for each member.</span>
            </div>
            <div class="report-link">
                <span class="title"><a href="Trustee/TrusteeCurrentValue.aspx">Member Current Value</a></span>
                <span class="description">The current value of each Members investment broken down by
                    fund.</span>
            </div>
            <div class="report-link">
                <span class="title"><a href="Trustee/TrusteeInvestmentAllocation.aspx">Member Investment Allocation</a></span>
                <span class="description">Allocation over time for each Member broken down by fund.</span>
            </div>
            <div class="report-link">
                <span class="title"><a href="Trustee/SchemeActivity.aspx">Member Activity</a></span>
                <span class="description">Report for members activity on site.</span>
            </div>
        </div>
    </div>
 
</asp:Content>
<asp:Content ID="Content4" runat="server" 
    contentplaceholderid="ContentPlaceHolderPageTitle">
                        <div class="scheme">
                            <! -- Change for Specific Icons -->
                            <h2>
                                <asp:Label runat="server" ID="lblPageHeader" Text="Scheme Overview" 
                                    meta:resourcekey="lblPageHeaderResource1" /></h2>
                            <p class="h2-line">
                                <asp:Label runat="server" ID="lblPageHeaderByline" 
                                    Text="Summary information for entire scheme" 
                                    meta:resourcekey="lblPageHeaderBylineResource1" /></p>
                        </div>
                    
</asp:Content>

