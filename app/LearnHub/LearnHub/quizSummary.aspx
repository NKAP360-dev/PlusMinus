<%@ Page Title="" Language="C#" MasterPageFile="~/Masterpage.Master" AutoEventWireup="true" CodeBehind="quizSummary.aspx.cs" Inherits="LearnHub.quizSummary" %>

<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="LearnHub.AppCode.dao" %>
<%@ Import Namespace="LearnHub.AppCode.entity" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
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
        <li><a href="createQuiz.aspx?id=<%=courseID%>">Create Quiz</a></li>
        <li class="active">Questions and Answers</li>
    </ul>

    <form runat="server" class="form-horizontal">
        <div class="container">
            <h1>Summary</h1>
            <% 
                User currentUser = (User)Session["currentUser"];
                QuizDAO quizDAO = new QuizDAO();
                int quizID = Convert.ToInt32(Request.QueryString["id"]);
                Quiz currentQuiz = quizDAO.getQuizByID(quizID);
                Course_elearn currentCourse = currentQuiz.getMainCourse();
                User courseCreator = currentCourse.getCourseCreator();
                Boolean superuser = false;
                foreach (string s in currentUser.getRoles())
                {
                    if (s.Equals("superuser"))
                    {
                        superuser = true;
                    }
                }
                if (currentUser != null && (currentUser.getUserID() == courseCreator.getUserID() || superuser))
                {
            %>

            <div class="dropdown" style="float: right;">
                <button class="dropbtn" onclick="return false;"><span class="glyphicon glyphicon-option-horizontal"></span></button>
                <div class="dropdown-content" style="right: 0;">
                    <a href="manageQuiz.aspx?id=<%=currentCourse.getCourseID()%>"><span class="glyphicon glyphicon-book"></span>&nbsp;&nbsp;Manage Quizzes</a>
                    <a href="createQuiz.aspx?id=<%=currentCourse.getCourseID()%>"><span class="glyphicon glyphicon-plus"></span>&nbsp;&nbsp;Add New Quiz</a>
                </div>
            </div>

            <%} %>
            <div class="verticalLine"></div>
        </div>
        <div class="container">
            <h2>Quiz has been created</h2>
            <br />

            <table class="table">
                <tbody>
            <%
                QuizResultDAO qrDAO = new QuizResultDAO();
                QuizQuestionDAO qqDAO = new QuizQuestionDAO();
                QuizAnswerDAO qaDAO = new QuizAnswerDAO();
                QuizResultHistoryDAO qrhDAO = new QuizResultHistoryDAO();
                List<QuizQuestion> allQuestions = qqDAO.getAllQuizQuestionByQuizID(currentQuiz.getQuizID());
                int counter = 1;    

                foreach (QuizQuestion question in allQuestions)
                {
                    List<QuizAnswer> allAnswers = qaDAO.getAllQuizAnswersByQuizQuestionID(question.getQuizQuestionID());

                    Response.Write("<tr class=\"active\">");
                    Response.Write($"<td><strong>Question {counter++} </strong></td></tr>");
                    Response.Write($"<tr><td>{question.getQuestion()}</td></tr>");
                    Response.Write("<tr><td><asp:RadioButtonList ID=\"rblAnswers\" runat=\"server\">");
                    foreach (QuizAnswer possibleAnswer in allAnswers)
                    {
                        Response.Write("<tr><td><label");
                        if (possibleAnswer.getAnswer().Equals(question.getQuizAnswer().getAnswer()))
                        {
                            Response.Write($" style=\"color: lightseagreen\"><input type=\"radio\" name=\"answers{counter}\"");
                        }
                        else
                        {
                            Response.Write($"><input type=\"radio\" name=\"answers{counter}\"");
                        }
                        Response.Write("disabled>");
                        Response.Write($"{possibleAnswer.getAnswer()}</label>");
                    }
                    Response.Write("</td></tr>");
                    Response.Write($"<tr class=\"pull-right\"><td>Correct Answer: {question.getQuizAnswer().getAnswer()}</td></tr>");
                }
            %>
                    </tbody>
                </table>

            <a href="viewModuleInfo.aspx?id=<%=currentCourse.getCourseID()%>" class="pull-left"><span class="glyphicon glyphicon-menu-left"></span>&nbsp;Back to Course</a>

        </div>
    </form>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
