<%@ Page Title="" Language="C#" MasterPageFile="~/Masterpage.Master" AutoEventWireup="true" CodeBehind="noResult.aspx.cs" Inherits="LearnHub.noResult" %>

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
                <asp:Label ID="lblScore" runat="server" CssClass="label label-default" Font-Size="Large" Text="" />&emsp;
                <strong>%:</strong>&nbsp;
                <asp:Label ID="lblPercent" runat="server" CssClass="label label-success" Font-Size="Large" Text="" />
            </div>

            <br />
            <br />
            <div class="alert alert-dismissible alert-warning">
                <h4><b>There are no answers available for this quiz.</b></h4>
                <p>
                    <span class="glyphicon glyphicon-info-sign"></span>&nbsp;
                        Course creator might have disabled viewing of answers for this quiz!
                </p>
            </div>
        </div>
    </form>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
