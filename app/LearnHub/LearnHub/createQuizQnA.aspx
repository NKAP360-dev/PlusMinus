<%@ Page Title="" Language="C#" MasterPageFile="~/Masterpage.Master" AutoEventWireup="true" CodeBehind="createQuizQnA.aspx.cs" Inherits="LearnHub.createQuizQnA" %>

<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="LearnHub.AppCode.dao" %>
<%@ Import Namespace="LearnHub.AppCode.entity" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script>
        $(document).ready(function () {
            $('#menu').hide();
        });

        function configuration() {
            var x = document.getElementById('menu');
            if (x.style.display === 'none') {
                x.style.display = 'block';
            } else {
                x.style.display = 'none';
            }
        }

    </script>
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
        <%int courseID = Convert.ToInt32(Request.QueryString["id"]); %>
        <li><a href="viewModuleInfo.aspx?id=<%=courseID%>">
            <asp:Label ID="lblBreadcrumbCourseName" runat="server" Text="courseName"></asp:Label></a></li>
        <li><a href="createQuiz.aspx?id=<%=courseID%>">Create Quiz</a></li>
        <li class="active">Questions and Answers</li>
    </ul>

    <div class="container">
        <h1>Create Question and Answers
             <% 
                 User currentUser = (User)Session["currentUser"];
                 Course_elearnDAO ceDAO = new Course_elearnDAO();
                 User courseCreator = ceDAO.get_course_by_id(courseID).getCourseCreator();
                 if (currentUser != null && (currentUser.getUserID() == courseCreator.getUserID() || currentUser.getRole().Equals("superuser")))
                 {
             %>

            <a href="#" id="config" onclick="configuration()" class="btn btn-default pull-right"><span class="glyphicon glyphicon-option-horizontal"></span></a>
        </h1>
        <div class="configure">
            <ul class="list-group" id="menu" style="display: none;">
                <a href="editModuleInfo.aspx?id=<%=courseID %>">
                    <li class="list-group-item"><span class="glyphicon glyphicon-pencil"></span>&emsp;Edit Module
                    </li>
                </a>
                <a href="#uploadModal" data-toggle="modal">
                    <li class="list-group-item"><span class="glyphicon glyphicon-level-up"></span>&emsp;Upload Learning Materials
                    </li>
                </a>
                <a href="createQuiz.aspx?id=<%=courseID%>">
                    <li class="list-group-item"><span class="glyphicon glyphicon-book"></span>&emsp;Create Quiz
                    </li>
                </a>
            </ul>
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
                <asp:Button ID="btnNewQn" runat="server" CssClass="btn btn-primary" Text="Add Question" onclick="btnNewQn_Click" ValidationGroup="ValidateForm"/>
                <button type="button" data-toggle="modal" data-target="#finishModal" class="btn btn-success">Finish</button>
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
                                   <asp:TextBox ID="txtNumCorrectAns" runat="server" CssClass="form-control"></asp:TextBox>
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
                        <div class="wrapper">
                            <asp:Button ID="btnConfirmSubmit" CssClass="btn btn-primary" runat="server" Text="Submit" OnClick="btnConfirmSubmit_Click" />
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
