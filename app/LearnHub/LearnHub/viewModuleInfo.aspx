<%@ Page Title="" Language="C#" MasterPageFile="~/Masterpage.Master" AutoEventWireup="true" CodeBehind="viewModuleInfo.aspx.cs" Inherits="LearnHub.viewModuleInfo" %>

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
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <% 
        int courseID = Convert.ToInt32(Request.QueryString["id"]);
        User currentUser = (User)Session["currentUser"];
        Course_elearnDAO ceDAO = new Course_elearnDAO();
        User courseCreator = ceDAO.get_course_by_id(courseID).getCourseCreator();
        if (currentUser != null && (currentUser.getUserID() == courseCreator.getUserID() || currentUser.getRole().Equals("superuser")))
        {
    %>
    <div class="configure">
        <a href="#" id="config" onclick="configuration()"><span class="label label-default"><span class="glyphicon glyphicon-cog"></span>Configuration Menu</span></a>
    </div>
    <br />
    <div class="configure">
        <ul class="list-group" id="menu" style="display: none;">
            <a href="editModuleInfo.aspx?id=<%=courseID %>">
                <li class="list-group-item"><span class="glyphicon glyphicon-pencil"></span>&emsp;Edit/Delete Module
                </li>
            </a>
            <a href="#uploadModal" data-toggle="modal">
                <li class="list-group-item"><span class="glyphicon glyphicon-level-up"></span>&emsp;Upload Learning Materials
                </li>
            </a>
        </ul>
    </div>
    <%} %>
    <form class="form-horizontal" runat="server">
        <div class="container">
            <h1>
                <asp:Label ID="lblCourseNameHeader" runat="server" Text="courseName"></asp:Label></h1>

            <div class="verticalLine"></div>
        </div>

        <div class="container">
            <div class="row">
                <div class="col-md-3">
                    <div class="wrapper">
                        <h4><strong><span class="glyphicon glyphicon-menu-hamburger">&emsp;</span>View Module Information</strong></h4>
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
                                <h3 class="panel-title">Details</h3>
                            </div>
                            <div class="panel-body">
                                <strong>
                                    <asp:Label ID="hoursLabel" runat="server" Text="Hours awarded after completion"></asp:Label></strong><br />
                                <asp:Label ID="hoursOutput" runat="server" Text="2"></asp:Label>
                                <br />
                                <br />
                                blahblah any other info timing date etc etc 
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
                                <h3 class="panel-title">Comments&emsp; <a href="#" data-toggle="collapse" data-target="#addComment"><span class="label label-default pull-right"><span class="glyphicon glyphicon-pencil"></span></span></a></h3>
                            </div>
                            <div class="panel-body">
                                <div class="collapse" id="addComment">
                                    <h4><strong>Add new comment</strong></h4>
                                    <fieldset>
                                        <div class="form-group">
                                            <div class="col-lg-10">
                                                <asp:TextBox ID="inputCommentTitle" runat="server" CssClass="form-control" placeholder="Title"></asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <div class="col-lg-10">
                                                <asp:TextBox ID="inputCommentBody" TextMode="multiline" Columns="50" Rows="5" runat="server" CssClass="form-control" placeholder="Comment"></asp:TextBox>
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
                                    <asp:Label ID="lblCommentUser" runat="server" Text="Rafid Aziz"></asp:Label></strong><br />
                                <asp:Label ID="lblCommentDate" runat="server" Text="24th July 2017"></asp:Label>
                                <br />
                                <br />
                                <strong>
                                    <asp:Label ID="lblCommentTitle" runat="server" Text="About Ming Kwang"></asp:Label>&emsp;<a href="#" data-toggle="modal" data-target="#deleteComment"><span class="label label-danger pull-right"><span class="glyphicon glyphicon-trash"></span></span></a></strong><br />
                                <asp:Label ID="lblCommentBody" runat="server" Text="Ming Kwang is my idol, I aspire to be like him"></asp:Label>
                                <hr />
                                <strong>
                                    <asp:Label ID="Label1" runat="server" Text="Eugene Tan Wei Hong"></asp:Label></strong><br />
                                <asp:Label ID="Label2" runat="server" Text="24th July 2017"></asp:Label>
                                <br />
                                <br />
                                <strong>
                                    <asp:Label ID="Label3" runat="server" Text="About Rafid"></asp:Label>&emsp;<a href="#" data-toggle="modal" data-target="#deleteComment"><span class="label label-danger pull-right"><span class="glyphicon glyphicon-trash"></span></span></a></strong><br />
                                <asp:Label ID="Label4" runat="server" Text="Ming Kwang is my idol, but Rafid is my senpai"></asp:Label>
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
                            string dir = "~/Data/" + current.getCourseName();
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
                                <a href="<%=Path.GetFileName(strfile) %>" download><%=Path.GetFileName(strfile) %></a><br />
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
                            <h4>Are you sure you want to delete the following comment?</h4><br />
                            "
                            <asp:Label ID="Label5" runat="server" Text="Ming Kwang is my idol, but Rafid is my senpai"></asp:Label>"

                            <br /><br />
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
