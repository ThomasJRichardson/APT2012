<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ContactUs.aspx.cs" Inherits="APT2012.ContactUs" meta:resourcekey="PageResource1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolderHead" runat="server">

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="fullbox">
        <h3>
            <asp:Label ID="Label1" runat="server" Text="Enquiries" 
                meta:resourcekey="Label1Resource1"></asp:Label></h3>
            <p>
                <asp:Label ID="Label2" runat="server" 
                    Text="You can use this page to make enquiries about your pension arrangement or to request updates to your information. Please select the type of message that you wish to send, enter the appropriate text and then click on the Submit button." 
                    meta:resourcekey="Label2Resource1"></asp:Label> 
                <asp:HyperLink NavigateUrl="~/InvestmentStrategy.aspx" 
                    Text="Click here to redirect or reinvest your contributions" ID="LinkButton1" 
                    runat="server" meta:resourcekey="LinkButton1Resource1" /></p>    
    </div>
    
    <div class="fullbox">
        <h3><asp:Label ID="Label3" runat="server" Text="Contact Us" 
                meta:resourcekey="Label3Resource1"></asp:Label></h3>
        <asp:Panel runat="server" ID="pnlInfo" Visible="False" CssClass="panel-info" 
            meta:resourcekey="pnlInfoResource1">
            <asp:Label runat="server" ID="lblInfo" meta:resourcekey="lblInfoResource1" />
        </asp:Panel>
        <p><asp:Label ID="Label13" runat="server" 
                Text="We currently have the following means of contacting you. You can edit these details " 
                meta:resourcekey="Label13Resource1" /><asp:HyperLink ID="hypProfileEdit" 
                runat="server" Text="here" NavigateUrl="~/UserProfile.aspx" 
                meta:resourcekey="hypProfileEditResource1" />.</p><table class="standardtable">
            <tr>
                <td>
                    <asp:Label ID="Label7" runat="server" Text="Name" 
                        meta:resourcekey="Label7Resource1"></asp:Label></td><td>
                    <asp:Label ID="lblName" runat="server" meta:resourcekey="lblNameResource1"></asp:Label></td></tr><tr>
                <td>
                    <asp:Label ID="Label8" runat="server" Text="Email" 
                        meta:resourcekey="Label8Resource1"></asp:Label></td><td>
                    <asp:Label ID="lblEmail" runat="server" meta:resourcekey="lblEmailResource1"></asp:Label></td></tr><tr>
                <td>
                    <asp:Label ID="Label9" runat="server" Text="Home" 
                        meta:resourcekey="Label9Resource1"></asp:Label></td><td>
                    <asp:Label ID="lblHome" runat="server" meta:resourcekey="lblHomeResource1"></asp:Label></td></tr><tr>
                <td>
                    <asp:Label ID="Label10" runat="server" Text="Office" 
                        meta:resourcekey="Label10Resource1"></asp:Label></td><td>
                    <asp:Label ID="lblOffice" runat="server" meta:resourcekey="lblOfficeResource1"></asp:Label></td></tr><tr>
                <td>
                    <asp:Label ID="Label11" runat="server" Text="Mob" 
                        meta:resourcekey="Label11Resource1"></asp:Label></td><td>
                    <asp:Label ID="lblMobile" runat="server" meta:resourcekey="lblMobileResource1"></asp:Label></td></tr><tr>
                <td>
                    <asp:Label ID="Label12" runat="server" Text="Fax" 
                        meta:resourcekey="Label12Resource1"></asp:Label></td><td>
                    <asp:Label ID="lblFax" runat="server" meta:resourcekey="lblFaxResource1"></asp:Label></td></tr><tr>
                <td>
                    <asp:Label ID="Label6" runat="server" Text="Preferred method of contact" 
                        meta:resourcekey="Label6Resource1"></asp:Label></td><td>
                    <asp:Label ID="lblPrefContact" runat="server" 
                        meta:resourcekey="lblPrefContactResource1"></asp:Label></td></tr><tr>
                <td>
                    <asp:Label ID="Label5" runat="server" Text="Please select a topic" 
                        meta:resourcekey="Label5Resource1"></asp:Label></td><td>
                    <asp:DropDownList ID="ddlTopic" runat="server" Width="310px" 
                        meta:resourcekey="ddlTopicResource1">
                        <asp:ListItem Value="" meta:resourcekey="ListItemResource1">-- Please select a topic --</asp:ListItem>
                        <asp:ListItem meta:resourcekey="ListItemResource2">I want to increase my contributions</asp:ListItem>
                        <asp:ListItem meta:resourcekey="ListItemResource3">I wish to find out my options on leaving the scheme</asp:ListItem>
                        <asp:ListItem meta:resourcekey="ListItemResource4">I have another query</asp:ListItem></asp:DropDownList>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                        ControlToValidate="ddlTopic" Display="Dynamic" ErrorMessage="*" 
                        ValidationGroup="contactus" 
                        meta:resourcekey="RequiredFieldValidator1Resource1"></asp:RequiredFieldValidator></td></tr><tr>
                <td>
                    <asp:Label ID="Label4" runat="server" 
                        Text="Query, information to update or other text" 
                        meta:resourcekey="Label4Resource1"></asp:Label></td><td>
                    <asp:TextBox ID="txtQuery" runat="server" Rows="5" TextMode="MultiLine" 
                        Width="305px" meta:resourcekey="txtQueryResource1"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
                        ControlToValidate="txtQuery" ErrorMessage="*" ValidationGroup="contactus" 
                        meta:resourcekey="RequiredFieldValidator2Resource1"></asp:RequiredFieldValidator></td></tr><tr>
                <td>
                    &nbsp;</td><td>
                    <asp:Button CssClass="button" ID="btnSend" runat="server" Text="Send Enquiry" 
                        onclick="btnSend_Click" ValidationGroup="contactus" 
                        meta:resourcekey="btnSendResource1" />
                </td>
            </tr>
        </table>
        
    </div>
</asp:Content>
<asp:Content ID="Content4" runat="server" 
    contentplaceholderid="ContentPlaceHolderPageTitle">
                        <div class="mail">
                            <! -- Change for Specific Icons -->
                            <h2>
                                <asp:Label runat="server" ID="lblPageHeader" Text="Contact Us" 
                                    meta:resourcekey="lblPageHeaderResource1" /></h2>
                            <p class="h2-line">
                                <asp:Label runat="server" ID="lblPageHeaderByline" 
                                    Text="Please fill out details relating to your query" 
                                    meta:resourcekey="lblPageHeaderBylineResource1" /></p>
                        </div>
                    
</asp:Content>

