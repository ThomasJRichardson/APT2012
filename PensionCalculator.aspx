<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="PensionCalculator.aspx.cs" Inherits="APT2012.PensionCalculator" meta:resourcekey="PageResource1"
    EnableViewState="false" %>

<%@ Register Assembly="Infragistics35.WebUI.UltraWebGauge.v9.1, Version=9.1.20091.1015, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.UltraWebGauge" TagPrefix="igGauge" %>
<%@ Register Assembly="Infragistics35.Web.v9.1, Version=9.1.20091.1015, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.Web.UI.EditorControls" TagPrefix="ig" %>
<%@ Register Assembly="Infragistics35.WebUI.UltraWebGauge.v9.1, Version=9.1.20091.1015, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.UltraGauge.Resources" TagPrefix="igGaugeProp" %>
<%@ Register Assembly="Infragistics35.WebUI.WebResizingExtender.v9.1, Version=9.1.20091.1015, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI" TagPrefix="igui" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolderHead" runat="server">

    <script type="text/javascript" language="javascript">

        var nextage;
        var contributionpercent;
        var currentsalary;
        var existingpension;
        var retirementage;
        var targetpension;
        var taxfreelumpsum;

        function valueChanged(value) {
            var oGauge = ig_getWebControlById("<%= iggRAMGauge.ClientID %>");
            oGauge.updateControlState("ValueFromClient", value);
            oGauge.refresh();
        }
        function tempValueChanged() {
            valueChanged(80);
            return false;
        }

        function ReCalculateValues() {

            currentsalary = Math.round($('#<%=txtCurrentSalary.ClientID %>').val());
            existingpension = Math.round($('#<%=txtPensionValue.ClientID %>').val());
            nextage = $('#<%=ddlNextAge.ClientID %>').val();

            var contributionpercentobj = $find('<%=sliderContributions.ClientID %>');
            if (contributionpercentobj == null)
                contributionpercent = Math.round('<%= sliderContributions.ValueAsDouble %>');
            else
                contributionpercent = Math.round(contributionpercentobj.get_value());

            var targetpensionobj = $find('<%=sliderTargetPension.ClientID %>');
            if (targetpensionobj == null)
                targetpension = Math.round('<%= sliderTargetPension.ValueAsDouble %>');
            else
                targetpension = Math.round(targetpensionobj.get_value());

            var taxfreelumpsumobj = $find('<%=sliderTaxFreeLump.ClientID %>');
            if (taxfreelumpsumobj == null)
                taxfreelumpsum = Math.round('<%= sliderTaxFreeLump.ValueAsDouble %>');
            else
                taxfreelumpsum = Math.round(taxfreelumpsumobj.get_value());

            var retirementageobj = $find('<%=sliderRetirementAge.ClientID %>');
            if (retirementageobj == null)
                retirementage = Math.round('<%= sliderRetirementAge.ValueAsDouble %>');
            else
                retirementage = Math.round(retirementageobj.get_value());

            var inflationpercent = $('#<%=lblInflationRate.ClientID %>').text();
            $.ajax({
                type: "POST",
                url: '<%# ResolveUrl ("APTAjax.aspx") %>/PensionCalculate',
                data: "{ 'nextage':'" + nextage + "', 'contributionpercent':'" + (contributionpercent / 100) + "', 'currentsalary':'" + currentsalary + "', 'existingpension':'" + existingpension + "', 'retirementage':'" + retirementage + "', 'targetpension':'" + (targetpension / 100) + "', 'taxfreelumpsum':'" + (taxfreelumpsum / 100) + "', 'inflationpercent':'" + inflationpercent + "' }",
                dataType: "json",
                contentType: "application/json; charset=utf-8",
                success: function(msg) {
                    $.each(msg.d.Table1, function(i, calc) {

                        $("#age").text(Math.round(retirementage));
                        $("#age2").text(Math.round(retirementage));
                        $("#pension-fund").text(calc.CurrencySymbol + Math.round(calc.EstimatedPensionFund));
                        $("#final-salary").text(calc.CurrencySymbol + Math.round(calc.EstimateSalary));
                        $("#members-pension").text(calc.CurrencySymbol + Math.round(calc.MembersPension));
                        $("#members-pension-percent").text(Math.round(calc.MemberPercentOfFinalSalary));
                        $("#lump-sum").text(calc.CurrencySymbol + Math.round(calc.TaxFreeLumpSum));
                        $("#lump-sum-percent").text(Math.round(calc.PercentOfTaxFreeSum));
                        $("#reduced-pension").text(calc.CurrencySymbol + Math.round(calc.ReducedPension));
                        $("#reduced-pension-percent").text(Math.round(calc.ReducedPensionPercent));
                        $("#target-percent").text(Math.round(targetpension));
                        $("#target-benefit").text(calc.CurrencySymbol + Math.round(calc.TargetPensionEuros));
                        $("#fund-shortfall-value").text(calc.CurrencySymbol + Math.round(calc.FundShortfallValue));
                        $("#fund-shortfall-percent").text(Math.round(calc.FundShortfallPercent));
                        if (calc.FundShortfallPercent == 0) {
                            valueChanged(100);
                            //valueChanged(0);
                        } else if (calc.FundShortfallPercent > 100) {
                            valueChanged(0);
                            //valueChanged(100);
                        }
                        else {
                            valueChanged(100 - calc.FundShortfallPercent);
                            //valueChanged(calc.FundShortfallPercent);
                        }
                        if (calc.FundShortfallValue == 0) {
                            $("#shortfall-required-row").hide();
                        }
                        else {
                            $("#shortfall-required-row").show();
                        }
                    });
                },
                ajaxError: function(msg) {
                    alert("Error: " + msg);
                }
            });

        }

        function RetirementAgeChanged(slider, args) {
            slider.set_value(Math.round(slider.get_value()));
            ReCalculateValues();
        }

        function NextAgeChanged() {
            ReCalculateValues();
        }

        function ContributionChanged(slider, args) {
            slider.set_value(Math.round(slider.get_value()));
            ReCalculateValues();
            $("#contPercent").text(Math.round(slider.get_value()));
        }

        function TargetPensionChanged(slider, args) {
            slider.set_value(Math.round(slider.get_value()));
            ReCalculateValues();
        }

        function TaxFreeLumpChanged(slider, args) {
            slider.set_value(Math.round(slider.get_value()));
            ReCalculateValues();
        }

        function CurrentSalaryChanged() {
            ReCalculateValues();
        }

        function ExistingPensionChanged() {
            ReCalculateValues();
        }

        $(document).ready(function() {
            $('#<%=ddlNextAge.ClientID %>').change(function() {
                NextAgeChanged();
            });

            $('#<%=txtPensionValue.ClientID %>').change(function() {
                ExistingPensionChanged();
            });

            $('#<%=txtCurrentSalary.ClientID %>').change(function() {
                CurrentSalaryChanged();
            });
            ReCalculateValues();

        });
    </script>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>

    <script type="text/javascript" language="javascript">
        $(document).ready(function() {
            ReCalculateValues();
        });
    </script>

    <div class="fullbox clear">
        <h3>
            <asp:Label ID="lblConfigureYourPension" runat="server" Text="Configure Your Pension"
                meta:resourcekey="lblConfigureYourPensionResource1"></asp:Label>
        </h3>
        <table>
            <tr>
                <td>
                    <asp:Label ID="Label1" AssociatedControlID="ddlNextAge" runat="server" Text="Your Next Age"
                        meta:resourcekey="Label1Resource1"></asp:Label>
                </td>
                <td>
                    <asp:DropDownList ID="ddlNextAge" runat="server" meta:resourcekey="ddlNextAgeResource1">
                        <asp:ListItem Value="18" meta:resourcekey="ListItemResource1">18</asp:ListItem>
                        <asp:ListItem Value="19" meta:resourcekey="ListItemResource2">19</asp:ListItem>
                        <asp:ListItem Value="20" meta:resourcekey="ListItemResource3">20</asp:ListItem>
                        <asp:ListItem Value="21" meta:resourcekey="ListItemResource4">21</asp:ListItem>
                        <asp:ListItem Value="22" meta:resourcekey="ListItemResource5">22</asp:ListItem>
                        <asp:ListItem Value="23" meta:resourcekey="ListItemResource6">23</asp:ListItem>
                        <asp:ListItem Value="24" meta:resourcekey="ListItemResource7">24</asp:ListItem>
                        <asp:ListItem Value="25" meta:resourcekey="ListItemResource8">25</asp:ListItem>
                        <asp:ListItem Value="26" meta:resourcekey="ListItemResource9">26</asp:ListItem>
                        <asp:ListItem Value="27" meta:resourcekey="ListItemResource10">27</asp:ListItem>
                        <asp:ListItem Value="28" meta:resourcekey="ListItemResource11">28</asp:ListItem>
                        <asp:ListItem Value="29" meta:resourcekey="ListItemResource12">29</asp:ListItem>
                        <asp:ListItem Value="30" meta:resourcekey="ListItemResource13">30</asp:ListItem>
                        <asp:ListItem Value="31" meta:resourcekey="ListItemResource14">31</asp:ListItem>
                        <asp:ListItem Value="32" meta:resourcekey="ListItemResource15">32</asp:ListItem>
                        <asp:ListItem Value="33" meta:resourcekey="ListItemResource16">33</asp:ListItem>
                        <asp:ListItem Value="34" meta:resourcekey="ListItemResource17">34</asp:ListItem>
                        <asp:ListItem Value="35" meta:resourcekey="ListItemResource18">35</asp:ListItem>
                        <asp:ListItem Value="36" meta:resourcekey="ListItemResource19">36</asp:ListItem>
                        <asp:ListItem Value="37" meta:resourcekey="ListItemResource20">37</asp:ListItem>
                        <asp:ListItem Value="38" meta:resourcekey="ListItemResource21">38</asp:ListItem>
                        <asp:ListItem Value="39" meta:resourcekey="ListItemResource22">39</asp:ListItem>
                        <asp:ListItem Value="40" meta:resourcekey="ListItemResource23">40</asp:ListItem>
                        <asp:ListItem Value="41" meta:resourcekey="ListItemResource24">41</asp:ListItem>
                        <asp:ListItem Value="42" meta:resourcekey="ListItemResource25">42</asp:ListItem>
                        <asp:ListItem Value="43" meta:resourcekey="ListItemResource26">43</asp:ListItem>
                        <asp:ListItem Value="44" meta:resourcekey="ListItemResource27">44</asp:ListItem>
                        <asp:ListItem Value="45" meta:resourcekey="ListItemResource28">45</asp:ListItem>
                        <asp:ListItem Value="46" meta:resourcekey="ListItemResource29">46</asp:ListItem>
                        <asp:ListItem Value="47" meta:resourcekey="ListItemResource30">47</asp:ListItem>
                        <asp:ListItem Value="48" meta:resourcekey="ListItemResource31">48</asp:ListItem>
                        <asp:ListItem Value="49" meta:resourcekey="ListItemResource32">49</asp:ListItem>
                        <asp:ListItem Value="50" meta:resourcekey="ListItemResource33">50</asp:ListItem>
                        <asp:ListItem Value="51" meta:resourcekey="ListItemResource34">51</asp:ListItem>
                        <asp:ListItem Value="52" meta:resourcekey="ListItemResource35">52</asp:ListItem>
                        <asp:ListItem Value="53" meta:resourcekey="ListItemResource36">53</asp:ListItem>
                        <asp:ListItem Value="54" meta:resourcekey="ListItemResource37">54</asp:ListItem>
                        <asp:ListItem Value="55" meta:resourcekey="ListItemResource38">55</asp:ListItem>
                        <asp:ListItem Value="56" meta:resourcekey="ListItemResource39">56</asp:ListItem>
                        <asp:ListItem Value="57" meta:resourcekey="ListItemResource40">57</asp:ListItem>
                        <asp:ListItem Value="58" meta:resourcekey="ListItemResource41">58</asp:ListItem>
                        <asp:ListItem Value="59" meta:resourcekey="ListItemResource42">59</asp:ListItem>
                        <asp:ListItem Value="60" meta:resourcekey="ListItemResource43">60</asp:ListItem>
                        <asp:ListItem Value="61" meta:resourcekey="ListItemResource44">61</asp:ListItem>
                        <asp:ListItem Value="62" meta:resourcekey="ListItemResource45">62</asp:ListItem>
                        <asp:ListItem Value="63" meta:resourcekey="ListItemResource46">63</asp:ListItem>
                        <asp:ListItem Value="64" meta:resourcekey="ListItemResource47">64</asp:ListItem>
                        <asp:ListItem Value="65" meta:resourcekey="ListItemResource48">65</asp:ListItem>
                    </asp:DropDownList>
                </td>
                <td>
                    <asp:Label ID="Label2" AssociatedControlID="txtCurrentSalary" runat="server" Text="Current Salary"
                        meta:resourcekey="Label2Resource1"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="txtCurrentSalary" runat="server" meta:resourcekey="txtCurrentSalaryResource1"
                        MaxLength="10"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="Label3" runat="server" Text="Contribution per annum" meta:resourcekey="Label3Resource1"></asp:Label>
                </td>
                <td>
                    <ig:WebSlider ID="sliderContributions" runat="server" MaxValueAsString="40" MinValueAsString="0"
                        StyleSetName="ElectricBlue">
                        <ClientEvents ValueChanged="ContributionChanged" />
                        <ValueLabel Location="FloatTopOrLeft" CssClass="igsli_ValueLabelFloatLShowAll" />
                    </ig:WebSlider>
                </td>
                <td>
                    <asp:Label ID="Label4" runat="server" Text="Retirement Age" meta:resourcekey="Label4Resource1"></asp:Label>
                </td>
                <td>
                    <ig:WebSlider ID="sliderRetirementAge" runat="server" Tickmarks-NumberOfMinorTickmarks="0"
                        Tickmarks-NumberOfMajorTickmarks="16" SnapToSmallChange="True" SmallChangeAsString="1"
                        MaxValueAsString="65" MinValueAsString="50" meta:resourcekey="sliderRetirementAgeResource1"
                        StyleSetName="ElectricBlue">
                        <ClientEvents ValueChanged="RetirementAgeChanged" />
                        <ValueLabel Location="FloatTopOrLeft" CssClass="igsli_ValueLabelFloatLShowAll" />
                        <Tickmarks NumberOfMinorTickmarks="0" NumberOfMajorTickmarks="16">
                        </Tickmarks>
                    </ig:WebSlider>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="Label5" AssociatedControlID="txtPensionValue" runat="server" Text="Existing Pension Value"
                        meta:resourcekey="Label5Resource1"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="txtPensionValue" runat="server" meta:resourcekey="txtPensionValueResource1"
                        MaxLength="10"></asp:TextBox>
                </td>
                <td>
                    &nbsp;
                </td>
                <td>
                    &nbsp;
                </td>
            </tr>
            <tr style="border-top: 2px Solid #333">
                <td>
                    <asp:Label ID="Label6" runat="server" Text="Target Pension" meta:resourcekey="Label6Resource1"></asp:Label>
                </td>
                <td>
                    <ig:WebSlider ID="sliderTargetPension" runat="server" MinValueAsString="33" MaxValueAsString="66"
                        Tickmarks-NumberOfMajorTickmarks="3" Tickmarks-NumberOfMinorTickmarks="0" meta:resourcekey="sliderTargetPensionResource1"
                        StyleSetName="ElectricBlue">
                        <ClientEvents ValueChanged="TargetPensionChanged" />
                        <ValueLabel Location="FloatTopOrLeft" CssClass="igsli_ValueLabelFloatLShowAll" />
                        <Tickmarks NumberOfMinorTickmarks="0">
                        </Tickmarks>
                    </ig:WebSlider>
                </td>
                <td>
                    <asp:Label ID="Label7" runat="server" Text="Tax Free Lump Sum" meta:resourcekey="Label7Resource1"></asp:Label>
                </td>
                <td>
                    <ig:WebSlider ID="sliderTaxFreeLump" runat="server" meta:resourcekey="sliderTaxFreeLumpResource1" MinValueAsString="0" MaxValueAsString="150"
                        StyleSetName="ElectricBlue">
                        <ClientEvents ValueChanged="TaxFreeLumpChanged" />
                        <ValueLabel Location="FloatTopOrLeft" CssClass="igsli_ValueLabelFloatLShowAll" />
                    </ig:WebSlider>
                </td>
            </tr>
        </table>
    </div>
    <div class="fullbox clear" id="mood-table">
        <h3>
            <asp:Label ID="lblPensionResults" runat="server" Text="Pension Results" meta:resourcekey="lblPensionResultsResource1"></asp:Label>
        </h3>
        <div class="leftbox70">
            <table width="100%">
                <tr>
                    <td colspan="3">
                        <asp:Label ID="Label8" runat="server" Text="Estimated Pension Fund at age" meta:resourcekey="Label8Resource1"></asp:Label>
                        <span id="age"></span>
                        <span>&nbsp;based on</span>
                        <span id="contPercent">5</span>
                        <span> percent contributions p.a. </span>
                    </td>
                    <td>
                        <strong><span id="pension-fund"></span></strong>
                    </td>
                </tr>
                <tr>
                    <td colspan="3">
                        <asp:Label ID="Label9" runat="server" Text="Estimated Final Salary at age" meta:resourcekey="Label9Resource1"></asp:Label>
                        <span id="age2"></span>
                    </td>
                    <td>
                        <strong><span id="final-salary"></span></strong>
                    </td>
                </tr>
                <tr>
                    <td>&nbsp;</td>
                    <td></td>
                    <td></td>
                    <td></td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="Label10" runat="server" Text="To Provide" meta:resourcekey="Label10Resource1"></asp:Label>
                    </td>
                    <td>
                    </td>
                    <td>
                    </td>
                    <td>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="Label11" runat="server" Text="(A) Members Pension of" meta:resourcekey="Label11Resource1"></asp:Label>
                    </td>
                    <td>
                        <strong><span id="members-pension"></span></strong>
                        &nbsp;<asp:Label ID="lblPerAnum" runat="server" Text="p.a." meta:resourcekey="lblPerAnumResource1"></asp:Label>
                    </td>
                    <td>
                    </td>
                    <td>
                        (<span id="members-pension-percent"></span>%
                        <asp:Label ID="Label12" runat="server" Text="of final salary" meta:resourcekey="Label12Resource1"></asp:Label>)
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="Label13" runat="server" Text="OR" meta:resourcekey="Label13Resource1"></asp:Label>
                    </td>
                    <td>
                    </td>
                    <td>
                    </td>
                    <td>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="Label14" runat="server" Text="(B) Tax free Lump Sum of" meta:resourcekey="Label14Resource1"></asp:Label>
                    </td>
                    <td>
                        <strong><span id="lump-sum"></span></strong>
                    </td>
                    <td>
                    </td>
                    <td>
                        (<span id="lump-sum-percent"></span>%
                        <asp:Label ID="Label15" runat="server" Text=" of final salary" meta:resourcekey="Label15Resource1"></asp:Label>)
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="Label16" runat="server" Text="AND" meta:resourcekey="Label16Resource1"></asp:Label>
                    </td>
                    <td>
                    </td>
                    <td>
                    </td>
                    <td>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="Label17" runat="server" Text="Reduced Pension of" meta:resourcekey="Label17Resource1"></asp:Label>
                    </td>
                    <td>
                        <strong><span id="reduced-pension"></span></strong>
                            &nbsp;<asp:Label ID="lblPerAnum3" runat="server" Text="p.a." meta:resourcekey="lblPerAnum3Resource1"></asp:Label>
                    </td>
                    <td>
                    </td>
                    <td>
                        (<span id="reduced-pension-percent"></span>%
                        <asp:Label ID="Label18" runat="server" Text=" of final salary" meta:resourcekey="Label18Resource1"></asp:Label>)
                    </td>
                </tr>
            </table>
            <p/>
            <table>
                <tr>
                    <td>
                        <strong>
                            <asp:Label ID="lblTargetBenefit" runat="server" Text="Target Benefit:" meta:resourcekey="lblTargetBenefitResource1"></asp:Label></strong>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblTargetPension" runat="server" Text="Target Pension " meta:resourcekey="lblTargetPensionResource1"></asp:Label>
                        <span id="target-percent"></span>
                        <asp:Label ID="lblPercOfFinalSal" runat="server" Text="% of Final Salary is " meta:resourcekey="lblPercOfFinalSalResource1"></asp:Label>
                        <strong><span id="target-benefit"></span></strong>
                        <asp:Label ID="lblPerAnum4" runat="server" Text=" p.a." meta:resourcekey="lblPerAnum4Resource1"></asp:Label>
                    </td>
                </tr>
                <tr id="shortfall-required-row">
                    <td>
                        <asp:Label ID="lblPensionCalcInfo1" runat="server" Text="An Additional Pension Contribution of "></asp:Label>
                        <strong><span id="fund-shortfall-value"></span>&nbsp;</strong>
                        <asp:Label ID="lblPensionCalcInfo2" runat="server" Text=" or "></asp:Label>
                        <span id="fund-shortfall-percent"></span>
                        <asp:Label ID="lblPensionCalcInfo3" runat="server" Text="% of your current salary p.a. is required increasing to fund the shortfall."></asp:Label>
                    </td>
                </tr>
            </table>
        </div>
        <div class="rightbox30">
            <span class="heading3">Target Pension Percentage</span>
            <igGauge:UltraGauge ID="iggRAMGauge" runat="server" BackColor="Transparent" Height="250px"
                Width="250px" OnAsyncRefresh="iggRAMGauge_AsyncRefresh">
                <Gauges>
                    <igGaugeProp:RadialGauge BoundsMeasure="Percent" CornerExtent="8" 
                        MarginString="2, 2, 2, 2, Pixels">
                        <Dial Bounds="0, 0, 100, 142" BoundsMeasure="Percent" CornerExtent="8" 
                            Shape="Rectangular">
                        </Dial>
                        <Scales>
                            <igGaugeProp:RadialGaugeScale EndAngle="360" StartAngle="180">
                                <MajorTickmarks EndExtent="88" EndWidth="4" StartExtent="80" StartWidth="4">
                                    <StrokeElement Color="DimGray">
                                    </StrokeElement>
                                    <BrushElements>
                                        <igGaugeProp:SolidFillBrushElement Color="White" />
                                    </BrushElements>
                                </MajorTickmarks>
                                <MinorTickmarks EndExtent="85" Frequency="0.25" StartExtent="80" StartWidth="2">
                                    <BrushElements>
                                        <igGaugeProp:SolidFillBrushElement Color="DeepSkyBlue" />
                                    </BrushElements>
                                </MinorTickmarks>
                                <Labels Extent="65" Font="Trebuchet MS, 12px, style=Bold" 
                                    Orientation="Horizontal" SpanMaximum="18">
                                    <Shadow Depth="2">
                                        <BrushElements>
                                            <igGaugeProp:SolidFillBrushElement />
                                        </BrushElements>
                                    </Shadow>
                                    <BrushElements>
                                        <igGaugeProp:SolidFillBrushElement Color="64, 64, 64" />
                                    </BrushElements>
                                </Labels>
                                <Markers>
                                    <igGaugeProp:RadialGaugeNeedle EndExtent="73" MidExtent="0" MidWidth="2" 
                                        StartExtent="-30" StartWidth="0" ValueString="35" WidthMeasure="Percent">
                                        <Anchor Radius="5" RadiusMeasure="Percent">
                                            <BrushElements>
                                                <igGaugeProp:RadialGradientBrushElement CenterColor="197, 223, 235" 
                                                    CenterPointString="25, 25" SurroundColor="120, 181, 209" />
                                            </BrushElements>
                                            <StrokeElement Color="106, 154, 172" Thickness="2">
                                            </StrokeElement>
                                        </Anchor>
                                        <BackAnchor>
                                            <BrushElements>
                                                <igGaugeProp:SolidFillBrushElement />
                                            </BrushElements>
                                        </BackAnchor>
                                        <StrokeElement Color="DimGray">
                                        </StrokeElement>
                                        <BrushElements>
                                            <igGaugeProp:SolidFillBrushElement Color="White" />
                                        </BrushElements>
                                    </igGaugeProp:RadialGaugeNeedle>
                                </Markers>
                                <Ranges>
                                    <igGaugeProp:RadialGaugeRange EndValueString="50" InnerExtentEnd="50" 
                                        InnerExtentStart="50" OuterExtent="60" StartValueString="0">
                                        <BrushElements>
                                            <igGaugeProp:SimpleGradientBrushElement EndColor="Red" 
                                                GradientStyle="VerticalBump" StartColor="DarkOrange" />
                                        </BrushElements>
                                    </igGaugeProp:RadialGaugeRange>
                                    <igGaugeProp:RadialGaugeRange EndValueString="100" InnerExtentEnd="50" 
                                        InnerExtentStart="50" OuterExtent="60" StartValueString="50">
                                        <BrushElements>
                                            <igGaugeProp:SimpleGradientBrushElement EndColor="Lime" 
                                                GradientStyle="VerticalBump" StartColor="DarkOrange" />
                                        </BrushElements>
                                    </igGaugeProp:RadialGaugeRange>
                                </Ranges>
                                <BrushElements>
                                    <igGaugeProp:SolidFillBrushElement />
                                </BrushElements>
                                <Axes>
                                    <igGaugeProp:NumericAxis EndValue="100" TickmarkInterval="20" />
                                </Axes>
                            </igGaugeProp:RadialGaugeScale>
                        </Scales>
                        <BrushElements>
                            <igGaugeProp:SimpleGradientBrushElement EndColor="Silver" 
                                GradientStyle="BackwardDiagonal" StartColor="WhiteSmoke" />
                        </BrushElements>
                        <StrokeElement Thickness="0">
                            <BrushElements>
                                <igGaugeProp:SimpleGradientBrushElement EndColor="233, 238, 242" 
                                    GradientStyle="Rectangular" StartColor="249, 251, 252" />
                            </BrushElements>
                        </StrokeElement>
                    </igGaugeProp:RadialGauge>
                </Gauges>
            </igGauge:UltraGauge>
        </div>
    </div>
    <div class="fullbox clear">
        <h3>
            <asp:Label ID="lblDisclaimer" runat="server" Text="Disclaimer"></asp:Label>
        </h3>
        <table>
            <tr id="">
                <td>
                    &nbsp;
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="lblPensionCalcInfo4" runat="server" Text="The above calculations are for illustrative purposes only and are not guaranteed. Should you require further information please contact us at: Tel: 01 - 2063010 or "></asp:Label>
                    <a href="mailto:website@alliedpensions.com?Subject=Pension Calculation Question">website@alliedpensions.com</a>
                </td>
            </tr>
            <tr>
                <td>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="lblPensionCalcInfo5" runat="server" Text="Notes:"></asp:Label>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="lblPensionCalcInfo6" runat="server" Text="1. Salary and Contributions are assumed to increase at "></asp:Label>
                    <asp:Label ID="lblInflationRate" runat="server" Text=""></asp:Label>
                    <asp:Label ID="lblPensionCalcInfo6b" runat="server" Text="% p.a. between now and retirement age."></asp:Label>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="lblPensionCalcInfo7" runat="server" Text="2. The Pension Fund is assumed to grow by "></asp:Label>
                    <asp:Label ID="lblInvestmentReturn" runat="server" Text=""></asp:Label>
                    <asp:Label ID="lblPensionCalcInfo7B" runat="server" Text="% p.a. to retirement age."></asp:Label>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="lblPensionCalcInfo8" runat="server" Text="3. The Pension quoted is a single Life Pension, increasing each year in payment by 3% p.a."></asp:Label>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="lblPensionCalcInfo9" runat="server" Text="4. State Retirement Benefits become payable from age 65."></asp:Label>
                </td>
            </tr>
        </table>
    </div>
</asp:Content>
<asp:Content ID="Content4" runat="server" ContentPlaceHolderID="ContentPlaceHolderPageTitle">
    <div class="calc">
        <! -- Change for Specific Icons -->
        <h2>
            <asp:Label runat="server" ID="lblPageHeader" Text="Pension Calculator" meta:resourcekey="lblPageHeaderResource1" /></h2>
        <p>
            <asp:Label runat="server" ID="lblPageHeaderByline" Text="Calculate your pension for when you reach retirement age"
                meta:resourcekey="lblPageHeaderBylineResource1" /></p>
    </div>
</asp:Content>
