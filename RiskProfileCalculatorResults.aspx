<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="RiskProfileCalculatorResults.aspx.cs" Inherits="APT2012.RiskProfileCalculatorResults" %>

<%@ Register Assembly="Infragistics35.WebUI.UltraWebGauge.v9.1, Version=9.1.20091.1015, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.UltraWebGauge" TagPrefix="igGauge" %>
<%@ Register Assembly="Infragistics35.Web.v9.1, Version=9.1.20091.1015, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.Web.UI.EditorControls" TagPrefix="ig" %>
<%@ Register Assembly="Infragistics35.WebUI.UltraWebGauge.v9.1, Version=9.1.20091.1015, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.UltraGauge.Resources" TagPrefix="igGaugeProp" %>
<%@ Register Assembly="Infragistics35.WebUI.WebResizingExtender.v9.1, Version=9.1.20091.1015, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI" TagPrefix="igui" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolderHead" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolderPageTitle" runat="server">
    <div class="calc">
        <! -- Change for Specific Icons -->
        <h2>
            <asp:Label runat="server" ID="lblPageHeader" Text="Risk Profile Calculator" meta:resourcekey="lblPageHeaderResource1" /></h2>
        <p>
            <asp:Label runat="server" ID="lblPageHeaderByline" Text="Calculate your risk" meta:resourcekey="lblPageHeaderBylineResource1" /></p>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="fullbox clear">
        <h3>
            <asp:Label ID="Label1" runat="server" Text="Risk Profile Iterpreter" meta:resourcekey="lblConfigureYourPensionResource1"></asp:Label>
        </h3>
        <div class="risk-calculator-sections">
            <div id="results-content">

                <div id="results">
                    <h5>
                        Totals Brought Forward
                    </h5>
                    <table>
                        <tr>
                            <td>
                                A. Time horizon
                            </td>
                            <td class="align-right">
                                <asp:Label ID="lblSectionATotals" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                B. Risk tolerance
                            </td>
                            <td class="align-right">
                                <asp:Label ID="lblSectionBTotals" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                C. Investment
                            </td>
                            <td class="align-right">
                                <asp:Label ID="lblSectionCTotals" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr id="grand-total">
                            <th>
                                Grand Total
                            </th>
                            <th class="align-right">
                                <asp:Label ID="lblRiskTotal" runat="server"></asp:Label>
                            </th>
                        </tr>
                    </table>
                </div>

                <div id="infra-container">
                    <h5>
                        Your Investment Strategy
                    </h5>
                    <igGauge:UltraGauge ID="iggRiskGauge" runat="server" BackColor="Transparent" Height="210px"
                        Width="145px">
                        <Gauges>
                            <igGaugeProp:LinearGauge CornerExtent="5" MarginString="2, 2, 2, 2, Pixels" 
                                Orientation="Vertical">
                                <Scales>
                                    <igGaugeProp:LinearGaugeScale>
                                        <MajorTickmarks EndExtent="80" EndWidth="4" Frequency="2.5" StartExtent="20" 
                                            StartWidth="4">
                                            <BrushElements>
                                                <igGaugeProp:SolidFillBrushElement />
                                            </BrushElements>
                                        </MajorTickmarks>
                                        <MinorTickmarks EndExtent="70" EndWidth="2" Frequency="5" StartExtent="30" 
                                            StartWidth="2">
                                        </MinorTickmarks>
                                        <Labels Extent="50" Font="Arial, 12pt, style=Bold" Frequency="20" 
                                            ZPosition="AboveMarkers">
                                        </Labels>
                                        <Markers>
                                            <igGaugeProp:LinearGaugeNeedle EndExtent="120" MidExtent="99" MidWidth="15" 
                                                StartExtent="85" StartWidth="1" ValueString="6">
                                                <StrokeElement>
                                                    <BrushElements>
                                                        <igGaugeProp:SolidFillBrushElement Color="64, 64, 64" />
                                                    </BrushElements>
                                                </StrokeElement>
                                                <BrushElements>
                                                    <igGaugeProp:SimpleGradientBrushElement EndColor="Maroon" StartColor="Red" />
                                                </BrushElements>
                                            </igGaugeProp:LinearGaugeNeedle>
                                        </Markers>
                                        <Axes>
                                            <igGaugeProp:NumericAxis EndValue="19" />
                                        </Axes>
                                    </igGaugeProp:LinearGaugeScale>
                                </Scales>
                                <BrushElements>
                                    <igGaugeProp:BrushElementGroup>
                                        <BrushElements>
                                            <igGaugeProp:MultiStopLinearGradientBrushElement Angle="90">
                                                <ColorStops>
                                                    <igGaugeProp:ColorStop Color="254, 42, 0" />
                                                    <igGaugeProp:ColorStop Color="212, 254, 0" Stop="0.637931" />
                                                    <igGaugeProp:ColorStop Color="0, 118, 0" Stop="1" />
                                                </ColorStops>
                                            </igGaugeProp:MultiStopLinearGradientBrushElement>
                                            <igGaugeProp:MultiStopLinearGradientBrushElement Angle="240" 
                                                RelativeBounds="0, 0, 100, 30" RelativeBoundsMeasure="Percent">
                                                <ColorStops>
                                                    <igGaugeProp:ColorStop Color="Transparent" />
                                                    <igGaugeProp:ColorStop Color="Transparent" Stop="0.3827586" />
                                                    <igGaugeProp:ColorStop Color="61, 254, 254, 254" Stop="0.4275862" />
                                                    <igGaugeProp:ColorStop Color="155, 255, 255, 255" Stop="1" />
                                                </ColorStops>
                                            </igGaugeProp:MultiStopLinearGradientBrushElement>
                                        </BrushElements>
                                    </igGaugeProp:BrushElementGroup>
                                </BrushElements>
                                <StrokeElement>
                                    <BrushElements>
                                        <igGaugeProp:SolidFillBrushElement />
                                    </BrushElements>
                                </StrokeElement>
                            </igGaugeProp:LinearGauge>
                        </Gauges>
                        <Annotations>
                            <igGaugeProp:BoxAnnotation Bounds="2, -37, 100, 100" BoundsMeasure="Percent">
                                <Label Font="Franklin Gothic Medium, 13pt" FormatString="Freestyle">
                                    <BrushElements>
                                        <igGaugeProp:SolidFillBrushElement Color="100, 0, 0, 0" />
                                    </BrushElements>
                                </Label>
                            </igGaugeProp:BoxAnnotation>
                            <igGaugeProp:BoxAnnotation Bounds="0, -38, 100, 100" BoundsMeasure="Percent">
                                <Label Font="Franklin Gothic Medium, 13pt" FormatString="Freestyle">
                                    <BrushElements>
                                        <igGaugeProp:SolidFillBrushElement Color="White" />
                                    </BrushElements>
                                </Label>
                            </igGaugeProp:BoxAnnotation>
                            <igGaugeProp:BoxAnnotation Bounds="2, -2, 100, 100" BoundsMeasure="Percent">
                                <Label Font="Franklin Gothic Medium, 13pt" FormatString="Lifestyle">
                                    <BrushElements>
                                        <igGaugeProp:SolidFillBrushElement Color="100, 0, 0, 0" />
                                    </BrushElements>
                                </Label>
                            </igGaugeProp:BoxAnnotation>
                            <igGaugeProp:BoxAnnotation Bounds="0, -3, 100, 100" BoundsMeasure="Percent">
                                <Label Font="Franklin Gothic Medium, 13pt" FormatString="Lifestyle">
                                    <BrushElements>
                                        <igGaugeProp:SolidFillBrushElement Color="White" />
                                    </BrushElements>
                                </Label>
                            </igGaugeProp:BoxAnnotation>
                            <igGaugeProp:BoxAnnotation Bounds="2, 34, 100, 100" BoundsMeasure="Percent">
                                <Label Font="Franklin Gothic Medium, 13pt" FormatString="Lifestyle">
                                    <BrushElements>
                                        <igGaugeProp:SolidFillBrushElement Color="100, 0, 0, 0" />
                                    </BrushElements>
                                </Label>
                            </igGaugeProp:BoxAnnotation>
                            <igGaugeProp:BoxAnnotation Bounds="0, 33, 100, 100" BoundsMeasure="Percent">
                                <Label Font="Franklin Gothic Medium, 13pt" FormatString="Lifestyle">
                                    <BrushElements>
                                        <igGaugeProp:SolidFillBrushElement Color="White" />
                                    </BrushElements>
                                </Label>
                            </igGaugeProp:BoxAnnotation>
                            <igGaugeProp:BoxAnnotation Bounds="2, 42, 100, 100" BoundsMeasure="Percent">
                                <Label Font="Franklin Gothic Medium, 13pt" FormatString="(Low Volatility)">
                                    <BrushElements>
                                        <igGaugeProp:SolidFillBrushElement Color="100, 0, 0, 0" />
                                    </BrushElements>
                                </Label>
                            </igGaugeProp:BoxAnnotation>
                            <igGaugeProp:BoxAnnotation Bounds="0, 41, 100, 100" BoundsMeasure="Percent">
                                <Label Font="Franklin Gothic Medium, 13pt" FormatString="(Low Volatility)">
                                    <BrushElements>
                                        <igGaugeProp:SolidFillBrushElement Color="White" />
                                    </BrushElements>
                                </Label>
                            </igGaugeProp:BoxAnnotation>
                            <igGaugeProp:BoxAnnotation Bounds="2, 7, 100, 100" BoundsMeasure="Percent">
                                <Label Font="Franklin Gothic Medium, 13pt" FormatString="(Medium Volatility)">
                                    <BrushElements>
                                        <igGaugeProp:SolidFillBrushElement Color="100, 0, 0, 0" />
                                    </BrushElements>
                                </Label>
                            </igGaugeProp:BoxAnnotation>
                            <igGaugeProp:BoxAnnotation Bounds="0, 6, 100, 100" BoundsMeasure="Percent">
                                <Label Font="Franklin Gothic Medium, 13pt" FormatString="(Medium Volatility)">
                                    <BrushElements>
                                        <igGaugeProp:SolidFillBrushElement Color="White" />
                                    </BrushElements>
                                </Label>
                            </igGaugeProp:BoxAnnotation>
                        </Annotations>
                    </igGauge:UltraGauge>
                </div>

                <div id="result-iterpreter">
                    <table>
                        <tr>
                            <th id="risk-profile-strategies-col1">
                                Score
                            </th>
                            <th id="risk-profile-strategies-col2">
                                Risk Profile
                            </th>
                            <th id="risk-profile-strategies-col3">
                                Investment Strategy
                            </th>
                        </tr>
                        <tr>
                            <td>
                                4-7
                            </td>
                            <td>
                                lower risk
                            </td>
                            <td>
                                Lifestyle (Low volatility)
                            </td>
                        </tr>
                        <tr>
                            <td>
                                8-11
                            </td>
                            <td>
                                moderate risk
                            </td>
                            <td>
                                Lifestyle (Medium volatility)
                            </td>
                        </tr>
                        <tr>
                            <td>
                                12+
                            </td>
                            <td>
                                higher risk
                            </td>
                            <td>
                                Freestyle
                            </td>
                        </tr>
                    </table>
                    <p>
                        Financial planners have found this simple questionaire can be a useful guide to
                        where you may prefer to invest. The profiler is not a substitue for financial planning.
                        It is just one of the tools you can use to help you choose your investment strategy.
                        APT Financial Services Ltd. encourages you to consider discussing your needs with
                        a financial adviser before you make a decision about your investment choice.</p>
                    <br />
                    <p>
                        APT Financial Services Ltd. can give you tailored advice on making your member investment
                        choice: call us on 01 2063010 if you need our help.</p>
                </div>

            </div>
        </div>
    </div>
</asp:Content>
