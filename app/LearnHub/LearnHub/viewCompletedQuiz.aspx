<%@ Page Title="" Language="C#" MasterPageFile="~/Masterpage.Master" AutoEventWireup="true" CodeBehind="viewCompletedQuiz.aspx.cs" Inherits="LearnHub.viewCompletedQuiz" %>

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

         .label {
             margin-top:15px;
         }

    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <ul class="breadcrumb">
        <li><a href="home.aspx">Home</a></li>
        <li><a href="progressReport.aspx">Progress Report</a></li>
        <li class="active">My Completed Quizzes</li>
    </ul>

    <div class="container">
        <h1>My Completed Quizzes</h1>
        <div class="verticalLine"></div>
          <form runat="server">
        <table class="table table-striped table-hover" data-paging="true" data-sorting="true" data-filtering="true">
            <thead>
                <tr>
                    <th width="80%">Quiz Title</th>
                    <th>Score</th> <%--take highest of all attempt--%>
                    <th>Result</th> <%--pass/fail--%>
                    <th data-filterable="false" data-sortable="false"></th>
                </tr>
            </thead>
                <tbody>
                    <tr><td>wash hand quiz 1</td>
                        <td>2</td>
                        <td>                <asp:Label ID="lblStatusPass" runat="server" CssClass="label label-success" Font-Size="Medium" Visible="true">Pass</asp:Label>
                <asp:Label ID="lblStatusFail" runat="server" CssClass="label label-danger" Font-Size="Medium" Visible="false">Fail</asp:Label>&emsp;
</td>
                        <td><a href="#" class="btn btn-success btn-sm"><span class="glyphicon glyphicon-search"></span></a></td>
                        <%--viewMyResult or noResult depending on quiz configuration--%>
                    </tr>
                    
                </tbody>
            </table>
        </form>

    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
