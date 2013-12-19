<%@ Page Title="" Language="C#" MasterPageFile="~/IPPP/IPPP.Master" AutoEventWireup="true"
    CodeBehind="youroptions.aspx.cs" Inherits="APT2012.IPPP.youroptions" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <script src="js/bootstrap.min.js" type="text/javascript"></script>
    <script src="js/bootbox.min.js" type="text/javascript"></script>
    <script src="js/common.js" type="text/javascript"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="contentbody" runat="server">
    <asp:HiddenField ID="hdnMsg" runat="server" />
    <h2>
        Accrued entitlement to date of wind up</h2>
    <p>
        Under the rules of the scheme, your accrued entitlement to the 17th March 2013 is
        calculated based on your pensionable service to that date and your pensionable salary.
        On that basis, had the scheme continued, you would be entitled to an estimated accrued
        annual pension of € 3,661.53 per annum, payable from your normal pension date.</p>
    <h2>
        Transfer value</h2>
    <p>
        As the scheme will cease to exist, your accrued entitlement is converted by the
        scheme actuary into an equivalent transfer value. The transfer value is calculated
        in accordance with the relevant pension’s legislation and professional actuarial
        guidance. The transfer value is further reduced to reflect the fact that the scheme
        is winding up in deficit.</p>
    <p>
        The scheme actuary has calculated the transfer value, which has been reduced to
        reflect the deficit in the scheme. The reduced transfer value is € 41,403.29, which
        represents approximately 71% of the full transfer value.</p>
    <h2>
        Options in relation to your transfer value</h2>
    <p>
        You may opt to have your transfer value transferred to one of the following:</p>
    <table>
        <tr class="white">
            <td>
                A. The Group Defined Contribution Pension Scheme
            </td>
        </tr>
        <tr class="blue">
            <td>
                You may opt to have your transfer value transferred to the defined contribution
                scheme, which has been operated by the group since 2005. In order to do so, it will
                be necessary for you to become a member of the scheme.
            </td>
        </tr>
        <tr class="blue">
            <td>
                <asp:Button ID="btnOptA" Text="Submit This Option" runat="server" OnClick="btnOptA_Click" />
            </td>
        </tr>
    </table>
    <table>
        <tr class="white">
            <td>
                B. Personal Retirement Bond (PRB)
            </td>
        </tr>
        <tr class="blue">
            <td>
                You may opt to have your transfer value transferred to a PRB, which is a personal
                contract offered by an investment firm or life assurance company, which will accommodate
                the investment of your money until your normal pension date, at which point, the
                proceeds will be used to provide benefits for you in your retirement. No further
                contributions can be paid into the PRB.
            </td>
        </tr>
        <tr class="blue">
            <td>
                <asp:Button ID="btnOptB" Text="Submit This Option" runat="server" OnClick="btnOptB_Click" />
            </td>
        </tr>
    </table>
    <table>
        <tr class="white">
            <td>
                C. Personal Retirement Savings Account (PRSA)
            </td>
        </tr>
        <tr class="blue">
            <td>
                You may opt to have your transfer value transferred to a PRSA, if you have completed
                less than 15 years service in the scheme.
            </td>
        </tr>
        <tr class="blue">
            <td>
                <asp:Button ID="btnOptC" Text="Submit This Option" runat="server" OnClick="btnOptC_Click" />
            </td>
        </tr>
    </table>
    <table>
        <tr class="white">
            <td>
                Or
            </td>
        </tr>
        <tr class="blue">
            <td>
                Alternatively, if your require a consultation or discussion with one of our consultants
                before you make a decision please submit.
            </td>
        </tr>
        <tr class="blue">
            <td>
                <asp:Button ID="btnOptD" Text="Submit This Option" runat="server" OnClick="btnOptD_Click" />
            </td>
        </tr>
    </table>
    <h2>
        Next steps</h2>
    <p>
        Please select your chosen option before Friday the 24th of May.</p>
    <div id="myModal" class="modal fade">
        <div class="modal-dialog">
            <div class="modal-content">
                <!-- dialog body -->
                <div class="modal-body">
                    <button type="button" class="close" data-dismiss="modal">
                        &times;</button>
                    <label id="lblMessage" style="color: Black">
                    </label>
                </div>
                <!-- dialog buttons -->
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary" onclick="closepopup()">
                        OK</button></div>
            </div>
        </div>
    </div>
</asp:Content>
