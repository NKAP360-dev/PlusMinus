<%@ Page Title="" Language="C#" MasterPageFile="~/Masterpage.Master" AutoEventWireup="true" CodeBehind="viewAllModule.aspx.cs" Inherits="LearnHub.viewAllModule" %>

<%@ Import Namespace="LearnHub.AppCode.entity" %>
<%@ Import Namespace="LearnHub.AppCode.dao" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
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


    </style>
    <link href="/Scripts/footable.bootstrap.min.css" rel="stylesheet" />
    <script src="/Scripts/footable.min.js"></script>
    <script>
        $(document).ready(function () {
            $('#menu').hide();
        });

        function configuration() {
            var x = document.getElementById('menu');
            if (x.style.display === 'none') {
                x.style.display = 'block';
            } else {
                x.style.display = 'none';
            }
        }

        jQuery(function ($) {
            $('.table').footable({
                "paging": {
                    "size": 5 <%--Change how many rows per page--%>
                },
                "filtering": {
                    "position": "left"
                }
            });
        });

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">
        <h1>View Modules

             <%
        User currentUser = (User)Session["currentUser"];
        if (currentUser != null && (currentUser.getRole().Equals("course creator") || currentUser.getRole().Equals("superuser")))
        {
    %>
       <a href="#" id="config" onclick="configuration()"class="btn btn-default pull-right"><span class="glyphicon glyphicon-option-horizontal"></span></a>
</h1>
        <div class="configure">
        <ul class="list-group" id="menu" style="display: none;">
            <a href="createModules.aspx">
                <li class="list-group-item"><span class="glyphicon glyphicon-book"></span>&emsp;Create New Modules
                </li>
            </a>
            <a href="manageCategories.aspx">
                <li class="list-group-item"><span class="glyphicon glyphicon-bookmark"></span>&emsp;Manage Module Categories
                </li>
            </a>
             <a href="viewCreatedModules.aspx">
                <li class="list-group-item"><span class="glyphicon glyphicon-search"></span>&emsp;View My Created Modules
                </li>
            </a>
        </ul>
    </div>
         <%
        }
    %>
        <div class="verticalLine"></div>
    </div>
    <asp:Panel ID="viewCompulsory" runat="server" Visible="false">
        <div class="container">
            <div class="row">
                <div class="col-md-3">
                    <div class="list-group">
                        <div class="wrapper">
                            <h4><strong><span class="glyphicon glyphicon-search">&emsp;</span>View Training Types</strong></h4>
                        </div>
                        <a href="viewAllModule.aspx?module=compulsory" class="list-group-item active">
                            <span class="glyphicon glyphicon-menu-right"></span>&emsp;Compulsory Training
                        </a>
                        <a href="viewAllModule.aspx?module=leadership" class="list-group-item">Leadership Skills Training
                        </a>
                        <a href="viewAllModule.aspx?module=professional" class="list-group-item">Professional Training
                        </a>

                    </div>
                </div>
                <div class="col-md-9">
                    <h2>Compulsory Modules</h2>
                    <table class="table" data-paging="true" data-sorting="true" data-filtering="true">
                        <thead>
                            <tr>
                                <th>Course Name</th>
                                <th data-breakpoints="xs sm">Course Provider</th>
                                <th data-breakpoints="xs sm">Hours Awarded</th>
                                <th data-filterable="false" data-sortable="false">View</th>

                            </tr>
                        </thead>
                        <tbody>
                            <%
                                Course_elearnDAO allListing = new Course_elearnDAO();
                                ArrayList list = allListing.view_courses(1);
                                String htmlStr = null;
                                if (list.Count > 0)
                                {
                                    foreach (Course_elearn ce in list)
                                    {
                                        htmlStr += "<tr><td>";
                                        htmlStr += ce.getCourseName();
                                        htmlStr += "</td>";
                                        htmlStr += "<td>";
                                        htmlStr += ce.getCourseProvider();
                                        htmlStr += "</td>";
                                        htmlStr += "<td>";
                                        htmlStr += ce.getHoursAwarded();
                                        htmlStr += "</td>";
                                        htmlStr += "<td><a href=\"viewModuleInfo.aspx?id=" + ce.getCourseID() + "\"><span class=\"glyphicon glyphicon-menu-right\"></span> View Info</a></td>";
                                        htmlStr += "</tr>";
                                    }
                                    Response.Write(htmlStr);
                                }

                            %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </asp:Panel>

    <asp:Panel ID="viewLeadership" runat="server" Visible="false">
        <div class="container">
            <div class="row">
                <div class="col-md-3">
                    <div class="list-group">
                        <div class="wrapper">
                            <h4><strong><span class="glyphicon glyphicon-search">&emsp;</span>View Training Types</strong></h4>
                        </div>
                        <a href="viewAllModule.aspx?module=compulsory" class="list-group-item">Compulsory Training
                        </a>
                        <a href="viewAllModule.aspx?module=leadership" class="list-group-item active">
                            <span class="glyphicon glyphicon-menu-right"></span>&emsp;Leadership Skills Training
                        </a>
                        <a href="viewAllModule.aspx?module=professional" class="list-group-item">Professional Training
                        </a>

                    </div>
                </div>
                <div class="col-md-9">
                    <h2>Leadership Modules</h2>
                    <table class="table" data-paging="true" data-sorting="true" data-filtering="true">
                        <thead>
                            <tr>
                                <th>Course Name</th>
                                <th data-breakpoints="xs sm">Course Provider</th>
                                <th data-breakpoints="xs sm">Hours Awarded</th>
                                <th data-filterable="false" data-sortable="false">View</th>

                            </tr>
                        </thead>
                        <tbody>
                            <%
                                Course_elearnDAO allListing = new Course_elearnDAO();
                                ArrayList list = allListing.view_courses(2);
                                String htmlStr = null;
                                if (list.Count > 0)
                                {
                                    foreach (Course_elearn ce in list)
                                    {
                                        htmlStr += "<tr><td>";
                                        htmlStr += ce.getCourseName();
                                        htmlStr += "</td>";
                                        htmlStr += "<td>";
                                        htmlStr += ce.getCourseProvider();
                                        htmlStr += "</td>";
                                        htmlStr += "<td>";
                                        htmlStr += ce.getHoursAwarded();
                                        htmlStr += "</td>";
                                        htmlStr += "<td><a href=\"viewModuleInfo.aspx?id=" + ce.getCourseID() + "\"><span class=\"glyphicon glyphicon-menu-right\"></span> View Info</a></td>";
                                        htmlStr += "</tr>";
                                    }
                                    Response.Write(htmlStr);
                                }

                            %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </asp:Panel>

    <asp:Panel ID="viewProfessional" runat="server" Visible="false">
        <div class="container">
            <div class="row">
                <div class="col-md-3">
                    <div class="list-group">
                        <div class="wrapper">
                            <h4><strong><span class="glyphicon glyphicon-search">&emsp;</span>View Training Types</strong></h4>
                        </div>
                        <a href="viewAllModule.aspx?module=compulsory" class="list-group-item">Compulsory Training
                        </a>
                        <a href="viewAllModule.aspx?module=leadership" class="list-group-item">Leadership Skills Training
                        </a>
                        <a href="viewAllModule.aspx?module=professional" class="list-group-item active"><span class="glyphicon glyphicon-menu-right"></span>&emsp;Professional Training
                        </a>

                    </div>
                </div>
                <div class="col-md-9">
                    <h2>Professional Modules</h2>
                    <table class="table" data-paging="true" data-sorting="true" data-filtering="true">
                        <thead>
                            <tr>
                                <th>Course Name</th>
                                <th data-breakpoints="xs sm">Course Provider</th>
                                <th data-breakpoints="xs sm">Hours Awarded</th>
                                <th data-filterable="false" data-sortable="false">View</th>

                            </tr>
                        </thead>
                        <tbody>
                            <%
                                Course_elearnDAO allListing = new Course_elearnDAO();
                                ArrayList list = allListing.view_courses(3);
                                String htmlStr = null;
                                if (list.Count > 0)
                                {
                                    foreach (Course_elearn ce in list)
                                    {
                                        htmlStr += "<tr><td>";
                                        htmlStr += ce.getCourseName();
                                        htmlStr += "</td>";
                                        htmlStr += "<td>";
                                        htmlStr += ce.getCourseProvider();
                                        htmlStr += "</td>";
                                        htmlStr += "<td>";
                                        htmlStr += ce.getHoursAwarded();
                                        htmlStr += "</td>";
                                        htmlStr += "<td><a href=\"viewModuleInfo.aspx?id=" + ce.getCourseID() + "\"><span class=\"glyphicon glyphicon-menu-right\"></span> View Info</a></td>";
                                        htmlStr += "</tr>";
                                    }
                                    Response.Write(htmlStr);
                                }

                            %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </asp:Panel>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
