<%@ Page Title="" Language="C#" MasterPageFile="~/Masterpage.Master" AutoEventWireup="true" CodeBehind="noTrngCal.aspx.cs" Inherits="LearnHub.noTrngCal" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class=" container">
        <div class="wrapper">
            <br />
        <h1>Calendar not found</h1>
            <br />
        <img src="img/calendar.png" style='width: 15%;' border="0"/>
        <h3>There is no training calendar uploaded.</h3>
            </div>
        <br />
         <a href='javascript:history.go(-1)'><span class="glyphicon glyphicon-menu-left"></span>&nbsp; Go Back To Previous Page</a>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
