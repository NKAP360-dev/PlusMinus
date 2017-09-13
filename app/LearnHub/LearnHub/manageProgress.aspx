<%@ Page Title="" Language="C#" MasterPageFile="~/Masterpage.Master" AutoEventWireup="true" CodeBehind="manageProgress.aspx.cs" Inherits="LearnHub.manageProgress" %>

<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="LearnHub.AppCode.dao" %>
<%@ Import Namespace="LearnHub.AppCode.entity" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
  <link href="/Scripts/footable.bootstrap.min.css" rel="stylesheet" />
    <script src="/Scripts/footable.min.js"></script>
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

    <style>
        .list-group-item {
            border-left: 1px solid white;
            border-right: 1px solid white;
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
        <li><a href="siteConfig.aspx">Configuration Settings</a></li>
        <li class="active">Manage Progress Report</li>
    </ul>

    <div class="container">
        <h1>Manage Progress Report</h1>
                 <div class="dropdown" style="float: right;">
                <button class="dropbtn" onclick="return false;"><span class="glyphicon glyphicon-option-horizontal"></span></button>
                <div class="dropdown-content" style="right: 0;">
                    <a href="suggestCourse.aspx>"><span class="glyphicon glyphicon-comment"></span>&nbsp;&nbsp;Suggest Courses</a>
                    <a href="progressFeedback.aspx>"><span class="glyphicon glyphicon-hand-right"></span>&nbsp;&nbsp;Provide Progress Feedback</a>
                </div>
            </div>
        <div class="verticalLine"></div>
        <form runat="server">
            <%--Only show subordinate's progress report for supervisors--%>
            <%-- HR can view everyone's??? **NOT SURE**--%>
        <table class="table table-striped table-hover" data-paging="true" data-sorting="true" data-filtering="true">
            <thead>
                <tr>
                    <th width="80%">Username</th>
                    <th>Department</th>
                    <th data-filterable="false" data-sortable="false"></th>
                </tr>
            </thead>
                <tbody>
                    <tr><td>Rafid</td>
                        <td>Nursing</td>
                        <td><a href="progressReport.aspx" class="btn btn-info"><span class="glyphicon glyphicon-search"></span></a></td>
                    </tr>
                    </tbody>
            </table></form>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
