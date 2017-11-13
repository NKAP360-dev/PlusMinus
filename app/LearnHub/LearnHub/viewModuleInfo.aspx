<%@ Page Title="" Language="C#" MasterPageFile="~/Masterpage.Master" AutoEventWireup="true" CodeBehind="viewModuleInfo.aspx.cs" Inherits="LearnHub.viewModuleInfo" %>

<%@ Register Assembly="CKEditor.NET" Namespace="CKEditor.NET" TagPrefix="CKEditor" %>

<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="LearnHub.AppCode.dao" %>
<%@ Import Namespace="LearnHub.AppCode.entity" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="//cdn.ckeditor.com/4.7.3/full/ckeditor.js"></script>
    <script>
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

        function showModal() {
            $('#uploadModal').modal('show');
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

        #dropdown {
            z-index: 100;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <ul class="breadcrumb">
        <li><a href="home.aspx">Home</a></li>
        <li><a href="viewAllModule.aspx">Courses</a></li>
        <li class="active">
            <asp:Label ID="lblBreadcrumbCourseName" runat="server" Text="courseName"></asp:Label></li>
    </ul>
    <form class="form-horizontal" runat="server">

        <div class="container">
            <h1>
                <asp:Label ID="lblCourseNameHeader" runat="server" Text="courseName"></asp:Label></h1>
            <% 
                    int courseID = Convert.ToInt32(Request.QueryString["id"]);
                    User currentUser = (User)Session["currentUser"];
                    Course_elearnDAO ceDAO = new Course_elearnDAO();
                    User courseCreator = ceDAO.get_course_by_id(courseID).getCourseCreator();
                    Course_elearn currentCourse = ceDAO.get_course_by_id(courseID);
                    superuser = false;
                    if (currentUser != null)
                    {
                        foreach (string s in currentUser.getRoles())
                        {
                            if (s.Equals("superuser"))
                            {
                                superuser = true;
                            }
                        }
                        if (currentUser != null && (currentUser.getUserID().Equals(courseCreator.getUserID()) || superuser))
                        {
            %>

            <div id="dropdown" class="dropdown" style="float: right;">
                <button class="dropbtn" onclick="return false;"><span class="glyphicon glyphicon-option-horizontal"></span></button>
                <div class="dropdown-content" style="right: 0;">
                    <div class="dropHeader">Individual Course Management</div>
                    <a href="editModuleInfo.aspx?id=<%=courseID %>"><span class="glyphicon glyphicon-pencil"></span>&nbsp;&nbsp;Edit Course</a>
                    <%
                        if (currentCourse.getCourseType().Equals("Online Learning"))
                        {
                    %>
                    <a href="#uploadModal" data-toggle="modal"><span class="glyphicon glyphicon-level-up"></span>&nbsp;&nbsp;Upload Learning Materials</a>
                    <a href="manageQuiz.aspx?id=<%=courseID%>"><span class="glyphicon glyphicon-book"></span>&nbsp;&nbsp;Manage Quizzes</a>
                    <%
                        }
                    %>
                </div>
            </div>
            <%}
    }%>
            <div class="verticalLine"></div>
        </div>

        <div class="container">
            <div class="row">
                <div class="col-md-3">
                    <div class="wrapper">
                        <h4><strong><span class="glyphicon glyphicon-search">&emsp;</span>View Course Information</strong></h4>
                    </div>
                </div>
            </div>
            <asp:Panel ID="viewInfo" runat="server" Visible="true">
                <div class="row">
                    <div class="col-md-3">
                        <div class="list-group">
                            <asp:LinkButton ID="LinkButton1" runat="server" class="list-group-item active" OnClick="moduleInfo_Click" CausesValidation="false"><span class="glyphicon glyphicon-info-sign"></span>&emsp;Course Info&emsp;</asp:LinkButton>
                            <%
                                int courseID = Convert.ToInt32(Request.QueryString["id"]);
                                Course_elearnDAO ceDAO = new Course_elearnDAO();
                                Course_elearn currentCourse = ceDAO.get_course_by_id(courseID);
                                if (currentCourse.getCourseType().Equals("Online Learning"))
                                {
                            %>
                            <asp:LinkButton ID="LinkButton2" runat="server" class="list-group-item" OnClick="learningMat_Click" CausesValidation="false">Learning Materials &emsp;</asp:LinkButton>
                            <asp:LinkButton ID="LinkButton3" runat="server" class="list-group-item" OnClick="quizzes_Click" CausesValidation="false">Quizzes &emsp;</asp:LinkButton>
                            <%
                                }
                            %>
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
                                <asp:Panel ID="panelInactive" runat="server" Visible="false">
                                    <div class="alert alert-dismissible alert-warning">
                                        <h4><b>This course is currently inactive.</b></h4>
                                        <p>
                                            <span class="glyphicon glyphicon-info-sign"></span>&nbsp;
                                                You will not be able to attempt quizzes and download learning material
                                        </p>
                                    </div>
                                </asp:Panel>
                                <b>Prerequisite</b><br />
                                <%
                                    ArrayList allPrereq = ceDAO.getPrereqOfCourse(courseID);
                                    if (allPrereq.Count > 0)
                                    {
                                        Boolean checkDisplay = false;
                                        Response.Write("<ul>");
                                        foreach (Course_elearn ce in allPrereq)
                                        {
                                            if (ce.getStatus().Equals("active") && (ce.getStartDate() <= DateTime.Now.Date && ce.getExpiryDate() >= DateTime.Now.Date))
                                            {
                                                checkDisplay = true;
                                                Response.Write($"<li><a href=\"viewModuleInfo.aspx?id={ce.getCourseID()}\">{ce.getCourseName()}</a></li>");
                                            }
                                        }

                                        Response.Write("</ul>");
                                        if (!checkDisplay)
                                        {
                                            Response.Write("-");
                                            Response.Write("<br />");
                                            Response.Write("<br />");
                                        }
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
                                <b>Course Availability Period</b><br />
                                <asp:Label ID="lblCoursePeriodStart" runat="server"></asp:Label>
                                <br />
                                <asp:Label ID="lblCoursePeriodEnd" runat="server"></asp:Label>
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
                                                                             if (user == null)
                                                                             {

                                                                             }
                                                                             else if (superuser || user.getDepartment().Equals("hr"))
                                                                             {%><a href="javascript:void(0);" data-toggle="collapse" data-target="#addTestimonial"><span class="label label-default pull-right"><span class="glyphicon glyphicon-pencil"></span></span></a><%} %></h3>
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
                                    User courseCreator = ceDAO.get_course_by_id(courseID).getCourseCreator();
                                    if (user == null)
                                    {

                                    }
                                    else if (superuser || user.getDepartment().Equals("hr"))
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
                            <asp:LinkButton ID="LinkButton4" runat="server" class="list-group-item" OnClick="moduleInfo_Click" CausesValidation="false">Course Info&emsp;</asp:LinkButton>
                            <asp:LinkButton ID="LinkButton5" runat="server" class="list-group-item active" OnClick="learningMat_Click" CausesValidation="false"><span class="glyphicon glyphicon-folder-open"></span>&emsp;Learning Materials &emsp;</asp:LinkButton>
                            <asp:LinkButton ID="LinkButton6" runat="server" class="list-group-item" OnClick="quizzes_Click" CausesValidation="false">Quizzes &emsp;</asp:LinkButton>

                        </div>
                    </div>


                    <div class="col-md-9">
                        <%--Each panel for one upload--%>
                        <%
                            User currentUser = (User)Session["currentUser"];
                            if (currentUser != null)
                            {
                                if (current.getStatus().Equals("inactive") || !(DateTime.Compare(current.getStartDate(), DateTime.Now) < 0 && DateTime.Compare(current.getExpiryDate(), DateTime.Now) > 0))
                                {
                                    Response.Write("Course is currently not available.");
                                }
                                else { 
                                Course_elearnDAO cdao = new Course_elearnDAO();
                                ArrayList list = cdao.get_uploaded_content_by_id(current);%>
                        <%
    string strfile = "";
    string dir = "Data/" + current.getCourseID();
    Boolean delete_path = false;
    foreach (Upload u in list)
    {
        //edit the getUploadID in dao to return video content also
        string title = null;
        string desc = null;
        string link = null;
        Boolean show_both = false;
        DateTime date = DateTime.Now;
        //Response.Write(u.upload_type);
        if (u.upload_type.Equals("file") || u.upload_type.Equals("both"))
        {
            foreach (string str in Directory.GetFiles(Server.MapPath(dir)))
            {
                //Response.Write(u.getServerPath());
                if (u.getServerPath() != null && u.getServerPath().Equals(str))
                {
                    //Response.Write(u.upload_type);
                    title = u.getTitle();
                    desc = u.getDesc();
                    date = u.getDate();
                    //Response.Write(title);
                    strfile = str;
                    delete_path = true;
                    if (u.upload_type.Equals("both"))
                    {
                        link = u.video_link;
                        date = u.getDate();
                        show_both = true;
                        delete_path = false;
                    }
                }
            }
        }
        else
        {
            title = u.getTitle();
            desc = u.getDesc();
            date = u.getDate();
            link = u.video_link;
            delete_path = false;

        }
        //Response.Write(strfile);

                                %>
                        <div class="panel panel-primary">   
                            <div class="panel-heading">
                                <h3 class="panel-title">
                                    <%=title %>
                                    <asp:Label ID="lblUploadTitle" runat="server"></asp:Label>
                                    <%  User user = (User)Session["currentUser"];
    Course_elearnDAO ceDAO = new Course_elearnDAO();
    int courseID = Convert.ToInt32(Request.QueryString["id"]);
    User courseCreator = ceDAO.get_course_by_id(courseID).getCourseCreator();

    if (user == null)
    {
        //Response.Redirect("login.aspx");
    }
    else if (superuser || user.getDepartment().Equals("hr") || currentUser.getUserID() == courseCreator.getUserID())
    {
        if (delete_path)
        {%>
                                    <a href="deleteMaterial.aspx?id=<%=current.getCourseID()%>&path=<%=strfile%>" onclick="return confirm('Are you sure?')"><span class="label label-danger pull-right"><span class="glyphicon glyphicon-trash"></span></span></a></strong><br />
                                    <%      }
    else if (show_both)
    {%>
                                    <a href="deleteBoth.aspx?id=<%=current.getCourseID()%>&path=<%=strfile%>&video_link=<%=u.video_link%>" onclick="return confirm('Are you sure?')"><span class="label label-danger pull-right"><span class="glyphicon glyphicon-trash"></span></span></a></strong><br />
                                        <%}
    else
    { %>
                                        <a href="deleteMaterialLink.aspx?id=<%=current.getCourseID()%>&video_link=<%=u.video_link%>" onclick="return confirm('Are you sure?')"><span class="label label-danger pull-right"><span class="glyphicon glyphicon-trash"></span></span></a></strong><br />
                                    <%}
    } %>
                                </h3>
                            </div>
                            <div class="panel-body">
                                Uploaded on:
                                <%= date.ToShortDateString() %>
                                <asp:Label ID="lblUploadDate" runat="server"></asp:Label><br />
                                <%= desc %>
                                <asp:Label ID="lblUploadDescription" runat="server"></asp:Label>
                                <br />
                                <br />
                                <% if (delete_path)
    {
        string var = dir + "/" + Path.GetFileName(strfile);
        if (Path.GetExtension(var).Equals(".pdf"))
        {
            var = "ViewerJS/#../" + dir + "/" + Path.GetFileName(strfile);
        }%>
                                <a href="<%=var %>"><%=Path.GetFileName(strfile) %></a><br />
                                <% }
    else if (show_both)
    {
        string var = dir + "/" + Path.GetFileName(strfile);
        //Response.Write(var);
        if (Path.GetExtension(var).Equals(".pdf"))
        {
            var = "ViewerJS/#../" + dir + "/" + Path.GetFileName(strfile);
        }
        string replace = link;
        if (link == null)
        {

        }
        else if (link.Contains("watch?v="))
        {
            replace = link.Replace("watch?v=", "embed/");
        }
                                        %>
                                     
                                
                                     <iframe width="560" height="315" src="<%=replace %>" frameborder="0" allowfullscreen></iframe><br /><br />
                                    <a href="<%=var %>"><%=Path.GetFileName(strfile) %></a><br />
                                    <%
                                        }
                                        else
                                        {
                                            string replace = link;
                                            if (link != null)
                                            {
                                                if (link.Contains("watch?v="))
                                                {
                                                    replace = link.Replace("watch?v=", "embed/");
                                                }
                                            }
                                            %>
                                <iframe width="560" height="315" src="<%=replace %>" frameborder="0" allowfullscreen></iframe>
                                <%} %>
                            </div>
                        </div>
                        <%
                                    }
                                }
                            }
                            else
                            {
                                Response.Write("Please login to view learning materials.");
                            }
                        %>
                    </div>
                </div>
            </asp:Panel>
            <asp:Panel ID="viewQuizzes" runat="server" Visible="false">
                <div class="row">
                    <div class="col-md-3">
                        <div class="list-group">
                            <asp:LinkButton ID="LinkButton8" runat="server" class="list-group-item" OnClick="moduleInfo_Click" CausesValidation="false">Course Info</asp:LinkButton>
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
                            if (currentUser != null)
                            {
                                if (current.getStatus().Equals("inactive") || !(DateTime.Compare(current.getStartDate(), DateTime.Now) < 0 && DateTime.Compare(current.getExpiryDate(), DateTime.Now) > 0))
                                {
                                    Response.Write("Course is currently not available.");
                                }
                                else if (allQuizzes.Count != 0)
                                {
                                    foreach (Quiz q in allQuizzes)
                                    {
                        %>
                        <div class="panel panel-primary">
                            <div class="panel-heading">
                                <h3 class="panel-title">
                                    <% 
                                        Response.Write(q.getTitle());
                                        Course_elearnDAO ceDAO = new Course_elearnDAO();
                                        User courseCreator = ceDAO.get_course_by_id(courseID).getCourseCreator();
                                        if (currentUser != null && (currentUser.getUserID() == courseCreator.getUserID() || superuser))
                                        {
                                    %>
                                    <a href="editQuiz.aspx?id=<%=q.getQuizID()%>" class="label label-default pull-right"><span class="glyphicon glyphicon-pencil"></span></a>
                                    <% } %>
                                </h3>
                            </div>
                            <div class="panel-body">
                                <% Response.Write(q.getDescription()); %>
                                <br />
                                <br />
                                <%
                                    if (q.getMultipleAttempts().Equals("n"))
                                    {
                                        int numOfAttempts = qrDAO.getNumberOfAttempts(currentUser.getUserID(), q.getQuizID());
                                        if (numOfAttempts < q.getNumberOfAttempts())
                                        {
                                %>
                                <div class="pull-right">
                                    <a href="quiz.aspx?id=<%=q.getQuizID()%>" class="btn btn-success btn-sm">Attempt Quiz</a>&nbsp; 
                                </div>
                                <br />
                                <%
                                }
                                else
                                {
                                %>
                                <div class="pull-right">
                                    <asp:Label ID="lblAttemptMsg" runat="server" CssClass="label label-danger" Font-Size="Small" Text="You have used up all your attempts" />&nbsp;
                                </div>
                                <br />
                                <%
                                    }
                                }
                                else
                                {
                                %>
                                <div class="pull-right">
                                    <a href="quiz.aspx?id=<%=q.getQuizID()%>" class="btn btn-success btn-sm">Attempt Quiz</a>&nbsp; 
                                </div>
                                <br />

                                <%}
                                    List<QuizResult> allAttempts = qrDAO.getQuizResultAttemptsByQuizIDandUserID(q.getQuizID(), currentUser.getUserID());
                                    if (allAttempts.Count > 0)
                                    {
                                        Response.Write("<br/><hr />");
                                        Response.Write("<table class=\"table table-striped\">");
                                        Response.Write("<thead><tr>");
                                        Response.Write("<th>Attempt #</th>");
                                        Response.Write("<th>Date</th>");
                                        Response.Write("<th>Score</th>");
                                        Response.Write("<th>Status</th></tr></thead>");

                                        foreach (QuizResult qr in allAttempts)
                                        {
                                            List<QuizQuestion> allQuestions = qqDAO.getAllQuizQuestionByQuizID(qr.getQuiz().getQuizID());
                                            string displayAnswer = q.getDisplayAnswer();
                                            Response.Write("<tr>");
                                            if (displayAnswer.Equals("always"))
                                            {
                                                Response.Write($"<td><a href=\"viewResults.aspx?id={qr.getQuizResultID()}\">Attempt {qr.getAttempt()}</a></td>");
                                            }
                                            else if (displayAnswer.Equals("never"))
                                            {
                                                Response.Write($"<td><a href=\"noResult.aspx?id={qr.getQuizResultID()}\">Attempt {qr.getAttempt()}</a></td>");
                                            }
                                            else
                                            {
                                                Boolean checkIfUserPassQuiz = qrDAO.checkIfUserPassQuiz(currentUser.getUserID(), q.getQuizID());
                                                if (checkIfUserPassQuiz)
                                                {
                                                    Response.Write($"<td><a href=\"viewResults.aspx?id={qr.getQuizResultID()}\">Attempt {qr.getAttempt()}</a></td>");
                                                }
                                                else
                                                {
                                                    Response.Write($"<td><a href=\"viewMyResult.aspx?id={qr.getQuizResultID()}\">Attempt {qr.getAttempt()}</a></td>");
                                                }
                                            }
                                            Response.Write($"<td>{qr.getDateSubmitted().ToString("dd/MM/yyyy")}</td>");
                                            Response.Write($"<td>{qr.getScore()}/{allQuestions.Count}</td>");
                                            Response.Write($"<td>{qr.getGrade()}</td>");
                                            Response.Write("</tr>");
                                        }
                                        Response.Write("</table>");
                                    }
                                %>
                            </div>
                        </div>
                        <%
                                    }
                                }
                                else
                                {
                                    Response.Write("There are currently no quizzes created!");
                                }
                            }
                            
                            else
                            {
                                Response.Write("Please login to attempt quiz.");
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

                        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
                        <asp:UpdatePanel ID="UpdatePanel1" runat="server">

                            <ContentTemplate>
                                <asp:RadioButtonList ID="rblUploadType" runat="server" OnSelectedIndexChanged="rblUploadType_SelectedIndexChanged" AutoPostBack="true">
                                    <asp:ListItem Value="file">File</asp:ListItem>
                                    <asp:ListItem Value="video">Video</asp:ListItem>
                                    <asp:ListItem Value="both">Both</asp:ListItem>
                                </asp:RadioButtonList>
                                <asp:RequiredFieldValidator ID="rfv_rblUploadType" runat="server" ErrorMessage="Please select and upload type" ControlToValidate="rblUploadType" ForeColor="Red" Display="Dynamic" ValidationGroup="ValidateForm2"></asp:RequiredFieldValidator>
                                <asp:Panel ID="fileOnlyPanel" runat="server" Visible="false">
                                    <label class="control-label">Upload File Only</label>
                                    <div class="form-group">

                                        <div class="col-lg-12">
                                            <p>
                                                <asp:TextBox ID="uploadTitleInput" runat="server" CssClass="form-control" placeholder="Enter Upload Title"></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="rfv_uploadTitleInput" runat="server" ErrorMessage="Please enter a Title" ControlToValidate="uploadTitleInput" ForeColor="Red" Display="Dynamic" ValidationGroup="ValidateForm2"></asp:RequiredFieldValidator>
                                                <asp:CustomValidator ID="cv_uploadTitleInput" runat="server" ErrorMessage="This title already exists! Please enter a different title" OnServerValidate="checkTitleExists" ForeColor="Red" ValidationGroup="ValidateForm2" Display="Dynamic"></asp:CustomValidator>
                                            </p>
                                            <br />
                                        </div>


                                    </div>
                                    <div class="form-group">
                                        <div class="col-lg-12">
                                            <p>
                                                <asp:TextBox ID="uploadDescriptionInput" TextMode="multiline" Columns="50" Rows="5" runat="server" CssClass="form-control" placeholder="Enter Upload Description"></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="rfv_uploadDescriptionInput" runat="server" ErrorMessage="Please enter a Description" ControlToValidate="uploadDescriptionInput" ForeColor="Red" Display="Dynamic" ValidationGroup="ValidateForm2"></asp:RequiredFieldValidator>
                                            </p>
                                            <br />
                                        </div>
                                    </div>
                                    <%--Positioning for buttons--%>
                                    <asp:FileUpload ID="FileUpload1" runat="server" Visible="False" />
                                    <asp:RequiredFieldValidator ID="rfv_FileUpload1" runat="server" ErrorMessage="Please select an item to upload!" ControlToValidate="FileUpload1" ForeColor="Red" Display="Dynamic" ValidationGroup="ValidateForm2"></asp:RequiredFieldValidator>
                                    <asp:CustomValidator ID="cv_FileUpload1" runat="server" ErrorMessage="This file already exists! Please upload a different file" OnServerValidate="checkUploadNameExists" ForeColor="Red" ValidationGroup="ValidateForm2" Display="Dynamic"></asp:CustomValidator>
                                    <br />
                                </asp:Panel>
                                
                                <asp:Panel ID="videoOnlyPanel" runat="server" Visible="false">
                                    <label class="control-label">Upload Video Only</label>
                                    <div class="form-group">
                                        <div class="col-lg-12">
                                            <p>
                                                <asp:TextBox ID="uploadTitleInput2" runat="server" CssClass="form-control" placeholder="Enter Upload Title"></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="rfv_uploadTitleInput2" runat="server" ErrorMessage="Please enter a Title" ControlToValidate="uploadTitleInput2" ForeColor="Red" Display="Dynamic" ValidationGroup="ValidateForm2"></asp:RequiredFieldValidator>
                                                <asp:CustomValidator ID="cv_uploadTitleInput2" runat="server" ErrorMessage="This title already exists! Please enter a different title" OnServerValidate="checkTitleExists" ForeColor="Red" ValidationGroup="ValidateForm2" Display="Dynamic"></asp:CustomValidator>
                                            </p>
                                            <br />
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <div class="col-lg-12">
                                            <p>
                                                <asp:TextBox ID="uploadDescriptionInput2" TextMode="multiline" Columns="50" Rows="5" runat="server" CssClass="form-control" placeholder="Enter Upload Description"></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="rfv_uploadDescriptionInput2" runat="server" ErrorMessage="Please enter a Description" ControlToValidate="uploadDescriptionInput2" ForeColor="Red" Display="Dynamic" ValidationGroup="ValidateForm2"></asp:RequiredFieldValidator>
                                            </p>
                                            <br />
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <div class="col-lg-12">
                                            <p>
                                                <asp:TextBox ID="txtVideo" runat="server" CssClass="form-control" placeholder="Enter YouTube Link"></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="rfv_txtVideo" runat="server" ErrorMessage="Please select a link to upload!" ControlToValidate="txtVideo" ForeColor="Red" Display="Dynamic" ValidationGroup="ValidateForm2"></asp:RequiredFieldValidator>
                                            </p>
                                            <br />
                                        </div>
                                    </div>
                                </asp:Panel>
                                <asp:Panel ID="bothPanel" runat="server" Visible="false">
                                    <label class="control-label">Upload File and Video</label>
                                    <div class="form-group">
                                        <div class="col-lg-12">
                                            <p>                                             
                                                <asp:TextBox ID="uploadTitleInput3" runat="server" CssClass="form-control" placeholder="Enter Upload Title"></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="rfv_uploadTitleInput3" runat="server" ErrorMessage="Please enter a Title" ControlToValidate="uploadTitleInput3" ForeColor="Red" Display="Dynamic" ValidationGroup="ValidateForm2"></asp:RequiredFieldValidator>
                                                <asp:CustomValidator ID="cv_uploadTitleInput3" runat="server" ErrorMessage="This title already exists! Please enter a different title" OnServerValidate="checkTitleExists" ForeColor="Red" ValidationGroup="ValidateForm2" Display="Dynamic"></asp:CustomValidator>
                                            </p>
                                            <br />
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <div class="col-lg-12">
                                            <p>
                                                <asp:TextBox ID="uploadDescriptionInput3" TextMode="multiline" Columns="50" Rows="5" runat="server" CssClass="form-control" placeholder="Enter Upload Description"></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="rfv_uploadDescriptionInput3" runat="server" ErrorMessage="Please enter a Description" ControlToValidate="uploadDescriptionInput3" ForeColor="Red" Display="Dynamic" ValidationGroup="ValidateForm2"></asp:RequiredFieldValidator>
                                            </p>
                                            <br />
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <div class="col-lg-12">
                                            <p>
                                                <asp:TextBox ID="txtVideo2" runat="server" CssClass="form-control" placeholder="Enter YouTube Link"></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="rfv_txtVideo2" runat="server" ErrorMessage="Please select a link to upload!" ControlToValidate="txtVideo2" ForeColor="Red" Display="Dynamic" ValidationGroup="ValidateForm2"></asp:RequiredFieldValidator>
                                            </p>
                                            <br />
                                        </div>
                                    </div>
                                <asp:FileUpload ID="FileUpload2" runat="server" Visible="False" />     
                                   <asp:RequiredFieldValidator ID="rfv_FileUpload2" runat="server" ErrorMessage="Please select an item to upload!" ControlToValidate="FileUpload2" ForeColor="Red" Display="Dynamic" ValidationGroup="ValidateForm2"></asp:RequiredFieldValidator> 
                                    <asp:CustomValidator ID="cv_FileUpload2" runat="server" ErrorMessage="This file already exists! Please upload a different file" OnServerValidate="checkUploadNameExists" ForeColor="Red" ValidationGroup="ValidateForm2" Display="Dynamic"></asp:CustomValidator>
                                </asp:Panel>
                                
                            </ContentTemplate>
                            <Triggers>
                                <asp:AsyncPostBackTrigger ControlID="rblUploadType" EventName="SelectedIndexChanged" />
                            </Triggers>
                        </asp:UpdatePanel>
                    </div>
                    <div class="modal-footer">
                        <asp:Button ID="Button1" class="btn btn-primary" runat="server" Text="Upload"
                            OnClick="upload_click" CausesValidation="True" />
                        <asp:Button ID="Button2" CssClass="btn btn-default" runat="server" class="close" data-dismiss="modal" Text="Go Back" />

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
