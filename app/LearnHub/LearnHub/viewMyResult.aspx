<%@ Page Title="" Language="C#" MasterPageFile="~/Masterpage.Master" AutoEventWireup="true" CodeBehind="viewMyResult.aspx.cs" Inherits="LearnHub.viewMyResult" %>

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
            
            <asp:Panel ID="panelViewResults" runat="server" Visible="true">
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
                            //Boolean userCorrect = false;
                            List<QuizAnswer> allAnswers = qaDAO.getAllQuizAnswersByQuizQuestionID(question.getQuizQuestionID());

                            Response.Write("<tr class=\"active\">");
                            Response.Write($"<td><strong>Question {counter++} </strong></td></tr>");
                            Response.Write($"<tr><td>{question.getQuestion()}</td></tr>");
                            Response.Write("<tr><td><asp:RadioButtonList ID=\"rblAnswers\" runat=\"server\">");
                            foreach (QuizAnswer possibleAnswer in allAnswers)
                            {
                                int userAnswerID = qrhDAO.getAllQuizAnswerIDByQuizIDandAttemptandQuestionIDandUserID(currentQuizResult.getAttempt(), currentQuiz.getQuizID(), question.getQuizQuestionID(), currentUser.getUserID());
                                Response.Write("<tr><td>");
                                if (possibleAnswer.getAnswer().Equals(question.getQuizAnswer().getAnswer()))
                                {
                                    Response.Write($"<input type=\"radio\" name=\"answers{counter}\"");
                                    /*
                                    if (possibleAnswer.getQuizAnswerID() == userAnswerID)
                                    {
                                        userCorrect = true;
                                    }*/
                                }
                                else
                                {
                                    Response.Write($"<input type=\"radio\" name=\"answers{counter}\"");
                                }
                                if (possibleAnswer.getQuizAnswerID() == userAnswerID)
                                {
                                    Response.Write(" checked=\"\" disabled>");
                                }
                                else
                                {
                                    Response.Write("disabled>");
                                }
                                Response.Write($"{possibleAnswer.getAnswer()}");
                            }
                            Response.Write("</td></tr>");
                            /*if (userCorrect)
                            {
                                Response.Write("<tr class=\"pull-right\"><td>Score: 1/1</td></tr>");
                            }
                            else
                            {
                                Response.Write("<tr class=\"pull-right\"><td>Score: 0/1</td></tr>");
                            }*/
                        }
                        %>
                    </tbody>
                </table>
            </asp:Panel>
            <%--****NEW PANEL****--%>
            <asp:Panel ID="panelNoResults" runat="server" Visible="false">
                <br /><br />
                <div class="alert alert-dismissible alert-warning">
                    <h4><b>There are no answers available for this quiz.</b></h4>
                    <p>
                        <span class="glyphicon glyphicon-info-sign"></span>&nbsp;
                        Course creator might have disabled viewing of answers for this quiz!
                    </p>
                </div>

            </asp:Panel>
        </div>
    </form>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
