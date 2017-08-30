<%@ Page Title="" Language="C#" MasterPageFile="~/Masterpage.Master" AutoEventWireup="true" CodeBehind="editQuiz.aspx.cs" Inherits="LearnHub.editQuiz" %>

<%@ Register Assembly="CKEditor.NET" Namespace="CKEditor.NET" TagPrefix="CKEditor" %>

<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="LearnHub.AppCode.dao" %>
<%@ Import Namespace="LearnHub.AppCode.entity" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script>
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

        function checkForm_Clicked(source, args) {

            Page_ClientValidate('ValidateForm');
            //Page_ClientValidate();

            if (!Page_IsValid) {
                document.getElementById('<%= lblErrorMsgFinal.ClientID %>').style.display = 'inherit';
                document.getElementById('<%= lblErrorMsgFinal.ClientID %>').innerHTML = "You have not filled up all of the required fields";
                //Page_ClientValidate('summaryGroup');
                document.getElementById('<%= btnConfirmSubmit.ClientID %>').disabled = true;
                console.log("The end");
            }
            else {
                document.getElementById('<%= lblErrorMsgFinal.ClientID %>').innerHTML = "";
                document.getElementById('<%= btnConfirmSubmit.ClientID %>').disabled = false;
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
        <li><a href="viewAllModule.aspx">Modules</a></li>
        <%
            QuizDAO qDAO = new QuizDAO();
            Quiz q = qDAO.getQuizByID(Convert.ToInt32(Request.QueryString["id"]));
            int courseID = q.getMainCourse().getCourseID();%>
        <li><a href="viewModuleInfo.aspx?id=<%=courseID%>">
            <asp:Label ID="lblBreadcrumbCourseName" runat="server" Text="courseName"></asp:Label></a></li>
        <li><a href="manageQuiz.aspx?id=<%=courseID%>">Manage Quizzes</a></li>
        <li class="active">Edit Quiz</li>
    </ul>
    <div class="container">
        <h1>Edit Quiz</h1>
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
        <div class="dropdown" style="float: right;">
            <button class="dropbtn" onclick="return false;"><span class="glyphicon glyphicon-option-horizontal"></span></button>
            <div class="dropdown-content" style="right: 0;">
                <a href="manageQuiz.aspx?id=<%=courseID%>"><span class="glyphicon glyphicon-book"></span>&nbsp;&nbsp;Manage Quizzes</a>
            </div>
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
                        <asp:RequiredFieldValidator ID="rfv_txtQuizTitle" runat="server" ErrorMessage="Please enter a Quiz Title" ControlToValidate="txtQuizTitle" ForeColor="Red" ValidationGroup="ValidateForm"></asp:RequiredFieldValidator>
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
                        <asp:RequiredFieldValidator ID="rfv_txtNumCorrectAns" runat="server" ErrorMessage="Please enter the number of correct answers" ControlToValidate="txtNumCorrectAns" ForeColor="Red" ValidationGroup="ValidateForm"></asp:RequiredFieldValidator>
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
                    <asp:Button ID="submitBtn" CssClass="btn btn-primary" runat="server" Text="Save" data-toggle="modal" OnClientClick="return checkForm_Clicked()" href="#submitModal" CausesValidation="True" UseSubmitBehavior="False" />
                    <asp:Button ID="btnDeactivate" CssClass="btn btn-warning" runat="server" Text="Deactivate Quiz" data-toggle="modal" href="#deactivateModal" OnClientClick="return false;" />
                    <asp:Button ID="btnActivate" CssClass="btn btn-success" runat="server" Text="Activate Quiz" data-toggle="modal" href="#activateModal" OnClientClick="return false;" />
            </div>

            <%--Modal for Submission Confirmation--%>
            <div id="submitModal" class="modal fade" role="dialog">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                            <h4 class="modal-title"><b>Edit Quiz</b></h4>
                        </div>
                        <%--Modal Content--%>
                        <div class="modal-body">
                            <div class="wrapper">
                                <h4>Are you sure you want to save? <br /> This will overwrite your existing information.</h4>
                                <br />
                                <asp:Label ID="lblErrorMsgFinal" runat="server" CssClass="text-danger" Visible="True"></asp:Label>
                                <br />
                                 <asp:Button ID="btnConfirmSubmit" CssClass="btn btn-primary" runat="server" Text="Save" onclick="btnConfirmSubmit_Click"/>
                                 <asp:Button ID="btnCancel" CssClass="btn btn-default" runat="server" class="close" data-dismiss="modal" Text="Cancel" OnClientClick="return false;" />
                                <br />
                            </div>
                        </div>
                    </div>

                </div>
            </div>

            <%--Modal for Deactivation Confirmation--%>
            <div id="deactivateModal" class="modal fade" role="dialog">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                            <h4 class="modal-title"><b>Deactivate Quiz</b></h4>
                        </div>
                        <%--Modal Content--%>
                        <div class="modal-body">
                           <div class="wrapper">
                                <h4>Are you sure you want to proceed?</h4>
                                
                                <h4 class="text-danger">This quiz will be deactivated and will no longer be visible to users!</h4>
                                <br />
                                <asp:Button ID="btnCfmDeactivate" CssClass="btn btn-warning" runat="server" Text="Deactivate" onclick="btnCfmDeactivate_Click"/>
                                <asp:Button ID="btnCancel2" CssClass="btn btn-default" runat="server" class="close" data-dismiss="modal" Text="Cancel" OnClientClick="return false;" />

                                <br />
                            </div>
                        </div>
                    </div>

                </div>
            </div>

            <%--Modal for Activation Confirmation--%>
            <div id="activateModal" class="modal fade" role="dialog">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                            <h4 class="modal-title"><b>Activate Quiz</b></h4>
                        </div>
                        <%--Modal Content--%>
                        <div class="modal-body">
                           <div class="wrapper">
                                <h4>Are you sure you want to proceed?</h4>
                                
                                <h4 class="text-danger">This quiz will be activated and appear visible to all users!</h4>
                                <br />
                                <asp:Button ID="btnCfmActivate" CssClass="btn btn-success" runat="server" Text="Activate" onclick="btnCfmActivate_Click"/>
                                <asp:Button ID="Button2" CssClass="btn btn-default" runat="server" class="close" data-dismiss="modal" Text="Cancel" OnClientClick="return false;" />

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
