<%@ Page Title="" Language="C#" MasterPageFile="~/Masterpage.Master" AutoEventWireup="true" CodeBehind="viewAllNews.aspx.cs" Inherits="LearnHub.viewAllNews" %>

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
         <div class="row">
                <div class="col-md-4">
                    <a href="news.aspx">
                        <div class="panel panel-default">
                            <div class="newsImage">
                                <img src="https://www.cdc.gov/handwashing/images/handwashing-banner1.jpg" alt="Learnhub">
                                <div class="newsType">
                                    news
                                </div>
                            </div>
                            <div class="panel-body">
                                <h4 class="text-success"><strong>New Course - Wash Hands 101</strong></h4>
                                <hr />
                                <p>Keeping hands clean is one of the most important steps we can take to avoid getting sick and spreading germs to others.</p>
                                <br />
                            </div>
                        </div>
                    </a>
                </div>

                <div class="col-md-4">
                    <a href="news.aspx">
                        <div class="panel panel-default">
                            <div class="newsImage">
                                <img src="https://d3tvpxjako9ywy.cloudfront.net/blog/content/uploads/2014/12/iStock-612235546-624x416.jpg?av=3605f7e90f16446ab34c16e85e991868" alt="Learnhub">
                                <div class="newsType">
                                    update
                                </div>
                            </div>
                            <div class="panel-body">
                                <h4 class="text-success"><strong>Training Calendar has been updated!</strong></h4>
                                <hr />
                                <p>Training Calendar has been updated!</p>
                                <br />
                            </div>
                        </div>
                    </a>
                </div>

                <div class="col-md-4">
                    <a href="news.aspx">
                        <div class="panel panel-default">
                            <div class="newsImage">
                                <img src="https://fedweb-assets.s3.amazonaws.com/cache/fed-48/2/Emergency%2520prep1_334072_resize_1524__1_1.png" alt="Learnhub">
                                <div class="newsType">
                                    news
                                </div>
                            </div>
                            <div class="panel-body">
                                <h4 class="text-success"><strong>New Course - Emergency Preparedness</strong></h4>
                                <hr />
                                <p>The course equips students with knowledge on how to be prepared to deal with emergencies and manage disasters effectively.</p>
                                <br />
                            </div>
                        </div>
                    </a>
                </div>
            </div>
            <div class="row">
                <div class="col-md-4">
                    <a href="news.aspx">
                        <div class="panel panel-default">
                            <div class="newsImage">
                                <img src="http://cdn.c3a.com.sg/1371026187_170081754_AhDf.jpg" alt="Learnhub">
                                <div class="newsType">
                                    news
                                </div>
                            </div>
                            <div class="panel-body">
                                <h4 class="text-success"><strong>New Course - Elderly Care 101</strong></h4>
                                <hr />
                                <p>Frail elderly who need more attention at home can get the care they need, if going to a nursing home is not on the cards.</p>
                                <br />
                            </div>
                        </div>
                    </a>
                </div>

                <div class="col-md-4">
                    <a href="news.aspx">
                        <div class="panel panel-default">
                            <div class="newsImage">
                                <img src="http://www.stephenblower.co.uk/wp-content/uploads/2013/03/maintenance-1.jpg" alt="Learnhub">
                                <div class="newsType">
                                    update
                                </div>
                            </div>
                            <div class="panel-body">
                                <h4 class="text-success"><strong>LearnHub Maintenance</strong></h4>
                                <hr />
                                <p>LearnHub will be undergoing maintenance this Sunday, 1st October. LearnHub will not be available on this day. We apologize for any inconvenience caused.</p>
                                <br />
                            </div>
                        </div>
                    </a>
                </div>

                <div class="col-md-4">
                    <a href="news.aspx">
                        <div class="panel panel-default">
                            <div class="newsImage">
                                <img src="https://www.naturalnews.com/gallery/640/Ebola/Ebola-Virus-Word-Shapes.jpg" alt="Learnhub">
                                <div class="newsType">
                                    news
                                </div>
                            </div>
                            <div class="panel-body">
                                <h4 class="text-success"><strong>Removal of Course -Ebola</strong></h4>
                                <hr />
                                <p>We will no longer be offering this course.</p>
                                <br />
                            </div>
                        </div>
                    </a>
                </div>
            </div>
         <div class="row">
                <div class="col-md-4">
                    <a href="news.aspx">
                        <div class="panel panel-default">
                            <div class="newsImage">
                                <img src="https://www.cdc.gov/handwashing/images/handwashing-banner1.jpg" alt="Learnhub">
                                <div class="newsType">
                                    news
                                </div>
                            </div>
                            <div class="panel-body">
                                <h4 class="text-success"><strong>New Course - Wash Hands 101</strong></h4>
                                <hr />
                                <p>Keeping hands clean is one of the most important steps we can take to avoid getting sick and spreading germs to others.</p>
                                <br />
                            </div>
                        </div>
                    </a>
                </div>

                <div class="col-md-4">
                    <a href="news.aspx">
                        <div class="panel panel-default">
                            <div class="newsImage">
                                <img src="https://d3tvpxjako9ywy.cloudfront.net/blog/content/uploads/2014/12/iStock-612235546-624x416.jpg?av=3605f7e90f16446ab34c16e85e991868" alt="Learnhub">
                                <div class="newsType">
                                    update
                                </div>
                            </div>
                            <div class="panel-body">
                                <h4 class="text-success"><strong>Training Calendar has been updated!</strong></h4>
                                <hr />
                                <p>Training Calendar has been updated!</p>
                                <br />
                            </div>
                        </div>
                    </a>
                </div>

                <div class="col-md-4">
                    <a href="news.aspx">
                        <div class="panel panel-default">
                            <div class="newsImage">
                                <img src="https://fedweb-assets.s3.amazonaws.com/cache/fed-48/2/Emergency%2520prep1_334072_resize_1524__1_1.png" alt="Learnhub">
                                <div class="newsType">
                                    news
                                </div>
                            </div>
                            <div class="panel-body">
                                <h4 class="text-success"><strong>New Course - Emergency Preparedness</strong></h4>
                                <hr />
                                <p>The course equips students with knowledge on how to be prepared to deal with emergencies and manage disasters effectively.</p>
                                <br />
                            </div>
                        </div>
                    </a>
                </div>
            </div>
            <div class="row">
                <div class="col-md-4">
                    <a href="news.aspx">
                        <div class="panel panel-default">
                            <div class="newsImage">
                                <img src="http://cdn.c3a.com.sg/1371026187_170081754_AhDf.jpg" alt="Learnhub">
                                <div class="newsType">
                                    news
                                </div>
                            </div>
                            <div class="panel-body">
                                <h4 class="text-success"><strong>New Course - Elderly Care 101</strong></h4>
                                <hr />
                                <p>Frail elderly who need more attention at home can get the care they need, if going to a nursing home is not on the cards.</p>
                                <br />
                            </div>
                        </div>
                    </a>
                </div>

                <div class="col-md-4">
                    <a href="news.aspx">
                        <div class="panel panel-default">
                            <div class="newsImage">
                                <img src="http://www.stephenblower.co.uk/wp-content/uploads/2013/03/maintenance-1.jpg" alt="Learnhub">
                                <div class="newsType">
                                    update
                                </div>
                            </div>
                            <div class="panel-body">
                                <h4 class="text-success"><strong>LearnHub Maintenance</strong></h4>
                                <hr />
                                <p>LearnHub will be undergoing maintenance this Sunday, 1st October. LearnHub will not be available on this day. We apologize for any inconvenience caused.</p>
                                <br />
                            </div>
                        </div>
                    </a>
                </div>

                <div class="col-md-4">
                    <a href="news.aspx">
                        <div class="panel panel-default">
                            <div class="newsImage">
                                <img src="https://www.naturalnews.com/gallery/640/Ebola/Ebola-Virus-Word-Shapes.jpg" alt="Learnhub">
                                <div class="newsType">
                                    news
                                </div>
                            </div>
                            <div class="panel-body">
                                <h4 class="text-success"><strong>Removal of Course -Ebola</strong></h4>
                                <hr />
                                <p>We will no longer be offering this course.</p>
                                <br />
                            </div>
                        </div>
                    </a>
                </div>
            </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
