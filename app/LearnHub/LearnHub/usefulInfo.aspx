<%@ Page Title="" Language="C#" MasterPageFile="~/Masterpage.Master" AutoEventWireup="true" CodeBehind="usefulInfo.aspx.cs" Inherits="LearnHub.usefulInfo" %>

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
    <ul class="breadcrumb">
        <li><a href="home.aspx">Home</a></li>
        <li class="active">Useful Information</li>
    </ul>

    <form runat="server" class="form-horizontal">
        <div class="container">
            <div class="col-lg-9">
                 <%ArticleDAO adao = new ArticleDAO();
                     ArrayList a = adao.getArticles();
                     foreach (Article article in a)
                     {
                            %>
                <div class="panel panel-default">
                    <div class="panel-body">
                        <h1><%=article.article_name %> </h1>
                        <hr />
                        <p><%=article.article_body %></p>
                        <br />
                         <div class="pull-right">
                             <a href="article.aspx?id=<%=article.article_id %>"><span class="glyphicon glyphicon-menu-right"></span>&nbsp; Read More</a>
                        </div>

                    </div>
                </div>
                <%} %>
            </div>
             <%
                ArrayList a1 = adao.getArticles();
                foreach (Article article in a1)
                {
                            %>
            <div class="col-lg-3">
                <div class="panel panel-default">
                    <div class="panel-body">
                        <%--Show 10 most recent posts--%>
                        <h4><strong>Recent Posts</strong></h4>
                        <hr />
                        <ul>
                            <li><a href="article.aspx?id=<%=article.article_id %>"><%=article.article_name %></a></li>
                        </ul>
                        <br />
                        <br />
                         <div class="pull-right">
                            <a href="viewAllArticles.aspx"><span class="glyphicon glyphicon-menu-right"></span>&nbsp; View All</a>
                        </div>
                    </div>
                </div>
            </div>
             <%} %>
        </div>
       
    </form>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
