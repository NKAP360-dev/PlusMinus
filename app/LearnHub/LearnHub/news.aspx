<%@ Page Title="" Language="C#" MasterPageFile="~/Masterpage.Master" AutoEventWireup="true" CodeBehind="news.aspx.cs" Inherits="LearnHub.news" %>

<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="LearnHub.AppCode.dao" %>
<%@ Import Namespace="LearnHub.AppCode.entity" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
         .breadcrumb {
            padding-top: 15px;
            margin-bottom: 10px;
            list-style: none;
            background-color: white;
            border-radius: 0px;
        }

        .panel-default {
            box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2);
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <form runat="server" class="form-horizontal">
        <ul class="breadcrumb">
            <li><a href="Home.aspx">Home</a></li>
            <li class="active"><asp:Label ID="lblNewsTitle" runat="server" Text="News Title"></asp:Label></li>
        </ul>

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
            <div class ="pull-right">
        <div class="dropdown" style="float: right;">
            <button class="dropbtn" onclick="return false;"><span class="glyphicon glyphicon-option-horizontal"></span></button> &emsp;
            <div class="dropdown-content" style="right: 0;">
                <div class="dropHeader">Resource Management</div>
                <a href="editAboutUs.aspx"><span class="glyphicon glyphicon-pencil"></span>&nbsp;&nbsp;Edit About Us</a>
                <a href="manageArticles.aspx"><span class="glyphicon glyphicon-duplicate"></span>&nbsp;&nbsp;Manage Articles</a>
                <a href="manageUsefulLinks.aspx"><span class="glyphicon glyphicon-globe"></span>&nbsp;&nbsp;Manage Links</a>
                <a href="manageContactUs.aspx"><span class="glyphicon glyphicon-earphone"></span>&nbsp;&nbsp;Manage Contact Us</a>
                <a href="uploadTrainingCalendar.aspx"><span class="glyphicon glyphicon-calendar"></span>&nbsp;&nbsp; Upload Training Calendar</a>
                        <a href="manageNewsBanners.aspx"><span class="glyphicon glyphicon-picture"></span>&nbsp;&nbsp; Manage News Banners</a>
                        <a href="manageNews.aspx"><span class="glyphicon glyphicon-blackboard"></span>&nbsp;&nbsp; Manage News</a>

                </div>
        </div>
    </div>
       
        <%
                }
            }
            %>

        <div class="container">
            <div class="panel panel-default">
                <div class="panel-body">
                    <%News_highlightsDAO ndao = new News_highlightsDAO();
                        News_highlights n = null;
                        if (Request.QueryString["id"] != null)
                        {
                            string id_str = Request.QueryString["id"];
                            int id_num = int.Parse(id_str);
                            n = ndao.getHighlightById(id_num);
                        }
                        else
                        {
                            Response.Redirect("errorPage.aspx");
                        }
                        %>
                    <h1><%=n.title %></h1>
                    <hr />
                    <p><%=n.news_text %></p>
                </div>
            </div>
        </div>
    </form>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
