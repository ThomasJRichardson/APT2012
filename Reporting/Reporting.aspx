<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="Reporting.aspx.cs" Inherits="APT2012.Reporting" meta:resourcekey="PageResource1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:Repeater runat="server" ID="rptMemberDocuments">
        <HeaderTemplate>
            <div class="fullbox clear">
                <h3>
                    <asp:Label ID="lblYourDocuments" Text="Your Documents" runat="server" meta:resourcekey="lblYourDocumentsResource1" /></h3>
                <div style="padding: 5px 5px 10px 5px;" class="clear">
        </HeaderTemplate>
        <ItemTemplate>
            <div class="report-link <%# getIcon(Eval("FileName").ToString().Trim()) %>">
                <span class="title"><a href='Download.aspx?filename=<%# Eval("FileName").ToString().Trim() %>&fileid=<%# Eval("Id") %>'>
                    <%# Eval("Title").ToString().Trim().Replace(" ", "&nbsp;") %></a></span> <span class="description">
                        &nbsp;</span>
            </div>
        </ItemTemplate>
        <FooterTemplate>
            </div></div>
        </FooterTemplate>
    </asp:Repeater>
    <asp:Repeater runat="server" ID="rptSchemeDocuments">
        <HeaderTemplate>
            <div class="fullbox clear">
                <h3>
                    <asp:Label ID="lblSchemeDocuments" Text="Scheme Documents" runat="server" meta:resourcekey="lblSchemeDocumentsResource1" /></h3>
               <div style="padding: 5px 5px 10px 5px;" class="clear">
        </HeaderTemplate>
        <ItemTemplate>
            <div class="report-link <%# getIcon(Eval("FileName").ToString().Trim()) %>">
                <span class="title"><a href='Download.aspx?filename=<%# Eval("FileName").ToString().Trim() %>&fileid=<%# Eval("Id") %>'>
                    <%# Eval("Title").ToString().Trim().Replace(" ", "&nbsp;") %></a></span> <span class="description">
                        &nbsp;</span>
            </div>
        </ItemTemplate>
        <FooterTemplate>
            </div></div>
        </FooterTemplate>
    </asp:Repeater>
    <asp:Repeater runat="server" ID="rptFundDocuments">
        <HeaderTemplate>
            <div class="fullbox clear">
                <h3>
                    <asp:Label ID="lblFundDocuments" Text="Fund Documents" runat="server" meta:resourcekey="lblFundDocumentsResource1" /></h3>
                <div style="padding: 5px 5px 10px 5px;" class="clear">
        </HeaderTemplate>
       <ItemTemplate>
            <div class="report-link <%# getIcon(Eval("FileName").ToString().Trim()) %>">
                <span class="title"><a href='Download.aspx?filename=<%# Eval("FileName").ToString().Trim() %>&fileid=<%# Eval("Id") %>'>
                    <%# Eval("Title").ToString().Trim().Replace(" ", "&nbsp;") %></a></span> <span class="description">
                        &nbsp;</span>
            </div></div>
        </ItemTemplate>
        <FooterTemplate>
            </ul></div>
        </FooterTemplate>
    </asp:Repeater>
    <asp:Repeater runat="server" ID="rptBenefitDocuments">
        <HeaderTemplate>
            <div class="fullbox clear">
                <h3>
                    <asp:Label ID="lblBenefitDocuments" Text="Benefit Documents" runat="server" meta:resourcekey="lblBenefitDocumentsResource1" /></h3>
                <div style="padding: 5px 5px 10px 5px;" class="clear">
        </HeaderTemplate>
        <ItemTemplate>
            <div class="report-link <%# getIcon(Eval("FileName").ToString().Trim()) %>">
                <span class="title"><a href='Download.aspx?filename=<%# Eval("FileName").ToString().Trim() %>&fileid=<%# Eval("Id") %>'>
                    <%# Eval("Title").ToString().Trim().Replace(" ", "&nbsp;") %></a></span> <span class="description">
                        &nbsp;</span>
            </div>
        </ItemTemplate>
        <FooterTemplate>
            </div> </div>
        </FooterTemplate>
    </asp:Repeater>
</asp:Content>
<asp:Content ID="Content2" runat="server" ContentPlaceHolderID="ContentPlaceHolderPageTitle">
    <div class="reporting">
        <! -- Change for Specific Icons -->
        <h2>
            <asp:Label runat="server" ID="lblPageHeader" Text="Documents &amp; Reporting" meta:resourcekey="lblPageHeaderResource1" /></h2>
        <p class="h2-line">
            <asp:Label runat="server" ID="lblPageHeaderByline" Text="Area to retrieve and print reports on your plan"
                meta:resourcekey="lblPageHeaderBylineResource1" /></p>
    </div>
</asp:Content>
