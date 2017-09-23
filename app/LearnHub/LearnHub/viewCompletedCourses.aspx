<%@ Page Title="" Language="C#" MasterPageFile="~/Masterpage.Master" AutoEventWireup="true" CodeBehind="viewCompletedCourses.aspx.cs" Inherits="LearnHub.viewCompletedCourses" %>

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

    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <ul class="breadcrumb">
        <li><a href="home.aspx">Home</a></li>
        <li><a href="progressReport.aspx">Progress Report</a></li>
        <li><a href="manageProgress.aspx">Manage Progress Report</a></li>
        <%UserDAO userDAO = new UserDAO();
                User user = userDAO.getUserByID((String)Request.QueryString["id"]); %>
        <li><a href="progressReports.aspx?id=<%=user.getUserID()%>"><%=user.getName() %> - Progress Report</a></li>
        <li class="active"><%=user.getName() %> - Completed Courses</li>
    </ul>

    <div class="container">
        <h1><%=user.getName() %> -  Completed Courses</h1>
        <div class="verticalLine"></div>

         <form runat="server">
        <table class="table table-striped table-hover" data-paging="true" data-sorting="true" data-filtering="true">
            <thead>
                <tr>
                    <th width="80%">Course Title</th>
                    <th>No. of Quizzes Completed</th> <%--excluding attempts--%>
                    <th data-filterable="false" data-sortable="false"></th>
                </tr>
            </thead>
            <tbody>
            <%
                List<int> allCompletedCourseID = (List<int>)Session["allCompletedCourseID"];
                UserDAO userDAO = new UserDAO();
                User currentUser = userDAO.getUserByID((String)Request.QueryString["id"]);
                Course_elearnDAO ceDAO = new Course_elearnDAO();
                QuizResultDAO qrDAO = new QuizResultDAO();
                foreach (int courseID in allCompletedCourseID)
                {
                    Course_elearn currentCourse = ceDAO.get_course_by_id(courseID);

                    //count number of quizzes completed for each course
                    int numOfQuizCompleted = qrDAO.getNumberOfPassQuizByUserIDandCourseID(currentUser.getUserID(), courseID);
                    Response.Write($"<tr>");
                    Response.Write($"<td>{currentCourse.getCourseName()}</td>");
                    Response.Write($"<td>{numOfQuizCompleted}</td>");
                    Response.Write($"<td><a href=\"viewModuleInfo.aspx?id={courseID}\" class=\"btn btn-success btn-sm\"><span class=\"glyphicon glyphicon-search\"></span></a></td>");
                    Response.Write($"</tr>");
                }
            %>
                </tbody>
            </table>
        </form>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
