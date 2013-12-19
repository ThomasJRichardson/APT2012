<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" MaintainScrollPositionOnPostback="true"
    AutoEventWireup="true" CodeBehind="InvestmentStrategy.aspx.cs" Inherits="APT2012.InvestmentStrategy" meta:resourcekey="PageResource1" %>

<asp:Content ID="ContentHead" ContentPlaceHolderID="ContentPlaceHolderHead" runat="server">

    <script type="text/javascript">

        function roundNumber(num, dec) {
            var result = Math.round(num * Math.pow(10, dec)) / Math.pow(10, dec);            
            return result;
        }

        $(document).ready(function () {

            //Initialise Totals

            var totalcontperc = 0.00;
            var totalaccumperc = 0.00;

            $("input.contvalues").each(function () {                
                totalcontperc = roundNumber(Number(totalcontperc) + Number($(this).val()), 7);
            });

            $("input.accumvalues").each(function () {                
                totalaccumperc = roundNumber(Number(totalaccumperc) + Number($(this).val()), 7);
            });

            if (totalcontperc > 0.00) {
                totalcontperc = Math.round(totalcontperc);
            }

            if (totalaccumperc > 0.00) {
                totalaccumperc = Math.round(totalaccumperc);
            }

            if (totalcontperc != 100.00) {
                $("#contInvestTotal").css("color", "red");
                $("#<%= btnSubmitContributionInvestment.ClientID %>").attr("disabled", "disabled");
            } else {
                $("#contInvestTotal").css("color", "green");
            }

            if (totalaccumperc != 100.00) {
                $("#accumAssetTotal").css("color", "red");
                $("#<%= btnSubmitAccumulatedAssets.ClientID %>").attr("disabled", "disabled");
            } else {
                $("#accumAssetTotal").css("color", "green");
            }

            $("#contInvestTotal").text(totalcontperc + "%");
            $("#accumAssetTotal").text(totalaccumperc + "%");

            //Total Event Handlers

            $("input.contvalues").keyup(function () {
                if (isNaN(this.value)) {
                    this.value = this.value.replace(/[^0-9\.]/g, '');
                }
                totalcontperc = 0.00;
                $("input.contvalues").each(function () {
                    totalcontperc = roundNumber(Number(totalcontperc) + Number($(this).val()), 7);
                });
                $("#contInvestTotal").text(totalcontperc + "%");
                if (totalcontperc != 100.00) {
                    $("#contInvestTotal").css("color", "red");
                    $("#<%= btnSubmitContributionInvestment.ClientID %>").attr("disabled", "disabled");
                } else {
                    $("#contInvestTotal").css("color", "green");
                    $("#<%= btnSubmitContributionInvestment.ClientID %>").removeAttr("disabled");
                }
            });

            $("input.accumvalues").keyup(function () {

                if (isNaN(this.value)) {
                    this.value = this.value.replace(/[^0-9\.]/g, '');
                }
                totalaccumperc = 0;
                $("input.accumvalues").each(function () {
                    totalaccumperc = roundNumber(Number(totalaccumperc) + Number($(this).val()), 7);
                });
                $("#accumAssetTotal").text(totalaccumperc + "%");
                if (totalaccumperc != 100.00) {
                    $("#accumAssetTotal").css("color", "red");
                    $("#<%= btnSubmitAccumulatedAssets.ClientID %>").attr("disabled", "disabled");
                } else {
                    $("#accumAssetTotal").css("color", "green");
                    $("#<%= btnSubmitAccumulatedAssets.ClientID %>").removeAttr("disabled");
                }
            });

            $("#<%= btnSubmitLifestyleChange.ClientID %>").hide();
            var initiallyselected = $("#<%= hdnOriginalLifestyleOption.ClientID %>").val();
            if (initiallyselected == 1) {
                $("#<%= gvAccumulatedAssets.ClientID %>").attr("disabled", "disabled");
                $("#<%= gvContributionInvestment.ClientID %>").attr("disabled", "disabled");
            }

            $("#<%=radLifestyle.ClientID%>").click(function () {
                $("#<%= btnSubmitLifestyleChange.ClientID %>").hide();
                var selected = $("input[@name='radLifestyle']:checked").val();
                if (selected != initiallyselected) {
                    $("#<%= btnSubmitLifestyleChange.ClientID %>").show();
                }
                if (selected == 0) {
                    //"Standard"
                    $("#<%= pnlLifestyleMessage.ClientID %>").hide();
                    $("#<%= btnSubmitAccumulatedAssets.ClientID %>").removeAttr("disabled");
                    $("#<%= btnSubmitContributionInvestment.ClientID %>").removeAttr("disabled");
                    $("#<%= gvAccumulatedAssets.ClientID %>").removeAttr("disabled");
                    $("#<%= gvContributionInvestment.ClientID %>").removeAttr("disabled");
                    $("input.contvalues").removeAttr("disabled");
                    $("input.accumvalues").removeAttr("disabled");
                } else {
                    //"Lifestyle"
                    $("#<%= pnlLifestyleMessage.ClientID %>").show();
                    $("#<%= btnSubmitAccumulatedAssets.ClientID %>").attr("disabled", "disabled");
                    $("#<%= btnSubmitContributionInvestment.ClientID %>").attr("disabled", "disabled");
                    $("#<%= gvAccumulatedAssets.ClientID %>").attr("disabled", "disabled");
                    $("#<%= gvContributionInvestment.ClientID %>").attr("disabled", "disabled");

                    $("input.contvalues").attr("disabled", "disabled");
                    $("input.accumvalues").attr("disabled", "disabled");
                }
            }).click();


        });

    </script>

</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:Panel runat="server" ID="pnlLifestyle" Visible="false">
        <div class="fullbox">
            <h3>
            <asp:Label runat="server" ID="lblLifeStyle" Text="Choose your investment strategy profile:"
                meta:resourcekey="lblLifeStyleResource1" />
            </h3>
                            <asp:Label runat="server" ID="lblLifeEmail" CssClass="invalidEmail" Visible="false"></asp:Label>
                <asp:TextBox ID="txtLifeEmailAddress" runat="server" Visible="false"></asp:TextBox>
                <asp:RegularExpressionValidator ID="valLifeEmail" runat="server" ControlToValidate="txtLifeEmailAddress"
                     Font-Bold="True" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"
                     ValidationGroup="lifeValGroup">* Email must be valid</asp:RegularExpressionValidator>
            <table>
            <tr>
            <td>
            <asp:RadioButtonList runat="server" ID="radLifestyle" RepeatDirection="Horizontal" 
                    onselectedindexchanged="radLifestyle_SelectedIndexChanged">
                <asp:ListItem Text="Lifestyle Strategy" Value="1" />
                <asp:ListItem Text="Standard Strategy" Value="0" />
            </asp:RadioButtonList>
            </td>
            <td>
            <asp:Button ID="btnSubmitLifestyleChange" CssClass="button" Text="Submit" runat="server" 
                            OnClick="btnSubmitLifestyleChange_Click" 
                            meta:resourcekey="btnSubmitLifestyleChangeResource1" ValidationGroup="lifeValGroup" />
            </td>
            </tr>
            </table>
        </div>
    </asp:Panel>
    <asp:Panel runat="server" ID="pnlLifestyleMessage" Visible="false">
        <div class="fullbox">
            <h3>Lifestyle Strategy currently In Operation</h3>
            
            <p style="font-weight: bold">
                <asp:Label ID="lblLifestyleMessage" runat="server" 
                Text="You have chosen the Lifestyle Strategy, your assets will be automatically transitioned in line with the strategy outlined in your scheme booklet." 
                meta:resourcekey="lblLifestyleMessageResource1"></asp:Label>
            </p>
        </div>
    </asp:Panel>
    <div class="fullbox">
        <h3>
            Contribution Investment</h3>
        <p>
            <asp:Label ID="Label3" runat="server" 
                Text="Your contributions are currently invested at the percentage rates shown in the table below.
        You may alter the percentage of future contributions invested between the fund options currently offered by your scheme trustees within the parameters laid down by your scheme rules.
        Please Complete the table below and click the Submit button to effect your changes." 
                meta:resourcekey="Label3Resource1"></asp:Label>
        </p>
        <asp:Panel runat="server" ID="pnlInfo" Visible="False" CssClass="panel-info" 
            meta:resourcekey="pnlInfoResource1">
        <asp:Label runat="server" ID="lblInfo" meta:resourcekey="lblInfoResource1" />
        </asp:Panel>
        <asp:Panel ID="pnlInvest" runat="server" 
            DefaultButton="btnSubmitContributionInvestment" 
            meta:resourcekey="pnlInvestResource1">
            <asp:GridView CssClass="investmentsSummary" ID="gvContributionInvestment" 
                runat="server" AutoGenerateColumns="False" 
                meta:resourcekey="gvContributionInvestmentResource1"
                OnRowCreated="gvContributionInvestment_RowDataBound">

                <Columns>
                    <asp:BoundField DataField="FundDescription" HeaderText="Fund" 
                        meta:resourcekey="BoundFieldResource1" />
                    <asp:BoundField DataField="Percent" HeaderText="Current Percent" 
                        DataFormatString="{0:}%" meta:resourcekey="BoundFieldResource2" />
                    <asp:TemplateField HeaderText="New Percent Value" 
                        meta:resourcekey="TemplateFieldResource1">
                        <ItemTemplate>
                            <asp:TextBox ID="txtContributionInvestment" MaxLength="8" ReadOnly='<%# Eval("IsFixedInvestmentAllocation") %>'
                                CssClass='<%# (bool)Eval("IsFixedInvestmentAllocation") == true ? "contvalues read-only" : "contvalues" %>'
                                Columns="5"
                                Text='<%# Eval("Percent") %>' runat="server" 
                                meta:resourcekey="txtContributionInvestmentResource1"></asp:TextBox>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
            
            <table style="width: 99%; margin: 3px; border: none;">
            <tr>
            <asp:Label runat="server" ID="lblEmail" CssClass="invalidEmail" Visible="false"></asp:Label>
            <asp:TextBox ID="txtEmailAddress" runat="server" Visible="false"></asp:TextBox>
            <asp:RegularExpressionValidator ID="valEmail" runat="server" ControlToValidate="txtEmailAddress"
                 Font-Bold="True" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"
                 ValidationGroup="contribValGroup">* Email must be valid</asp:RegularExpressionValidator>
            </tr>
                <tr>
                    <td style="font-size: 1.2em; font-weight: bold">
                        <asp:Label ID="lblTotal" runat="server" Text="Total:"></asp:Label> <span id="contInvestTotal"></span>
                    </td>
                    <td align="right">
                        <asp:Button ID="btnSubmitContributionInvestment" CssClass="button" Text="Submit" runat="server" 
                            OnClick="btnSubmitContributionInvestment_Click" 
                            meta:resourcekey="btnSubmitContributionInvestmentResource1" ValidationGroup="contribValGroup" />
                    </td>
                </tr>
            </table>
        </asp:Panel>
    </div>
    <div class="fullbox">
        <h3>
            Accumulated Assets</h3>
        <p style="font-weight: bold">
            <asp:Label ID="Label2" runat="server" 
                Text="Switching Accumulated Assets may result in your assets being out of the market for up to 15 working days. 
        Neither APT, the Trustees or the investment managers are liable for any losses or gains incurred during this period. " 
                meta:resourcekey="Label2Resource1"></asp:Label>
        </p>
        <p>
            <asp:Label ID="Label1" runat="server" 
                Text="Your Accumulated Assets are currently invested at the percentage rates shown in the table below. 
        You may alter the percentage of Accumulated Assets invested between the fund options currently offered by your scheme trustees within the parameters laid down by your scheme rules. 
        Please Complete the table below and click the Submit button to effect your changes." 
                meta:resourcekey="Label1Resource1"></asp:Label>
        </p>
        <asp:Panel runat="server" ID="pnlInfo2" Visible="False" CssClass="panel-info" 
            meta:resourcekey="pnlInfo2Resource1">
            <asp:Label runat="server" ID="lblInfo2" meta:resourcekey="lblInfo2Resource1" />
        </asp:Panel>
        <asp:Panel ID="pnlAccum" runat="server" 
            DefaultButton="btnSubmitAccumulatedAssets" meta:resourcekey="pnlAccumResource1">
            <asp:GridView CssClass="investmentsSummary" ID="gvAccumulatedAssets" 
                runat="server" AutoGenerateColumns="False" 
                meta:resourcekey="gvAccumulatedAssetsResource1" OnRowCreated="gvAccumulatedAssets_RowDataBound">
                <Columns>
                    <asp:BoundField DataField="FundDescription" HeaderText="Fund" 
                        meta:resourcekey="BoundFieldResource3" />
                    <asp:BoundField DataField="Value" HeaderText="Value" DataFormatString="{0:c}" 
                        meta:resourcekey="BoundFieldResource4" />
                    <asp:BoundField DataField="Percent" HeaderText="Current Percent" 
                        DataFormatString="{0:}%" meta:resourcekey="BoundFieldResource5" />
                    <asp:TemplateField HeaderText="New Percent Value" 
                        meta:resourcekey="TemplateFieldResource2">
                        <ItemTemplate>
                            <asp:TextBox ID="txtAccumulatedAssets" Columns="5" MaxLength="8" ReadOnly='<%# Eval("IsFroozen") %>' 
                            CssClass='<%# (bool)Eval("IsFroozen") == true ? "accumvalues read-only" : "accumvalues" %>'
                                Text='<%# Eval("Percent") %>' runat="server" 
                                meta:resourcekey="txtAccumulatedAssetsResource1"></asp:TextBox>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
            <table style="width: 99%; margin: 3px; border: none;">
                
                <tr>
            <asp:Label runat="server" ID="lblAccuEmail" CssClass="invalidEmail" Visible="false"></asp:Label>
            <asp:TextBox ID="txtAccuEmailAddress" runat="server" Visible="false"></asp:TextBox>
            <asp:RegularExpressionValidator ID="valAccuEmail" runat="server" ControlToValidate="txtAccuEmailAddress"
                 Font-Bold="True" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"
                 ValidationGroup="accuValGroup">* Email must be valid</asp:RegularExpressionValidator>
            </tr>
                <tr>
                    <td style="font-size: 1.2em; font-weight: bold">
                        Total: <span id="accumAssetTotal"></span>
                    </td>
                    <td align="right">
                        <asp:Button ID="btnSubmitAccumulatedAssets" CssClass="button" Text="Submit" runat="server" 
                            OnClick="btnSubmitAccumulatedAssets_Click" 
                            meta:resourcekey="btnSubmitAccumulatedAssetsResource1" ValidationGroup="accuValGroup" />
                    </td>
                </tr>
            </table>
        </asp:Panel>
    </div>
    <asp:HiddenField ID="hdnOriginalLifestyleOption" runat="server"/>
</asp:Content>
<asp:Content ID="Content2" runat="server" ContentPlaceHolderID="ContentPlaceHolderPageTitle">
    <div class="coins">
        <! -- Change for Specific Icons -->
        <h2>
            <asp:Label runat="server" ID="lblPageHeader" Text="Investment Strategy" 
                meta:resourcekey="lblPageHeaderResource1" /></h2>
        <p class="h2-line">
            <asp:Label runat="server" ID="lblPageHeaderByline" 
                Text="Change your investment strategy" 
                meta:resourcekey="lblPageHeaderBylineResource1" /></p>
        <asp:Panel runat="server" ID="pnlInfo3" Visible="False" CssClass="panel-info" 
            meta:resourcekey="pnlInfo3Resource1">
            <asp:Label runat="server" ID="lblInfo3" meta:resourcekey="lblInfo3Resource1" />
        </asp:Panel>
    </div>
</asp:Content>
