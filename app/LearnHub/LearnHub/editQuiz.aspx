﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Masterpage.Master" AutoEventWireup="true" CodeBehind="editQuiz.aspx.cs" Inherits="LearnHub.editQuiz" %>

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
                 QuizDAO quizDAO = new QuizDAO();
                 String id_str = Request.QueryString["id"];
                 int id_num = int.Parse(id_str);
                 Quiz currentQuiz = quizDAO.getQuizByID(id_num);
                 User courseCreator = currentQuiz.getMainCourse().getCourseCreator();
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

                             <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>">
                        </asp:SqlDataSource>
                        <asp:GridView ID="gvPrereq" runat="server" AutoGenerateColumns="False" DataKeyNames="quizID" AllowPaging="True" CssClass="table table-striped table-hover" GridLines="None" OnRowCommand="gvPrereq_RowCommand" EmptyDataText="There are no quizzes available to choose from.">
                            <Columns>
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <asp:LinkButton ID="btnAdd" runat="server" CausesValidation="false" CommandArgument='<%# Eval("quizID") %>'><span class="glyphicon glyphicon-plus"></span></asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="title" HeaderText="Prerequisite Quiz Title" SortExpression="title" />
                                <asp:BoundField DataField="quizID" Visible="False" />
                            </Columns>
                        </asp:GridView>
                             <h6><em>Click on "+" to select quiz as a prerequisite quiz</em></h6>


                             <br />
                         </div>


                         <asp:SqlDataSource ID="SqlDataSourcePrereqCart" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>">
                        </asp:SqlDataSource>
                        <asp:GridView ID="gvPrereqCart" runat="server" CssClass="table table-striped table-hover" DataKeyNames="quizID" EmptyDataText="Please choose a prerequisite first" GridLines="None" AutoGenerateColumns="False" OnRowCommand="gvPrereqCart_RowCommand">
                            <Columns>
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <asp:LinkButton ID="btnRemove" runat="server" CausesValidation="false" CommandArgument='<%# Eval("quizID") %>'><span class="glyphicon glyphicon-minus"></span></asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <input type="hidden" name="quizID" value='<%# Eval("quizID") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="title" HeaderText="Prerequisite Quiz Title" SortExpression="title" />
                            </Columns>
                            
                        </asp:GridView>

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
                    <asp:Button ID="btnConfirmSubmit" CssClass="btn btn-primary" runat="server" Text="Save" onclick="btnConfirmSubmit_Click"/>
                   <asp:Button ID="btnDeactivate" CssClass="btn btn-danger" runat="server" Text="Deactivate" onclick="btnDeactivate_Click"/>
                   <asp:Button ID="btnActivate" CssClass="btn btn-success" runat="server" Text="Activate" onclick="btnActivate_Click"/>
            </div>
        </form>
    </div>


</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
