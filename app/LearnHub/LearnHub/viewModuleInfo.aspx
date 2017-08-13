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
  <li class="active"><asp:Label ID="lblBreadcrumbCourseName" runat="server" Text="courseName"></asp:Label></li>
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
                            <asp:LinkButton ID="LinkButton1" runat="server" class="list-group-item active" OnClick="moduleInfo_Click"><span class="glyphicon glyphicon-info-sign"></span>&emsp;Module Info&emsp;</asp:LinkButton>
                            <asp:LinkButton ID="LinkButton2" runat="server" class="list-group-item" OnClick="learningMat_Click">Learning Materials &emsp;</asp:LinkButton>
                            <asp:LinkButton ID="LinkButton3" runat="server" class="list-group-item" OnClick="quizzes_Click">Quizzes &emsp;</asp:LinkButton>
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
                                <%
                                    int cseID = Convert.ToInt32(Request.QueryString["id"]);
                                    User curUser = (User)Session["currentUser"];
                                    Course_elearnDAO ceDAO = new Course_elearnDAO();
                                    User cc = ceDAO.get_course_by_id(cseID).getCourseCreator();
                                    if (curUser != null && (curUser.getUserID() == cc.getUserID() || curUser.getRole().Equals("superuser")))
                                    {
                                %>
                                    <a href="#" data-toggle="collapse" data-target="#editDetails"><span class="label label-default pull-right"><span class="glyphicon glyphicon-pencil"></span></span></a>
                                <%} %>
                                </h3>
                            </div>
                            <div class="panel-body">
                                <div class="collapse" id="editDetails">
                                    <h4><strong>Edit Other Details</strong></h4>
                                    <fieldset>
                                        <div class="form-group">
                                                <div class="col-lg-12">
                                            <asp:TextBox ID="txtOtherDetails" CssClass="form-control" placeholder="Other Details" runat="server" TextMode="MultiLine"></asp:TextBox>                                    
                                            </div></div>
                                        <div class="form-group">
                                            <div class="col-lg-10">
                                                <asp:Button ID="btnSaveDetails" CssClass="btn btn-primary" runat="server" Text="Save" OnClick="btnSaveDetails_Click" />
                                            </div>
                                        </div>

                                    </fieldset>

                                    <hr />
                                </div>
                                <b>Prerequisite</b><br />
                                <ul><li>hi..</li>
                                    <li>generate...</li>
                                    <li>me...</li>
                                </ul>
                                <b>Learning Hours</b><br />
                                <asp:Label ID="hoursOutput" runat="server" Text=""></asp:Label>
                                <br />
                                <br />
                                <b>Target Audience</b><br />
                                <asp:Label ID="lblTargetAudience" runat="server"></asp:Label>
                                <br /><br />
                                <b>Other Details</b><br/>
                                <asp:Label ID="lblOtherDetails" runat="server" Text="whatever is in that text box will appear here"></asp:Label>
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
                                <h3 class="panel-title">Testimonial&emsp; <a href="javascript:void(0);" data-toggle="collapse" data-target="#addTestimonial"><span class="label label-default pull-right"><span class="glyphicon glyphicon-pencil"></span></span></a></h3>
                            </div>
                            <div class="panel-body">
                                <div class="collapse" id="addTestimonial">
                                    <h4><strong>Add New Testimonial</strong></h4>
                                    <fieldset>
                                        <div class="form-group">
                                            <div class="col-lg-12">
                                                <asp:TextBox ID="txtTestimonial" runat="server" CssClass="form-control" placeholder="Title"></asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <div class="col-lg-12">
                                                <CKEditor:CKEditorControl ID="CKEditorControl2" runat="server">
            </CKEditor:CKEditorControl>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <div class="col-lg-12">
                                                <asp:TextBox ID="txtByWho" runat="server" CssClass="form-control" placeholder="Name"></asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <div class="col-lg-10">
                                                <asp:Button ID="cfmSubmit" CssClass="btn btn-primary" runat="server" Text="Submit" />
                                            </div>
                                        </div>

                                    </fieldset>

                                    <hr />
                                </div>
                                <strong>
                                    <asp:Label ID="lblCommentTitle" runat="server" Text="About the content"></asp:Label></strong>&emsp;<a href="#" data-toggle="modal" data-target="#deleteComment"><span class="label label-danger pull-right"><span class="glyphicon glyphicon-trash"></span></span></a></strong><br />
                                <br />
                                <blockquote>
                                    <asp:Label ID="lblCommentBody" runat="server" Text="Needs more in depth explanation."></asp:Label>
                                    <small>Rafid Aziz</small>
                                </blockquote>
                                <hr />

                                <strong>
                                    <asp:Label ID="Label3" runat="server" Text="About this course"></asp:Label></strong>&emsp;<a href="#" data-toggle="modal" data-target="#deleteComment"><span class="label label-danger pull-right"><span class="glyphicon glyphicon-trash"></span></span></a></strong><br />
                                <br />
                                <blockquote><asp:Label ID="Label4" runat="server" Text="This is an interesting course"></asp:Label>
                                    <small>Eugene Tan Wei Hong</small>
                                </blockquote>                               
                            </div>
                        </div>
                    </div>
                </div>
            </asp:Panel>
            <asp:Panel ID="viewLearningMaterial" runat="server" Visible="false">
                <div class="row">
                    <div class="col-md-3">
                        <div class="list-group">
                            <asp:LinkButton ID="LinkButton4" runat="server" class="list-group-item" OnClick="moduleInfo_Click">Module Info&emsp;</asp:LinkButton>
                            <asp:LinkButton ID="LinkButton5" runat="server" class="list-group-item active" OnClick="learningMat_Click"><span class="glyphicon glyphicon-folder-open"></span>&emsp;Learning Materials &emsp;</asp:LinkButton>
                            <asp:LinkButton ID="LinkButton6" runat="server" class="list-group-item" OnClick="quizzes_Click">Quizzes &emsp;</asp:LinkButton>

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
                                    <asp:LinkButton ID="LinkButton7" CssClass="btn btn-danger btn-xs pull-right" runat="server" Text="" data-toggle="modal" href="#deleteMaterials"><span class="glyphicon glyphicon-trash"></span></asp:LinkButton>
                                </h3>
                            </div>
                            <div class="panel-body">
                                Uploaded on:
                                <asp:Label ID="lblUploadDate" runat="server"><%= date.ToShortDateString() %></asp:Label><br />
                                <asp:Label ID="lblUploadDescription" runat="server"><%= desc %></asp:Label>
                                <br />
                                <br />
                                <% string var = dir + "/" + Path.GetFileName(strfile); %>
                                <a href="<%=var %>" download><%=Path.GetFileName(strfile) %></a><br />
                            </div>
                        </div>
                        <%} %>
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
                                </p>
                                <br />
                            </div>


                        </div>
                        <div class="form-group">
                            <div class="col-lg-12">
                                <p>
                                    <asp:TextBox ID="uploadDescriptionInput" TextMode="multiline" Columns="50" Rows="5" runat="server" CssClass="form-control" placeholder="Enter Upload Description"></asp:TextBox>
                                </p>
                                <br />
                            </div>
                        </div>
                        <%--Positioning for buttons--%>
                        <asp:FileUpload ID="FileUpload1" runat="server" />

                        <br />

                        <div class="modal-footer">

                            <asp:Button ID="Button1" class="btn btn-primary" runat="server" Text="Upload"
                                OnClick="upload_click" />
                            <asp:Button ID="Button2" CssClass="btn btn-default" runat="server" class="close" data-dismiss="modal" Text="Go Back" />

                        </div>
                    </div>
                </div>
            </div>
        </div>
        <%--Delete Comments Modal--%>
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
                            <asp:Label ID="Label5" runat="server" Text="Ming Kwang is my idol, but Rafid is my senpai"></asp:Label>"

                            <br />
                            <br />
                        </div>
                        <div class="modal-footer">
                            <div class="wrapper">
                                <asp:Button ID="deleteBtn" CssClass="btn btn-danger" runat="server" Text="Delete" />
                                <asp:Button ID="Button4" CssClass="btn btn-default" runat="server" class="close" data-dismiss="modal" Text="Go Back" />
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

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
