<%@ Page Title="" Language="C#" MasterPageFile="~/Masterpage.Master" AutoEventWireup="true" CodeBehind="emmaConfiguration.aspx.cs" Inherits="LearnHub.emmaConfiguration" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">
    <h1>Emma Configuration Settings</h1>
     <div class="verticalLine"></div>
     </div>
    <br />
    <div class="container">
        <a href="askEmmaAddAns.aspx" class="btn btn-success">Add Answers</a>
        &emsp;
        <a href="askEmmaEditAns.aspx" class="btn btn-success">Edit Answers</a>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
