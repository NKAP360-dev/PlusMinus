<%@ Page Title="" Language="C#" MasterPageFile="~/Masterpage.Master" AutoEventWireup="true" CodeBehind="viewCompletedQuizzes.aspx.cs" Inherits="LearnHub.viewCompletedQuizzes" %>

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
        <li><a href="manageProgress.aspx">Manage Progress Report</a></li>
        <%UserDAO userDAO = new UserDAO();
                User user = userDAO.getUserByID((String)Request.QueryString["id"]); %>
        <li><a href="progressReports.aspx?id=<%=user.getUserID()%>"><%=user.getName() %> - Progress Report</a></li>
        <li class="active"><%=user.getName() %> - Completed Quizzes</li>
    </ul>

    <div class="container">
        <h1><%=user.getName() %> -  Completed Quizzes</h1>
        <div class="verticalLine"></div>
          <form runat="server">
        <table class="table table-striped table-hover" data-paging="true" data-sorting="true" data-filtering="true">
            <thead>
                <tr>
                    <th width="50%">Quiz Title</th>
                    <th>Course Name</th>
                    <th>Score</th> <%--take highest of all attempt--%>
                    <th>Result</th> <%--pass/fail--%>
                    <th data-filterable="false" data-sortable="false"></th>
                </tr>
            </thead>
                <tbody>

                    <%
                        UserDAO userDAO = new UserDAO();
                        User currentUser = userDAO.getUserByID((String)Request.QueryString["id"]);
                        QuizDAO quizDAO = new QuizDAO();
                        QuizResultDAO qrDAO = new QuizResultDAO();
                        QuizQuestionDAO qqDAO = new QuizQuestionDAO();
                        List<Quiz> allQuiz = quizDAO.getAllQuiz();
                        foreach (Quiz currentQuiz in allQuiz)
                        {
                            if (qrDAO.getAttemptForQuiz(currentQuiz.getQuizID(), currentUser.getUserID()) != 0)
                            {
                                Response.Write("<tr>");
                                Response.Write($"<td>{currentQuiz.getTitle()}</td>");
                                Response.Write($"<td>{currentQuiz.getMainCourse().getCourseName()}</td>");
                                ArrayList allResultForQuiz = qrDAO.getAllQuizResultByQuizID(currentQuiz.getQuizID());
                                List<QuizQuestion> allQuestions = qqDAO.getAllQuizQuestionByQuizID(currentQuiz.getQuizID());
                                string displayAnswer = currentQuiz.getDisplayAnswer();
                                if (allResultForQuiz.Count > 1)
                                {
                                    //retrieve highest score of the attempts
                                    QuizResult highestAttempt = null;
                                    foreach (QuizResult checkAttempt in allResultForQuiz)
                                    {
                                        if (highestAttempt == null)
                                        {
                                            highestAttempt = checkAttempt;
                                        }
                                        else
                                        {
                                            if (checkAttempt.getScore() > highestAttempt.getScore())
                                            {
                                                highestAttempt = checkAttempt;
                                            }
                                        }
                                    }

                                    //display attempt
                                    Response.Write($"<td>{highestAttempt.getScore()}/{allQuestions.Count}</td>");
                                    if (highestAttempt.getGrade().Equals("pass"))
                                    {
                                        Response.Write("<td><span style=\"font-size: 10pt\" class=\"label label-success\">Pass</span></td>");
                                    }
                                    else
                                    {
                                        Response.Write("<td><span style=\"font-size: 10pt\" class=\"label label-danger\">Pass</span></td>");
                                    }
                                    
                                    //always show result
                                    Response.Write($"<td><a href=\"viewResults.aspx?id={highestAttempt.getQuizResultID()}\" class=\"btn btn-success btn-sm\"><span class=\"glyphicon glyphicon-search\"></span></a></td>");
                                    
                                }
                                else
                                {
                                    //only attempt
                                    QuizResult onlyResult = (QuizResult)allResultForQuiz[0];
                                    Response.Write($"<td>{onlyResult.getScore()}/{allQuestions.Count}</td>");
                                    if (onlyResult.getGrade().Equals("pass"))
                                    {
                                        Response.Write("<td><span style=\"font-size: 10pt\" class=\"label label-success\">Pass</span></td>");
                                    }
                                    else
                                    {
                                        Response.Write("<td><span style=\"font-size: 10pt\" class=\"label label-danger\">Pass</span></td>");
                                    }

                                    //always show result
                                    Response.Write($"<td><a href=\"viewResults.aspx?id={onlyResult.getQuizResultID()}\" class=\"btn btn-success btn-sm\"><span class=\"glyphicon glyphicon-search\"></span></a></td>");
                                    
                                }

                                Response.Write("</tr>");
                            }
                        }
                    %>
                    
                </tbody>
            </table>
        </form>

    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
