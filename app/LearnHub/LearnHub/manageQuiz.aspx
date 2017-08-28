<%@ Page Title="" Language="C#" MasterPageFile="~/Masterpage.Master" AutoEventWireup="true" CodeBehind="manageQuiz.aspx.cs" Inherits="LearnHub.manageQuiz" %>

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
        <li class="active">Manage Quizzes</li>
    </ul>

    <div class="container">
        <h1>Manage Quizzes
              <% 
                 User currentUser = (User)Session["currentUser"];
                 Course_elearnDAO ceDAO = new Course_elearnDAO();
                 User courseCreator = ceDAO.get_course_by_id(courseID).getCourseCreator();
                 if (currentUser != null && (currentUser.getUserID() == courseCreator.getUserID() || currentUser.getRole().Equals("superuser")))
                 {
             %>

        <a href="#" id="config" onclick="configuration()" class="btn btn-default pull-right"><span class="glyphicon glyphicon-option-horizontal"></span></a>
        <a href="createQuiz.aspx?id=<%=courseID%>" class="btn btn-success">Add</a>
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
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
