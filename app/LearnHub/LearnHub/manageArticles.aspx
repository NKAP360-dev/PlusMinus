<%@ Page Title="" Language="C#" MasterPageFile="~/Masterpage.Master" AutoEventWireup="true" CodeBehind="manageArticles.aspx.cs" Inherits="LearnHub.manageArticles" %>

<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="LearnHub.AppCode.dao" %>
<%@ Import Namespace="LearnHub.AppCode.entity" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
     <link href="/Scripts/footable.bootstrap.min.css" rel="stylesheet" />
    <script src="/Scripts/footable.min.js"></script>
        <style>
        .breadcrumb {
            padding-top: 15px;
            margin-bottom: 10px;
            list-style: none;
            background-color: white;
            border-radius: 0px;
        }

        .pagination li > a,
        .pagination li > span,
        .pagination li > a:focus, .pagination .disabled > a,
        .pagination .disabled > a:hover,
        .pagination .disabled > a:focus,
        .pagination .disabled > span {
            background-color: white;
            color: black;
        }

            .pagination li > a:hover {
                background-color: #96a8ba;
            }

        .pagination > .active > a,
        .pagination > .active > span,
        .pagination > .active > a:hover,
        .pagination > .active > span:hover,
        .pagination > .active > a:focus,
        .pagination > .active > span:focus {
            background-color: #576777;
        }
    </style>
    <script>
        jQuery(function ($) {
            $('.table').footable({
                "paging": {
                    "size": 10 <%--Change how many rows per page--%>
                },
                "filtering": {
                    "position": "left"
                }
            });
        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
 <ul class="breadcrumb">
        <li><a href="home.aspx">Home</a></li>
        <li><a href="siteConfig.aspx">Configuration Settings</a></li>
        <li class="active">Manage Useful Information Articles</li>
    </ul>

    <form runat="server">
    <div class="container">
        <h1>Manage Useful Information Articles
        <a href="createArticle.aspx" class="btn btn-success">Add New Article</a>
        </h1>
   

     <div class="dropdown" style="float: right;">
            <button class="dropbtn" onclick="return false;"><span class="glyphicon glyphicon-option-horizontal"></span></button>
            <div class="dropdown-content" style="right: 0;">
                <a href="manageArticles.aspx"><span class="glyphicon glyphicon-duplicate"></span>&nbsp;&nbsp;Manage Articles</a>
                <a href="createArticles.aspx"><span class="glyphicon glyphicon-pencil"></span>&nbsp;&nbsp;Add Article</a>
            </div>
        </div>
    <div class="verticalLine"></div>
    <table class="table table-striped table-hover" data-paging="true" data-sorting="true" data-filtering="true">
            <thead>
                <tr>
                    <th width="80%">Title</th>
                    <th>Date Posted</th>
                    <th data-filterable="false" data-sortable="false"></th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>What is the best fruit on earth?</td>
                    <td>14/9/17</td>
                    <td><a href="editArticle.aspx" class="btn btn-sm btn-info"><span class="glyphicon glyphicon-pencil"></span></a>
                <asp:LinkButton ID="btnDelete" CssClass="btn btn-sm btn-danger" runat="server" data-toggle="modal" href="#deleteModal" OnClientClick="$('#myModal').modal();  return false;" UseSubmitBehavior="False"><span class="glyphicon glyphicon-trash"></span></asp:LinkButton>
                    </td>
                </tr>
            </tbody>
        </table>
         </div>

    <div id="deleteModal" class="modal fade" role="dialog">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title"><b>Delete Article </b></h4>
                    </div>
                    <div class="modal-body">
                        <div class="wrapper">
                            <h4>Are you sure you want to delete?</h4>
                            <br />
                            
                            <asp:Button ID="cfmDelete" CssClass="btn btn-danger" runat="server" Text="Delete"/>
                            <asp:Button ID="Button2" CssClass="btn btn-default" runat="server" class="close" data-dismiss="modal" Text="Cancel" OnClientClick="return false;" />

                            <br />
                        </div>
                    </div>
                </div>

            </div>
        </div>
        </form>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
