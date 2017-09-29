<%@ Page Title="" Language="C#" MasterPageFile="~/Masterpage.Master" AutoEventWireup="true" CodeBehind="editQuiz.aspx.cs" MaintainScrollPositionOnPostBack="true" Inherits="LearnHub.editQuiz" %>

<%@ Register Assembly="CKEditor.NET" Namespace="CKEditor.NET" TagPrefix="CKEditor" %>

<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="LearnHub.AppCode.dao" %>
<%@ Import Namespace="LearnHub.AppCode.entity" %>

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

        
        function openModal() {
            console.log("submitModal");
            $("#submitModal").modal();
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
        <form class="form-horizontal" runat="server">
            <fieldset>
                <legend>Edit current quiz information</legend>
                    <div class="form-group required">
                    <strong>
                        <asp:Label runat="server" CssClass="col-lg-2 control-label" Text="Title of Quiz"></asp:Label></strong>
                    <div class="col-lg-5">
                        <asp:TextBox ID="txtQuizTitle" CssClass="form-control" runat="server" placeholder="Title of Quiz"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfv_txtQuizTitle" runat="server" ErrorMessage="Please enter a Quiz Title" ControlToValidate="txtQuizTitle" ForeColor="Red" ValidationGroup="ValidateForm" Display="Dynamic"></asp:RequiredFieldValidator>
                        <asp:CustomValidator ID="cv_txtQuizTitle" runat="server" ErrorMessage="This Title already exists! Please enter another Title." OnServerValidate="ValidateDuplicateTitle" ForeColor="Red" ValidationGroup="ValidateForm" EnableClientScript="false" ControlToValidate="txtQuizTitle" Display="Dynamic"></asp:CustomValidator>
                    </div>
                </div>
                <div class="form-group required">
                    <strong>
                        <asp:Label runat="server" CssClass="col-lg-2 control-label" Text="Description of Quiz"></asp:Label></strong>
                    <div class="col-lg-5">
                        <CKEditor:CKEditorControl ID="txtQuizDesc" runat="server"></CKEditor:CKEditorControl>
                        <asp:CustomValidator ID="cv_txtQuizDesc" runat="server" EnableClientScript="true" ErrorMessage="Please input a Quiz Description" ClientValidationFunction="ValidateQuizDescription" ForeColor="Red" ValidationGroup="ValidateForm" Display="Dynamic"></asp:CustomValidator>
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

                <div class="form-group required">
                    <label class="col-lg-2 control-label">No. of correct answers needed to pass</label>
                    <div class="col-lg-5">
                        <asp:TextBox ID="txtNumCorrectAns" runat="server" CssClass="form-control" TextMode="Number"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfv_txtNumCorrectAns" runat="server" ErrorMessage="Please enter the number of correct answers" ControlToValidate="txtNumCorrectAns" ForeColor="Red" ValidationGroup="ValidateForm" Display="Dynamic"></asp:RequiredFieldValidator>
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
                <br />
                <div class="form-group required">
                             <label class="col-lg-2 control-label">Time Limit (seconds)</label>
                            <div class="col-lg-5">
                                <asp:TextBox ID="txtTimeLimit" runat="server" CssClass="form-control" placeholder="Time Limit in Seconds" TextMode="Number" min="0"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfv_txtTimeLimit" runat="server" ErrorMessage="Please enter the Time Limit" ControlToValidate="txtTimeLimit" ForeColor="Red" ValidationGroup="ValidateForm" Display="Dynamic"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                        <br/>
                        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
                        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                            <ContentTemplate>
                                <div class="form-group required">
                             <label class="col-lg-2 control-label">Allow Multiple Quiz Attempts</label>
                            <div class="col-lg-5">
                                <asp:RadioButtonList ID="rdlAttempt" runat="server" AutoPostBack="True" OnSelectedIndexChanged="rdlAttempt_SelectedIndexChanged">
                                    <asp:ListItem Value="unlimited">&nbsp;Unlimited</asp:ListItem>
                                    <asp:ListItem Value="limited">&nbsp;Limited</asp:ListItem>
                                </asp:RadioButtonList>
                                <asp:RequiredFieldValidator ID="rfv_rdlAttempt" runat="server" ErrorMessage="Please select the attempt type" ControlToValidate="rdlAttempt" ForeColor="Red" ValidationGroup="ValidateForm" Display="Dynamic"></asp:RequiredFieldValidator>
                                <asp:TextBox ID="txtNoOfAttempt" runat="server" CssClass="form-control" placeholder="If Limited, Number of Attempts" TextMode="Number" min="0"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfv_txtNoOfAttempt" runat="server" ErrorMessage="Please input the number of attempts" ControlToValidate="txtNoOfAttempt" ForeColor="Red" ValidationGroup="ValidateForm" Display="Dynamic" Enabled="False"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                            </ContentTemplate>
                            <Triggers>
                                <asp:AsyncPostBackTrigger ControlID="rdlAttempt" />
                            </Triggers>
                        </asp:UpdatePanel>
                        <br />
                         <div class="form-group required">
                             <label class="col-lg-2 control-label">Display Quiz Answers</label>
                            <div class="col-lg-5">
                                <asp:DropDownList ID="ddlDisplayAnswer" runat="server" CssClass="form-control">
                                    <asp:ListItem Value="always">Always</asp:ListItem>
                                    <asp:ListItem Value="afterpass">After Passing Quiz</asp:ListItem>
                                    <asp:ListItem Value="never">Never</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>
            </fieldset>
            <br /><br />
            <div class="wrapper">
                    <%--<asp:Button ID="submitBtn" CssClass="btn btn-primary" runat="server" Text="Save" data-toggle="modal" OnClientClick="return checkForm_Clicked()" href="#submitModal" CausesValidation="True" UseSubmitBehavior="False"/>--%>
                    <asp:Button ID="Button1" CssClass="btn btn-primary" runat="server" Text="Save" onclick="checkForm" CausesValidation="True" UseSubmitBehavior="False"/>
                    
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
