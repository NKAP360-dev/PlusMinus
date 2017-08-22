<%@ Page Title="" Language="C#" MasterPageFile="~/Masterpage.Master" AutoEventWireup="true" CodeBehind="editQuiz.aspx.cs" Inherits="LearnHub.editQuiz" %>

<%@ Register Assembly="CKEditor.NET" Namespace="CKEditor.NET" TagPrefix="CKEditor" %>

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
        <li class="active">Edit Quiz</li>
    </ul>
    <div class="container">
        <h1>Edit Quiz
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
                <legend>Edit current quiz information</legend>
                    <div class="form-group required">
                    <strong>
                        <asp:Label runat="server" CssClass="col-lg-2 control-label" Text="Title of Quiz"></asp:Label></strong>
                    <div class="col-lg-5">
                        <asp:TextBox ID="txtQuizTitle" CssClass="form-control" runat="server" placeholder="Title of Quiz"></asp:TextBox>
                    </div>
                </div>
                <div class="form-group required">
                    <strong>
                        <asp:Label runat="server" CssClass="col-lg-2 control-label" Text="Description of Quiz"></asp:Label></strong>
                    <div class="col-lg-5">
                        <CKEditor:CKEditorControl ID="txtQuizDesc" runat="server"></CKEditor:CKEditorControl>
                    </div>
                </div>
                <%-- Preq --%>
                 <div class="form-group">
                    <strong>
                         <a href="javascript:void(0);" class="col-lg-2 control-label" data-toggle="collapse" data-target="#preq"">Prerequisite Quiz Selection </a></strong>

                     <div class="col-lg-5">
                         <div id="preq" class="collapse">

                             <table class="table table-striped table-hover">
                                 <thead>
                                     <tr>
                                         <th></th>
                                         <th>Prequisite Quiz Name</th>
                                         <th>Category</th>
                                     </tr>
                                 </thead>
                                 <tbody>
                                     <tr>
                                         <td>
                                             <asp:LinkButton ID="btnAdd" runat="server"><span class="glyphicon glyphicon-plus"></span></asp:LinkButton></td>
                                         <td>I am not a gridview</td>
                                         <td>Please replace me with gridview</td>
                                     </tr>
                                 </tbody>
                             </table>
                             <h6><em>Click on "+" to select quiz as a prerequisite quiz</em></h6>


                             <br />
                         </div>


                         <table class="table table-striped table-hover">
                             <thead>
                                 <tr>
                                     <th></th>
                                     <th>Prequisite Quiz Name</th>
                                     <th>Category</th>
                                 </tr>
                             </thead>
                             <tbody>
                                 <tr>
                                     <td>
                                         <asp:LinkButton ID="btnRemove" runat="server"><span class="glyphicon glyphicon-minus"></span></asp:LinkButton></td>
                                     <td>I am not a gridview</td>
                                     <td>Please replace me with gridview</td>
                                 </tr>
                             </tbody>
                         </table>
                         <h6><em>Click on "Prerequisite Quiz Selection" to choose prerequisite quizzes</em></h6>
                     </div>
                 </div>

                <div class="form-group required">
                    <label class="col-lg-2 control-label">No. of correct answers needed to pass</label>
                    <div class="col-lg-5">
                        <asp:TextBox ID="txtNumCorrectAns" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>
                </div>
                <div class="form-group required">
                    <label class="col-lg-2 control-label">Randomize question order</label>
                    <div class="col-lg-5">
                        <asp:DropDownList ID="ddlRandomize" runat="server" CssClass="form-control">
                            <asp:ListItem>Randomize</asp:ListItem>
                            <asp:ListItem>In Order</asp:ListItem>
                        </asp:DropDownList>
                    </div>

                </div>
            </fieldset>
            <br /><br />
            <div class="wrapper">
                  <asp:Button ID="btnConfirmSubmit" CssClass="btn btn-primary" runat="server" Text="Save" />
            </div>
        </form>
    </div>


</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
