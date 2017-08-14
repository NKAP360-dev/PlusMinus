<%@ Page Title="" Language="C#" MasterPageFile="~/Masterpage.Master" AutoEventWireup="true" CodeBehind="viewCreatedModules.aspx.cs" Inherits="LearnHub.viewCreatedModules" %>
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

         .breadcrumb {
            padding-top: 15px;
            margin-bottom: 0px;
            list-style: none;
            background-color: white;
            border-radius: 0px;
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
              <li><a href="viewAllModule.aspx">Module</a></li>
        <li class="active">View My Created Modules</li>
    </ul>
    <div class="container">
        <h1>View My Created Modules
                 <%
                 User currentUser = (User)Session["currentUser"];
                 if (currentUser != null && (currentUser.getRole().Equals("course creator") || currentUser.getRole().Equals("superuser")))
                 {
             %>
            <a href="#" id="config" onclick="configuration()" class="btn btn-default pull-right"><span class="glyphicon glyphicon-option-horizontal"></span></a>
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
    <div class="container">
        <form runat="server">
            <%
                User currentUser = (User)Session["currentUser"];
                Course_elearnDAO ceDAO = new Course_elearnDAO();
                Course_elearnCategoryDAO cecDAO = new Course_elearnCategoryDAO();
                ArrayList allUserCourses = ceDAO.getAllCoursesByCreatorID(currentUser.getUserID());
                if (allUserCourses.Count > 0)
                {
            %>
        <table class="table table-striped table-hover" data-paging="true" data-sorting="true" data-filtering="true">
                        <thead>
                            <tr>
                                <th>Course Name</th>
                                <th>Course Category</th>
                                <th data-breakpoints="xs sm">Course Provider</th>
                                <th data-breakpoints="xs sm">Start Date</th>
                                <th data-breakpoints="xs sm">End Date</th>
                                <th data-filterable="false" data-sortable="false"></th>

                            </tr>
                        </thead>
                        <tbody>
                            <%
                                foreach (Course_elearn ce in allUserCourses)
                                {
                                    CourseCategory cc = cecDAO.getCategoryByID(ce.getCategoryID());
                                    Response.Write("<tr>");
                                    Response.Write($"<td>{ce.getCourseName()}</td>");
                                    Response.Write($"<td>{cc.category}</td>");
                                    Response.Write($"<td>{ce.getCourseProvider()}</td>");
                                    Response.Write($"<td>{ce.getStartDate().ToString("dd/MM/yyyy")}</td>");
                                    Response.Write($"<td>{ce.getExpiryDate().ToString("dd/MM/yyyy")}</td>");
                                    Response.Write("<td><a href=\"editModuleInfo.aspx?id=" + ce.getCourseID() + "\" class=\"btn btn-info btn-sm pull-right\"><span class=\"glyphicon glyphicon-pencil\"></span></a></td>");
                                    Response.Write("</tr>");
                                }
                            %>
                        </tbody>
                    </table>    
            <%
                }
                else
                {
                    Response.Write("<h3>You have not created any modules</h3>");
                }
            %>
            </form>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
