<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ChartInvestmentValueOverTime.aspx.cs" Inherits="APT2012.ChartInvestmentValueOverTime" %>
<%@ Register Assembly="Infragistics35.WebUI.UltraWebChart.v9.1, Version=9.1.20091.1015, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.UltraWebChart" TagPrefix="igchart" %>
<%@ Register Assembly="Infragistics35.WebUI.UltraWebChart.v9.1, Version=9.1.20091.1015, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.UltraChart.Resources.Appearance" TagPrefix="igchartprop" %>
<%@ Register Assembly="Infragistics35.WebUI.UltraWebChart.v9.1, Version=9.1.20091.1015, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.UltraChart.Data" TagPrefix="igchartdata" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <igchart:UltraChart ID="uctInvestment" runat="server" 
                BackgroundImageFileName="" BorderColor="#868686"
                BorderWidth="0px" ChartType="LineChart" 
                Version="9.1"
                SplineAreaChart-LineDrawStyle="Solid" Width="700px" 
                OnInvalidDataReceived="SetEmptyChartData"
                EmptyChartText="Data Not Available. Please call UltraChart.Data.DataBind() after setting valid Data.DataSource" 
                Height="200px" meta:resourcekey="uctInvestmentResource1">
                <Legend BackgroundColor="Transparent" BorderThickness="0" 
                    Font="Calibri, 9.75pt, style=Bold" SpanPercentage="20" Visible="True">
                </Legend>
                <ColorModel AlphaLevel="255" ColorBegin="155, 187, 98" ColorEnd="DarkRed" 
                    ModelStyle="CustomLinear">
                    <Skin ApplyRowWise="False">
                        <PEs>
                            <igchartprop:PaintElement Fill="79, 129, 189" Stroke="187, 187, 187" />
                        </PEs>
                    </Skin>
                </ColorModel>
                <Axis>
                    <PE ElementType="Gradient" Fill="251, 255, 245" FillGradientStyle="Vertical" 
                        FillStopColor="241, 253, 224" StrokeWidth="0" />
                    <X Extent="20" LineColor="152, 185, 84" LineThickness="1" TickmarkInterval="0" 
                        TickmarkStyle="DataInterval" Visible="True">
                        <MajorGridLines AlphaLevel="255" Color="Gainsboro" DrawStyle="Dot" 
                            Thickness="1" Visible="False" />
                        <MinorGridLines AlphaLevel="255" Color="LightGray" DrawStyle="Dot" 
                            Thickness="1" Visible="False" />
                        <Labels Font="Calibri, 9.75pt, style=Bold" FontColor="89, 89, 89" 
                            HorizontalAlign="Near" ItemFormatString="&lt;ITEM_LABEL&gt;" 
                            Orientation="Horizontal" VerticalAlign="Center">
                            <SeriesLabels Font="Verdana, 7pt" FontColor="DimGray" FormatString="" 
                                HorizontalAlign="Near" Orientation="VerticalLeftFacing" VerticalAlign="Center" 
                                Visible="False">
                                <Layout Behavior="Auto">
                                </Layout>
                            </SeriesLabels>
                            <Layout Behavior="Auto">
                            </Layout>
                        </Labels>
                    </X>
                    <Y Extent="20" LineColor="152, 185, 84" LineThickness="1" TickmarkInterval="50" 
                        TickmarkStyle="Smart" Visible="True">
                        <MajorGridLines AlphaLevel="255" Color="199, 214, 176" DrawStyle="Dot" 
                            Thickness="1" Visible="True" />
                        <MinorGridLines AlphaLevel="255" Color="LightGray" DrawStyle="Dot" 
                            Thickness="1" Visible="False" />
                        <Labels Font="Calibri, 9.75pt, style=Bold" FontColor="89, 89, 89" 
                            HorizontalAlign="Far" ItemFormatString="&lt;DATA_VALUE:00.##&gt;" 
                            Orientation="Horizontal" VerticalAlign="Center">
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
                <border color="134, 134, 134" cornerradius="10" thickness="0" />
                <Tooltips FormatString="&lt;ITEM_LABEL&gt;: &lt;DATA_VALUE:c&gt;" />
            </igchart:UltraChart>
    </div>
    </form>
</body>
</html>
