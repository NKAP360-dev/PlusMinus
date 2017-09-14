
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
            <li class="active">
                <asp:Label ID="lblArticleTitle" runat="server" Text="What is the best fruit on earth?"></asp:Label></li>
        </ul>


        <div class="container">
            <div class="col-lg-9">
                <div class="panel panel-default">
                    <div class="panel-body">
                        <h1>What is the best fruit on earth? </h1>
                        <hr />
                        <p>
                            <img src="https://i0.wp.com/media.boingboing.net/wp-content/uploads/2015/07/watermelon-shark.jpg?fit=620%2C414" />
                        </p>
                        <p>
                            Helps You Hydrate<br />
                            Drinking water is an important way to keep your body hydrated.
                            <br />
                            However, eating foods that have a high water content can also help.
                            <br />
                            Interestingly, watermelon is 92% water (1).
                            <br />
                            A high water content is one of the reasons that fruits and vegetables help you feel full. The combination of water and fiber means you're eating a good volume of food without a lot of calories.
                       As far as fruits go, watermelon is one of the lowest in calories — only 46 calories per cup. That's lower than even "low-sugar" fruits such as berries (2).

A cup (154 grams) of watermelon has many other nutrients as well, including these vitamins and minerals:

Vitamin C: 21% of the RDI
Vitamin A: 18% of the RDI
Potassium: 5% of the RDI
Magnesium: 4% of the RDI
Vitamins B1, B5 and B6: 3% of the RDI
Watermelon is also high in carotenoids, including beta-carotene and lycopene. Plus, it has citrulline, an important amino acid.

Here's an overview of watermelon's most important antioxidants:

Vitamin C
Vitamin C is an antioxidant that helps prevent cell damage from free radicals.

Carotenoids
Carotenoids are a class of plant compounds that includes alpha-carotene and beta-carotene, which your body converts to vitamin A.

Lycopene
Lycopene is a type of carotenoid that doesn't change into vitamin A. This potent antioxidant gives a red color to plant foods such as tomatoes and watermelon, and is linked to many health benefits.

Cucurbitacin E
Cucurbitacin E is a plant compound with antioxidant and anti-inflammatory effects. Bitter melon, a relative of watermelon, contains even more cucurbitacin E.
                            </p>
                        <br />
                    </div>
                </div>  
            </div>

            <div class="col-lg-3">
                <div class="panel panel-default">
                    <div class="panel-body">
                        <h4><strong>Recent Posts</strong></h4>
                        <hr />
                        <ul>
                            <li><a href="article.aspx">What is the best fruit on earth?</a></li>
                            <li>2</li>
                        </ul>
                        <br />
                        <br />
                        <div class="pull-right">
                            <a href="article.aspx"><span class="glyphicon glyphicon-menu-right"></span>&nbsp; View All</a>
                        </div>
                    </div>
                </div>
            </div>

        </div>

    </form>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
