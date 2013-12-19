<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Investments.aspx.cs" Inherits="APT2012.Investments" meta:resourcekey="PageResource1" %>
<%@ Register assembly="Infragistics35.WebUI.UltraWebChart.v9.1, Version=9.1.20091.1015, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" namespace="Infragistics.WebUI.UltraWebChart" tagprefix="igchart" %>
<%@ Register assembly="Infragistics35.WebUI.UltraWebChart.v9.1, Version=9.1.20091.1015, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" namespace="Infragistics.UltraChart.Resources.Appearance" tagprefix="igchartprop" %>
<%@ Register assembly="Infragistics35.WebUI.UltraWebChart.v9.1, Version=9.1.20091.1015, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" namespace="Infragistics.UltraChart.Data" tagprefix="igchartdata" %>
<%@ Register assembly="System.Web.Entity, Version=3.5.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089" namespace="System.Web.UI.WebControls" tagprefix="asp" %>
<%@ Register assembly="Infragistics35.WebUI.WebResizingExtender.v9.1, Version=9.1.20091.1015, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" namespace="Infragistics.WebUI" tagprefix="igui" %>
<asp:Content ID="ContentHead" ContentPlaceHolderID="ContentPlaceHolderHead" runat="server">
    
    <script type="text/javascript" src="js/jquery.highlightFade.js"></script>
    <script type="text/javascript">
        $(document).ready(function() {
            $("div#divInvestmentDetails").hide();
            Sys.WebForms.PageRequestManager.getInstance().add_pageLoaded(endRequestHandle);
        });
        function endRequestHandle(sender, Args) {
            if (Args._panelsUpdated.length != 0) {
                    $("div#divInvestmentDetails").show('1000');
                    $("#divInvestmentDetails").highlightFade({ color: '#FFFF9B', speed: 3000 });
            }
        }
        function GetInvestments(fundId) {
            doPostBackAsync('udpInvestmentDetails', fundId);
            $("div#divInvestmentDetails").hide(200);
        }
        function highlight(tableRow, active) 
        {
            if (active) {
                if(!($(tableRow).hasClass('tableRowSelected')))
                {
                    $(tableRow).addClass('tableRowActive');
                }
            }
            else {
                $(tableRow).removeClass('tableRowActive');
            }
        }
        function selectedRow(tableRow) {
            $(tableRow).parent().find("tr").removeClass('tableRowSelected');
            $(tableRow).removeClass('tableRowActive');
            $(tableRow).addClass('tableRowSelected');
        }
        function doPostBackAsync(eventName, eventArgs) {
            var prm = Sys.WebForms.PageRequestManager.getInstance();

            if (!Array.contains(prm._asyncPostBackControlIDs, eventName)) {
                prm._asyncPostBackControlIDs.push(eventName);
            }

            if (!Array.contains(prm._asyncPostBackControlClientIDs, eventName)) {
                prm._asyncPostBackControlClientIDs.push(eventName);
            }
            __doPostBack(eventName, eventArgs);
        }
    </script>
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server" ></asp:ScriptManager>
    <div class="fullbox">
        <h3><asp:Label ID="lblFund" runat="server" Text="Unit Price Over Last Year" 
                meta:resourcekey="lblFundResource1"></asp:Label></h3>
                 <asp:Button ID="BtnEnlarge" runat="server" CssClass="button" Text="Enlarge Graph" 
            onclick="BtnEnlarge_Click" />
    <asp:Button ID="btnShrink" runat="server" CssClass="button" Text="Shrink Graph" 
            onclick="BtnShrink_Click" Visible="false"/>
        <igchart:UltraChart ID="uctFund" runat="server" BackgroundImageFileName="" 
            OnInvalidDataReceived="SetEmptyChartData"
            BorderColor="Black" BorderWidth="0px" ChartType="LineChart" 
            Version="9.1" Height="250px" Width="700px" 
            EmptyChartText="Data Not Available. Please call UltraChart.Data.DataBind() after setting valid Data.DataSource" 
            meta:resourcekey="uctFundResource1">
            <Legend Visible="True" BorderThickness="0" SpanPercentage="30" 
                Location="Bottom"></Legend>
            <ColorModel AlphaLevel="150" ColorBegin="Pink" ColorEnd="DarkRed" 
                ModelStyle="CustomLinear">
            </ColorModel>
            <Axis>
                <PE ElementType="None" Fill="Cornsilk" />
                <X Extent="47" LineThickness="1" TickmarkInterval="0" TickmarkStyle="Smart" 
                    Visible="True">
                    <Margin>
                        <Near Value="0.48780487804878048" />
                    </Margin>
                    <MajorGridLines AlphaLevel="255" Color="Gainsboro" DrawStyle="Dot" 
                        Thickness="1" Visible="True" />
                    <MinorGridLines AlphaLevel="255" Color="LightGray" DrawStyle="Dot" 
                        Thickness="1" Visible="False" />
                    <Labels Font="Verdana, 7pt" FontColor="DimGray" HorizontalAlign="Near" 
                        ItemFormatString="&lt;ITEM_LABEL&gt;" Orientation="VerticalLeftFacing" 
                        VerticalAlign="Center">
                        <SeriesLabels Font="Verdana, 7pt" FontColor="DimGray" FormatString="" 
                            HorizontalAlign="Near" Orientation="VerticalLeftFacing" VerticalAlign="Center">
                            <Layout Behavior="Auto">
                            </Layout>
                        </SeriesLabels>
                        <Layout Behavior="Auto">
                        </Layout>
                    </Labels>
                </X>
                <Y Extent="31" LineThickness="1" TickmarkInterval="40" TickmarkStyle="Smart" 
                    Visible="True">
                    <MajorGridLines AlphaLevel="255" Color="Gainsboro" DrawStyle="Dot" 
                        Thickness="1" Visible="True" />
                    <MinorGridLines AlphaLevel="255" Color="LightGray" DrawStyle="Dot" 
                        Thickness="1" Visible="False" />
                    <Labels Font="Verdana, 7pt" FontColor="DimGray" HorizontalAlign="Far" 
                        ItemFormatString="&lt;DATA_VALUE:00.##&gt;" Orientation="Horizontal" 
                        VerticalAlign="Center">
                        <SeriesLabels Font="Verdana, 7pt" FontColor="DimGray" FormatString="" 
                            HorizontalAlign="Far" Orientation="Horizontal" VerticalAlign="Center">
                            <Layout Behavior="Auto">
                            </Layout>
                        </SeriesLabels>
                        <Layout Behavior="Auto">
                        </Layout>
                    </Labels>
                </Y>
                <Y2 LineThickness="1" TickmarkInterval="40" TickmarkStyle="Smart" 
                    Visible="False">
                    <MajorGridLines AlphaLevel="255" Color="Gainsboro" DrawStyle="Dot" 
                        Thickness="1" Visible="True" />
                    <MinorGridLines AlphaLevel="255" Color="LightGray" DrawStyle="Dot" 
                        Thickness="1" Visible="False" />
                    <Labels Font="Verdana, 7pt" FontColor="Gray" HorizontalAlign="Near" 
                        ItemFormatString="&lt;DATA_VALUE:00.##&gt;" Orientation="Horizontal" 
                        VerticalAlign="Center" Visible="False">
                        <SeriesLabels Font="Verdana, 7pt" FontColor="Gray" FormatString="" 
                            HorizontalAlign="Near" Orientation="Horizontal" VerticalAlign="Center">
                            <Layout Behavior="Auto">
                            </Layout>
                        </SeriesLabels>
                        <Layout Behavior="Auto">
                        </Layout>
                    </Labels>
                </Y2>
                <X2 LineThickness="1" TickmarkInterval="0" TickmarkStyle="Smart" 
                    Visible="False">
                    <MajorGridLines AlphaLevel="255" Color="Gainsboro" DrawStyle="Dot" 
                        Thickness="1" Visible="True" />
                    <MinorGridLines AlphaLevel="255" Color="LightGray" DrawStyle="Dot" 
                        Thickness="1" Visible="False" />
                    <Labels Font="Verdana, 7pt" FontColor="Gray" HorizontalAlign="Far" 
                        ItemFormatString="&lt;ITEM_LABEL&gt;" Orientation="VerticalLeftFacing" 
                        VerticalAlign="Center" Visible="False">
                        <SeriesLabels Font="Verdana, 7pt" FontColor="Gray" FormatString="" 
                            HorizontalAlign="Far" Orientation="VerticalLeftFacing" VerticalAlign="Center">
                            <Layout Behavior="Auto">
                            </Layout>
                        </SeriesLabels>
                        <Layout Behavior="Auto">
                        </Layout>
                    </Labels>
                </X2>
                <Z LineThickness="1" TickmarkInterval="0" TickmarkStyle="Smart" Visible="False">
                    <MajorGridLines AlphaLevel="255" Color="Gainsboro" DrawStyle="Dot" 
                        Thickness="1" Visible="True" />
                    <MinorGridLines AlphaLevel="255" Color="LightGray" DrawStyle="Dot" 
                        Thickness="1" Visible="False" />
                    <Labels Font="Verdana, 7pt" FontColor="DimGray" HorizontalAlign="Near" 
                        ItemFormatString="&lt;ITEM_LABEL&gt;" Orientation="Horizontal" 
                        VerticalAlign="Center" Visible="False">
                        <SeriesLabels Font="Verdana, 7pt" FontColor="DimGray" HorizontalAlign="Near" 
                            Orientation="Horizontal" VerticalAlign="Center">
                            <Layout Behavior="Auto">
                            </Layout>
                        </SeriesLabels>
                        <Layout Behavior="Auto">
                        </Layout>
                    </Labels>
                </Z>
                <Z2 LineThickness="1" TickmarkInterval="0" TickmarkStyle="Smart" 
                    Visible="False">
                    <MajorGridLines AlphaLevel="255" Color="Gainsboro" DrawStyle="Dot" 
                        Thickness="1" Visible="True" />
                    <MinorGridLines AlphaLevel="255" Color="LightGray" DrawStyle="Dot" 
                        Thickness="1" Visible="False" />
                    <Labels Font="Verdana, 7pt" FontColor="Gray" HorizontalAlign="Near" 
                        ItemFormatString="" Orientation="Horizontal" VerticalAlign="Center" 
                        Visible="False">
                        <SeriesLabels Font="Verdana, 7pt" FontColor="Gray" HorizontalAlign="Near" 
                            Orientation="Horizontal" VerticalAlign="Center">
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
            <Border Thickness="0" />
            <Tooltips Font-Bold="False" Font-Italic="False" Font-Overline="False" 
                Font-Strikeout="False" Font-Underline="False" 
                FormatString="&lt;ITEM_LABEL&gt;: &lt;DATA_VALUE:c&gt;" />
        </igchart:UltraChart>
       
    </div>
    <div class="fullbox">
        <h3><asp:Label ID="lblInvestments" runat="server" Text="Investments" 
                meta:resourcekey="lblInvestmentsResource1"></asp:Label></h3>
        <p class="note">
            <asp:Label ID="lblClickInvestment" runat="server" 
                Text="Click on an Investment to view detail" 
                meta:resourcekey="lblClickInvestmentResource1"></asp:Label></p>
        <asp:GridView CssClass="investmentsSummary" ID="gvInvestments" runat="server" 
            AutoGenerateColumns="False" OnRowCreated="gvInvestments_RowDataBound" 
            meta:resourcekey="gvInvestmentsResource1">
            <Columns>
                <asp:BoundField DataField="FundDescription" HeaderText="Fund" 
                    ItemStyle-CssClass="table-link" meta:resourcekey="BoundFieldResource1">
<ItemStyle CssClass="table-link"></ItemStyle>
                </asp:BoundField>
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
    </div>
    <div class="fullbox" id="divInvestmentDetails">
        <asp:UpdatePanel ID="udpInvestmentDetails" runat="server" OnLoad="udpInvestmentDetails_OnLoad"  UpdateMode="Conditional">
            <ContentTemplate>
                <h3><asp:Label ID="lblInvestmentDetails" Text="Investment Details" runat="server" 
                        meta:resourcekey="lblInvestmentDetailsResource1"/></h3>
                <div style="overflow: auto; height: 200px;">
                <asp:GridView ID="gvInvestmentDetails" CssClass="investmentsSummary" runat="server" 
                        AutoGenerateColumns="False" meta:resourcekey="gvInvestmentDetailsResource1">
                    <Columns>
                        <asp:BoundField DataField="DateReceived" HeaderText="Period" 
                            meta:resourcekey="BoundFieldResource6" />
                        <asp:BoundField DataField="DateInvested" HeaderText="Date Invested" 
                            meta:resourcekey="BoundFieldResource7" />
                        <asp:BoundField DataField="Source" HeaderText="Source" 
                            meta:resourcekey="BoundFieldResource8" />
                        <asp:BoundField DataField="Type" HeaderText="Type" 
                            meta:resourcekey="BoundFieldResource9" />
                        <asp:BoundField DataField="AmountInvested" HeaderText="Invested Amount" 
                            meta:resourcekey="BoundFieldResource10" />
                        <asp:BoundField DataField="DealtPrice" HeaderText="Dealt Price" 
                            meta:resourcekey="BoundFieldResource11" />
                        <asp:BoundField DataField="UnitsQuantity" HeaderText="Units" 
                            meta:resourcekey="BoundFieldResource12" />
                    </Columns>
                </asp:GridView>
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
</asp:Content>
<asp:Content ID="Content2" runat="server" 
    contentplaceholderid="ContentPlaceHolderPageTitle">

                        <div class="coins">
                            <! -- Change for Specific Icons -->
                            <h2>
                                <asp:Label runat="server" ID="lblPageHeader" Text="Investments" 
                                    meta:resourcekey="lblPageHeaderResource1" /></h2>
                            <p class="h2-line">
                                <asp:Label runat="server" ID="lblPageHeaderByline" 
                                    Text="Your Investment &amp; Fund information" 
                                    meta:resourcekey="lblPageHeaderBylineResource1" /></p>
                        </div>
                    
</asp:Content>
