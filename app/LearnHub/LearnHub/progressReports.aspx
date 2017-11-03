<%@ Page Title="" Language="C#" MasterPageFile="~/Masterpage.Master" AutoEventWireup="true" CodeBehind="progressReports.aspx.cs" Inherits="LearnHub.progressReports" %>


<%@ Register Assembly="CKEditor.NET" Namespace="CKEditor.NET" TagPrefix="CKEditor" %>


<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="LearnHub.AppCode.dao" %>
<%@ Import Namespace="LearnHub.AppCode.entity" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="//cdn.ckeditor.com/4.7.3/full/ckeditor.js"></script>
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
    <script type="text/javascript">
        function ValidateFeedbackDescription(sender, args) {
            console.log("enter fbd");
            var feedbackDescription = document.getElementById("<%= CKEditorControl2.ClientID %>").value;
            if (feedbackDescription == "") {
                console.log("no desc");
                args.IsValid = false;
            }
            else {
                console.log("Yes desc");
                args.IsValid = true;
            }
        }

        function showDiv() {
            if (document.getElementById) {
                document.getElementById('addFeedback').style.display = 'block';
            }
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <ul class="breadcrumb">
        <li><a href="home.aspx">Home</a></li>
        <li><a href="progressReport.aspx">Progress Report</a></li>
        <li><a href="manageProgress.aspx">Manage Progress Report</a></li>
        <li class="active"><asp:Label ID="lblUsernameBC" runat="server" Text="username"></asp:Label> - Progress Report</li>
    </ul>

    <form runat="server" class="form-horizontal">
        <% string userID = (String)Request.QueryString["id"]; %>
        <div class="container">
            <h1><asp:Label ID="lblUsername" runat="server" Text="username"></asp:Label> - Progress Report</h1>
            <div class="dropdown" style="float: right;">
                <button class="dropbtn" onclick="return false;"><span class="glyphicon glyphicon-option-horizontal"></span></button>
                <div class="dropdown-content" style="right: 0;">
                    <div class="dropHeader">Progress Management</div>
                    <a href="manageProgress.aspx"><span class="glyphicon glyphicon-duplicate"></span>&nbsp&nbsp; Manage Progress Reports</a>
                    <a href="suggestCourses.aspx?id=<%=userID %>"><span class="glyphicon glyphicon-comment"></span>&nbsp;&nbsp;Suggest Courses</a>
                </div>
            </div>
            <div class="verticalLine"></div>
            <br />
           
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
                                        <td><span style="font-size: 75px; color: darkslategray;" class="glyphicon glyphicon-book "></span>
                                        </td>
                                        <td style="text-align: right">
                                            <a href="viewCompletedCourses.aspx?id=<%=userID %>"><asp:Label ID="lblCourseNumber" class="h1" runat="server" Text=""></asp:Label></a></td>
                                        <td style="text-align: right"><span style="font-size: 75px; opacity: 0.0;" class="glyphicon glyphicon-book "></span>
                                            <br />
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
                                        <td><span style="font-size: 75px; color: darkslategray;" class="glyphicon glyphicon-check"></span>
                                        </td>
                                        <td style="text-align: right">
                                            <a href="viewCompletedQuizzes.aspx?id=<%=userID %>"><asp:Label ID="lblQuizNumber" class="h1" runat="server" Text=""></asp:Label></a></td>
                                        <td style="text-align: right"><span style="font-size: 75px; opacity: 0.0;" class="glyphicon glyphicon-check"></span>
                                            <br />
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
                                    <label class="control-label">TOTAL LEARNING HOURS</label></h4>
                            </div>
                            <table class="table">
                                <tbody>
                                    <tr>
                                        <td><span style="font-size: 75px; color: darkslategray;" class="glyphicon glyphicon-time"></span>
                                        </td>
                                        <td style="text-align: right">
                                            <asp:Label ID="lblHours" class="h1" runat="server" Text="0"></asp:Label></td>&emsp;&emsp;
                                        <td style="text-align: right"><span style="font-size: 75px; opacity: 0.0;" class="glyphicon glyphicon-time"></span>
                                            <br />
                                            
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
                                    List<int> allSuggestedCourseID = ceDAO.getAllSuggestedCoursesByUserID(userID);
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
                                <h3 class="panel-title">Feedback<a href="javascript:void(0);" data-toggle="collapse" data-target="#addFeedback"><span class="label label-default pull-right">

                                    <span class="glyphicon glyphicon-pencil"></span></span></a></h3>
                            </div>
                            <div class="panel-body">
                                <div class="collapse" id="addFeedback">
                                    <h4><strong>Add New Feedback</strong></h4>
                                    <fieldset>
                                        <div class="form-group">
                                            <div class="col-lg-12">
                                                <asp:TextBox ID="txtFeedback" runat="server" CssClass="form-control" placeholder="Feedback"></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="rfv_txtFeedback" runat="server" ErrorMessage="Required*" ControlToValidate="txtFeedback" ForeColor="Red" ValidationGroup="ValidateForm" Display="Dynamic"></asp:RequiredFieldValidator>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <div class="col-lg-12">
                                                <CKEditor:CKEditorControl ID="CKEditorControl2" runat="server">
                                                </CKEditor:CKEditorControl>
                                                <asp:CustomValidator ID="cv_txtFeedbackDesc" runat="server" EnableClientScript="true" ErrorMessage="Required*" ClientValidationFunction="ValidateFeedbackDescription" ForeColor="Red" ValidationGroup="ValidateForm" ></asp:CustomValidator>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <div class="col-lg-10">
                                                <asp:Button ID="cfmSubmit" CssClass="btn btn-primary" runat="server" Text="Submit" OnClick="cfmSubmit_Click" ValidationGroup="ValidateForm"/>
                                            </div>
                                        </div>

                                    </fieldset>

                                    <hr />
                                </div>
                                <asp:Label ID="lblErrorMsg" runat="server" Visible="false" ForeColor="Red"></asp:Label>
                                <%
                                    User currentUser = (User)Session["currentUser"];
                                    SupervisorFeedbackDAO sfDAO = new SupervisorFeedbackDAO();
                                    List<SupervisorFeedback> allFeedbacks = sfDAO.getAllUserFeedback(userID);
                                    int counter = 1;
                                    if (allFeedbacks.Count < 1)
                                    {
                                        Response.Write("There are no feedbacks available.");
                                    }
                                    else
                                    {
                                        foreach (SupervisorFeedback sf in allFeedbacks)
                                        {
                                            Response.Write($"<h5><b>{sf.title}</b>");
                                            if (sf.userFrom.getUserID().Equals(currentUser.getUserID()))
                                            {
                                                Response.Write($"<a href=\"deleteSupervisorFeedback.aspx?id={sf.feedbackID}&ud={sf.userTo.getUserID()}\"><span class=\"label label-danger pull-right\"><span class=\"glyphicon glyphicon-trash\"></span></span></a>");
                                            }
                                            Response.Write("</h5>");
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
                       
                        <%--<a href="accountSetting.aspx">
                            <div class="col-lg-12 btn-info">
                                <br />
                                <br />
                                <div class="wrapper">
                                    <span style="font-size: 30px;" class="glyphicon glyphicon-cog"></span>
                                    <h4>Account Settings</h4>
                                    <br />
                                </div>
                            </div>
                        </a>--%>
                        
                    </div>
                </div>
            </div>
        </div>
    </form>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
