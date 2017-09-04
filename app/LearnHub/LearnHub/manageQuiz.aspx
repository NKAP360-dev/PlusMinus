<%@ Page Title="" Language="C#" MasterPageFile="~/Masterpage.Master" AutoEventWireup="true" CodeBehind="manageQuiz.aspx.cs" Inherits="LearnHub.manageQuiz" %>

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
        <li><a href="viewAllModule.aspx">Courses</a></li>
        <%int courseID = Convert.ToInt32(Request.QueryString["id"]); %>
        <li><a href="viewModuleInfo.aspx?id=<%=courseID%>">
            <asp:Label ID="lblBreadcrumbCourseName" runat="server" Text="courseName"></asp:Label></a></li>
        <li class="active">Manage Quizzes</li>
    </ul>

    <div class="container">
        <h1>Manage Quizzes</h1>
              <% 
                  User currentUser = (User)Session["currentUser"];
                  Course_elearnDAO ceDAO = new Course_elearnDAO();
                  Course_elearn currentCourse = ceDAO.get_course_by_id(courseID);
                  User courseCreator = currentCourse.getCourseCreator();
                  Boolean superuser = false;
                  foreach (string s in currentUser.getRoles())
                  {
                      if (s.Equals("superuser"))
                      {
                          superuser = true;
                          return;
                      }
                  }
                  if (currentUser != null && (currentUser.getUserID() == courseCreator.getUserID() || superuser))
                  {
              %>
            <a href="createQuiz.aspx?id=<%=courseID%>" class="btn btn-success">Add New Quiz</a>
        
         <div class="dropdown" style="float: right;">
                <button class="dropbtn" onclick="return false;"><span class="glyphicon glyphicon-option-horizontal"></span></button>
                <div class="dropdown-content" style="right: 0;">
                    <a href="manageQuiz.aspx?id=<%=courseID%>"><span class="glyphicon glyphicon-book"></span>&nbsp;&nbsp;Manage Quizzes</a>
                    <a href="createQuiz.aspx?id=<%=courseID%>"><span class="glyphicon glyphicon-plus"></span>&nbsp;&nbsp;Add New Quiz</a>
                </div>
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
