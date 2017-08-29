<%@ Page Title="" Language="C#" MasterPageFile="~/Masterpage.Master" AutoEventWireup="true" CodeBehind="viewModuleInfo.aspx.cs" Inherits="LearnHub.viewModuleInfo" %>

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

        function ValidateTestimonial(sender, args) {
            //console.log("validateModuleDesc");
            var testimonial = document.getElementById("<%= CKEditorControl2.ClientID %>").value;
            //console.log("moduledesc" + moduleDescription);
            if (testimonial == "") {
                //console.log("no desc");
                args.IsValid = false;
            }
            else {
                //console.log("Yes desc");
                args.IsValid = true;
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
        <li class="active">
            <asp:Label ID="lblBreadcrumbCourseName" runat="server" Text="courseName"></asp:Label></li>
    </ul>
    <form class="form-horizontal" runat="server">
        <div class="container">
            <h1>
                <asp:Label ID="lblCourseNameHeader" runat="server" Text="courseName"></asp:Label>
                <% 
                    int courseID = Convert.ToInt32(Request.QueryString["id"]);
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
                    <a href="manageQuiz.aspx?id=<%=courseID%>">
                        <li class="list-group-item"><span class="glyphicon glyphicon-book"></span>&emsp;Manage Quizzes
                        </li>
                    </a>
                </ul>
            </div>
            <%} %>
            <div class="verticalLine"></div>
        </div>

        <div class="container">
            <div class="row">
                <div class="col-md-3">
                    <div class="wrapper">
                        <h4><strong><span class="glyphicon glyphicon-search">&emsp;</span>View Module Information</strong></h4>
                    </div>
                </div>
            </div>
            <asp:Panel ID="viewInfo" runat="server" Visible="true">
                <div class="row">
                    <div class="col-md-3">
                        <div class="list-group">
                            <asp:LinkButton ID="LinkButton1" runat="server" class="list-group-item active" OnClick="moduleInfo_Click"><span class="glyphicon glyphicon-info-sign" CausesValidation="false"></span>&emsp;Module Info&emsp;</asp:LinkButton>
                            <asp:LinkButton ID="LinkButton2" runat="server" class="list-group-item" OnClick="learningMat_Click" CausesValidation="false">Learning Materials &emsp;</asp:LinkButton>
                            <asp:LinkButton ID="LinkButton3" runat="server" class="list-group-item" OnClick="quizzes_Click" CausesValidation="false">Quizzes &emsp;</asp:LinkButton>
                        </div>
                    </div>


                    <div class="col-md-6">
                        <div class="panel panel-primary">

                            <div class="panel-heading">
                                <h3 class="panel-title">
                                    <asp:Label ID="lblCourseName" runat="server" Text="courseDescription"></asp:Label></h3>

                            </div>
                            <div class="panel-body">
                                <asp:Label ID="lblCourseDescription" runat="server" Text="courseDescription"></asp:Label>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="panel panel-primary">
                            <div class="panel-heading">
                                <h3 class="panel-title">Details 
                                </h3>
                            </div>
                            <div class="panel-body">

                                <b>Prerequisite</b><br />
                                <%
                                    Course_elearnDAO ceDAO = new Course_elearnDAO();
                                    int courseID = Convert.ToInt32(Request.QueryString["id"]);
                                    ArrayList allPrereq = ceDAO.getPrereqOfCourse(courseID);
                                    if (allPrereq.Count > 0)
                                    {
                                        Response.Write("<ul>");
                                        foreach (Course_elearn ce in allPrereq)
                                        {
                                            Response.Write($"<li><a href=\"viewModuleInfo.aspx?id={ce.getCourseID()}\">{ce.getCourseName()}</a></li>");
                                        }
                                        Response.Write("</ul>");
                                    }
                                    else
                                    {
                                        Response.Write("-");
                                        Response.Write("<br />");
                                        Response.Write("<br />");
                                    }
                                %>
                                <b>Learning Hours</b><br />
                                <asp:Label ID="hoursOutput" runat="server" Text=""></asp:Label>
                                <br />
                                <br />
                                <b>Target Audience</b><br />
                                <asp:Label ID="lblTargetAudience" runat="server"></asp:Label>
                                <br />
                                <br />
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-3">
                    </div>
                    <div class="col-md-9">
                        <div class="panel panel-primary">

                            <div class="panel-heading">
                                <h3 class="panel-title">Testimonial&emsp;<%  User user = (User)Session["currentUser"];
                                                                             if (user==null)
                                                                             {

                                                                             }
                                                                             else if(user.getRole().Equals("superuser") || user.getDepartment().Equals("hr")) 
                                                                             {%> <a href="javascript:void(0);" data-toggle="collapse" data-target="#addTestimonial"><span class="label label-default pull-right">

                                    <span class="glyphicon glyphicon-pencil"></span></span></a>
                                    <%} %>
                                </h3>
                            </div>
                            <div class="panel-body">
                                <div class="collapse" id="addTestimonial">
                                    <h4><strong>Add New Testimonial</strong></h4>
                                    <fieldset>
                                        <div class="form-group">
                                            <div class="col-lg-12">
                                                <asp:TextBox ID="txtTestimonial" runat="server" CssClass="form-control" placeholder="Title"></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="rfv_txtTestimonial" runat="server" ErrorMessage="Please enter a Title" ControlToValidate="txtTestimonial" ForeColor="Red" ValidationGroup="ValidateForm"></asp:RequiredFieldValidator>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <div class="col-lg-12">
                                                <CKEditor:CKEditorControl ID="CKEditorControl2" runat="server">
                                                </CKEditor:CKEditorControl>
                                                <asp:CustomValidator ID="cv_testimonial" runat="server" EnableClientScript="true" ErrorMessage="Please input a Testimonial" ClientValidationFunction="ValidateTestimonial" ForeColor="Red" ValidationGroup="ValidateForm"></asp:CustomValidator>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <div class="col-lg-12">
                                                <asp:TextBox ID="txtByWho" runat="server" CssClass="form-control" placeholder="Name"></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="rfv_txtByWho" runat="server" ErrorMessage="Please enter a Name" ControlToValidate="txtByWho" ForeColor="Red" ValidationGroup="ValidateForm"></asp:RequiredFieldValidator>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <div class="col-lg-10">
                                                <asp:Button ID="cfmSubmit" CssClass="btn btn-primary" runat="server" Text="Submit" OnClick="submitTestimonial_Click" ValidationGroup="ValidateForm" />
                                            </div>
                                        </div>

                                    </fieldset>

                                    <hr />
                                </div>
                                <%if (testimonials.Count != 0)
                                    {
                                        foreach (Testimonial test in testimonials)
                                        { %>
                                <strong>
                                    <asp:Label ID="lblCommentTitle"><%= test.getTitle() %></asp:Label></strong>&emsp;
                                <% 
                                    if(user == null) { 

                                    }else if (user.getRole().Equals("superuser") || user.getDepartment().Equals("hr"))
                                    {%>
                                <a href="deleteTestimonial.aspx?id=<%=test.getID() %>&cid=<%=current.getCourseID() %>" onclick="return confirm('Are you sure?')"><span class="label label-danger pull-right"><span class="glyphicon glyphicon-trash"></span></span></a></strong><br />
                                <%} %>
                                <br />
                                <blockquote>
                                    <asp:Label ID="lblCommentBody"><%= test.getQuote() %></asp:Label>
                                    <small><%= test.getStaffName()%></small>
                                </blockquote>
                                <hr />
                                <%}
                                    }
                                    else
                                    {
                                %>
                                <asp:Label runat="server" Text="There are no testimonials to be displayed"></asp:Label>
                                <%

                                    }
                                %>
                            </div>
                        </div>
                    </div>
                </div>
            </asp:Panel>
            <asp:Panel ID="viewLearningMaterial" runat="server" Visible="false">
                <div class="row">
                    <div class="col-md-3">
                        <div class="list-group">
                            <asp:LinkButton ID="LinkButton4" runat="server" class="list-group-item" OnClick="moduleInfo_Click" CausesValidation="false">Module Info&emsp;</asp:LinkButton>
                            <asp:LinkButton ID="LinkButton5" runat="server" class="list-group-item active" OnClick="learningMat_Click" CausesValidation="false"><span class="glyphicon glyphicon-folder-open"></span>&emsp;Learning Materials &emsp;</asp:LinkButton>
                            <asp:LinkButton ID="LinkButton6" runat="server" class="list-group-item" OnClick="quizzes_Click" CausesValidation="false">Quizzes &emsp;</asp:LinkButton>

                        </div>
                    </div>


                    <div class="col-md-9">
                        <%--Each panel for one upload--%>
                        <%
                            Course_elearnDAO cdao = new Course_elearnDAO();
                            ArrayList list = cdao.get_uploaded_content_by_id(current);%>
                        <%
                            string dir = "Data/" + current.getCourseID();
                            foreach (string strfile in Directory.GetFiles(Server.MapPath(dir)))
                            {
                                //Response.Write(strfile);
                                title = null;
                                desc = null;
                                date = DateTime.Now;
                                foreach (Upload u in list)
                                {
                                    //Response.Write(u.getServerPath());
                                    if (u.getServerPath() != null && u.getServerPath().Equals(strfile))
                                    {
                                        title = u.getTitle();
                                        desc = u.getDesc();
                                        date = u.getDate();
                                    }
                                }%>
                        <div class="panel panel-primary">
                            <div class="panel-heading">
                                <h3 class="panel-title">
                                    <asp:Label ID="lblUploadTitle" runat="server"><%= title %></asp:Label>
                                    <%  User user = (User)Session["currentUser"];
                                        if (user == null) {
                                            Response.Redirect("login.aspx");
                                        }else if (user.getRole().Equals("superuser") || user.getDepartment().Equals("hr"))
                                        {%>
                                    <a href="deleteMaterial.aspx?id=<%=current.getCourseID()%>&path=<%=strfile%>" onclick="return confirm('Are you sure?')"><span class="label label-danger pull-right"><span class="glyphicon glyphicon-trash"></span></span></a></strong><br />
                                    <%} %>
                                </h3>
                            </div>
                            <div class="panel-body">
                                Uploaded on:
                                <asp:Label ID="lblUploadDate" runat="server"><%= date.ToShortDateString() %></asp:Label><br />
                                <asp:Label ID="lblUploadDescription" runat="server"><%= desc %></asp:Label>
                                <br />
                                <br />
                                <% string var = dir + "/" + Path.GetFileName(strfile);
                                    if (Path.GetExtension(var).Equals(".pdf")){
                                        var = "ViewerJS/#../" + dir + "/" + Path.GetFileName(strfile);%>
                                        <a href="<%=var %>"><%=Path.GetFileName(strfile) %></a><br />     
                                <% } else {%>
                                        <a href="<%=var %>" download><%=Path.GetFileName(strfile) %></a><br />
                                <%} %>
                            </div>
                        </div>
                        <%} %>
                    </div>
                </div>
            </asp:Panel>
            <asp:Panel ID="viewQuizzes" runat="server" Visible="false">
                <div class="row">
                    <div class="col-md-3">
                        <div class="list-group">
                            <asp:LinkButton ID="LinkButton8" runat="server" class="list-group-item" OnClick="moduleInfo_Click" CausesValidation="false">Module Info</asp:LinkButton>
                            <asp:LinkButton ID="LinkButton9" runat="server" class="list-group-item" OnClick="learningMat_Click" CausesValidation="false">Learning Materials</asp:LinkButton>
                            <asp:LinkButton ID="LinkButton10" runat="server" class="list-group-item active" OnClick="quizzes_Click" CausesValidation="false"><span class="glyphicon glyphicon-education"></span>&emsp;Quizzes</asp:LinkButton>
                        </div>
                    </div>

                    
                    <div class="col-md-9">
                        <%--One panel per quiz--%>
                        <%
                            int courseID = Convert.ToInt32(Request.QueryString["id"]);
                            User currentUser = (User)Session["currentUser"];
                            QuizDAO quizDAO = new QuizDAO();
                            QuizResultDAO qrDAO = new QuizResultDAO();
                            QuizQuestionDAO qqDAO = new QuizQuestionDAO();
                            List<Quiz> allQuizzes = quizDAO.getAllQuizByCourseID(courseID);
                            foreach (Quiz q in allQuizzes) {
                        %>
                        <div class="panel panel-primary">
                            <div class="panel-heading">
                                <h3 class="panel-title">
                                    <% 
                                        Response.Write(q.getTitle());
                                        Course_elearnDAO ceDAO = new Course_elearnDAO();
                                        User courseCreator = ceDAO.get_course_by_id(courseID).getCourseCreator();
                                        if (currentUser != null && (currentUser.getUserID() == courseCreator.getUserID() || currentUser.getRole().Equals("superuser"))) { 
                                    %>
                                    <a href="editQuiz.aspx?id=<%=q.getQuizID()%>" class="label label-default pull-right"><span class="glyphicon glyphicon-pencil"></span></a>
                                    <% } %>
                                </h3>
                            </div>
                            <div class="panel-body">
                                <% Response.Write(q.getDescription()); %>
                                <br />
                                <br />
                                <div class="pull-right">
                                    <a href="quiz.aspx?id=<%=q.getQuizID()%>" class="btn btn-success btn-sm">Attempt Quiz</a>&nbsp; 
                                </div>
                                <br />
                                <hr />
                                <%
                                    List<QuizResult> allAttempts = qrDAO.getQuizResultAttemptsByQuizIDandUserID(q.getQuizID(), currentUser.getUserID());
                                    if (allAttempts.Count > 0)
                                    {
                                        Response.Write("<table class=\"table table-striped\">");
                                        Response.Write("<thead><tr>");
                                        Response.Write("<th>Attempt #</th>");
                                        Response.Write("<th>Date</th>");
                                        Response.Write("<th>Score</th></tr></thead>");

                                        foreach (QuizResult qr in allAttempts)
                                        {
                                            List<QuizQuestion> allQuestions = qqDAO.getAllQuizQuestionByQuizID(qr.getQuiz().getQuizID());
                                            Response.Write("<tr>");
                                            Response.Write($"<td><a href=\"viewResults.aspx?id={qr.getQuizResultID()}\">Attempt {qr.getAttempt()}</a></td>");
                                            Response.Write($"<td>{qr.getDateSubmitted().ToString("dd/MM/yyyy")}</td>");
                                            Response.Write($"<td>{qr.getScore()}/{allQuestions.Count}</td>");
                                            Response.Write("</tr>");
                                        }
                                        Response.Write("</table>");
                                    }
                                %>
                            </div>
                        </div>
                        <%
                        }
                        %>
                    </div>
                </div>
            </asp:Panel>
        </div>



        <%--Upload Modal--%>
        <div id="uploadModal" class="modal fade" role="dialog">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title"><span class="glyphicon glyphicon-open"></span>&emsp;Upload Learning Materials</h4>
                    </div>
                    <div class="modal-body">

                        <div class="form-group">

                            <div class="col-lg-12">
                                <p>
                                    <asp:TextBox ID="uploadTitleInput" runat="server" CssClass="form-control" placeholder="Enter Upload Title"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfv_uploadTitleInput" runat="server" ErrorMessage="Please enter a Title" ControlToValidate="uploadTitleInput" ForeColor="Red"></asp:RequiredFieldValidator>
                                </p>
                                <br />
                            </div>


                        </div>
                        <div class="form-group">
                            <div class="col-lg-12">
                                <p>
                                    <asp:TextBox ID="uploadDescriptionInput" TextMode="multiline" Columns="50" Rows="5" runat="server" CssClass="form-control" placeholder="Enter Upload Description"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfv_uploadDescriptionInput" runat="server" ErrorMessage="Please enter a Description" ControlToValidate="uploadDescriptionInput" ForeColor="Red"></asp:RequiredFieldValidator>
                                </p>
                                <br />
                            </div>
                        </div>
                        <%--Positioning for buttons--%>
                        <asp:FileUpload ID="FileUpload1" runat="server" />
                        <asp:RequiredFieldValidator ID="rfv_FileUpload1" runat="server" ErrorMessage="Please select an item to upload!" ControlToValidate="FileUpload1" ForeColor="Red"></asp:RequiredFieldValidator>
                        <br />

                        <div class="modal-footer">

                            <asp:Button ID="Button1" class="btn btn-primary" runat="server" Text="Upload"
                                OnClick="upload_click" CausesValidation="True" />
                            <asp:Button ID="Button2" CssClass="btn btn-default" runat="server" class="close" data-dismiss="modal" Text="Go Back" />

                        </div>
                    </div>
                </div>
            </div>
        </div>
        <%--Delete Comments Modal--%>
        <% foreach (Testimonial t in testimonials)
            { %>
        <div id="deleteComment" class="modal fade" role="dialog">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title"><span class="glyphicon glyphicon-trash"></span>&emsp;<b>Delete Comment</b></h4>
                    </div>
                    <div class="modal-body">
                        <div class="wrapper">
                            <h4>Are you sure you want to delete the following comment?</h4>
                            <br />
                            "
                            <asp:Label ID="Label5"></asp:Label>"                           
                            <br />
                            <br />
                        </div>
                        <div class="modal-footer">
                            <div class="wrapper">
                                <% deleteThis = t; %>
                                <asp:Button ID="deleteBtn" CssClass="btn btn-danger" runat="server" Text="Delete" />
                                <asp:Button ID="Button4" CssClass="btn btn-default" runat="server" class="close" data-dismiss="modal" Text="Go Back" />
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <%} %>

        <%--Delete Materials Modal--%>
        <div id="deleteMaterials" class="modal fade" role="dialog">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title"><span class="glyphicon glyphicon-trash"></span>&emsp;<b>Delete Learning Materials</b></h4>
                    </div>
                    <div class="modal-body">
                        <div class="wrapper">
                            <h4>Are you sure you want to delete?</h4>
                        </div>
                        <br />
                        <div class="modal-footer">
                            <div class="wrapper">
                                <asp:Button ID="Button3" CssClass="btn btn-danger" runat="server" Text="Delete" />
                                <asp:Button ID="Button5" CssClass="btn btn-default" runat="server" class="close" data-dismiss="modal" Text="Go Back" />
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
