<%@ Page Title="" Language="C#" MasterPageFile="~/Masterpage.Master" AutoEventWireup="true" CodeBehind="siteMap.aspx.cs" Inherits="LearnHub.siteMap" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">
        <br />
        <h1>Site Map</h1>
        <div class="verticalLine">
        </div>
        <br />
         <a href="login.aspx">Login</a><br />
        <a href="forgotPassword.aspx">Forgot Password</a><br />        
        <a href="Home.aspx">Home</a><br />
        <a href="viewAllModule.aspx">View Courses</a><br />
        <a href="usefulInfo.aspx">Useful Information</a><br />
        <a href="usefulLinks.aspx">Useful Links</a><br />
        <a href="aboutUs.aspx">About Us</a><br />
         <a href="contactUs.aspx">Contact Us</a><br />
         
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
