<%@ Page Title="" Language="C#" MasterPageFile="~/Masterpage.Master" AutoEventWireup="true" CodeBehind="viewAllNews.aspx.cs" Inherits="LearnHub.viewAllNews" %>

<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Collections" %>
<%@ Import Namespace="LearnHub.AppCode.dao" %>
<%@ Import Namespace="LearnHub.AppCode.entity" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="https://fonts.googleapis.com/css?family=Biryani:800" rel="stylesheet">
    <style>
        .newsType {
            font-family: 'Biryani', sans-serif !important;
            font-size: 10px;
            text-transform: uppercase !important;
            padding: 3px;
            margin-bottom: 5px;
            color: slategrey;
        }

        .breadcrumb {
            padding-top: 15px;
            margin-bottom: 10px;
            list-style: none;
            background-color: white;
            border-radius: 0px;
        }

        .panel {
            height: 400px;
            position: relative;
        }

        .panel-default {
            box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2);
        }

        .panel-body {
            padding-top: 0px;
            margin-top: 0px;
            color: slategrey;
        }

        .newsImage {
            height: 200px;
            margin-bottom: 5px;
        }

            .newsImage img {
                max-width: 100%;
                max-height: 100%;
                width: 100%;
                height: 100%
            }
    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <ul class="breadcrumb">
        <li><a href="home.aspx">Home</a></li>
        <li class="active">View All News</li>
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

            <%
                    }
                }
            %>

    <%--PULL ALL NEWS TO DISPLAY--%>
    <div class="container">
        
        <%News_highlightsDAO ndao = new News_highlightsDAO();
                    ArrayList highlights = ndao.getNewsHighlights();
                    string dir = "img/highlights";
                    foreach (News_highlights highlight in highlights)
                    {
                        string str = "";
                        foreach (string strfile in Directory.GetFiles(Server.MapPath(dir)))
                        {

                            if (highlight.img_path.Equals(strfile))
                            {
                                str = strfile;

                            }
                        }
                        %>
                <div class="col-md-4">
                    <a href="news.aspx?id=<%=highlight.highlight_id%>">
                        <div class="panel panel-default">
                            <div class="newsImage">
                                <img src="<%= dir+"/"+Path.GetFileName(str)%>" alt="Learnhub">
                                <div class="newsType">
                                    <%=highlight.type %>
                                </div>
                            </div>
                            <div class="panel-body">
                                <h4 class="text-success"><strong><%=highlight.title %></strong></h4>
                                <hr />
                                <p><%=highlight.body %></p>
                                <br />
                            </div>
                        </div>
                    </a>
                </div>
                <%} %>
        
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
