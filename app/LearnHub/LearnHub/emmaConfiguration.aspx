<%@ Page Title="" Language="C#" MasterPageFile="~/Masterpage.Master" AutoEventWireup="true" CodeBehind="emmaConfiguration.aspx.cs" Inherits="LearnHub.emmaConfiguration" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">
        <h1>Emma Configuration Settings</h1>
        <div class="verticalLine"></div>
    </div>

    <div class="container">
        <div class="row">
            <h3>Creation</h3>
            <div class="col-md-3">
                <a href="askEmmaAddAns.aspx" class="btn btn-primary btn-lg btn-block"><span class="glyphicon glyphicon-plus-sign"></span>&nbsp; Add Answers</a>
            </div>
            <div class="col-md-1"></div>
            <div class="col-md-3">
                <a href="askEmmaAddIntent.aspx" class="btn btn-primary btn-lg btn-block"><span class="glyphicon glyphicon-asterisk"></span>&nbsp; Create New Intent</a>
            </div>

        </div>
        <div class="row">
            <h3>Configuration</h3>
            <div class="col-md-3">
                <a href="askEmmaInitializeMsg.aspx" class="btn btn-primary btn-lg btn-block"><span class="glyphicon glyphicon-off"></span>&nbsp; Initialization Message</a>
            </div>

            <div class="col-md-1"></div>
            <div class="col-md-3">
                <a href="askEmmaHelpQn.aspx" class="btn btn-primary btn-lg btn-block"><span class="glyphicon glyphicon-send"></span>&nbsp; Question Suggestions</a>
            </div>
            <div class="col-md-1"></div>
            <div class="col-md-3">
                <a href="askEmmaEditAns.aspx" class="btn btn-primary btn-lg btn-block"><span class="glyphicon glyphicon-pencil"></span>&nbsp; Edit Answers</a>
            </div>

        </div>
        <div class="row">
            <h3>View</h3>
            <div class="col-md-3">
                <a href="askEmmaFeedback.aspx" class="btn btn-primary btn-lg btn-block"><span class="glyphicon glyphicon-thumbs-up"></span>&nbsp; Emma's Feedback</a>
            </div>

        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
