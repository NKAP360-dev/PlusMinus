<%@ Page Title="" Language="C#" MasterPageFile="~/Masterpage.Master" AutoEventWireup="true" CodeBehind="submitTRF.aspx.cs" Inherits="LearnHub.submitTRF" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">
        <h1>Submission Confirmation</h1>
        <h3>Thank you for your submission</h3>
        You will receive an email once your application is approved.
        <br /><br />
            <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/trfApplicationStatus.aspx"><span class="glyphicon glyphicon-menu-right"></span>&nbsp; View Application Status</asp:HyperLink>
            <br /><asp:HyperLink ID="HyperLink2" runat="server"><span class="glyphicon glyphicon-menu-right"></span>&nbsp; View Course Listing</asp:HyperLink>

        
        </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
