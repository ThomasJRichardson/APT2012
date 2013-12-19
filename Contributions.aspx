<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="Contributions.aspx.cs" Inherits="APT2012.Contributions" meta:resourcekey="PageResource1" %>

<asp:Content ID="ContentHead" ContentPlaceHolderID="ContentPlaceHolderHead" runat="server">

    <script type="text/javascript" src="js/jquery.highlightFade.js"></script>

    <script type="text/javascript">
        $(document).ready(function() {
            $("div#divContributionDetails").hide();
            $("div#divInvestmentDetails").hide();

            //Sys.WebForms.PageRequestManager.getInstance().add_beginRequest(beginRequestHandle);
            Sys.WebForms.PageRequestManager.getInstance().add_pageLoaded(endRequestHandle);
        });

        function endRequestHandle(sender, Args) {
            if (Args._panelsUpdated.length != 0) {
                if (Args.get_panelsUpdated()[0].id.endsWith('udpContributionDetails')) {
                    $("div#divContributionDetails").show('1000');
                    $("#divContributionDetails").highlightFade({ color: '#FFFF9B', speed: 3000 });
                }
                if (Args.get_panelsUpdated()[0].id.endsWith('udpInvestmentDetails')) {
                    $("div#divInvestmentDetails").show('1000');
                    $("#divInvestmentDetails").highlightFade({ color: '#FFFF9B', speed: 3000 });
                }
            }
        }
        function GetContributions(date) {
            doPostBackAsync('udpContributionDetails', date);
            $("div#divInvestmentDetails").hide(200);
            $("div#divContributionDetails").hide(200);
        }
        function GetInvestments(contDetails) {
            doPostBackAsync('udpInvestmentDetails', contDetails);
            $("div#divInvestmentDetails").hide();
        }
        function highlight(tableRow, active) {
            if (active) {
                if (!($(tableRow).hasClass('tableRowSelected'))) {
                    $(tableRow).addClass('tableRowActive');
                }
            }
            else {
                $(tableRow).removeClass('tableRowActive');
            }
        }
        function selectedRow(tableRow) {
            $(tableRow).parent().find("tr").removeClass('tableRowSelected');
            $(tableRow).removeClass('tableRowActive');
            $(tableRow).addClass('tableRowSelected');
        }
        function doPostBackAsync(eventName, eventArgs) {
            var prm = Sys.WebForms.PageRequestManager.getInstance();

            if (!Array.contains(prm._asyncPostBackControlIDs, eventName)) {
                prm._asyncPostBackControlIDs.push(eventName);
            }

            if (!Array.contains(prm._asyncPostBackControlClientIDs, eventName)) {
                prm._asyncPostBackControlClientIDs.push(eventName);
            }
            __doPostBack(eventName, eventArgs);
        }
        String.prototype.endsWith = function(str)
        { return (this.match(str + "$") == str) }
    </script>

</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <div class="fullbox">
        <h3><asp:Label ID="lblContributions" Text="Contributions" runat="server" 
                meta:resourcekey="lblContributionsResource1" /></h3>
        <p class="note">
            <asp:Label ID="lblClickContribution" runat="server" 
                Text="Click on a Contribution to view detail" 
                meta:resourcekey="lblClickContributionResource1"></asp:Label></p>
        <div class="static-height" style="overflow: auto; height: 200px;">
            <asp:GridView ID="gvContributions" runat="server" CssClass="investmentsSummary" AutoGenerateColumns="False"
                OnRowCreated="gvContributions_RowDataBound" 
                meta:resourcekey="gvContributionsResource1">
                <Columns>
                    <asp:BoundField DataField="DateReceived" HeaderText="Period" 
                        DataFormatString="{0:dd/MM/yyyy}" ItemStyle-CssClass="table-link" 
                        meta:resourcekey="BoundFieldResource1">
<ItemStyle CssClass="table-link"></ItemStyle>
                    </asp:BoundField>
                    <asp:BoundField DataField="Source" HeaderText="Source" 
                        meta:resourcekey="BoundFieldResource2" />
                    <asp:BoundField DataField="Amount" HeaderText="Amount" DataFormatString="{0:c}" 
                        meta:resourcekey="BoundFieldResource3" />
                </Columns>
                <EmptyDataTemplate>
                    <asp:Label ID="lblContributionsEmpty" runat="server" 
                        Text="Currently you do not have any contributions." 
                        meta:resourcekey="lblContributionsEmptyResource1"></asp:Label>
                </EmptyDataTemplate>
            </asp:GridView>
        </div>
    </div>
    <div id="divContributionDetails" class="fullbox">
    
        <asp:UpdatePanel ID="udpContributionDetails" runat="server" OnLoad="udpContributionDetails_OnLoad"
            UpdateMode="Conditional">
            <ContentTemplate>
                <h3><asp:Label ID="lblContributionDetails" Text="Contribution Details" 
                        runat="server" meta:resourcekey="lblContributionDetailsResource1" /></h3>
                <asp:GridView CssClass="investmentsSummary" ID="gvContributionDetails" runat="server"
                    AutoGenerateColumns="False" 
                    OnRowCreated="gvContributionDetails_RowDataBound" 
                    meta:resourcekey="gvContributionDetailsResource1">
                    <Columns>
                        <asp:BoundField DataField="DateReceived" HeaderText="Period" 
                            DataFormatString="{0:dd/MM/yyyy}" meta:resourcekey="BoundFieldResource4" />
                        <asp:BoundField DataField="ContributionTypeDesc" HeaderText="Type" 
                            meta:resourcekey="BoundFieldResource5">
                        <ItemStyle CssClass="table-link" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Amount" HeaderText="Amount" DataFormatString="{0:c}" 
                            meta:resourcekey="BoundFieldResource6" />
                    </Columns>
                </asp:GridView>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
    <div id="divInvestmentDetails" class="fullbox">
        <asp:UpdatePanel ID="udpInvestmentDetails" runat="server" OnLoad="udpInvestmentDetails_OnLoad"
            UpdateMode="Conditional">
            <ContentTemplate>
                <h3><asp:Label ID="lblInvestmentDetails" Text="Investment Details"
                    runat="server" meta:resourcekey="lblInvestmentDetailsResource1" /></h3>
                <asp:GridView CssClass="investmentsSummary" ID="gvInvestmentDetails" runat="server"
                    AutoGenerateColumns="False" 
                    meta:resourcekey="gvInvestmentDetailsResource1">
                    <Columns>
                        <asp:BoundField DataField="DateReceived" HeaderText="Period" 
                            DataFormatString="{0:dd/MM/yyyy}" meta:resourcekey="BoundFieldResource7" />
                        <asp:BoundField DataField="DateInvested" HeaderText="Date Invested" 
                            DataFormatString="{0:dd/MM/yyyy}" meta:resourcekey="BoundFieldResource8" />
                        <asp:BoundField DataField="Fund" HeaderText="Fund" 
                            meta:resourcekey="BoundFieldResource9" />
                        <asp:BoundField DataField="AmountInvested" HeaderText="Contribution Amount" 
                            DataFormatString="{0:c}" meta:resourcekey="BoundFieldResource10" />
                        <asp:BoundField DataField="DealtPrice" HeaderText="Dealt Price" 
                            DataFormatString="{0:c}" meta:resourcekey="BoundFieldResource11"/>
                        <asp:BoundField DataField="UnitsQuantity" HeaderText="Units" 
                            meta:resourcekey="BoundFieldResource12" />
                    </Columns>
                </asp:GridView>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
</asp:Content>


<asp:Content ID="Content2" runat="server" ContentPlaceHolderID="ContentPlaceHolderPageTitle">
    <div class="coins">
        <h2>
            <asp:Label runat="server" ID="lblPageHeader" Text="Member Contributions" 
                meta:resourcekey="lblPageHeaderResource1" /></h2>
        <p class="h2-line">
            <asp:Label runat="server" ID="lblPageHeaderByline" 
                Text="Your member contribution information" 
                meta:resourcekey="lblPageHeaderBylineResource1" /></p>
    </div>
</asp:Content>
