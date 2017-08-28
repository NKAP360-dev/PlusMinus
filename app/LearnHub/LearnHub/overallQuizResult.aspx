<%@ Page Title="" Language="C#" MasterPageFile="~/Masterpage.Master" AutoEventWireup="true" CodeBehind="overallQuizResult.aspx.cs" Inherits="LearnHub.overallQuizResult" %>

<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="LearnHub.AppCode.dao" %>
<%@ Import Namespace="LearnHub.AppCode.entity" %>

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
        <li><a href="viewAllModule.aspx">Modules</a></li>
        <%int courseID = Convert.ToInt32(Request.QueryString["id"]); %>
        <li><a href="viewModuleInfo.aspx?id=<%=courseID%>">
            <asp:Label ID="lblBreadcrumbCourseName" runat="server" Text="courseName"></asp:Label></a></li>
        <li><a href="manageQuiz.aspx?id=<%=courseID%>">Manage Quizzes</a></li>
        <li class="active">Quiz Statistics</li>
    </ul>
    <form runat="server">
        <div class="container">
            <h1>Overall Quiz Statistics
             <% 
                 User currentUser = (User)Session["currentUser"];
                 Course_elearnDAO ceDAO = new Course_elearnDAO();
                 int courseID = Convert.ToInt32(Request.QueryString["id"]);
                 User courseCreator = ceDAO.get_course_by_id(courseID).getCourseCreator();
                 if (currentUser != null && (currentUser.getUserID() == courseCreator.getUserID() || currentUser.getRole().Equals("superuser")))
                 {
             %>

                <a href="#" id="config" onclick="configuration()" class="btn btn-default pull-right"><span class="glyphicon glyphicon-option-horizontal"></span></a>
            </h1>
            <div class="configure">
                <ul class="list-group" id="menu" style="display: none;">
                    <a href="editModuleInfo.aspx?id=<%=courseID %>">
                        <li class="list-group-item"><span class="glyphicon glyphicon-pencil"></span>&emsp;Edit Module
                        </li>
                    </a>
                    <a href="#uploadModal" data-toggle="modal">
                        <li class="list-group-item"><span class="glyphicon glyphicon-level-up"></span>&emsp;Upload Learning Materials
                        </li>
                    </a>
                    <a href="manageQuiz.aspx?id=<%=courseID%>">
                        <li class="list-group-item"><span class="glyphicon glyphicon-book"></span>&emsp;Manage Quizzes
                        </li>
                    </a>

                </ul>
            </div>
            <h4>
                <asp:Label ID="lblQuizTitle" runat="server" Text="Quiz Title"></asp:Label></h4>

            <%} %>
            <div class="verticalLine"></div>
        </div>
        <div class="container">
           <table class="table table-striped table-hover" data-paging="true" data-sorting="true" data-filtering="true">
           <thead>
                <tr>
                    <th>User</th>
                    <th>Score</th>
                    <th>Grade</th>
                    <th>Date Submitted</th>
                </tr>
            </thead>
                <tbody>
                    <%--Link to viewResults.aspx--%>
                    <tr><td><a href="#">Rafid</a></td>
                        <td>0/10</td>
                           
                    </tr>
                </tbody>
           </table>
        </div>
    </form>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
