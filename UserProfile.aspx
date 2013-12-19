<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="Profile.aspx.cs" Inherits="APT2012.UserProfile" meta:resourcekey="PageResource1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="fullbox">
        <h3>
            <asp:Label ID="lblInvestments" Text="My Profile" runat="server" 
                meta:resourcekey="lblInvestmentsResource1" /></h3>
        <table cellpadding="0" cellspacing="0" width="100%" class="standardtable">
            <tr>
                <td>
                    <asp:Label Font-Bold="True" ID="lblName" runat="server" Text="Name" 
                        meta:resourcekey="lblNameResource1"></asp:Label>
                </td>
                <td>
                    <asp:Label ID="lblNameValue" runat="server" 
                        meta:resourcekey="lblNameValueResource1"></asp:Label>
                </td>
                <td>
                    <asp:Label Font-Bold="True" ID="lblScheme" runat="server" Text="Scheme" 
                        meta:resourcekey="lblSchemeResource1"></asp:Label>
                </td>
                <td>
                    <asp:Label ID="lblSchemeValue" runat="server" 
                        meta:resourcekey="lblSchemeValueResource1"></asp:Label>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label Font-Bold="True" ID="lblPPSNo" runat="server" Text="PPS No" 
                        meta:resourcekey="lblPPSNoResource1"></asp:Label>
                </td>
                <td>
                    <asp:Label ID="lblPPSNoValue" runat="server" 
                        meta:resourcekey="lblPPSNoValueResource1"></asp:Label>
                </td>
                <td>
                    <asp:Label Font-Bold="True" ID="lblUserName" runat="server" Text="Username" 
                        meta:resourcekey="lblUserNameResource1"></asp:Label>
                </td>
                <td>
                    <asp:Label ID="lblUserNameValue" runat="server" 
                        meta:resourcekey="lblUserNameValueResource1"></asp:Label>
                </td>
            </tr>
        </table>
    </div>
    
    <asp:Panel ID="pnlNoUser" runat="server" Visible="False" 
        meta:resourcekey="pnlNoUserResource1">
        <div class="clear">
            <div class="fullbox">
                <h3>
                    <asp:Label ID="lblContactInfoTitle" Text="Contact Information" runat="server" 
                        meta:resourcekey="lblContactInfoTitleResource1" /></h3>
                <p>
                    <asp:Label ID="lblNoUserForMember" runat="server" 
                        Text="The selected member does not have an associated user in the system." 
                        meta:resourcekey="lblNoUserForMemberResource1"></asp:Label></p>
            </div>
        </div>
    </asp:Panel>
    
    <asp:Panel ID="pnlContactInfo" runat="server" Visible="False" 
        meta:resourcekey="pnlContactInfoResource1">
        <div class="clear">
            <div class="leftbox">
                <h3>
                    <asp:Label ID="lblContactInformation" Text="Contact Information" runat="server" 
                        meta:resourcekey="lblContactInformationResource1" /></h3>
                <asp:ValidationSummary ID="ValidationSummary1" runat="server" DisplayMode="SingleParagraph"
                    ValidationGroup="profileValGroup" 
                    meta:resourcekey="ValidationSummary1Resource1" />
                <table cellpadding="0" cellspacing="0" width="100%" class="summarytable">
                    <tr>
                        <td>
                            <asp:Label Font-Bold="True" ID="lblEmailAddress" runat="server" Text="Email Address"
                                AssociatedControlID="txtEmailAddress" 
                                meta:resourcekey="lblEmailAddressResource1"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtEmailAddress" runat="server" 
                                meta:resourcekey="txtEmailAddressResource1"></asp:TextBox>
                            <asp:RegularExpressionValidator ID="valEmail" runat="server" ControlToValidate="txtEmailAddress"
                                ErrorMessage="Email must be valid" Font-Bold="True" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"
                                ValidationGroup="profileValGroup" meta:resourcekey="valEmailResource1">*</asp:RegularExpressionValidator>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label Font-Bold="True" ID="lblHomeTelephoneNo" runat="server" Text="Home Telephone No"
                                AssociatedControlID="txtHomeTelephoneNo" 
                                meta:resourcekey="lblHomeTelephoneNoResource1"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtHomeTelephoneNo" runat="server" 
                                meta:resourcekey="txtHomeTelephoneNoResource1"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label Font-Bold="True" ID="lblOfficeTelephoneNo" runat="server" Text="Office Telephone No"
                                AssociatedControlID="txtOfficeTelephoneNo" 
                                meta:resourcekey="lblOfficeTelephoneNoResource1"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtOfficeTelephoneNo" runat="server" 
                                meta:resourcekey="txtOfficeTelephoneNoResource1"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label Font-Bold="True" ID="lblMobileTelephoneNo" runat="server" Text="Mobile Telephone No"
                                AssociatedControlID="txtMobileTelephoneNo" 
                                meta:resourcekey="lblMobileTelephoneNoResource1"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtMobileTelephoneNo" runat="server" 
                                meta:resourcekey="txtMobileTelephoneNoResource1"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label Font-Bold="True" ID="lblFacsimileNo" runat="server" Text="Facsimile No"
                                AssociatedControlID="txtFacsimileNo" 
                                meta:resourcekey="lblFacsimileNoResource1"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtFacsimileNo" runat="server" 
                                meta:resourcekey="txtFacsimileNoResource1"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label Font-Bold="True" ID="lblAddress" runat="server" Text="Address" 
                                AssociatedControlID="txtAddress1" meta:resourcekey="lblAddressResource1"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtAddress1" runat="server" 
                                meta:resourcekey="txtAddress1Resource1"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td>
                        </td>
                        <td>
                            <asp:TextBox ID="txtAddress2" runat="server" 
                                meta:resourcekey="txtAddress2Resource1"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td>
                        </td>
                        <td>
                            <asp:TextBox ID="txtAddress3" runat="server" 
                                meta:resourcekey="txtAddress3Resource1"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td>
                        </td>
                        <td>
                            <asp:TextBox ID="txtAddress4" runat="server" 
                                meta:resourcekey="txtAddress4Resource1"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            &nbsp;
                        </td>
                        <td>
                            <asp:Button CssClass="button" ID="btnUpdateContactDetails" runat="server" Text="Save Profile" OnClick="btnUpdateContactDetails_Click"
                                ValidationGroup="profileValGroup" 
                                meta:resourcekey="btnUpdateContactDetailsResource1" />
                        </td>
                    </tr>
                </table>
            </div>
            <div class="rightbox">
                <h3>
                    <asp:Label ID="lblPreferredContactmethod" Text="Preferred Contact Method" 
                        runat="server" meta:resourcekey="lblPreferredContactmethodResource1" /></h3>
                <asp:RadioButtonList ID="rblPreferredContactMethod" runat="server" 
                    meta:resourcekey="rblPreferredContactMethodResource1">
                    <asp:ListItem Text="Email" meta:resourcekey="ListItemResource1" />
                    <asp:ListItem Text="Home Phone" meta:resourcekey="ListItemResource2" />
                    <asp:ListItem Text="Office" meta:resourcekey="ListItemResource3" />
                    <asp:ListItem Text="Mobile" meta:resourcekey="ListItemResource4" />
                    <asp:ListItem Text="Fax" meta:resourcekey="ListItemResource5" />
                </asp:RadioButtonList>
            </div>
        </div>
    </asp:Panel>
</asp:Content>
<asp:Content ID="Content2" runat="server" ContentPlaceHolderID="ContentPlaceHolderPageTitle">
    <div class="member">
        <! -- Change for Specific Icons -->
        <h2>
            <asp:Label runat="server" ID="lblPageHeader" Text="My Profile" 
                meta:resourcekey="lblPageHeaderResource1" /></h2>
        <p class="h2-line">
            <asp:Label runat="server" ID="lblPageHeaderByline" 
                Text="Change contact details and personal information" 
                meta:resourcekey="lblPageHeaderBylineResource1" /></p>
    </div>
</asp:Content>
