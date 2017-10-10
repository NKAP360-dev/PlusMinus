﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Masterpage.Master" AutoEventWireup="true" CodeBehind="createArticle.aspx.cs" Inherits="LearnHub.createArticle" %>

<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="LearnHub.AppCode.dao" %>
<%@ Import Namespace="LearnHub.AppCode.entity" %>

<%@ Register Assembly="CKEditor.NET" Namespace="CKEditor.NET" TagPrefix="CKEditor" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="//cdn.ckeditor.com/4.7.3/full/ckeditor.js"></script>
    <style>
        .breadcrumb {
            padding-top: 15px;
            margin-bottom: 10px;
            list-style: none;
            background-color: white;
            border-radius: 0px;
        }
    </style>
    <script type="text/javascript">
        function ValidateArticleDescription(sender, args) {
            console.log("enter fbd");
            var feedbackDescription = document.getElementById("<%= txtTitle.ClientID %>").value;
            if (feedbackDescription == "") {
                console.log("no desc");
                args.IsValid = false;
            }
            else {
                console.log("Yes desc");
                args.IsValid = true;
            }
        }
        function openModal() {
            console.log("submitModal");
            $("#submitModal").modal();
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <ul class="breadcrumb">
        <li><a href="home.aspx">Home</a></li>
        <li><a href="usefulInfo.aspx">Useful Information</a></li>
        <li><a href="manageArticles.aspx">Manage Useful Information Articles</a></li>
        <li class="active">Create New Article</li>
    </ul>

    <div class="container">
        <h1>Create New Article</h1>

        <div class="dropdown" style="float: right;">
            <button class="dropbtn" onclick="return false;"><span class="glyphicon glyphicon-option-horizontal"></span></button>
            <div class="dropdown-content" style="right: 0;">
                <div class="dropHeader">Content Management</div>
                <a href="editAboutUs.aspx"><span class="glyphicon glyphicon-pencil"></span>&nbsp;&nbsp;Edit About Us</a>
                <a href="manageArticles.aspx"><span class="glyphicon glyphicon-duplicate"></span>&nbsp;&nbsp;Manage Articles</a>
                <a href="manageUsefulLinks.aspx"><span class="glyphicon glyphicon-globe"></span>&nbsp;&nbsp;Manage Links</a>
                <a href="manageContactUs.aspx"><span class="glyphicon glyphicon-earphone"></span>&nbsp;&nbsp;Manage Contact Us</a>

                </div>
        </div>

        <div class="verticalLine"></div>
        <br />
        <form class="form-horizontal" runat="server">
            <div class="form-group required">
                <strong>
                    <asp:Label runat="server" CssClass="col-lg-1 control-label" Text="Title"></asp:Label></strong>
                <div class="col-lg-11">
                    <asp:TextBox ID="txtTitle" runat="server" CssClass="form-control" placeholder="Title of Article"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfv_txtTitle" runat="server" ErrorMessage="Please input a Title" ControlToValidate="txtTitle" ForeColor="Red" ValidationGroup="ValidateForm" Display="Dynamic"></asp:RequiredFieldValidator>
                </div>
            </div>

            <CKEditor:CKEditorControl ID="CKEditor1" runat="server">
            </CKEditor:CKEditorControl>
            <asp:CustomValidator ID="cv_txtArticleDesc" runat="server" EnableClientScript="true" ErrorMessage="Required*" ClientValidationFunction="ValidateArticleDescription" ForeColor="Red" ValidationGroup="ValidateForm" Display="Dynamic" ></asp:CustomValidator>
            <br />
            <div class="form-group wrapper">
                <asp:Button ID="btnCreate" CssClass="btn btn-primary" runat="server" Text="Create" onclick="checkForm" CausesValidation="True" UseSubmitBehavior="False" ValidationGroup="ValidateForm"/>
            </div>

               <div id="submitModal" class="modal fade" role="dialog">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title"><b>Create Article </b></h4>
                    </div>
                    <div class="modal-body">
                        <div class="wrapper">
                            <h4>This article will be published. Are you sure you want to proceed?</h4>
                            <br />
                            <asp:Label ID="lblErrorMsgFinal" runat="server" CssClass="text-danger" Visible="True"></asp:Label>
                                <br />
                            <asp:Button ID="cfmSubmit" CssClass="btn btn-primary" runat="server" Text="Create" OnClick="cfmSubmit_Click" />
                            <asp:Button ID="Button2" CssClass="btn btn-default" runat="server" class="close" data-dismiss="modal" Text="Cancel" OnClientClick="return false;" />

                            <br />
                        </div>
                    </div>
                </div>

            </div>
        </div>


        </form>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
