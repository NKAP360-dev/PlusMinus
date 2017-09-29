<%@ Page Title="" Language="C#" MasterPageFile="~/Masterpage.Master" AutoEventWireup="true" CodeBehind="createQuiz.aspx.cs" Inherits="LearnHub.createQuiz" %>
<%@ Register Assembly="CKEditor.NET" Namespace="CKEditor.NET" TagPrefix="CKEditor" %>

<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="LearnHub.AppCode.dao" %>
<%@ Import Namespace="LearnHub.AppCode.entity" %>
<%@ Import Namespace="System.Collections" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="Scripts/footable.bootstrap.min.css" rel="stylesheet" />
    <script src="Scripts/footable.min.js"></script>
    <script>
        $(window).on('load', function () {
            $('#myModal').modal('show');
        });

        function ValidateQuizDescription(sender, args) {
            console.log("validateModuleDesc");
            var quizDescription = document.getElementById("<%= txtQuizDesc.ClientID %>").value;
            if (quizDescription == "") {
                console.log("no desc");
                args.IsValid = false;
            }
            else {
                console.log("Yes desc");
                args.IsValid = true;
            }
        }

        jQuery(function ($) {
            $('[id*=gvPrereq]').footable({
                "paging": {
                    "size": 10 <%--Change how many rows per page--%>
                },
                "filtering": {
                    "position": "left"
                }
            });
        });

    </script>
     <style>
         .breadcrumb {
             padding-top: 15px;
             margin-bottom: 10px;
             list-style: none;
             background-color: white;
             border-radius: 0px;
         }

          .pagination li > a,
        .pagination li > span,
        .pagination li > a:focus, .pagination .disabled > a,
        .pagination .disabled > a:hover,
        .pagination .disabled > a:focus,
        .pagination .disabled > span {
            background-color: white;
            color: black;
        }

            .pagination li > a:hover {
                background-color: #96a8ba;
            }

        .pagination > .active > a,
        .pagination > .active > span,
        .pagination > .active > a:hover,
        .pagination > .active > span:hover,
        .pagination > .active > a:focus,
        .pagination > .active > span:focus {
            background-color: #576777;
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
        <li><a href="manageQuiz.aspx?id=<%=courseID%>">Manage Quizzes</a></li>
         <li class="active">Create Quiz</li>
    </ul>

     <div class="container">
        <h1>Create Quiz</h1>
             <% 
                 User currentUser = (User)Session["currentUser"];
                 ArrayList roles = currentUser.getRoles();
                 Course_elearnDAO ceDAO = new Course_elearnDAO();
                 User courseCreator = ceDAO.get_course_by_id(courseID).getCourseCreator();
                 Boolean correct = false;
                 foreach (string s in roles)
                 {
                     if (s.Equals("superuser"))
                     {
                         correct = true;                       
                     }
                 }
                 if (currentUser != null && (currentUser.getUserID() == courseCreator.getUserID() || correct))
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
        <form class="form-horizontal" runat="server">
            <fieldset>
                <legend>Input new quiz information</legend>
                <div class="form-group required">
                    <strong>
                        <asp:Label runat="server" CssClass="col-lg-2 control-label" Text="Title of Quiz"></asp:Label></strong>
                    <div class="col-lg-5">
                        <asp:TextBox ID="txtQuizTitle" CssClass="form-control" runat="server" placeholder="Title of Quiz"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfv_txtQuizTitle" runat="server" ErrorMessage="Please enter a Title" ControlToValidate="txtQuizTitle" ForeColor="Red" ValidationGroup="ValidateForm" Display="Dynamic"></asp:RequiredFieldValidator>
                        <asp:Label ID="lbl_duplicateTitle" runat="server" CssClass="text-danger" Visible="True"></asp:Label>
                    </div>
                </div>
                <div class="form-group required">
                    <strong>
                        <asp:Label runat="server" CssClass="col-lg-2 control-label" Text="Description of Quiz"></asp:Label></strong>
                    <div class="col-lg-5">
                        <CKEditor:CKEditorControl ID="txtQuizDesc" runat="server"></CKEditor:CKEditorControl>
                        <asp:CustomValidator ID="cv_txtQuizDesc" runat="server" EnableClientScript="true" ErrorMessage="Please input a Quiz Description" ClientValidationFunction="ValidateQuizDescription" ForeColor="Red" ValidationGroup="ValidateForm"></asp:CustomValidator>
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
                        <asp:GridView ID="gvPrereq" runat="server" AutoGenerateColumns="False" DataKeyNames="quizID" AllowPaging="False" CssClass="footable table table-striped table-hover" data-paging="true" GridLines="None" OnRowCommand="gvPrereq_RowCommand" EmptyDataText="There are no quizzes available to choose from.">
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
                
                <br /><br />
                <div class="form-group wrapper">
                    <%--int courseID = Convert.ToInt32(Request.QueryString["id"]); %>
                    <a href="createQuizQnA.aspx?id=<%=courseID%>" class="btn btn-primary">Next</a>--%>
                    <asp:Button ID="btnCreate" runat="server" CssClass="btn btn-primary" Text="Next" OnClick="btnCreate_Click" ValidationGroup ="ValidateForm"/>
                    
                </div>
            </fieldset>
        </form>

        <div class="container">
            <div class="modal" id="myModal">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                            <h4 class="modal-title"><b>U N D E R &nbsp; C O N S T R U C T I O N</b></h4>
                        </div>
                        <div class="modal-body">
                            <div class="wrapper"><img src="img/barrier.png" style='width: 30%;' border="0"/>
                                <h3 class="text-danger">This page is currently still under construction!</h3>
                                <p>You may still navigate around but not everything is working as it should be. <br /> Team PlusMinus is trying their best to get everything
                                    up as soon as possible!
                                </p>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <div class="wrapper">
                            <button type="button" class="btn btn-warning" data-dismiss="modal">Got it!</button>
                                </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
