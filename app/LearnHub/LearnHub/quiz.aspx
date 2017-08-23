<%@ Page Title="" Language="C#" MasterPageFile="~/Masterpage.Master" AutoEventWireup="true" CodeBehind="quiz.aspx.cs" Inherits="LearnHub.quiz" %>

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
    <form id="form1" runat="server">
        <ul class="breadcrumb">
            <li><a href="home.aspx">Home</a></li>
            <li><a href="viewAllModule.aspx">Modules</a></li>
            <%int courseID = Convert.ToInt32(Request.QueryString["id"]); %>
            <li><a href="viewModuleInfo.aspx?id=<%=courseID%>">
                <asp:Label ID="lblBreadcrumbCourseName" runat="server" Text="courseName"></asp:Label></a></li>
            <li class="active">Attempt Quiz</li>
        </ul>

        <div class="container">
            <h1>Attempt Quiz</h1>
            <h4>
                <asp:Label ID="lblQuizTitle" runat="server" Text="Washing Hands Part One"></asp:Label></h4>
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
                                    00:00
                                </h3>

                                <h4>Total Number of Questions: 
                                    <asp:Label ID="lblTotalNumQn" runat="server" Text="10"></asp:Label>
                                </h4>

                            </div>
                        </div>
                        <br />
                        <asp:Label ID="lblQuizDesc" runat="server" Text="">Quiz Description here... blahblahblah.. <br /> Instruction: blahblah..</asp:Label>
                        <br />
                        <div class="wrapper">
                            <asp:LinkButton ID="btnStartQuiz" runat="server" OnClick="btnStartQuiz_Click" CssClass="btn btn-lg btn-primary"><span class="glyphicon glyphicon-chevron-right"></span> &nbsp;Start Quiz</asp:LinkButton>

                        </div>


                    </asp:Panel>
                    <asp:Panel ID="panelQuiz" runat="server" Visible="false">
                        <div class="wrapper">
                            <div class="row">

                                <h3>Time left: 
                                    00:00
                                </h3>

                                <h4>Question Number: 
                                    <asp:Label ID="lblQnNum" Text="1" runat="server"></asp:Label>
                                    /
                                    <asp:Label ID="lblTotalQn" Text="10" runat="server"></asp:Label>
                                </h4>

                            </div>
                        </div>
                        <br />
                        <table class="table">
                            <tbody>
                                <tr class="active">
                                    <td><strong>
                                        <asp:Label ID="lblQuestion" runat="server">What is the nicest fruit on earth?</asp:Label></strong></td>

                                </tr>
                                <tr>
                                    <td>
                                        <asp:RadioButtonList ID="rblAnswers" runat="server">
                                            <asp:ListItem Text="Watermelon"></asp:ListItem>
                                            <asp:ListItem Text="Pineapple"></asp:ListItem>
                                            <asp:ListItem Text="Orange"></asp:ListItem>
                                            <asp:ListItem Text="Apple"></asp:ListItem>
                                        </asp:RadioButtonList>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                        <br />
                        <div class="pull-right">
                            <%--If got more qn, show btnNext, if last qn, show btnFinish--%>
                        <asp:LinkButton ID="btnFinish" runat="server" CssClass="btn btn-primary"><span class="glyphicon glyphicon-glyphicon glyphicon-ok"></span> &nbsp;Finish Quiz</asp:LinkButton>
                        <asp:LinkButton ID="btnNext" runat="server" CssClass="btn btn-primary"><span class="glyphicon glyphicon-chevron-right"></span> &nbsp;Next Question</asp:LinkButton>

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
