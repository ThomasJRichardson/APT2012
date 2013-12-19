<%@ Page Title="" Language="C#" EnableEventValidation="false" MasterPageFile="~/Site.Master"
    AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="APT2012.Default"
    meta:resourcekey="PageResource1" %>

<%@ Register Assembly="Infragistics35.WebUI.UltraWebChart.v9.1, Version=9.1.20091.1015, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.UltraWebChart" TagPrefix="igchart" %>
<%@ Register Assembly="Infragistics35.WebUI.UltraWebChart.v9.1, Version=9.1.20091.1015, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.UltraChart.Resources.Appearance" TagPrefix="igchartprop" %>
<%@ Register Assembly="Infragistics35.WebUI.UltraWebChart.v9.1, Version=9.1.20091.1015, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.UltraChart.Data" TagPrefix="igchartdata" %>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolderHead" runat="server">

    <script type="text/javascript" language="javascript">
        $(document).ready(function() {
            //Load Asnyc Chart
            $("#async-chart01").html("<div class='loading'>Loading Chart</div>");
            $("#async-chart01").load("ChartInvestmentValueOverTime.aspx?TICKS=<%= DateTime.Now.Ticks%> #uctInvestment");
        });
    </script>

</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="fullbox clear">
        <h3>
            <asp:Label ID="lblMembershipOverview" Text="Membership Overview" runat="server" meta:resourcekey="lblMembershipOverviewResource1" /></h3>
        <div class="left">
            <table cellpadding="0" cellspacing="0" width="100%" class="summarytable">
                <tr>
                    <td class="tdright">
                        <asp:Label ID="lblName" runat="server" Text="Name" meta:resourcekey="lblNameResource1"></asp:Label>
                    </td>
                    <td>
                        <asp:Label ID="lblNameValue" runat="server" meta:resourcekey="lblNameValueResource1"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="tdright">
                        <asp:Label ID="lblDateOfBirth" runat="server" Text="Date of Birth" meta:resourcekey="lblDateOfBirthResource1"></asp:Label>
                    </td>
                    <td>
                        <asp:Label ID="lblDateOfBirthValue" runat="server" meta:resourcekey="lblDateOfBirthValueResource1"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="tdright">
                        <asp:Label ID="lblDateJoinedCompany" runat="server" Text="Date Joined Company" meta:resourcekey="lblDateJoinedCompanyResource1"></asp:Label>
                    </td>
                    <td>
                        <asp:Label ID="lblDateJoinedCompanyValue" runat="server" meta:resourcekey="lblDateJoinedCompanyValueResource1"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="tdright">
                        <asp:Label ID="lblDateJoinedPlan" runat="server" Text="Date Joined Plan" meta:resourcekey="lblDateJoinedPlanResource1"></asp:Label>
                    </td>
                    <td>
                        <asp:Label ID="lblDateJoinedPlanValue" runat="server" meta:resourcekey="lblDateJoinedPlanValueResource1"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="tdright">
                        <asp:Label ID="lblNormalPensionDate" runat="server" Text="Normal Pension Date" meta:resourcekey="lblNormalPensionDateResource1"></asp:Label>
                    </td>
                    <td>
                        <asp:Label ID="lblNormalPensionDateValue" runat="server" meta:resourcekey="lblNormalPensionDateValueResource1"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="tdright">
                        <asp:Label ID="lblBasicSalary" runat="server" Visible="False" Text="Salary as of "
                            meta:resourcekey="lblBasicSalaryResource1"></asp:Label>
                        <asp:Label ID="lblBasicSalaryDate" runat="server" Visible="False" meta:resourcekey="lblBasicSalaryDateResource1"></asp:Label>
                    </td>
                    <td>
                        <asp:Label ID="lblBasicSalaryValue" runat="server" Visible="False" meta:resourcekey="lblBasicSalaryValueResource1"></asp:Label>
                    </td>
                </tr>
            </table>
        </div>
        <div class="right">
            <table cellpadding="0" cellspacing="0" width="100%">
                <tr>
                    <td class="tdsmallright" valign="top">
                        <asp:Label ID="lblScheme" runat="server" Text="Scheme" meta:resourcekey="lblSchemeResource1"></asp:Label>
                    </td>
                    <td class="tdbigright">
                        <asp:Label ID="lblSchemeValue" runat="server" meta:resourcekey="lblSchemeValueResource1"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="tdsmallright">
                        <asp:Label ID="lblNameOfPRSAProvider" runat="server" Text="PRSA Provider" Visible="false"></asp:Label>
                    </td>
                    <td class="tdbigright">
                        <asp:Label ID="lblNameOfPRSAProviderValue" runat="server" Text="APT" Visible="false"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="tdsmallright">
                        <asp:Label ID="lblSchemeStartDate" runat="server" Text="Scheme Start Date" meta:resourcekey="lblSchemeStartDateResource1"></asp:Label>
                    </td>
                    <td class="tdbigright">
                        <asp:Label ID="lblSchemeStartDateValue" runat="server" meta:resourcekey="lblSchemeStartDateValueResource1"></asp:Label>
                    </td>
                </tr>
            </table>
        </div>
    </div>
    <!-- End fullbox -->
    <asp:Panel ID="pnlInvVsCont" runat="server" meta:resourcekey="pnlInvVsContResource1">
        <div class="clear fullbox">
            <h3>
                <asp:Label ID="lblInvestmentsOverTime" Text="Investment Value Over Time" runat="server"
                    meta:resourcekey="lblInvestmentsOverTimeResource1" />
            </h3>
            <div style="text-align: center;">
                <div id="async-chart01" style="width: 700px; height: 200px; margin: 0 auto 0 auto;">
                </div>
                <asp:Label CssClass="chartNote" ID="lblCvsIInfo" runat="server" Text="The above graph shows the value of your investment by comparison to your contributions paid.<br/> Sharp declines in the investment value may occur as a result of fund switching and is not always a reflection of your fund performance."
                    meta:resourcekey="lblCvsIInfoResource1"></asp:Label>
            </div>
        </div>
    </asp:Panel>
    <div class="clear">
        <div class="leftbox">
            <h3>
                <asp:Label ID="lblPlanSummary" Text="Plan Summary" runat="server" meta:resourcekey="lblPlanSummaryResource1" /></h3>
            <table cellpadding="0" cellspacing="0" class="summarytable">
                <tr>
                    <td>
                        <asp:Label ID="lblTotalValueAsAt" runat="server" Text="Total Value as at " meta:resourcekey="lblTotalValueAsAtResource1"></asp:Label>
                        <asp:Label ID="lblTotalValueAsAtDate" runat="server" meta:resourcekey="lblTotalValueAsAtDateResource1"></asp:Label>
                    </td>
                    <td>
                        <asp:Label ID="lblTotalValueAsAtValue" runat="server" meta:resourcekey="lblTotalValueAsAtValueResource1"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblTotalContributionsReceived" runat="server" Text="Total Contributions Received"
                            meta:resourcekey="lblTotalContributionsReceivedResource1"></asp:Label>
                    </td>
                    <td>
                        <asp:Label ID="lblTotalContributionsReceivedValue" runat="server" meta:resourcekey="lblTotalContributionsReceivedValueResource1"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblTotalWithdrawalsAdjustments" runat="server" Text="Total Withdrawals/Adjustments"
                            Visible="False" meta:resourcekey="lblTotalWithdrawalsAdjustmentsResource1"></asp:Label>&nbsp;
                    </td>
                    <td>
                        <asp:Label ID="lblTotalWithdrawalsAdjustmentsValue" runat="server" Visible="False"
                            meta:resourcekey="lblTotalWithdrawalsAdjustmentsValueResource1" Text="&amp;nbsp;"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblInvestmentReturn" runat="server" Text="Investment Return" meta:resourcekey="lblInvestmentReturnResource1"></asp:Label>
                    </td>
                    <td>
                        <asp:Label ID="lblInvestmentReturnValue" runat="server" meta:resourcekey="lblInvestmentReturnValueResource1"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblPercentageReturn" runat="server" Text="Percentage Return" meta:resourcekey="lblPercentageReturnResource1"></asp:Label>
                    </td>
                    <td>
                        <asp:Label ID="lblPercentageReturnValue" runat="server" meta:resourcekey="lblPercentageReturnValueResource1"></asp:Label>
                    </td>
                </tr>
            </table>
        </div>
        <div class="rightbox">
            <h3>
                <asp:Label ID="lblContributionsSummary" Text="Contributions Summary" runat="server"
                    meta:resourcekey="lblContributionsSummaryResource1" /></h3>
            <table cellpadding="0" cellspacing="0" class="summarytable">
                <tr>
                    <td>
                        <asp:Label ID="lblEmployeeContributions" runat="server" Text="Employee Contributions"
                            meta:resourcekey="lblEmployeeContributionsResource1"></asp:Label>
                    </td>
                    <td>
                        <asp:Label ID="lblEmployeeContributionsValue" runat="server" meta:resourcekey="lblEmployeeContributionsValueResource1"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblEmployerContributions" runat="server" Text="Employer Contributions"
                            meta:resourcekey="lblEmployerContributionsResource1"></asp:Label>
                    </td>
                    <td>
                        <asp:Label ID="lblEmployerContributionsValue" runat="server" meta:resourcekey="lblEmployerContributionsValueResource1"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblAVCs" runat="server" Text="AVC's" meta:resourcekey="lblAVCsResource1"></asp:Label>
                    </td>
                    <td>
                        <asp:Label ID="lblAVCsValue" runat="server" meta:resourcekey="lblAVCsValueResource1"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblTransferIn" runat="server" Text="Transfer in" meta:resourcekey="lblTransferInResource1"></asp:Label>
                    </td>
                    <td>
                        <asp:Label ID="lblTransferInValue" runat="server" meta:resourcekey="lblTransferInValueResource1"></asp:Label>
                    </td>
                </tr>
                <tr class="bold">
                    <td>
                        <asp:Label ID="lblTotalContributions" runat="server" Text="Total Contributions" meta:resourcekey="lblTotalContributionsResource1"></asp:Label>
                    </td>
                    <td>
                        <asp:Label ID="lblTotalContributionsValue" runat="server" meta:resourcekey="lblTotalContributionsValueResource1"></asp:Label>
                    </td>
                </tr>
            </table>
        </div>
    </div>
    <div class="fullbox clear">
        <h3>
            <asp:Label ID="lblInvestmentsSummary" Text="Investments Summary" runat="server" meta:resourcekey="lblInvestmentsSummaryResource1" /></h3>
        <asp:GridView CssClass="investmentsSummary" ID="gvInvestmentSummary" runat="server"
            AutoGenerateColumns="False" meta:resourcekey="gvInvestmentSummaryResource1">
            <Columns>
                <asp:BoundField DataField="FundDescription" HeaderText="Fund" meta:resourcekey="BoundFieldResource1" />
                <asp:BoundField DataField="EffectiveFrom" HeaderText="Unit Price at" meta:resourcekey="BoundFieldResource2" />
                <asp:BoundField DataField="Price" HeaderText="Unit Price" DataFormatString="{0:c}"
                    meta:resourcekey="BoundFieldResource3" />
                <asp:BoundField DataField="Units" HeaderText="Units Held" meta:resourcekey="BoundFieldResource4" />
                <asp:BoundField DataField="Value" HeaderText="Value" DataFormatString="{0:c}" meta:resourcekey="BoundFieldResource5" />
            </Columns>
            <EmptyDataTemplate>
                <asp:Label ID="lblInvestmentSummaryEmpty" runat="server" Text="Currently you do not have any investments."
                    meta:resourcekey="lblInvestmentSummaryEmptyResource1"></asp:Label>
            </EmptyDataTemplate>
        </asp:GridView>
        <table class="investmentsSummary">
            <tbody>
                <tr>
                    <td style="font-weight: bold; font-style: italic; text-align: right;">
                        <asp:Label ID="lblTotalInvestments" runat="server" Text="Total Investments:" meta:resourcekey="lblTotalInvestmentsResource1" />
                        <asp:Label ID="lblTotalInvestmentsValue" runat="server" meta:resourcekey="lblTotalInvestmentsValueResource1" />
                    </td>
                </tr>
            </tbody>
        </table>
    </div>
</asp:Content>
<asp:Content ID="Content2" runat="server" ContentPlaceHolderID="ContentPlaceHolderPageTitle">
    <div class="member">
        <! -- Change for Specific Icons -->
        <h2>
            <asp:Label runat="server" ID="lblPageHeader" Text="Member Overview" meta:resourcekey="lblPageHeaderResource1" /></h2>
        <p class="h2-line">
            <asp:Label runat="server" ID="lblPageHeaderByline" Text="Summary of your Scheme and Member Information"
                meta:resourcekey="lblPageHeaderBylineResource1" /></p>
    </div>
</asp:Content>
