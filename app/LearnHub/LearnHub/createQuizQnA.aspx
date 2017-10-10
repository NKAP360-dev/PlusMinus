<%@ Page Title="" Language="C#" MasterPageFile="~/Masterpage.Master" AutoEventWireup="true" CodeBehind="createQuizQnA.aspx.cs" Inherits="LearnHub.createQuizQnA" %>

<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="LearnHub.AppCode.dao" %>
<%@ Import Namespace="LearnHub.AppCode.entity" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script>
        var unsaved = true;

        function unsavedFalse() {
            unsaved = false;
        }

        $(document).ready(function () {
            function unloadPage() {
                if (unsaved) {
                    return "You have unsaved changes on this page. Do you want to leave this page and discard your changes or stay on this page?";
                }
            }

            window.onbeforeunload = unloadPage;
        });

        function openModal() {
            console.log("openModal");
            $("#finishModal").modal();
        }

        function checkForm_Clicked(source, args) {

            console.log("Checkform");
            Page_ClientValidate('ValidateForm');


            if (!Page_IsValid) {
                console.log("Not valid");
                document.getElementById('<%=rfv_txtNumCorrectAns.ClientID%>').Enabled = false;
                document.getElementById('<%=rfv_txtTimeLimit.ClientID%>').Enabled = false;
            }
            else {

                //$find("#finishModal").show();
                $("#finishModal").modal();
                console.log("VALID");
                document.getElementById('<%=rfv_txtNumCorrectAns.ClientID%>').Enabled = true;
                document.getElementById('<%=rfv_txtTimeLimit.ClientID%>').Enabled = true;
                if (document.getElementById('<%=rfv_txtNumCorrectAns.ClientID%>').enabled = true) {
                    console.log("its enabled");
                }
                else {
                    console.log("its NOT enabled");
                }
            }
            return false;
        }

    </script>
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

    <div class="container">
        <h1>Create Question and Answers</h1>
             <% 
                 User currentUser = (User)Session["currentUser"];
                 Course_elearnDAO ceDAO = new Course_elearnDAO();
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
                    <div class="dropHeader">Quiz Management</div>
                    <a href="manageQuiz.aspx?id=<%=courseID%>"><span class="glyphicon glyphicon-book"></span>&nbsp;&nbsp;Manage Quizzes</a>
                    <a href="createQuiz.aspx?id=<%=courseID%>"><span class="glyphicon glyphicon-plus"></span>&nbsp;&nbsp;Add New Quiz</a>
                </div>
            </div>

        <%} %>
        <div class="verticalLine"></div>
    </div>
    <div class="container">
        <form class="form-horizontal" runat="server">
            <fieldset>
                <legend>Input quiz question and answers</legend>
                <div class="form-group required">
                    <strong>
                        <asp:Label ID="lblQuestionNumber" runat="server" CssClass="col-lg-2 control-label"></asp:Label>
                    </strong>
                    <div class="col-lg-9">
                        <asp:TextBox ID="txtQuizQuestion" CssClass="form-control" runat="server" placeholder="Quiz Question"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfv_txtQuizQuestion" runat="server" ErrorMessage="Please enter the Question" ControlToValidate="txtQuizQuestion" ForeColor="Red" ValidationGroup="ValidateForm"></asp:RequiredFieldValidator>
                    </div>
                </div>
                <div class="form-group required">
                    <strong>
                        <asp:Label runat="server" CssClass="col-lg-2 control-label" Text="Answers"></asp:Label>
                    </strong>
                    <div class="col-lg-6">
                        <asp:TextBox ID="txtOptionOne" runat="server" CssClass="form-control" placeholder="Option 1"></asp:TextBox><br />
                        <asp:RequiredFieldValidator ID="rfv_txtOptionOne" runat="server" ErrorMessage="Please enter the first option" ControlToValidate="txtOptionOne" ForeColor="Red" ValidationGroup="ValidateForm"></asp:RequiredFieldValidator>
                        <asp:TextBox ID="txtOptionTwo" runat="server" CssClass="form-control" placeholder="Option 2"></asp:TextBox><br />
                        <asp:RequiredFieldValidator ID="rfv_txtOptionTwo" runat="server" ErrorMessage="Please enter the second option" ControlToValidate="txtOptionTwo" ForeColor="Red" ValidationGroup="ValidateForm"></asp:RequiredFieldValidator>
                        <asp:TextBox ID="txtOptionThree" runat="server" CssClass="form-control" placeholder="Option 3"></asp:TextBox><br />
                        <asp:RequiredFieldValidator ID="rfv_txtOptionThree" runat="server" ErrorMessage="Please enter the third option" ControlToValidate="txtOptionThree" ForeColor="Red" ValidationGroup="ValidateForm"></asp:RequiredFieldValidator>
                        <asp:TextBox ID="txtOptionFour" runat="server" CssClass="form-control" placeholder="Option 4"></asp:TextBox><br />
                        <asp:RequiredFieldValidator ID="rfv_txtOptionFour" runat="server" ErrorMessage="Please enter the fourth option" ControlToValidate="txtOptionFour" ForeColor="Red" ValidationGroup="ValidateForm"></asp:RequiredFieldValidator>
                    </div>
                </div>
                <div class="form-group required">
                    <strong>
                        <asp:Label runat="server" CssClass="col-lg-2 control-label" Text="Correct Answer"></asp:Label>
                    </strong>
                    <div class="col-lg-3">
                        <asp:DropDownList ID="ddlCorrectAns" runat="server" CssClass="form-control">
                            <asp:ListItem Value="1">Option 1</asp:ListItem>
                            <asp:ListItem Value="2">Option 2</asp:ListItem>
                            <asp:ListItem Value="3">Option 3</asp:ListItem>
                            <asp:ListItem Value="4">Option 4</asp:ListItem>

                        </asp:DropDownList>
                    </div>
                </div>
            </fieldset>
            <br />
            <br />
            <div class="wrapper">
                <asp:Label ID="lblAddedMsg" CssClass="label label-success" runat="server"  Font-Size="Medium" Visible="false"></asp:Label>
            </div>
            <br />
            <div class="form-group wrapper">
                <asp:Button ID="btnNewQn" runat="server" CssClass="btn btn-primary" Text="Add Question" OnClientClick="unsavedFalse()" onclick="btnNewQn_Click" ValidationGroup="ValidateForm"/>
                <asp:Button ID="btnFinish" runat="server" CssClass="btn btn-success" Text="Finish" OnClientClick="unsavedFalse()" onclick="checkForm" useSubmitBehavior="false" ValidationGroup="ValidateForm"/>
            </div>

            <div id="finishModal" class="modal fade" role="dialog">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title"><b>Finish Quiz Creation</b></h4>
                    </div>
                    <div class="modal-body">
                        <div class="form-group required">
                                <label class="col-lg-3 control-label">No. of correct answers needed to pass</label>
                                <div class="col-lg-7">
                                   <asp:TextBox ID="txtNumCorrectAns" runat="server" CssClass="form-control" TextMode="Number"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfv_txtNumCorrectAns" runat="server" ErrorMessage="Please enter the number of Correct Answers" ControlToValidate="txtNumCorrectAns" ForeColor="Red" ValidationGroup="ValidateFormTwo" Display="Dynamic"></asp:RequiredFieldValidator>
                                    <asp:CustomValidator ID="cv_txtNumCorrectAns" runat="server" ErrorMessage="You have entered a number that is more than the total number of questions! Please enter a lower number!" OnServerValidate="ValidateNumberOfQuestions" ControlToValidate ="txtNumCorrectAns" ForeColor="Red" ValidationGroup="ValidateFormTwo" Display="Dynamic" ></asp:CustomValidator>
                                </div>
                            </div>
                        <div class="form-group required">
                             <label class="col-lg-3 control-label">Randomize question order</label>
                            <div class="col-lg-7">
                                <asp:DropDownList ID="ddlRandomize" runat="server" CssClass="form-control">
                                    <asp:ListItem Value="y">Randomize</asp:ListItem>
                                    <asp:ListItem Value="n">In Order</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>
                        <br />
                         <div class="form-group required">
                             <label class="col-lg-3 control-label">Time Limit (seconds)</label>
                            <div class="col-lg-7">
                                <asp:TextBox ID="txtTimeLimit" runat="server" CssClass="form-control" placeholder="Time Limit in Seconds" TextMode="Number" min="0"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfv_txtTimeLimit" runat="server" ErrorMessage="Please enter the Time Limit" ControlToValidate="txtTimeLimit" ForeColor="Red" ValidationGroup="ValidateFormTwo" Display="Dynamic"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                        <br/>
                        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
                        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                            <ContentTemplate>
                                <div class="form-group required">
                             <label class="col-lg-3 control-label">Allow Multiple Quiz Attempts</label>
                            <div class="col-lg-7">
                                <asp:RadioButtonList ID="rdlAttempt" runat="server" OnSelectedIndexChanged="RadioButtonList_OnSelectedIndexChange" AutoPostBack="true">
                                    <asp:ListItem Value="unlimited">&nbsp;Unlimited</asp:ListItem>
                                    <asp:ListItem Value="limited">&nbsp;Limited</asp:ListItem>
                                </asp:RadioButtonList>
                                <asp:RequiredFieldValidator ID="rfv_rdlAttempt" runat="server" ErrorMessage="Please select the attempt type" ControlToValidate="rdlAttempt" ForeColor="Red" ValidationGroup="ValidateFormTwo" Display="Dynamic"></asp:RequiredFieldValidator>
                                <asp:TextBox ID="txtNoOfAttempt" runat="server" CssClass="form-control" placeholder="If Limited, Number of Attempts" TextMode="Number" min="0"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfv_txtNoOfAttempt" runat="server" ErrorMessage="Please input the number of attempts" ControlToValidate="txtNoOfAttempt" ForeColor="Red" ValidationGroup="ValidateFormTwo" Display="Dynamic" Enabled="False"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                            </ContentTemplate>
                            <Triggers>
                                <asp:AsyncPostBackTrigger ControlID="rdlAttempt" EventName="SelectedIndexChanged" />
                            </Triggers>
                        </asp:UpdatePanel>
                         
                        <br />
                         <div class="form-group required">
                             <label class="col-lg-3 control-label">Display Quiz Answers</label>
                            <div class="col-lg-7">
                                <asp:DropDownList ID="ddlDisplayAnswer" runat="server" CssClass="form-control">
                                    <asp:ListItem Value="always">Always</asp:ListItem>
                                    <asp:ListItem Value="afterpass">After Passing Quiz</asp:ListItem>
                                    <asp:ListItem Value="never">Never</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>

                        <div class="wrapper">
                            <asp:Button ID="btnConfirmSubmit" CssClass="btn btn-primary" runat="server" Text="Submit" OnClick="btnConfirmSubmit_Click" OnClientClick="unsavedFalse()" ValidationGroup="ValidateFormTwo" />
                            <asp:Button ID="btnCancel1" CssClass="btn btn-default" runat="server" class="close" data-dismiss="modal" Text="Cancel" OnClientClick="return false;" />
                            <br />
                        </div>
                    </div>
                </div>

            </div>
        </div>
        </form>
    </div>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
