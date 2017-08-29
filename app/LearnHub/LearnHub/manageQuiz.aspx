<%@ Page Title="" Language="C#" MasterPageFile="~/Masterpage.Master" AutoEventWireup="true" CodeBehind="manageQuiz.aspx.cs" Inherits="LearnHub.manageQuiz" %>

<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="LearnHub.AppCode.dao" %>
<%@ Import Namespace="LearnHub.AppCode.entity" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
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
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <ul class="breadcrumb">
        <li><a href="home.aspx">Home</a></li>
        <li><a href="viewAllModule.aspx">Modules</a></li>
        <%int courseID = Convert.ToInt32(Request.QueryString["id"]); %>
        <li><a href="viewModuleInfo.aspx?id=<%=courseID%>">
            <asp:Label ID="lblBreadcrumbCourseName" runat="server" Text="courseName"></asp:Label></a></li>
        <li class="active">Manage Quizzes</li>
    </ul>

    <div class="container">
        <h1>Manage Quizzes
              <% 
                  User currentUser = (User)Session["currentUser"];
                  Course_elearnDAO ceDAO = new Course_elearnDAO();
                  Course_elearn currentCourse = ceDAO.get_course_by_id(courseID);
                  User courseCreator = currentCourse.getCourseCreator();
                  if (currentUser != null && (currentUser.getUserID() == courseCreator.getUserID() || currentUser.getRole().Equals("superuser")))
                  {
              %>

            <a href="#" id="config" onclick="configuration()" class="btn btn-default pull-right"><span class="glyphicon glyphicon-option-horizontal"></span></a>
            <a href="createQuiz.aspx?id=<%=courseID%>" class="btn btn-success">Add New Quiz</a>
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
        <%} %>
        <div class="verticalLine"></div>
    </div>
    <div class="container">
        <form runat="server">
        <table class="table table-striped table-hover" data-paging="true" data-sorting="true" data-filtering="true">
            <thead>
                <tr>
                    <th width="80%">Quiz Title</th>
                    <th>Status</th>
                    <th data-filterable="false" data-sortable="false"></th>
                    <th data-filterable="false" data-sortable="false"></th>
                </tr>
            </thead>
                <tbody>
                    <%
                        QuizDAO quizDAO = new QuizDAO();
                        int courseID = Convert.ToInt32(Request.QueryString["id"]);
                        List<Quiz> allQuizzes = quizDAO.getAllQuizByCourseIDActiveAndInactive(courseID);
                        foreach (Quiz q in allQuizzes)
                        {
                            Response.Write("<tr>");
                            Response.Write($"<td>{q.getTitle()}</td>");
                            Response.Write($"<td>{q.getStatus()}</td>");
                            Response.Write($"<td><a href=\"editQuiz.aspx?id={q.getQuizID()}\" class=\"btn btn-info btn-sm\"><span class=\"glyphicon glyphicon-pencil\"></span></a></td>");
                            Response.Write($"<td><a href=\"overallQuizResult.aspx?id={courseID}\" class=\"btn btn-warning btn-sm\"><span class=\"glyphicon glyphicon-stats\"></span></a></td>");
                            Response.Write("</tr>");
                        }
                    %>
                </tbody>
            </table>
        </form>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
