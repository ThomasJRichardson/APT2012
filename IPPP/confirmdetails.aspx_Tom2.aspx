<%@ Page Title="" Language="C#" MasterPageFile="~/IPPP/IPPP.Master" AutoEventWireup="true"
    CodeBehind="confirmdetails.aspx.cs" Inherits="APT2012.IPPP.confirmdetails" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="css/Calander.css" rel="stylesheet" type="text/css" />
    <link href="css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <script src="js/bootstrap.min.js" type="text/javascript"></script>
    <script src="js/bootbox.min.js" type="text/javascript"></script>
    <script src="js/common.js" type="text/javascript"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="contentbody" runat="server">
    <ajaxToolkit:ToolkitScriptManager runat="Server" EnableScriptGlobalization="true"
        EnableScriptLocalization="true" ID="ScriptManager1" CombineScripts="false" />
    <asp:HiddenField ID="hdnMsg" runat="server" />
    <asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowSummary="False"
        ShowMessageBox="True" />
    <div class="form">
        <h4>
            Your personal details:</h4>
        <h6>
            <%= APT.UTIL.Utility.GetAppSettingValue("reviewMessage1") + " <font color='red'>" + APT.UTIL.Utility.GetAppSettingValue("reviewMessage2") + "</font> " + APT.UTIL.Utility.GetAppSettingValue("reviewMessage3") %>
        </h6>
        <p>
            PPSN<asp:TextBox Text="" name="PPSN" ID="txtPPSN" MaxLength="50" size="100" runat="server" />
        </p>
        <p>
            Surname
            <asp:TextBox Text="" name="Surname" ID="txtSurname" MaxLength="50" size="30" runat="server" />
        </p>
        <p>
            Forename(s)<asp:TextBox Text="" name="Forename" ID="txtForename" MaxLength="50" size="30"
                runat="server" />
            <p>
                Address<asp:TextBox Text="" name="Address" ID="txtAddress" MaxLength="50" size="30"
                    runat="server" />
                <asp:TextBox Text="" name="Address2" ID="txtAddress2" MaxLength="50" size="30" runat="server" />
                <asp:TextBox Text="" name="Address3" ID="txtAddress3" MaxLength="50" size="30" runat="server" />
                <asp:TextBox Text="" name="Address4" ID="txtAddress4" MaxLength="50" size="30" runat="server" />
            </p>
            <p>
                Home Phone
                <asp:TextBox Text="" name="Home Phone" ID="txtHomePhone" MaxLength="50" size="30"
                    runat="server" />
            </p>
            <p>
                Mobile
                <asp:TextBox Text="" name="Mobile" ID="txtMobile" MaxLength="50" size="30" runat="server" /></p>
            <p>
                Email Address<asp:TextBox Text="" name="EmailAddress" ID="txtEmailAddress" MaxLength="50"
                    size="30" runat="server" /></p>
            <p>
                Date Of Birth<asp:TextBox Text="" name="DOB" ID="txtDOB" MaxLength="50" size="30"
                    runat="server" />
                <ajaxToolkit:CalendarExtender ID="txtDOB_CalendarExtender" runat="server" TargetControlID="txtDOB"
                    CssClass="ajax__calendar">
                </ajaxToolkit:CalendarExtender>
            </p>
            <p>
                Gender<asp:DropDownList ID="ddlGender" runat="server">
                </asp:DropDownList>
            </p>
            <p>
                Marital Status
                <asp:DropDownList ID="ddlMaritalStatus" runat="server">
                </asp:DropDownList>
            </p>
            <p class="fullwidth">
                <asp:Label ID="lblPersonal" CssClass="reply" Text="Your personal details were last updated online at 10:17 on 04/12/2013."
                    runat="server" />
            </p>
            <h4>
                Your Service Record:</h4>
            <div class="service_record">
                <p>
                    Date service commenced
                    <asp:TextBox Text="" Enabled="false" name="DSCommenced" ID="txtDSCommenced" MaxLength="50"
                        size="30" runat="server" />
                </p>
                <p>
                    Date service ceased
                    <asp:TextBox Text="" Enabled="false" name="DSCeased" ID="txtDSCeased" MaxLength="50"
                        size="30" runat="server" /></p>
                <p>
                    Date joined scheme
                    <asp:TextBox Text="" Enabled="false" name="DJScheme" ID="txtDJScheme" MaxLength="50"
                        size="30" runat="server" /></p>
                <p>
                    Scheme category
                    <asp:DropDownList ID="ddlSchemecategory" Enabled="false" runat="server">
                    </asp:DropDownList>
                </p>
                <p>
                    Pensionable Salary
                    <asp:TextBox Text="" Enabled="false" name="PSal" ID="txtPSal" MaxLength="50" size="30"
                        runat="server" /></p>
                <p>
                    Transfer in from previous employment?
                    <asp:DropDownList ID="ddlEmployment" Enabled="false" runat="server">
                    </asp:DropDownList>
                </p>
                <p>
                    Normal retirement date
                    <asp:TextBox Text="" Enabled="false" name="NRetDate" ID="txtNRetDate" MaxLength="50"
                        size="30" runat="server" /></p>
            </div>
            <asp:Panel ID="pnlSRecord2" runat="server">
                <h4>
                    Your Second Service Record:</h4>
                <div class="service_record2">
                    <p>
                        Date service commenced
                        <asp:TextBox Enabled="false" Text="" name="Dateservicecommenced" ID="txtDSCommenced1"
                            MaxLength="50" size="30" runat="server" />
                        <ajaxToolkit:CalendarExtender ID="txtDSCommenced1_CalendarExtender" runat="server"
                            Enabled="True" TargetControlID="txtDSCommenced1">
                        </ajaxToolkit:CalendarExtender>
                    </p>
                    <p>
                        Date service ceased
                        <asp:TextBox Text="" Enabled="false" name="DateServiceCeased" ID="txtDSCeased1" MaxLength="50"
                            size="30" runat="server" />
                        <ajaxToolkit:CalendarExtender ID="txtDSCeased1_CalendarExtender" runat="server" Enabled="True"
                            TargetControlID="txtDSCeased1">
                        </ajaxToolkit:CalendarExtender>
                    </p>
                    <p>
                        Date joined scheme
                        <asp:TextBox Text="" Enabled="false" name="DateJoinedScheme" ID="txtDJScheme1" MaxLength="50"
                            size="30" runat="server" /></p>
                    <p>
                        Scheme category
                        <asp:DropDownList ID="ddlSchemeCategory1" Enabled="false" runat="server">
                        </asp:DropDownList>
                    </p>
                    <p>
                        Pensionable Salary
                        <asp:TextBox Text="" Enabled="false" name="PensionableSalary" ID="txtPSal1" MaxLength="50"
                            size="30" runat="server" /></p>
                    <p>
                        Transfer in from previous employment?
                        <asp:DropDownList ID="ddlEmployment1" Enabled="false" runat="server">
                        </asp:DropDownList>
                    </p>
                    <p>
                        Normal retirement date
                        <asp:TextBox Text="" Enabled="false" name="NormalRetirementDate" ID="txtNRetDate1"
                            MaxLength="50" size="30" runat="server" /></p>
                </div>
            </asp:Panel>
            <asp:Label ID="lblServiceRecordUpdated" runat="server" CssClass="reply" Text="Your service record was last updated by the Administrators at 10:17 on 04/12/2013" />
            <p class="fullwidth">
                <asp:RadioButtonList ID="rblConfirm" runat="server">
                </asp:RadioButtonList>
            </p>
            <asp:Panel ID="pnlEdit" runat="server">
                <div id="editablerecords_wrapper">
                    <h4>
                        Please Edit Your Service Record(s) Here:</h4>
                    <div class="service_record_editable">
                        <p>
                            Date service commenced
                            <asp:RequiredFieldValidator ID="rfvDTCom1" runat="server" ControlToValidate="txtEDSCommenced"
                                CssClass="required" Display="Dynamic" ErrorMessage="Date Service Commenced is required."
                                Text="*"></asp:RequiredFieldValidator>
                            <asp:TextBox Text="" ID="txtEDSCommenced" MaxLength="50" size="30" runat="server" />
                            <ajaxToolkit:CalendarExtender ID="txtEDSCommenced_CalendarExtender" runat="server"
                                Enabled="True" TargetControlID="txtEDSCommenced">
                            </ajaxToolkit:CalendarExtender>
                        </p>
                        <p>
                            Date service ceased<asp:TextBox Text="" ID="txtEDSCeased" MaxLength="50" size="30"
                                runat="server" />
                            <ajaxToolkit:CalendarExtender ID="txtEDSCeased_CalendarExtender" runat="server" Enabled="True"
                                TargetControlID="txtEDSCeased">
                            </ajaxToolkit:CalendarExtender>
                        </p>
                        <p>
                            Date joined scheme<asp:TextBox Text="" ID="txtEDJScheme" MaxLength="50" size="30"
                                runat="server" />
                            <ajaxToolkit:CalendarExtender ID="txtEDJScheme_CalendarExtender" runat="server" Enabled="True"
                                TargetControlID="txtEDJScheme">
                            </ajaxToolkit:CalendarExtender>
                        </p>
                        <p>
                            Scheme category
                            <asp:DropDownList ID="ddlESchemeCategory" runat="server">
                            </asp:DropDownList>
                        </p>
                        <p>
                            Pensionable Salary
                            <asp:TextBox Text="" ID="txtEPSal" MaxLength="50" size="30" runat="server" /></p>
                        <p>
                            Transfer in from previous employment?
                            <asp:DropDownList ID="ddlEEmployment" runat="server">
                            </asp:DropDownList>
                        </p>
                        <p>
                            Normal retirement date
                            <asp:TextBox Text="" ID="txtENRetDate" MaxLength="50" size="30" runat="server" />
                            <ajaxToolkit:CalendarExtender ID="txtENRetDate_CalendarExtender" runat="server" Enabled="True"
                                TargetControlID="txtENRetDate">
                            </ajaxToolkit:CalendarExtender>
                        </p>
                    </div>
                    <asp:Panel ID="pnlESRecord" runat="server">
                        <div class="service_record_editable2">
                            <p>
                                Date service commenced
                                <asp:TextBox Text="" ID="txtEDSCommenced1" MaxLength="50" size="30" runat="server" />
                                <ajaxToolkit:CalendarExtender ID="txtEDSCommenced1_CalendarExtender" runat="server"
                                    Enabled="True" TargetControlID="txtEDSCommenced1">
                                </ajaxToolkit:CalendarExtender>
                            </p>
                            <p>
                                Date service ceased
                                <asp:TextBox Text="" ID="txtEDSCeased1" MaxLength="50" size="30" runat="server" />
                                <ajaxToolkit:CalendarExtender ID="txtEDSCeased1_CalendarExtender" runat="server"
                                    Enabled="True" TargetControlID="txtEDSCeased1">
                                </ajaxToolkit:CalendarExtender>
                            </p>
                            <p>
                                Date joined scheme
                                <asp:TextBox Text="" ID="txtEDJScheme1" MaxLength="50" size="30" runat="server" />
                                <ajaxToolkit:CalendarExtender ID="txtEDJScheme1_CalendarExtender" runat="server"
                                    Enabled="True" TargetControlID="txtEDJScheme1">
                                </ajaxToolkit:CalendarExtender>
                            </p>
                            <p>
                                Scheme category
                                <asp:DropDownList ID="ddlESchemeCategory1" runat="server">
                                </asp:DropDownList>
                            </p>
                            <p>
                                Pensionable Salary
                                <asp:TextBox Text="" name="PensionableSalary" ID="txtEPSal1" MaxLength="50" size="30"
                                    runat="server" />
                            </p>
                            <p>
                                Transfer in from previous employment?
                                <asp:DropDownList ID="ddlEEmployment1" runat="server">
                                </asp:DropDownList>
                            </p>
                            <p>
                                Normal retirement date
                                <asp:TextBox Text="" name="NormalRetirementDate" ID="txtENRetDate1" MaxLength="50"
                                    size="30" runat="server" />
                                <ajaxToolkit:CalendarExtender ID="txtENRetDate1_CalendarExtender" runat="server"
                                    Enabled="True" TargetControlID="txtENRetDate1">
                                </ajaxToolkit:CalendarExtender>
                            </p>
                        </div>
                    </asp:Panel>
                </div>
                <p class="fullwidth">
                    <asp:Label ID="lblServices" CssClass="reply" Text="You submitted amendments at 10:17 on 04/12/2013 and they are under reviewe by the
                Administrators" runat="server" />
                </p>
            </asp:Panel>
            <p class="fullwidth">
                <asp:Button ID="btnSubmit" Text="Submit Changes" Style="float: left;" runat="server"
                    OnClick="btnSubmit_Click" />
            </p>
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
    <script src="js/confirmdetails.js" type="text/javascript"></script>
</asp:Content>
