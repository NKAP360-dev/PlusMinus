
<%@ Page Title="" Language="C#" MasterPageFile="~/Masterpage.Master" AutoEventWireup="true" CodeBehind="article.aspx.cs" Inherits="LearnHub.article" %>

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
            <li><a href="home.aspx">Home</a></li>
            <li><a href="usefulInfo.aspx">Useful Information</a></li>
            <%ArticleDAO adao = new ArticleDAO();
                     Article article = adao.getArticleById(id_num);
                            %>
            <li class="active">
                <asp:Label ID="lblArticleTitle"><%=article.article_name %></asp:Label></li>
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
                <div class="dropHeader">Content Management</div>
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
            <div class="col-lg-9">
                
                <div class="panel panel-default">
                    <div class="panel-body">
                         <h1><%=article.article_name %> </h1>
                        <hr />
                        <p><%=article.article_body %></p>
                        <br />
                    </div>
                </div>  
            </div>
            
            <div class="col-lg-3">
                <div class="panel panel-default">
                    <div class="panel-body">
                        <h4><strong>Recent Posts</strong></h4>

                        <hr />
                        <%
                            ArrayList a1 = adao.getArticles();
                            foreach (Article a in a1)
                            {
                                    %>
                        <ul>
                            <li><a href="article.aspx?id=<%=a.article_id %>"><%=a.article_name %></a></li>
                         </ul>
                        <%} %>
                        <br />
                        <br />
                       <div class="pull-right">
                            <a href="viewAllArticles.aspx"><span class="glyphicon glyphicon-menu-right"></span>&nbsp; View All</a>
                       </div>
                </div>
            </div>
        </div>   
    </div>
    </form>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
