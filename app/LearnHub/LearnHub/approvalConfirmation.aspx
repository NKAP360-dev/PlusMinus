<%@ Page Title="" Language="C#" MasterPageFile="~/Masterpage.Master" AutoEventWireup="true" CodeBehind="approvalConfirmation.aspx.cs" Inherits="LearnHub.approvalConfirmation" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
        <div class="container">
            <h1>Approval Confirmation</h1>
        <div class="verticalLine"></div>
        <h3>Thank you for approving the Training Request Form</h3>      
        <br /><br />
            <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/pendingApproval.aspx"><span class="glyphicon glyphicon-menu-right"></span>&nbsp; View All Pending Training Request Form</asp:HyperLink>
            <br />
            <asp:HyperLink ID="HyperLink2" runat="server" NavigateUrl="~/approvedTRF.aspx"><span class="glyphicon glyphicon-menu-right"></span>&nbsp; View All Approved TRF</asp:HyperLink>

        </div>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
