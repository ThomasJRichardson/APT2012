<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="RiskProfileCalculator.aspx.cs" Inherits="APT2012.RiskProfileCalculator" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolderHead" runat="server">
    <script type="text/javascript" language="javascript">
        $(document).ready(function () {
            showDisclaimer();
        });

        var checked;

        function chkTermsCheckedChanged() {
            //if ($('#chkTerms').attr('checked') == true) {
            if (checked == true) {
                $('.acceptButtonClass').attr("disabled", "disabled");
                checked = false;
            } else {
                $('.acceptButtonClass').removeAttr("disabled", "disabled");
                checked = true;
            }
        };

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolderPageTitle" runat="server">
    <div id="Div1" style="display: none;">
        <div id="DisclaimerDialog" style="background-color:#b0c4de; border-style:solid; border-width:medium; border-color:blue;">
            The following questionnaire may help you in assessing the level of risk you are comfortable
            with. There are no right or wrong answers and the questions do not take into account
            your specific circumstances, objectives or needs. The contents or results of the
            questionnaire should not be relied upon, either directly or indirectly, as a basis
            up which to make investment or financial decisions or arrangements. APT Financial
            Services Limited does nto accept any liability, either direct or indirect, arising
            from any such profile, or any other investment issue.
            <p/> 
            Financial planners have found that this simple questionnaire can be a useful guide
            to where people may prefer to invest. Naturally this indicator is not a substitute
            for considered financial planning. APT Financial Sevices Limited encourages you
            to discuss your requirements with your adviser.
            <br />
            <div id="chkTermsContainer"><div id="chkTermsContent"><asp:CheckBox runat="server" Text="I accept these terms and conditions" id="chkTerms"/></div></div>
        </div>
    </div>
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
            <asp:Label ID="Label1" runat="server" Text="A. Your personal time horizon" meta:resourcekey="lblConfigureYourPensionResource1"></asp:Label>
        </h3>
        <div class="risk-calculator-sections">
            <h5>
                1. How long do you expect this money will remain invested?
            </h5>
            <%--<table class="question-numbers">
                <tr>
                    <td>
                        A.
                    </td>
                </tr>
                <tr>
                    <td>
                        B.
                    </td>
                </tr>
                <tr>
                    <td>
                        C.
                    </td>
                </tr>
            </table>--%>
            <table>
                <tr>
                    <td>
                        <asp:RadioButtonList runat="server" ID="rblSectionA1" RepeatDirection="Vertical">
                            <asp:ListItem Text="0-3 years" Value="1" />
                            <asp:ListItem Text="4-10 years" Value="2" />
                            <asp:ListItem Text="longer than 10 years" Value="3" />
                        </asp:RadioButtonList>
                        <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator1"
                                                ControlToValidate="rblSectionA1" ErrorMessage="Please select an option" 
                                                ToolTip="Please select an option" >Please select an option from above</asp:RequiredFieldValidator>
                    </td>
                </tr>
            </table>
            <h5>
                2. Keeping in mind the fact that higher returns generally involve higher risk, what
                long term average return do you reasonably expect to receive from your investments
                after inflation has been considered?
            </h5>
            <%--<table class="question-numbers">
                <tr>
                    <td>
                        A.
                    </td>
                </tr>
                <tr>
                    <td>
                        B.
                    </td>
                </tr>
                <tr>
                    <td>
                        C.
                    </td>
                </tr>
            </table>--%>
            <table>
                <tr>
                    <td>
                        <asp:RadioButtonList runat="server" ID="rblSectionA2" RepeatDirection="Vertical">
                            <asp:ListItem Text="Less than 5%" Value="1" />
                            <asp:ListItem Text="5-8%" Value="2" />
                            <asp:ListItem Text="above 8%" Value="3" />
                        </asp:RadioButtonList>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
                                                ControlToValidate="rblSectionA2" ErrorMessage="Please select an option" 
                                                ToolTip="Please select an option" >Please select an option from above</asp:RequiredFieldValidator>
                    </td>
                </tr>
            </table>
        </div>
    </div>
    <div class="fullbox clear">
        <h3>
            <asp:Label ID="Label2" runat="server" Text="B. Your personal risk tolerance" meta:resourcekey="lblConfigureYourPensionResource1"></asp:Label>
        </h3>
        <div class="risk-calculator-sections">
        <h5>
            3. Have you ever invested in shares, government bonds or managed funds?
        </h5>
        <%--<table class="question-numbers">
            <tr>
                <td>
                    A.
                </td>
            </tr>
            <tr>
                <td>
                    B.
                </td>
            </tr>
            <tr>
                <td>
                    C.
                </td>
            </tr>
            <tr>
                <td>
                    D.
                </td>
            </tr>
        </table>--%>
        <table>
            <tr>
                <td>
                    <asp:RadioButtonList runat="server" ID="rblSectionB1" RepeatDirection="Vertical">
                        <asp:ListItem Text="No - but if I had, fluctutations in returns would make me uncomfortable"
                            Value="1" />
                        <asp:ListItem Text="No - but if I had, I'd be comfortable with fluctutations in returns in order to have the potential higher returns"
                            Value="2" />
                        <asp:ListItem Text="Yes I have - but I was uncomfortable with fluctutations in returns despite the potential for higher returns"
                            Value="3" />
                        <asp:ListItem Text="Yes I have - and I was comfortable with fluctutations in returns despite the potential for higher returns"
                            Value="4" />
                    </asp:RadioButtonList>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" 
                                                ControlToValidate="rblSectionB1" ErrorMessage="Please select an option" 
                                                ToolTip="Please select an option" >Please select an option from above</asp:RequiredFieldValidator>
                    
                </td>
            </tr>
        </table>
        <h5>
            4. How would you react if your long term investments declined by 10% in one year?
        </h5>
        <%--<table class="question-numbers">
            <tr>
                <td>
                    A.
                </td>
            </tr>
            <tr>
                <td>
                    B.
                </td>
            </tr>
            <tr>
                <td>
                    C.
                </td>
            </tr>
            <tr>
                <td>
                    D.
                </td>
            </tr>
        </table>--%>
        <table>
            <tr>
                <td>
                    <asp:RadioButtonList runat="server" ID="rblSectionB2" RepeatDirection="Vertical">
                        <asp:ListItem Text="I cannot accept any declines in the value of my investments"
                            Value="1" />
                        <asp:ListItem Text="I generally invest for the long term but would be concerned with this decline"
                            Value="2" />
                        <asp:ListItem Text="I would not be concerned about volatility or declining capital in the short term"
                            Value="3" />
                        <asp:ListItem Text="I invest for the long term and would accept these fluctutations due to short term market influences"
                            Value="3" />
                    </asp:RadioButtonList>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" 
                                                ControlToValidate="rblSectionB2" ErrorMessage="Please select an option" 
                                                ToolTip="Please select an option" >Please select an option from above</asp:RequiredFieldValidator>
                  
                </td>
            </tr>
        </table>
        </div>
    </div>
    <div class="fullbox clear">
        <h3>
            <asp:Label ID="Label3" runat="server" Text="C. Your personal investment objectivese"
                meta:resourcekey="lblConfigureYourPensionResource1"></asp:Label>
        </h3>
        <div class="risk-calculator-sections">
        <h5>
            5. Objectives
        </h5>
        <%--<table class="question-numbers">
            <tr>
                <td>
                    A.
                </td>
            </tr>
            <tr>
                <td>
                    B.
                </td>
            </tr>
            <tr>
                <td>
                    C.
                </td>
            </tr>
        </table>--%>
        <table>
            <tr>
                <td>
                    <asp:RadioButtonList runat="server" ID="rblSectionC1" RepeatDirection="Vertical">
                        <asp:ListItem Text="Protecting my savings is more important than making them grow."
                            Value="1" />
                        <asp:ListItem Text="I prefer my investments to grow steadily and avoid sharp ups and downs, even if it lowers my long term returns."
                            Value="2" />
                        <asp:ListItem Text="It is important for me to earn the highest possible return on my investment, even if I must take some risk to do so."
                            Value="3" />
                    </asp:RadioButtonList>
                     <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" 
                                                ControlToValidate="rblSectionC1" ErrorMessage="Please select an option" 
                                                ToolTip="Please select an option" >Please select an option from above</asp:RequiredFieldValidator>
                </td>
            </tr>
        </table>
    </div>
    </div>
    <asp:Button ID="btnSubmitRiskProfileCalculator" CssClass="button" Text="Submit" 
        runat="server" onclick="btnSubmitRiskProfileCalculator_Click" />

</asp:Content>
