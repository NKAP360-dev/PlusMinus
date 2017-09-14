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
                <div class="panel panel-default">
                    <div class="panel-body">
                        <h1>What is the best fruit on earth? </h1>
                        <hr />
                        <p>
                            <img src="https://i0.wp.com/media.boingboing.net/wp-content/uploads/2015/07/watermelon-shark.jpg?fit=620%2C414" /></p>
                        <p>
                            Helps You Hydrate<br />
Drinking water is an important way to keep your body hydrated.
                            <br />
However, eating foods that have a high water content can also help.
                            <br />
Interestingly, watermelon is 92% water (1).
                            <br />
A high water content is one of the reasons that fruits and vegetables help you feel full. The combination of water and fiber means you're eating a good volume of food without a lot of calories.
                        </p>
                        <br />
                        <div class="pull-right">
                            <%-- PLEASE READ:
                                Not sure if should have Read More? How to determine what will be previewed if have? Can remove if troublesome/not feasible to implement--%>
                            <a href="article.aspx"><span class="glyphicon glyphicon-menu-right"></span>&nbsp; Read More</a>
                        </div>
                    </div>
                </div>

                <div class="panel panel-default">
                    <div class="panel-body">
                        <h1>title </h1>
                        <hr />
                        <p>body</p>
                        <br />
                         <div class="pull-right">
                            <a href="article.aspx"><span class="glyphicon glyphicon-menu-right"></span>&nbsp; Read More</a>
                        </div>

                    </div>
                </div>

                <div class="panel panel-default">
                    <div class="panel-body">
                        <h1>title </h1>
                        <hr />
                        <p>body</p>
                        <br />
                         <div class="pull-right">
                            <a href="article.aspx"><span class="glyphicon glyphicon-menu-right"></span>&nbsp; Read More</a>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-lg-3">
                <div class="panel panel-default">
                    <div class="panel-body">
                        <%--Show 10 most recent posts--%>
                        <h4><strong>Recent Posts</strong></h4>
                        <hr />
                        <ul>
                            <li><a href="article.aspx">What is the best fruit on earth?</a></li>
                            <li>2</li>
                        </ul>
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
