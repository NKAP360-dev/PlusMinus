<%@ Page Title="" Language="C#" MasterPageFile="~/Masterpage.Master" AutoEventWireup="true" CodeBehind="quiz.aspx.cs" Inherits="LearnHub.quiz" %>

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
    <form id="form1" runat="server">
        <ul class="breadcrumb">
            <li><a href="home.aspx">Home</a></li>
            <li><a href="viewAllModule.aspx">Modules</a></li>
            <% QuizDAO qDAO = new QuizDAO();
                int quizID = Convert.ToInt32(Request.QueryString["id"]);
                Quiz q = qDAO.getQuizByID(quizID);
                int courseID = q.getMainCourse().getCourseID();%>
            <li><a href="viewModuleInfo.aspx?id=<%=courseID%>">
                <asp:Label ID="lblBreadcrumbCourseName" runat="server" Text="courseName"></asp:Label></a></li>
            <li class="active">Attempt Quiz</li>
        </ul>

        <div class="container">
            <h1>Attempt Quiz</h1>
            <h4>
                <asp:Label ID="lblQuizTitle" runat="server" Text=""></asp:Label></h4>
            <div class="verticalLine">
            </div>
        </div>

        <div class="container">
            <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                    <asp:Panel ID="panelStartQuiz" runat="server" Visible="true">

                        <div class="wrapper">
                            <div class="row">

                                <h3>Time left: 
                                     <asp:Label ID="lblTimerDisplay" runat="server" Text=""></asp:Label>
                                </h3>

                                <h4>Total Number of Questions: 
                                    <asp:Label ID="lblTotalNumQn" runat="server" Text=""></asp:Label>
                                </h4>

                            </div>
                        </div>
                        <br />
                        <b>Description:</b>
                        <br />
                        <asp:Label ID="lblQuizDesc" runat="server" Text="" />
                        <br />
                        <b>Passing requirements:</b>
                        <br />
                        <asp:Label ID="lblPassingReq" runat="server" Text="" />
                        <br />
                        <br />
                        <b>Instruction:</b>
                        <br />
                        Please select start to begin the quiz. Timer will begin when "Start Quiz" is pressed. Please do not leave the page until completion of quiz. All the best!
                        <br />
                        <br />
                        <b>Maximum attempt:</b>
                        <br />
                        <asp:Label ID="lblMaxAttempt" runat="server" Text="" />
                        <br />
                        <br />
                        <div class="wrapper">
                            <asp:LinkButton ID="btnStartQuiz" runat="server" OnClick="btnStartQuiz_Click" CssClass="btn btn-lg btn-primary"><span class="glyphicon glyphicon-menu-right"></span> &nbsp;Start Quiz</asp:LinkButton>

                        </div>


                    </asp:Panel>
                    <asp:Panel ID="panelQuiz" runat="server" Visible="false">
                        <div class="wrapper">
                            <div class="row">

                                <h3>Time left: 
                                    <asp:Label ID="lblTimer" runat="server" Text=""></asp:Label>
                                    <asp:Timer ID="Timer1" runat="server" Interval="1000" OnTick="Timer1_Tick"></asp:Timer>
                                </h3>

                                <h4>Question Number: 
                                    <asp:Label ID="lblQnNum" Text="" runat="server"></asp:Label>
                                    /
                                    <asp:Label ID="lblTotalQn" Text="" runat="server"></asp:Label>
                                </h4>

                            </div>
                        </div>
                        <br />
                        <table class="table">
                            <tbody>
                                <tr class="active">
                                    <td><strong>
                                        <asp:Label ID="lblQuestion" runat="server" Text="" /></strong></td>

                                </tr>
                                <tr>
                                    <td>
                                        <asp:RadioButtonList ID="rblAnswers" runat="server">
                                        </asp:RadioButtonList>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                        <br />
                        <div class="pull-right">
                            <%--If got more qn, show btnNext, if last qn, show btnFinish--%>
                            <asp:LinkButton ID="btnFinish" runat="server" CssClass="btn btn-primary" OnClick="btnFinish_Click"><span class="glyphicon glyphicon-glyphicon glyphicon-ok"></span> &nbsp;Finish Quiz</asp:LinkButton>
                            <asp:LinkButton ID="btnNext" runat="server" CssClass="btn btn-primary" OnClick="btnNext_Click"><span class="glyphicon glyphicon-chevron-right"></span> &nbsp;Next Question</asp:LinkButton>

                        </div>

                    </asp:Panel>
                    <%--****NEW PANEL****--%>
                    <asp:Panel ID="panelTimesUp" runat="server" Visible="false">
                        <div class="wrapper">
                            <h3>Time left: 
                                     <asp:Label ID="lblTimesUp" runat="server" Text="00:00:00" ForeColor="red"></asp:Label>
                            </h3>
                            <br />
                            <h1>Quiz has ended!</h1>
                            <br />
                            <br />
                            <br />
                            <%--If unlimited attempts or still have attempts left, show button and Visible=True for panelStartQuiz--%>
                            <asp:LinkButton ID="btnRestartQuiz" runat="server" CssClass="btn btn-lg btn-primary">Re-attempt Quiz</asp:LinkButton><br />
                            <br />
                            <asp:LinkButton ID="btnViewResults" runat="server" CssClass="pull-right">View Results&nbsp;<span class="glyphicon glyphicon-menu-right"></span></asp:LinkButton>
                            <% QuizDAO qDAO = new QuizDAO();
                                int quizID = Convert.ToInt32(Request.QueryString["id"]);
                                Quiz q = qDAO.getQuizByID(quizID);
                                int courseID = q.getMainCourse().getCourseID();%>
                            <a href="viewModuleInfo.aspx?id=<%=courseID%>" class="pull-left"><span class="glyphicon glyphicon-menu-left"></span>&nbsp;Back to Course</a>

                        </div>
                    </asp:Panel>
                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="btnStartQuiz" EventName="Click" />
                </Triggers>
            </asp:UpdatePanel>
        </div>
    </form>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
