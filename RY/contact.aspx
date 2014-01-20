<%@ Page Title="" Language="C#" MasterPageFile="~/RY/RY.Master" AutoEventWireup="true"
    CodeBehind="contact.aspx.cs" Inherits="APT2012.RY.contact" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <script src="js/bootstrap.min.js" type="text/javascript"></script>
    <script src="js/bootbox.min.js" type="text/javascript"></script>
    <script src="js/common.js" type="text/javascript"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="contentbody" runat="server">
    <p>
        Address:<br />
        Allied Pension Trustees, Apex Business Centre,<br>
        Blackthorn Road, Sandyford, Dublin 18,<br>
        Ireland,<br />
        Tel:+353 (0)1 2063010<br />
        Fax:+353 (0)1 2063017<br />
        Email:<a href="mailto:info@alliedpensions.com">info@alliedpensions.com</a>
        <div class="form">
            <p>
                <asp:HiddenField ID="hdnMsg" runat="server" />
                <input type="hidden" name="action" value="submit" />
                Your name:<br />
                <asp:TextBox ID="txtName" runat="server" size="30" />
                <br />
                Your email:<br />
                <asp:TextBox ID="txtEmail" runat="server" size="30" />
                <br />
                Your message:<br />
                <asp:TextBox ID="txtMessage" TextMode="MultiLine" Rows="7" Columns="30" runat="server"
                    size="30" />
                <br /><br />
                <asp:Button Text="Send email" runat="server" ID="btnSendEmail" OnClick="btnSendEmail_Click" />
        </div>
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
<asp:Content ID="Content3" ContentPlaceHolderID="scriptplaceholder" runat="server">
</asp:Content>
