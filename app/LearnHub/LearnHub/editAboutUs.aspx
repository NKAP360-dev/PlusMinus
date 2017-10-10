<%@ Page Title="" Language="C#" MasterPageFile="~/Masterpage.Master" AutoEventWireup="true" CodeBehind="editAboutUs.aspx.cs" Inherits="LearnHub.editAboutUs" %>

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
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <ul class="breadcrumb">
        <li><a href="home.aspx">Home</a></li>
        <li><a href="aboutUs.aspx">About Us</a></li>
        <li class="active">Edit About Us</li>
    </ul>

    <div class="container">
        <h1>Edit About Us</h1>

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
            <CKEditor:CKEditorControl ID="CKEditor1" runat="server">
            </CKEditor:CKEditorControl>

            <br />
            <div class="form-group wrapper">
                <asp:Button ID="btnCreate" CssClass="btn btn-primary" runat="server" Text="Save" data-toggle="modal" href="#submitModal" OnClientClick="$('#myModal').modal();  return false;" UseSubmitBehavior="False" />
            </div>

            <div id="submitModal" class="modal fade" role="dialog">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                            <h4 class="modal-title"><b>Edit About Us </b></h4>
                        </div>
                        <div class="modal-body">
                            <div class="wrapper">
                                <h4>This will overwrite your current content. Are you sure you want to proceed?</h4>
                                <br />

                                <asp:Button ID="cfmSubmit" CssClass="btn btn-primary" runat="server" Text="Yes" />
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
