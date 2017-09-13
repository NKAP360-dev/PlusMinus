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
                Course_elearnDAO ceDAO = new Course_elearnDAO();
                int courseID = Convert.ToInt32(Request.QueryString["id"]);
                User courseCreator = ceDAO.get_course_by_id(courseID).getCourseCreator();
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
                    <a href="manageQuiz.aspx?id=<%=courseID%>"><span class="glyphicon glyphicon-book"></span>&nbsp;&nbsp;Manage Quizzes</a>
                    <a href="createQuiz.aspx?id=<%=courseID%>"><span class="glyphicon glyphicon-plus"></span>&nbsp;&nbsp;Add New Quiz</a>
                </div>
            </div>

            <%} %>
            <div class="verticalLine"></div>
        </div>
        <div class="container">
            <h2>Quiz has been created</h2>
            <br />
            <%--Output question and answers--%>
            <table class="table">
                <tbody>
                    <tr class="active">
                        <td><strong>Question {counter++}</strong></td>
                    </tr>
                    <tr>
                        <td>Is watermelon good?</td>
                    </tr>
                    <tr>
                        <td>
                            <asp:RadioButtonList ID="rblAnswers" runat="server">
                                <asp:ListItem>yes</asp:ListItem>
                                <asp:ListItem>no</asp:ListItem>
                            </asp:RadioButtonList></td>
                    </tr>
                    <tr>
                        <td>
                            <div class="pull-right">
                                Correct Answer: Yes <%--either show option no. or direct ans, whatever is doable--%>
                            </div>
                        </td>
                    </tr>
                </tbody>
            </table>

            <a href="viewModuleInfo.aspx?id=<%=courseID%>" class="pull-left"><span class="glyphicon glyphicon-menu-left"></span>&nbsp;Back to Course</a>

        </div>
    </form>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
