<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="PlanSummary.aspx.cs" Inherits="APT2012.PlanSummary" meta:resourcekey="PageResource1" %>

<%@ Register Assembly="Infragistics35.WebUI.UltraWebChart.v9.1, Version=9.1.20091.1015, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.UltraWebChart" TagPrefix="igchart" %>
<%@ Register Assembly="Infragistics35.WebUI.UltraWebChart.v9.1, Version=9.1.20091.1015, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.UltraChart.Resources.Appearance" TagPrefix="igchartprop" %>
<%@ Register Assembly="Infragistics35.WebUI.UltraWebChart.v9.1, Version=9.1.20091.1015, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.UltraChart.Data" TagPrefix="igchartdata" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="clear" style="margin-bottom: 5px;">
        <div class="leftbox">
            <h3>
                <asp:Label ID="lblInvestments" Text="Investments" runat="server" meta:resourcekey="lblInvestmentsResource1" />
            </h3>
            <igchart:UltraChart ID="uctInvestments" runat="server" BackgroundImageFileName=""
                OnInvalidDataReceived="SetEmptyChartData" BorderWidth="1px" ChartType="PieChart"
                Version="9.1" Height="200px" Width="350px" EmptyChartText="Data Not Available. Please call UltraChart.Data.DataBind() after setting valid Data.DataSource"
                meta:resourcekey="uctInvestmentsResource1">
                <Legend Visible="True" SpanPercentage="50"></Legend>
                <ColorModel AlphaLevel="150" ColorBegin="Pink" ColorEnd="DarkRed" ModelStyle="CustomLinear">
                </ColorModel>
                <PieChart OthersCategoryPercent="0">
                </PieChart>
                <Axis>
                    <PE ElementType="None" Fill="Cornsilk" />
                    <X LineThickness="1" TickmarkInterval="0" TickmarkStyle="Smart" Visible="True">
                        <MajorGridLines AlphaLevel="255" Color="Gainsboro" DrawStyle="Dot" Thickness="1"
                            Visible="True" />
                        <MinorGridLines AlphaLevel="255" Color="LightGray" DrawStyle="Dot" Thickness="1"
                            Visible="False" />
                        <Labels HorizontalAlign="Near" ItemFormatString="&lt;ITEM_LABEL&gt;" Orientation="Horizontal"
                            VerticalAlign="Center">
                            <SeriesLabels Font="Verdana, 7pt" FontColor="DimGray" FormatString="" HorizontalAlign="Near"
                                Orientation="Horizontal" VerticalAlign="Center">
                                <Layout Behavior="Auto">
                                </Layout>
                            </SeriesLabels>
                            <Layout Behavior="Auto">
                            </Layout>
                        </Labels>
                    </X>
                    <Y LineThickness="1" TickmarkInterval="10" TickmarkStyle="Smart" Visible="True">
                        <MajorGridLines AlphaLevel="255" Color="Gainsboro" DrawStyle="Dot" Thickness="1"
                            Visible="True" />
                        <MinorGridLines AlphaLevel="255" Color="LightGray" DrawStyle="Dot" Thickness="1"
                            Visible="False" />
                        <Labels HorizontalAlign="Near" ItemFormatString="&lt;DATA_VALUE:00.##&gt;" Orientation="Horizontal"
                            VerticalAlign="Center">
                            <SeriesLabels Font="Verdana, 7pt" FontColor="DimGray" HorizontalAlign="Near" Orientation="Horizontal"
                                VerticalAlign="Center" FormatString="">
                                <Layout Behavior="Auto">
                                </Layout>
                            </SeriesLabels>
                            <Layout Behavior="Auto">
                            </Layout>
                        </Labels>
                    </Y>
                    <Y2 LineThickness="1" TickmarkInterval="10" TickmarkStyle="Smart" Visible="False">
                        <MajorGridLines AlphaLevel="255" Color="Gainsboro" DrawStyle="Dot" Thickness="1"
                            Visible="True" />
                        <MinorGridLines AlphaLevel="255" Color="LightGray" DrawStyle="Dot" Thickness="1"
                            Visible="False" />
                        <Labels HorizontalAlign="Near" ItemFormatString="" Orientation="Horizontal" VerticalAlign="Center"
                            Visible="False">
                            <SeriesLabels Font="Verdana, 7pt" FontColor="Gray" HorizontalAlign="Near" Orientation="Horizontal"
                                VerticalAlign="Center" FormatString="">
                                <Layout Behavior="Auto">
                                </Layout>
                            </SeriesLabels>
                            <Layout Behavior="Auto">
                            </Layout>
                        </Labels>
                    </Y2>
                    <X2 LineThickness="1" TickmarkInterval="0" TickmarkStyle="Smart" Visible="False">
                        <MajorGridLines AlphaLevel="255" Color="Gainsboro" DrawStyle="Dot" Thickness="1"
                            Visible="True" />
                        <MinorGridLines AlphaLevel="255" Color="LightGray" DrawStyle="Dot" Thickness="1"
                            Visible="False" />
                        <Labels FontColor="Gray" HorizontalAlign="Near" ItemFormatString="" Orientation="Horizontal"
                            VerticalAlign="Center" Visible="False">
                            <SeriesLabels Font="Verdana, 7pt" FontColor="Gray" FormatString="" HorizontalAlign="Near"
                                Orientation="Horizontal" VerticalAlign="Center">
                                <Layout Behavior="Auto">
                                </Layout>
                            </SeriesLabels>
                            <Layout Behavior="Auto">
                            </Layout>
                        </Labels>
                    </X2>
                    <Z LineThickness="1" TickmarkInterval="0" TickmarkStyle="Smart" Visible="False">
                        <MajorGridLines AlphaLevel="255" Color="Gainsboro" DrawStyle="Dot" Thickness="1"
                            Visible="True" />
                        <MinorGridLines AlphaLevel="255" Color="LightGray" DrawStyle="Dot" Thickness="1"
                            Visible="False" />
                        <Labels FontColor="DimGray" HorizontalAlign="Near" ItemFormatString="&lt;ITEM_LABEL&gt;"
                            Orientation="Horizontal" VerticalAlign="Center" Visible="False">
                            <SeriesLabels Font="Verdana, 7pt" FontColor="DimGray" HorizontalAlign="Near" Orientation="Horizontal"
                                VerticalAlign="Center">
                                <Layout Behavior="Auto">
                                </Layout>
                            </SeriesLabels>
                            <Layout Behavior="Auto">
                            </Layout>
                        </Labels>
                    </Z>
                    <Z2 LineThickness="1" TickmarkInterval="0" TickmarkStyle="Smart" Visible="False">
                        <MajorGridLines AlphaLevel="255" Color="Gainsboro" DrawStyle="Dot" Thickness="1"
                            Visible="True" />
                        <MinorGridLines AlphaLevel="255" Color="LightGray" DrawStyle="Dot" Thickness="1"
                            Visible="False" />
                        <Labels Font="Verdana, 7pt" FontColor="Gray" HorizontalAlign="Near" ItemFormatString=""
                            Orientation="Horizontal" VerticalAlign="Center" Visible="False">
                            <SeriesLabels Font="Verdana, 7pt" FontColor="Gray" HorizontalAlign="Near" Orientation="Horizontal"
                                VerticalAlign="Center">
                                <Layout Behavior="Auto">
                                </Layout>
                            </SeriesLabels>
                            <Layout Behavior="Auto">
                            </Layout>
                        </Labels>
                    </Z2>
                </Axis>
                <Effects>
                    <Effects>
                        <igchartprop:GradientEffect />
                    </Effects>
                </Effects>
                <Border Color="" />
                <Tooltips Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                    Font-Underline="False" FormatString="&lt;ITEM_LABEL&gt;: &lt;DATA_VALUE:c&gt;" />
            </igchart:UltraChart>
        </div>
        <div class="rightbox">
            <h3>
                <asp:Label ID="lblContributionsOverTime" Text="Contributions Over Time" runat="server"
                    meta:resourcekey="lblContributionsOverTimeResource1" />
                <asp:DropDownList ID="ddlContributionYears" runat="server" OnSelectedIndexChanged="ddlContributionYears_SelectedIndexChanged"
                    AutoPostBack="True" meta:resourcekey="ddlContributionYearsResource1">
                </asp:DropDownList>
            </h3>
            <igchart:UltraChart ID="uctContribution" runat="server" OnInvalidDataReceived="SetEmptyChartData"
                BackgroundImageFileName="" BorderColor="#868686" BorderWidth="0px" ChartType="LineChart"
                Version="9.1" SplineAreaChart-LineDrawStyle="Solid" Height="200px" Width="350px"
                EmptyChartText="Data Not Available. Please call UltraChart.Data.DataBind() after setting valid Data.DataSource"
                meta:resourcekey="uctContributionResource1">
                <Legend Location="Bottom" BackgroundColor="Transparent" BorderThickness="0" Font="Calibri, 9.75pt, style=Bold"
                    Visible="True" SpanPercentage="30"></Legend>
                <ColorModel ModelStyle="Office2007Style" ColorBegin="155, 187, 98" ColorEnd="DarkRed"
                    AlphaLevel="255">
                    <Skin ApplyRowWise="False">
                        <PEs>
                            <igchartprop:PaintElement Fill="79, 129, 189" Stroke="187, 187, 187" />
                        </PEs>
                    </Skin>
                </ColorModel>
                <Axis>
                    <PE ElementType="Gradient" Fill="251, 255, 245" FillGradientStyle="Vertical" FillStopColor="241, 253, 224"
                        StrokeWidth="0"></PE>
                    <X Visible="True" LineThickness="1" TickmarkStyle="DataInterval" TickmarkInterval="0"
                        Extent="20" LineColor="152, 185, 84">
                        <MajorGridLines Visible="False" DrawStyle="Dot" Color="Gainsboro" Thickness="1" AlphaLevel="255">
                        </MajorGridLines>
                        <MinorGridLines Visible="False" DrawStyle="Dot" Color="LightGray" Thickness="1" AlphaLevel="255">
                        </MinorGridLines>
                        <Labels ItemFormatString="&lt;ITEM_LABEL&gt;" Font="Calibri, 9.75pt, style=Bold"
                            FontColor="89, 89, 89" HorizontalAlign="Near" VerticalAlign="Center" Orientation="Horizontal">
                            <SeriesLabels FormatString="" Font="Verdana, 7pt" FontColor="DimGray" HorizontalAlign="Near"
                                VerticalAlign="Center" Orientation="VerticalLeftFacing" Visible="False">
                                <Layout Behavior="Auto">
                                </Layout>
                            </SeriesLabels>
                            <Layout Behavior="Auto">
                            </Layout>
                        </Labels>
                    </X>
                    <Y Visible="True" LineThickness="1" TickmarkStyle="Smart" TickmarkInterval="100"
                        Extent="20" LineColor="152, 185, 84">
                        <MajorGridLines Visible="True" DrawStyle="Dot" Color="199, 214, 176" Thickness="1"
                            AlphaLevel="255"></MajorGridLines>
                        <MinorGridLines Visible="False" DrawStyle="Dot" Color="LightGray" Thickness="1" AlphaLevel="255">
                        </MinorGridLines>
                        <Labels ItemFormatString="&lt;DATA_VALUE:00.##&gt;" Font="Calibri, 9.75pt, style=Bold"
                            FontColor="89, 89, 89" HorizontalAlign="Far" VerticalAlign="Center" Orientation="Horizontal">
                            <SeriesLabels FormatString="" Font="Verdana, 7pt" FontColor="DimGray" HorizontalAlign="Far"
                                VerticalAlign="Center" Orientation="Horizontal">
                                <Layout Behavior="Auto">
                                </Layout>
                            </SeriesLabels>
                            <Layout Behavior="Auto">
                            </Layout>
                        </Labels>
                    </Y>
                    <Y2 Visible="False" LineThickness="1" TickmarkStyle="Smart" TickmarkInterval="50">
                        <MajorGridLines Visible="True" DrawStyle="Dot" Color="Gainsboro" Thickness="1" AlphaLevel="255">
                        </MajorGridLines>
                        <MinorGridLines Visible="False" DrawStyle="Dot" Color="LightGray" Thickness="1" AlphaLevel="255">
                        </MinorGridLines>
                        <Labels ItemFormatString="&lt;DATA_VALUE:00.##&gt;" Visible="False" Font="Verdana, 7pt"
                            FontColor="Gray" HorizontalAlign="Near" VerticalAlign="Center" Orientation="Horizontal">
                            <SeriesLabels FormatString="" Font="Verdana, 7pt" FontColor="Gray" HorizontalAlign="Near"
                                VerticalAlign="Center" Orientation="Horizontal">
                                <Layout Behavior="Auto">
                                </Layout>
                            </SeriesLabels>
                            <Layout Behavior="Auto">
                            </Layout>
                        </Labels>
                    </Y2>
                    <X2 Visible="False" LineThickness="1" TickmarkStyle="Smart" TickmarkInterval="0">
                        <MajorGridLines Visible="True" DrawStyle="Dot" Color="Gainsboro" Thickness="1" AlphaLevel="255">
                        </MajorGridLines>
                        <MinorGridLines Visible="False" DrawStyle="Dot" Color="LightGray" Thickness="1" AlphaLevel="255">
                        </MinorGridLines>
                        <Labels ItemFormatString="&lt;ITEM_LABEL&gt;" Visible="False" Font="Verdana, 7pt"
                            FontColor="Gray" HorizontalAlign="Far" VerticalAlign="Center" Orientation="VerticalLeftFacing">
                            <SeriesLabels FormatString="" Font="Verdana, 7pt" FontColor="Gray" HorizontalAlign="Far"
                                VerticalAlign="Center" Orientation="VerticalLeftFacing">
                                <Layout Behavior="Auto">
                                </Layout>
                            </SeriesLabels>
                            <Layout Behavior="Auto">
                            </Layout>
                        </Labels>
                    </X2>
                    <Z Visible="False" LineThickness="1" TickmarkStyle="Smart" TickmarkInterval="0">
                        <MajorGridLines Visible="True" DrawStyle="Dot" Color="Gainsboro" Thickness="1" AlphaLevel="255">
                        </MajorGridLines>
                        <MinorGridLines Visible="False" DrawStyle="Dot" Color="LightGray" Thickness="1" AlphaLevel="255">
                        </MinorGridLines>
                        <Labels ItemFormatString="&lt;ITEM_LABEL&gt;" Visible="False" Font="Verdana, 7pt"
                            FontColor="DimGray" HorizontalAlign="Near" VerticalAlign="Center" Orientation="Horizontal">
                            <SeriesLabels Font="Verdana, 7pt" FontColor="DimGray" HorizontalAlign="Near" VerticalAlign="Center"
                                Orientation="Horizontal">
                                <Layout Behavior="Auto">
                                </Layout>
                            </SeriesLabels>
                            <Layout Behavior="Auto">
                            </Layout>
                        </Labels>
                    </Z>
                    <Z2 Visible="False" LineThickness="1" TickmarkStyle="Smart" TickmarkInterval="0">
                        <MajorGridLines Visible="True" DrawStyle="Dot" Color="Gainsboro" Thickness="1" AlphaLevel="255">
                        </MajorGridLines>
                        <MinorGridLines Visible="False" DrawStyle="Dot" Color="LightGray" Thickness="1" AlphaLevel="255">
                        </MinorGridLines>
                        <Labels ItemFormatString="" Visible="False" Font="Verdana, 7pt" FontColor="Gray"
                            HorizontalAlign="Near" VerticalAlign="Center" Orientation="Horizontal">
                            <SeriesLabels Font="Verdana, 7pt" FontColor="Gray" HorizontalAlign="Near" VerticalAlign="Center"
                                Orientation="Horizontal">
                                <Layout Behavior="Auto">
                                </Layout>
                            </SeriesLabels>
                            <Layout Behavior="Auto">
                            </Layout>
                        </Labels>
                    </Z2>
                </Axis>
                <Effects>
                    <Effects>
                        <igchartprop:GradientEffect>
                        </igchartprop:GradientEffect>
                    </Effects>
                </Effects>
                <Border Thickness="0" Color="134, 134, 134" CornerRadius="10" />
                <Tooltips FormatString="&lt;ITEM_LABEL&gt;: &lt;DATA_VALUE:c&gt;" />
            </igchart:UltraChart>
        </div>
    </div>
    <%--<div class="rightbox">
            <h3>
                <asp:Label ID="lblContributionsPaid" Text="What Contributions are paid?" runat="server" /></h3>
            <table cellpadding="0" cellspacing="0" width="100%" class="summarytable">
                <tr>
                    <td>
                        <asp:Label ID="lblEmployee" runat="server" Text="Employee"></asp:Label>
                    </td>
                    <td>
                        <asp:Label ID="lblEmployeeValue" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblEmployer" runat="server" Text="Employer"></asp:Label>
                    </td>
                    <td>
                        <asp:Label ID="lblEmployerValue" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        &nbsp;
                    </td>
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td>
                        &nbsp;
                    </td>
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td>
                        &nbsp;
                    </td>
                    <td>
                        &nbsp;
                    </td>
                </tr>
            </table>
        </div>--%>
    <!-- End clear -->
    <div class="clear">
    <div class="fullbox">
        <h3>
            <asp:Label ID="lblPerformance" Text="Performance" runat="server" meta:resourcekey="lblPerformanceResource1" /></h3>
        <table cellpadding="0" cellspacing="0" width="100%" class="standardtable">
            <tr>
                <td>
                    <asp:Label Font-Bold="True" ID="lblTotalValueAsAt" runat="server" Text="Total Value as at ***TODAY***"
                        meta:resourcekey="lblTotalValueAsAtResource1"></asp:Label>
                </td>
                <td>
                    <asp:Label ID="lblTotalValueAsAtValue" runat="server" meta:resourcekey="lblTotalValueAsAtValueResource1"></asp:Label>
                </td>
                <td>
                    <asp:Label Font-Bold="True" ID="lblTotalContributionsReceived" runat="server" Text="Total Contributions Received"
                        meta:resourcekey="lblTotalContributionsReceivedResource1"></asp:Label>
                </td>
                <td>
                    <asp:Label ID="lblTotalContributionsReceivedValue" runat="server" meta:resourcekey="lblTotalContributionsReceivedValueResource1"></asp:Label>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label Font-Bold="True" ID="lblInvestmentReturn" runat="server" Text="Investment Return"
                        meta:resourcekey="lblInvestmentReturnResource1"></asp:Label>
                </td>
                <td>
                    <asp:Label ID="lblInvestmentReturnValue" runat="server" meta:resourcekey="lblInvestmentReturnValueResource1"></asp:Label>
                </td>
                <td>
                    <asp:Label Font-Bold="True" ID="lblPercentageReturn" runat="server" Text="Percentage Return"
                        meta:resourcekey="lblPercentageReturnResource1"></asp:Label>
                </td>
                <td>
                    <asp:Label ID="lblPercentageReturnValue" runat="server" meta:resourcekey="lblPercentageReturnValueResource1"></asp:Label>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label Font-Bold="True" ID="lblInitialCapitalInvested" runat="server" Text="Initial Capital Invested"
                        Visible="False" meta:resourcekey="lblInitialCapitalInvestedResource1"></asp:Label>
                </td>
                <td>
                    <asp:Label ID="lblInitialCapitalInvestedValue" runat="server" Visible="False" meta:resourcekey="lblInitialCapitalInvestedValueResource1"></asp:Label>
                </td>
                <td>
                    <asp:Label Font-Bold="True" ID="lblAdditionalIncomeInvested" runat="server" Text="Additional Income Invested"
                        Visible="False" meta:resourcekey="lblAdditionalIncomeInvestedResource1"></asp:Label>
                </td>
                <td>
                    <asp:Label ID="lblAdditionalIncomeInvestedValue" runat="server" Visible="False" meta:resourcekey="lblAdditionalIncomeInvestedValueResource1"></asp:Label>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label Font-Bold="True" ID="lblTotalWithdrawalsAdjustments" runat="server" Text="Total Withdrawals/Adjustments"
                        Visible="False" meta:resourcekey="lblTotalWithdrawalsAdjustmentsResource1"></asp:Label>
                </td>
                <td>
                    <asp:Label ID="lblTotalWithdrawalsAdjustmentsValue" runat="server" Visible="False"
                        meta:resourcekey="lblTotalWithdrawalsAdjustmentsValueResource1"></asp:Label>
                </td>
                <td>
                    &nbsp;
                </td>
                <td>
                    &nbsp;
                </td>
            </tr>
        </table>
    </div>
    </div>
    <%--This employee info may be implemented by apt in the future so not removing.--%>
    <%--<div class="rightbox">
            <h3>
                <asp:Label ID="lblContributionsPaid" Text="What Contributions are paid?" runat="server" /></h3>
            <table cellpadding="0" cellspacing="0" width="100%" class="summarytable">
                <tr>
                    <td>
                        <asp:Label ID="lblEmployee" runat="server" Text="Employee"></asp:Label>
                    </td>
                    <td>
                        <asp:Label ID="lblEmployeeValue" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblEmployer" runat="server" Text="Employer"></asp:Label>
                    </td>
                    <td>
                        <asp:Label ID="lblEmployerValue" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        &nbsp;
                    </td>
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td>
                        &nbsp;
                    </td>
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td>
                        &nbsp;
                    </td>
                    <td>
                        &nbsp;
                    </td>
                </tr>
            </table>
        </div>
        --%>
    <asp:Panel ID="pnlSchemeInformation" runat="server" meta:resourcekey="pnlSchemeInformationResource1">
        <div class="fullbox clear">
            <h3>
                <asp:Label ID="lblSchemeInformation" Text="Scheme Information" runat="server" meta:resourcekey="lblSchemeInformationResource1" /></h3>
            <table cellpadding="0" cellspacing="0" width="100%" class="standardtable">
                <tr>
                    <td colspan="3">
                        <asp:Label Font-Bold="True" ID="lblSchemeName" runat="server" Text="Scheme Name"
                            meta:resourcekey="lblSchemeNameResource1"></asp:Label>
                        <asp:Label ID="lblSchemeNameValue" runat="server" meta:resourcekey="lblSchemeNameValueResource1"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label Font-Bold="True" ID="lblSchemeType" runat="server" Text="Scheme Type"
                            meta:resourcekey="lblSchemeTypeResource1"></asp:Label>
                        <asp:Label ID="lblSchemeTypeValue" runat="server" meta:resourcekey="lblSchemeTypeValueResource1"></asp:Label>
                    </td>
                    <td>
                        <asp:Label Font-Bold="True" ID="lblSchemeStatus" runat="server" Text="Scheme Status"
                            meta:resourcekey="lblSchemeStatusResource1"></asp:Label>
                        <asp:Label ID="lblSchemeStatusValue" runat="server" meta:resourcekey="lblSchemeStatusValueResource1"></asp:Label>
                    </td>
                    <td>
                        <asp:Label Font-Bold="True" ID="lblMembership" runat="server" Text="Membership" meta:resourcekey="lblMembershipResource1"></asp:Label>
                        <asp:Label ID="lblMembershipValue" runat="server" meta:resourcekey="lblMembershipValueResource1"></asp:Label>
                    </td>
                </tr>
            </table>
        </div>
    </asp:Panel>
</asp:Content>
<asp:Content ID="Content2" runat="server" ContentPlaceHolderID="ContentPlaceHolderPageTitle">
    <div class="plan">
        <h2>
            <asp:Label runat="server" ID="lblPageHeader" Text="Plan Summary" meta:resourcekey="lblPageHeaderResource1" /></h2>
        <p class="h2-line">
            <asp:Label runat="server" ID="lblPageHeaderByline" Text="Overview of your Pension Plan"
                meta:resourcekey="lblPageHeaderBylineResource1" /></p>
    </div>
</asp:Content>
