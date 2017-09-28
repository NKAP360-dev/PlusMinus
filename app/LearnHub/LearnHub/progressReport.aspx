<%@ Page Title="" Language="C#" MasterPageFile="~/Masterpage.Master" AutoEventWireup="true" CodeBehind="progressReport.aspx.cs" Inherits="LearnHub.progressReport" %>

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

        .panel{
            margin-right: 15px;
        }

    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <ul class="breadcrumb">
        <li><a href="home.aspx">Home</a></li>
        <li class="active">Progress Report</li>
    </ul>

    <form runat="server" class="form-horizontal">
        <div class="container">
            <h1>My Progress Report</h1>
            <div class="verticalLine"></div>
            <br />
            <div class="row">
                <h1>&nbsp;Hi, 
                        <asp:Label ID="lblUsername" runat="server" Text="username"></asp:Label>
                </h1>
            </div>
            <br />
            <br />
            <div class="row">
                <div class="col-lg-6">
                    <div class="jumbotron">
                        <div class="row">
                            <div class="wrapper">
                                <h4>
                                    <label class="control-label">TOTAL NUMBER OF COURSES COMPLETED</label></h4>
                            </div>
                            <table class="table">
                                <tbody>
                                    <tr>
                                        <td><span style="font-size: 75px; color: lightskyblue;" class="glyphicon glyphicon-book "></span>
                                        </td>
                                        <td style="text-align: right">
                                            <asp:Label ID="lblCourseNumber" class="h1" runat="server" Text=""></asp:Label></td>
                                        <td style="text-align: right"><span style="font-size: 75px; opacity: 0.0;" class="glyphicon glyphicon-book "></span>
                                            <br />
                                            <a href="viewCompletedCourse.aspx"><span class="glyphicon glyphicon-menu-right"></span>&nbsp;View Courses</a>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                        <div class="verticalLine"></div>
                        <br />
                        <div class="row">
                            <div class="wrapper">
                                <h4>
                                    <label class="control-label">TOTAL NUMBER OF QUIZZES COMPLETED</label></h4>
                            </div>
                            <table class="table">
                                <tbody>
                                    <tr>
                                        <td><span style="font-size: 75px; color: lightskyblue;" class="glyphicon glyphicon-check"></span>
                                        </td>
                                        <td style="text-align: right">
                                            <asp:Label ID="lblQuizNumber" class="h1" runat="server" Text=""></asp:Label></td>
                                        <td style="text-align: right"><span style="font-size: 75px; opacity: 0.0;" class="glyphicon glyphicon-check"></span>
                                            <br />
                                            <a href="viewCompletedQuiz.aspx"><span class="glyphicon glyphicon-menu-right"></span>&nbsp;View Quizzes</a>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4">
                    <div class="row">
                        <div class="panel panel-primary">
                            <div class="panel-heading">
                                <h3 class="panel-title">List of Suggested Courses</h3>
                            </div>
                            <div class="panel-body">
                                <%
                                    Course_elearnDAO ceDAO = new Course_elearnDAO();
                                    User currentUser = (User)Session["currentUser"];
                                    List<int> allSuggestedCourseID = ceDAO.getAllSuggestedCoursesByUserID(currentUser.getUserID());
                                    if (allSuggestedCourseID.Count > 0)
                                    {
                                        Response.Write("<ul>");
                                        foreach (int courseID in allSuggestedCourseID)
                                        {
                                            Course_elearn currentCourse = ceDAO.get_course_by_id(courseID);
                                            Response.Write($"<li><a href=\"viewModuleInfo.aspx?id={courseID}\">{currentCourse.getCourseName()}</a></li>");
                                        }
                                        Response.Write("</ul>");
                                    }
                                    else
                                    {
                                        Response.Write("There are no suggested courses available.");
                                    }
                                %>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="panel panel-primary">
                            <div class="panel-heading">
                                <h3 class="panel-title">Feedback</h3>
                            </div>
                            <div class="panel-body">
                                <%
                                    SupervisorFeedbackDAO sfDAO = new SupervisorFeedbackDAO();
                                    List<SupervisorFeedback> allFeedbacks = sfDAO.getAllUserFeedback(currentUser.getUserID());
                                    int counter = 1;
                                    if (allFeedbacks.Count < 1)
                                    {
                                        Response.Write("There are no feedbacks available.");
                                    }
                                    else
                                    {
                                        foreach (SupervisorFeedback sf in allFeedbacks)
                                        {
                                            Response.Write($"<h5><b>{sf.title}</b></h5>");
                                            Response.Write(sf.feedback);
                                            Response.Write($"<br /><h5 class=\"pull-right\">By: {sf.userFrom.getName()}</h5><br />");

                                            if (counter != allFeedbacks.Count)
                                            {
                                                Response.Write("<hr />");
                                            }
                                            counter++;
                                        }
                                    }

                                %>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-2">
                    <div class="row">
                        <a href="viewAllModule.aspx">
                            <div class="col-lg-12 btn-success">
                                <br />
                                <br />
                                <div class="wrapper">
                                    <span style="font-size: 30px;" class="glyphicon glyphicon-book"></span>
                                    <h4>View Courses</h4>
                                    <br />
                                </div>
                            </div>
                        </a>
                        <a href="usefulInfo.aspx">
                            <div class="col-lg-12 btn-warning">
                                <br />
                                <br />
                                <div class="wrapper">
                                    <span style="font-size: 30px;" class="glyphicon glyphicon-info-sign"></span>
                                    <h4>Useful Information</h4>
                                    <br />
                                </div>
                            </div>
                        </a>
                        <a href="accountSetting.aspx">
                            <div class="col-lg-12 btn-info">
                                <br />
                                <br />
                                <div class="wrapper">
                                    <span style="font-size: 30px;" class="glyphicon glyphicon-cog"></span>
                                    <h4>Account Settings</h4>
                                    <br />
                                </div>
                            </div>
                        </a>
                        <%
                            UserDAO userDAO = new UserDAO();
                            if (currentUser.getRoles().Contains("superuser") || userDAO.checkIfUserIsSupervisor(currentUser.getUserID()))
                            {
                        %>
                         <a href="manageProgress.aspx">
                              <div class="col-lg-12 btn-primary">
                                <br />
                                <br />
                                <div class="wrapper">
                                    <span style="font-size: 30px;" class="glyphicon glyphicon-duplicate"></span>
                                    <h4>Subordinate's Progress Report</h4>
                                    <br />
                                </div>
                            </div>
                        </a>
                        <%} %>
                    </div>
                </div>
            </div>
        </div>
    </form>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
