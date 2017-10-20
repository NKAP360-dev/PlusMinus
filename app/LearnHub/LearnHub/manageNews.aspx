<%@ Page Title="" Language="C#" MasterPageFile="~/Masterpage.Master" AutoEventWireup="true" CodeBehind="manageNews.aspx.cs" Inherits="LearnHub.manageNews" %>

<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Collections" %>
<%@ Import Namespace="LearnHub.AppCode.dao" %>
<%@ Import Namespace="LearnHub.AppCode.entity" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="Scripts/footable.bootstrap.min.css" rel="stylesheet" />
    <script src="Scripts/footable.min.js"></script>

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

        .dropdown {
            z-index: 100;
        }
    </style>
        <script>
        jQuery(function ($) {
            $('.table').footable({
                "paging": {
                    "size": 10 <%--Change how many rows per page--%>
                },
                "filtering": {
                    "position": "left"
                }
            });
        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<ul class="breadcrumb">
        <li><a href="home.aspx">Home</a></li>
        <li class="active">Manage News</li>
    </ul>

    <form runat="server" class="form-horizontal">
    <div class="container">
        <h1>Manage News
          <a href="addNews.aspx" class="btn btn-success">Add News</a>
        </h1>
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
                    <a href="manageNewsBanners.aspx"><span class="glyphicon glyphicon-picture"></span>&nbsp;&nbsp; Manage News Banners</a>
                    <a href="manageNews.aspx"><span class="glyphicon glyphicon-blackboard"></span>&nbsp;&nbsp; Manage News</a>

                </div>
            </div>

            <%
                    }
                }
            %>

            <div class="verticalLine"></div>
            <table class="table table-striped table-hover" data-paging="true" data-sorting="true" data-filtering="true">
                <thead>
                    <tr>
                        <th width="70%">News Title</th>
                        <th>Type</th>
                        <th>Date Posted</th>
                        <th data-filterable="false" data-sortable="false"></th>
                        
                    </tr>
                </thead>
                
                <tbody>
                    <%News_highlightsDAO ndao = new News_highlightsDAO();
                    ArrayList arr = ndao.getNewsHighlights();
                    foreach (News_highlights news in arr)
                    {%>
                    <tr><td><a href="news.aspx?id=<%=news.highlight_id %>"><%=news.title %></a></td>
                        <td><%=news.type %></td>
                        <td><%=news.entry_time.ToShortDateString() %></td>
                        <td><a href="editNews.aspx?id=<%=news.highlight_id %>" class="btn btn-sm btn-info"><span class="glyphicon glyphicon-pencil"></span></a><a href="deleteNewsHighlight.aspx?id=<%=news.highlight_id %>" class="btn btn-sm btn-danger" onclick="return confirm('Are you sure?')"><span class="glyphicon glyphicon-trash"></span></a></td>
                    </tr>
                    <%} %>
                    </tbody>
                
                </table>
    </div>
        </form>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
