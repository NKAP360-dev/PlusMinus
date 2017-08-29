<%@ Page Title="" Language="C#" MasterPageFile="~/Masterpage.Master" AutoEventWireup="true" CodeBehind="viewResults.aspx.cs" Inherits="LearnHub.viewResults" %>

<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="LearnHub.AppCode.dao" %>
<%@ Import Namespace="LearnHub.AppCode.entity" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
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
        <%
            QuizResultDAO qrDAO = new QuizResultDAO();
            int quizResultID = Convert.ToInt32(Request.QueryString["id"]);
            QuizResult currentQuizResult = qrDAO.getQuizResultByID(quizResultID);
            int courseID = currentQuizResult.getQuiz().getMainCourse().getCourseID();
        %>
        <li><a href="viewModuleInfo.aspx?id=<%=courseID%>">
            <asp:Label ID="lblBreadcrumbCourseName" runat="server" Text="courseName"></asp:Label></a></li>
        <li class="active">View Quiz Results</li>
    </ul>

    <form class="form-horizontal" runat="server">
        <div class="container">

            <h1>View Quiz Results</h1>
            <h4>Attempt 
            <asp:Label ID="lblAttemptNo" runat="server" Text=""></asp:Label>
                -
            <asp:Label ID="lblQuizDate" runat="server" Text=""></asp:Label>

            </h4>
            <div class="verticalLine"></div>
            <br />
        </div>

        <div class="container">
            <div class="pull-right">
                <strong>Status:</strong>&nbsp;
                <asp:Label ID="lblStatusPass" runat="server" CssClass="label label-success" Font-Size="Large" Visible="false">Pass</asp:Label>
                <asp:Label ID="lblStatusFail" runat="server" CssClass="label label-danger" Font-Size="Large" Visible="false">Fail</asp:Label>&emsp;
                <strong>Quiz Score:</strong>&nbsp; 
                <asp:Label ID="lblScore" runat="server" CssClass="label label-default" Font-Size="Large" Text="" />
            </div>
            <br />
            <br />
            <br />
            <table class="table">
                <tbody>
                    <%
                        User currentUser = (User)Session["currentUser"];
                        QuizResultDAO qrDAO = new QuizResultDAO();
                        QuizDAO quizDAO = new QuizDAO();
                        QuizQuestionDAO qqDAO = new QuizQuestionDAO();
                        QuizAnswerDAO qaDAO = new QuizAnswerDAO();
                        QuizResultHistoryDAO qrhDAO = new QuizResultHistoryDAO();
                        int quizResultID = Convert.ToInt32(Request.QueryString["id"]);
                        QuizResult currentQuizResult = qrDAO.getQuizResultByID(quizResultID);
                        Quiz currentQuiz = currentQuizResult.getQuiz();
                        List<QuizQuestion> allQuestions = qqDAO.getAllQuizQuestionByQuizID(currentQuiz.getQuizID());
                        int counter = 1;

                        foreach(QuizQuestion question in allQuestions)
                        {
                            Boolean userCorrect = false;
                            List<QuizAnswer> allAnswers = qaDAO.getAllQuizAnswersByQuizQuestionID(question.getQuizQuestionID());

                            Response.Write("<tr class=\"active\">");
                            Response.Write($"<td><strong>Question {counter++} </strong></td></tr>");
                            Response.Write($"<tr><td>{question.getQuestion()}</td></tr>");
                            Response.Write("<tr><td><asp:RadioButtonList ID=\"rblAnswers\" runat=\"server\">");
                            foreach (QuizAnswer possibleAnswer in allAnswers)
                            {
                                int userAnswerID = qrhDAO.getAllQuizAnswerIDByQuizIDandAttemptandQuestionIDandUserID(currentQuizResult.getAttempt(), currentQuiz.getQuizID(), question.getQuizQuestionID(), currentUser.getUserID());
                                Response.Write("<tr><td><label style=\"color: ");
                                if (possibleAnswer.getAnswer().Equals(question.getQuizAnswer().getAnswer()))
                                {
                                    Response.Write($"lightseagreen\"><input type=\"radio\" name=\"answers{counter}\"");
                                    
                                    if (possibleAnswer.getQuizAnswerID() == userAnswerID)
                                    {
                                        userCorrect = true;
                                    }
                                }
                                else
                                {
                                    Response.Write($"tomato\"><input type=\"radio\" name=\"answers{counter}\"");
                                }
                                if (possibleAnswer.getQuizAnswerID() == userAnswerID)
                                {
                                    Response.Write(" checked=\"\" disabled>");
                                }
                                else
                                {
                                    Response.Write("disabled>");
                                }
                                Response.Write($"{possibleAnswer.getAnswer()}</label>");
                            }
                            Response.Write("</td></tr>");
                            if (userCorrect)
                            {
                                Response.Write("<tr class=\"pull-right\"><td>Score: 1/1</td></tr>");
                            }
                            else
                            {
                                Response.Write("<tr class=\"pull-right\"><td>Score: 0/1</td></tr>");
                            }
                        }
                        %>
                    </tbody>
                </table>
            <br /><br />
            <div class="pull-right">
                <button type="button" onclick="javascript:history.back()" class="btn btn-primary"><span class="glyphicon glyphicon-chevron-left"></span>&nbsp;Back to Quiz Attempts</button>
            </div>
        </div>
    </form>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
