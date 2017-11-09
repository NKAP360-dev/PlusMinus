﻿<%@ Page Title="Home - LearnHub" Language="C#" MasterPageFile="~/Masterpage.Master" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="LearnHub.Home" %>
<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Collections" %>
<%@ Import Namespace="LearnHub.AppCode.dao" %>
<%@ Import Namespace="LearnHub.AppCode.entity" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="https://fonts.googleapis.com/css?family=Biryani:800" rel="stylesheet">
    <style>
         h3 {
            display: inline;
        }

        .newsType {
            font-family: 'Biryani', sans-serif !important;
            font-size: 10px;
            text-transform: uppercase !important;
            padding: 3px;
            margin-bottom: 5px;
            color: slategrey;
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

        .carousel-inner {
            width: 100%;
            background-size: contain;
            height:400px;
        }

            .carousel-inner img {
                min-width: 100%;
                min-height: 100%;
                background-size: contain;
            }

        .item img {
            width: 100%;
            height: 100%;
            background-size: contain;
        }



        .newsFooter {
            padding-top: 10px;
            position: absolute;
            bottom: 0;
        }

        .navbar, .navbar navbar-default {
            margin-bottom: 0;
        }

        .well {
            background-color: #fff;
        }

        .navbar {
            margin-bottom: 0;
        }

        .linkStyleActive {
            background-color: white;
            color: dimgray;
            display: inline-block;
            border-bottom-style: solid;
            border-bottom: solid #0abab5;
            text-decoration: none;
        }

            .linkStyleActive:hover, .linkStyleActive:active, .linkStyleActive:visited {
                background-color: white;
                color: dimgray;
                display: inline-block;
                border-bottom-style: solid;
                border-bottom: solid #0abab5;
                text-decoration: none;
            }


        .linkStyle:hover, .linkStyle:active, .linkStyle:visited {
            background-color: white;
            color: dimgray;
            display: inline-block;
            border-bottom-style: solid;
            border-bottom: solid #0abab5;
            text-decoration: none;
        }

        .linkStyle {
            background-color: white;
            color: darkgray;
            display: inline-block;
            border-style: none;
            text-decoration: none;
        }
    </style>
    <script type="text/javascript">
        $('.highlightsBtn').click(function () {
            $(".highlightsBtn").removeClass("linkStyle");
            $(this).addClass("linkStyleActive");
            $(".eventsBtn").removeClass("linkStyleActive");
            $(".eventsBtn").addClass("linkStyle");
            $(".eventsPanel").hide();
            $("highlightsPanel").show();

        });

        $('.eventsBtn').click(function () {
            $(".eventsBtn").removeClass("linkStyle");
            $(this).addClass("linkStyleActive");
            $(".highlightsBtn").removeClass("linkStyleActive");
            $(".highlightsBtn").addClass("linkStyle");
            $(".eventsPanel").show();
            $("highlightsPanel").hide();
        });

    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div id="myCarousel" class="carousel slide" data-ride="carousel">
        <!-- Indicators -->
        <%-- THIS PART TO BE INTEGRATED 
             each li for no. of banners
            class="active" for first li--%>
        <!--<ol class="carousel-indicators">
            <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
            <li data-target="#myCarousel" data-slide-to="1"></li>
            <li data-target="#myCarousel" data-slide-to="2"></li>
        </ol>-->

        <!-- Wrapper for slides -->
        <%-- THIS PART TO BE INTEGRATED 
             each <div class="item"> for each banner uploaded
            <div class="item active"> for first banner
            alt = BANNER NAME
            a href = BANNER LINK--%>
        <div class="carousel-inner">
            
            <% 
                int i = 0;
                NewsDAO ndao = new NewsDAO();
                ArrayList allNews = ndao.getNews();
                string dir = "img/banner";
                //News n in allNews
                foreach (News n in allNews)
                {
                    if (i== 0) {
                        string str = "";
                        foreach (string strfile in Directory.GetFiles(Server.MapPath(dir)))
                        {
                            
                            if (n.img_path.Equals(strfile))
                            {
                                str = strfile;

                            }
                        }  %>
                            <div class="item active">
                                <a href="<%=n.banner_link %>">
                                    <img src="<%=dir+"/"+Path.GetFileName(str)%>" alt="<%=n.banner_name %>"  style="height: 100%;"/>
                                 </a>
                            </div>
                       <%
                           } else {
                               string str = "";
                               foreach(string strfile in Directory.GetFiles(Server.MapPath(dir)))
                               {

                                   if (n.img_path.Equals(strfile))
                                   {
                                       str = strfile;

                                   }
                               }%>
                        <div class="item">
                                <a href="<%=n.banner_link %>">
                                    <img src="<%=dir+"/"+Path.GetFileName(str)%>" alt="<%=n.banner_name %>"  style="height: 100%;"/>
                                 </a>
                            </div>
                    <%} 
                 i++;
              }%>
        </div>

        <!-- Left and right controls -->
        <a class="left carousel-control" href="#myCarousel" data-slide="prev">
            <span class="glyphicon glyphicon-chevron-left"></span>
            <span class="sr-only">Previous</span>
        </a>
        <a class="right carousel-control" href="#myCarousel" data-slide="next">
            <span class="glyphicon glyphicon-chevron-right"></span>
            <span class="sr-only">Next</span>
        </a>
    </div>




</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
    <form id="form1" runat="server">
        <br />
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
        <div class="row">
            <div class="col-lg-12">
                <div class="dropdown" style="float: right;">
                    <button class="dropbtn" onclick="return false;"><span class="glyphicon glyphicon-option-horizontal"></span></button>
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
        </div>
        <%
        }
    }
            %>
        <br />
        <div class="container">

            <%--TO BE INTEGRATED--%>
            <%--Display 6 latest news--%>
                <%News_highlightsDAO ndao = new News_highlightsDAO();
                    ArrayList highlights = ndao.getNewsHighlights();
                    string dir = "img/highlights";
                    int count = highlights.Count;
                    if (count >= 6)
                    {
                        count = 6;
                    }
                    for (int i = 0; i < count; i++)
                    {
                        News_highlights highlight = (News_highlights)highlights[i];
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
            <div class="row">
                <div class="wrapper"><br />
                    <a href="viewAllNews.aspx"><h3>View All</h3>&emsp;<span class="glyphicon glyphicon-menu-right"></span></a>
                </div>
            </div>
        </div>


    </form>
</asp:Content>
