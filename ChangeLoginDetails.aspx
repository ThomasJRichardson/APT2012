<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="ChangeLoginDetails.aspx.cs" Inherits="APT2012.ChangeLoginDetails" meta:resourcekey="PageResource1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolderPageTitle" runat="server">
    <div class="member">
        <! -- Change for Specific Icons -->
        <h2>
            <asp:Label runat="server" ID="lblPageHeader" Text="Change Login Details" 
                meta:resourcekey="lblPageHeaderResource1" /></h2>
        <p class="h2-line">
            <asp:Label runat="server" ID="lblPageHeaderByline" 
                Text="Change your username and password" 
                meta:resourcekey="lblPageHeaderBylineResource1" /></p>
    </div>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:Panel ID="pnlNoUser" runat="server" Visible="False" 
        meta:resourcekey="pnlNoUserResource1">
        <div class="clear">
            <div class="fullbox">
                <h3>
                    <asp:Label ID="lblNoUserTitle" runat="server" Text="Login Details" 
                        meta:resourcekey="lblNoUserTitleResource1"></asp:Label></h3>
                <p>
                    <asp:Label ID="lblNoUserText" runat="server" 
                        Text="The selected member does not have an associated user in the system." 
                        meta:resourcekey="lblNoUserTextResource1"></asp:Label></p>
            </div>
        </div>
    </asp:Panel>
    <asp:Panel ID="pnlUserChangePassword" runat="server" Visible="False" 
        meta:resourcekey="pnlUserChangePasswordResource1">
        <div class="leftbox">
            <h3>
                <asp:Label ID="lblChangeYourPassword" runat="server" 
                    Text="Change Your Password" meta:resourcekey="lblChangeYourPasswordResource1"></asp:Label></h3>
            <asp:ChangePassword ID="ChangePassword1" runat="server" 
                ContinueButtonImageUrl="~/ChangeLoginDetails.aspx" CssClass="changePassword" 
                meta:resourcekey="ChangePassword1Resource1">
                <TitleTextStyle CssClass="title1" />
                <ChangePasswordTemplate>
                    <table border="0" cellpadding="1" cellspacing="0" 
                        style="border-collapse:collapse;">
                        <tr>
                            <td>
                                <table border="0" cellpadding="0">
                                         <tr>
                                        <td align="right">
                                            <asp:Label ID="CurrentPasswordLabel" runat="server" 
                                                AssociatedControlID="CurrentPassword" 
                                                meta:resourcekey="CurrentPasswordLabelResource1">Password:</asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="CurrentPassword" runat="server" TextMode="Password" 
                                                meta:resourcekey="CurrentPasswordResource1"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="CurrentPasswordRequired" runat="server" 
                                                ControlToValidate="CurrentPassword" ErrorMessage="Password is required." 
                                                ToolTip="Password is required." ValidationGroup="ChangePassword1" 
                                                meta:resourcekey="CurrentPasswordRequiredResource1">*</asp:RequiredFieldValidator>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="right">
                                            <asp:Label ID="NewPasswordLabel" runat="server" 
                                                AssociatedControlID="NewPassword" 
                                                meta:resourcekey="NewPasswordLabelResource1">New Password:</asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="NewPassword" runat="server" TextMode="Password" 
                                                meta:resourcekey="NewPasswordResource1"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="NewPasswordRequired" runat="server" 
                                                ControlToValidate="NewPassword" ErrorMessage="New Password is required." 
                                                ToolTip="New Password is required." ValidationGroup="ChangePassword1" 
                                                meta:resourcekey="NewPasswordRequiredResource1">*</asp:RequiredFieldValidator>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="right">
                                            <asp:Label ID="ConfirmNewPasswordLabel" runat="server" 
                                                AssociatedControlID="ConfirmNewPassword" 
                                                meta:resourcekey="ConfirmNewPasswordLabelResource1">Confirm New Password:</asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="ConfirmNewPassword" runat="server" TextMode="Password" 
                                                meta:resourcekey="ConfirmNewPasswordResource1"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="ConfirmNewPasswordRequired" runat="server" 
                                                ControlToValidate="ConfirmNewPassword" 
                                                ErrorMessage="Confirm New Password is required." 
                                                ToolTip="Confirm New Password is required." 
                                                ValidationGroup="ChangePassword1" 
                                                meta:resourcekey="ConfirmNewPasswordRequiredResource1">*</asp:RequiredFieldValidator>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="center" colspan="2">
                                            <asp:CompareValidator ID="NewPasswordCompare" runat="server" 
                                                ControlToCompare="NewPassword" ControlToValidate="ConfirmNewPassword" 
                                                Display="Dynamic" 
                                                ErrorMessage="The Confirm New Password must match the New Password entry." 
                                                ValidationGroup="ChangePassword1" 
                                                meta:resourcekey="NewPasswordCompareResource1"></asp:CompareValidator>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="center" colspan="2" style="color:Red;">
                                            <asp:Literal ID="FailureText" runat="server" EnableViewState="False" 
                                                meta:resourcekey="FailureTextResource1"></asp:Literal>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="right">
                                            <asp:Button CssClass="button" ID="ChangePasswordPushButton" runat="server" 
                                                CommandName="ChangePassword" Text="Change Password" 
                                                ValidationGroup="ChangePassword1" 
                                                meta:resourcekey="ChangePasswordPushButtonResource1" />
                                        </td>
                                        <td>
                                            <asp:Button ID="CancelPushButton" CssClass="button" runat="server" CausesValidation="False" 
                                                CommandName="Cancel" Text="Cancel" 
                                                meta:resourcekey="CancelPushButtonResource1" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </ChangePasswordTemplate>
            </asp:ChangePassword>
        </div>
    </asp:Panel>
    <asp:Panel ID="pnlAdminChangePassword" runat="server" Visible="False" 
        DefaultButton="btnSubmit" meta:resourcekey="pnlAdminChangePasswordResource1">
        <div class="leftbox">
            <h3>
                <asp:Label ID="lblAdminChangePassword" runat="server" Text="Change Password" 
                    meta:resourcekey="lblAdminChangePasswordResource1"></asp:Label></h3>
            <table cellpadding="0" cellspacing="0" width="100%" class="summarytable">
                <tr>
                    <td class="tdright">
                        <asp:Label ID="lblName" runat="server" Text="Name" 
                            meta:resourcekey="lblNameResource1"></asp:Label>
                    </td>
                    <td>
                        <asp:Label ID="lblNameValue" runat="server" 
                            meta:resourcekey="lblNameValueResource1"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="tdright">
                        <asp:Label ID="lblUsername" runat="server" Text="Username" 
                            meta:resourcekey="lblUsernameResource1"></asp:Label>
                    </td>
                    <td>
                        <asp:Label ID="lblUsernameValue" runat="server" Text="Username" 
                            meta:resourcekey="lblUsernameValueResource1"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="tdright">
                        <asp:Label ID="lblNewPassword" runat="server" Text="New Password" 
                            meta:resourcekey="lblNewPasswordResource1"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox TextMode="Password" ID="txtPassword" runat="server" 
                            meta:resourcekey="txtPasswordResource1" MaxLength="20"></asp:TextBox>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" 
                            ControlToValidate="txtPassword" Display="Dynamic" 
                            ValidationExpression=".{6,}" ValidationGroup="ChangePassword">Password must be at least 6 characters.</asp:RegularExpressionValidator>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                            ControlToValidate="txtPassword" ValidationGroup="ChangePassword">*</asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td class="tdright">
                        <asp:Label ID="lblConfirmPassword" runat="server" Text="Confirm New Password" 
                            meta:resourcekey="lblConfirmPasswordResource1"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox TextMode="Password" ID="txtConfirmPassword" runat="server" 
                            meta:resourcekey="txtConfirmPasswordResource1"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
                            ControlToValidate="txtConfirmPassword" ValidationGroup="ChangePassword">*</asp:RequiredFieldValidator>
                        <asp:CompareValidator ID="CompareValidator1" runat="server" 
                            ControlToCompare="txtPassword" ControlToValidate="txtConfirmPassword" 
                            ValidationGroup="ChangePassword">Passwords must match</asp:CompareValidator>
                    </td>
                </tr>
                <tr>
                    <td class="tdright">
                    </td>
                    <td>
                        <asp:Button CssClass="button" ID="btnSubmit" runat="server" Text="Change Password" 
                            OnClick="btnSubmit_Click" meta:resourcekey="btnSubmitResource1" 
                            ValidationGroup="ChangePassword" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblInfo" runat="server" Visible="False" 
                            meta:resourcekey="lblInfoResource1"></asp:Label>
                    </td>
                </tr>
            </table>
        </div>
    </asp:Panel>   
</asp:Content>
