<%@ Page Title="" Language="C#" MasterPageFile="~/Masterpage.Master" AutoEventWireup="true" CodeBehind="manageUsers.aspx.cs" Inherits="LearnHub.manageUsers" %>

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
        <li class="active">Manage Users</li>
    </ul>

    <div class="container">
        <h1>Manage Users
                        <a href="createAccess.aspx" class="btn btn-success">Add New Users</a>

        </h1>
        <% 
            User currentUser = (User)Session["currentUser"];
            Boolean superuser = false;
            foreach (string s in currentUser.getRoles())
            {
                if (s.Equals("superuser"))
                {
                    superuser = true;
                }
            }
            if (currentUser != null && superuser)
            {
        %>

        <div class="dropdown" style="float: right;">
            <button class="dropbtn" onclick="return false;"><span class="glyphicon glyphicon-option-horizontal"></span></button>
            <div class="dropdown-content" style="right: 0;">
                <a href="manageUsers.aspx"><span class="glyphicon glyphicon-user"></span>&nbsp;&nbsp;Manage Users</a>
                <a href="createAccess.aspx"><span class="glyphicon glyphicon-plus"></span>&nbsp;&nbsp;Add Users</a>
            </div>
        </div>

        <%} %>
        <div class="verticalLine"></div>
    </div>
    <div class="container">
        <table class="table table-striped table-hover" data-paging="true" data-sorting="true" data-filtering="true">
            <thead>
                <tr>
                    <th>User ID</th>
                    <th>Department</th>
                    <th>Contact No</th>
                    <th>Email</th>
                    <th>Status</th>
                    <th data-filterable="false" data-sortable="false"></th>
                </tr>
            </thead>
            <tbody>
                <%foreach (User u in all_users)
                    { %>
                <tr>
                    <td><%=u.getName() %></td>
                    <td><%=u.getDepartment() %></td>
                    <td><%=u.getContact() %></td>
                    <td><%=u.getEmail() %></td>
                    <td><%=u.getStatus() %></td>
                    <td width="10%"><a href="editUsers.aspx?userID=<%=u.getUserID() %>" class="btn btn-info btn-sm pull-right"><span class="glyphicon glyphicon-pencil"></span></a></td>
                </tr>
                <%} %>
            </tbody>
        </table>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
