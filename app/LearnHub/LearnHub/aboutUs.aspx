<%@ Page Title="" Language="C#" MasterPageFile="~/Masterpage.Master" AutoEventWireup="true" CodeBehind="aboutUs.aspx.cs" Inherits="LearnHub.aboutUs" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
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
<%@ Import Namespace="LearnHub.AppCode.dao" %>
<%@ Import Namespace="LearnHub.AppCode.entity" %>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <ul class="breadcrumb">
        <li><a href="home.aspx">Home</a></li>
        <li class="active">About Us</li>
    </ul>

     <div class="container">
        <h1>About Us</h1>
         <%
             User currentUser = (User)Session["currentUser"];
             Boolean superuser = false;
             Boolean content_creator = false;
             if (currentUser != null)
             {
                 foreach (string s in currentUser.getRoles())
                 {
                     if (s.Equals("superuser"))
                     {
                         superuser = true;
                     }
                     else if (s.Equals("content creator"))
                     {
                         content_creator = true;
                     }
                 }
                 if (currentUser != null && (content_creator || superuser))
                 {
        %>
          <div class="dropdown" style="float: right;">
            <button class="dropbtn" onclick="return false;"><span class="glyphicon glyphicon-option-horizontal"></span></button>
            <div class="dropdown-content" style="right: 0;">
                <div class="dropHeader">Content Management</div>
                <a href="editAboutUs.aspx"><span class="glyphicon glyphicon-pencil"></span>&nbsp;&nbsp;Edit About Us</a>
                <a href="manageArticles.aspx"><span class="glyphicon glyphicon-duplicate"></span>&nbsp;&nbsp;Manage Articles</a>
                <a href="manageUsefulLinks.aspx"><span class="glyphicon glyphicon-globe"></span>&nbsp;&nbsp;Manage Links</a>
                <a href="manageContactUs.aspx"><span class="glyphicon glyphicon-earphone"></span>&nbsp;&nbsp;Manage Contact Us</a>
                <a href="uploadTrainingCalendar.aspx"><span class="glyphicon glyphicon-calendar"></span>&nbsp;&nbsp; Upload Training Calendar</a>


                </div>
        </div>
         <%
                 }
             }
         %>
        <div class="verticalLine"></div>
    </div>

    <div class="container">
        <br />
        Content goes here - everything that was entered in ckeditor in editAboutUs.aspx
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
