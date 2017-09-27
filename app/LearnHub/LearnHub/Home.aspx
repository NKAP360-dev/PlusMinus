<%@ Page Title="Home - LearnHub" Language="C#" MasterPageFile="~/Masterpage.Master" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="LearnHub.Home" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .carousel-inner {
            width: 100%;
            max-height: 350px !important;
        }

        .newsFooter {
            padding-top: 20px;
            border-top: 1px solid #dddddd;
            text-align: right;
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
        $(window).on('load', function () {
            $('#myModal').modal('show');
        });

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
        <ol class="carousel-indicators">
            <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
            <li data-target="#myCarousel" data-slide-to="1"></li>
        </ol>

        <!-- Wrapper for slides -->
        <div class="carousel-inner">
            <div class="item active">
                <a href="#">
                    <img src="img/learnhub1.png" alt="Learnhub" style="width: 100%;">
                </a>
            </div>

            <div class="item">
                <img src="img/learnhubbanner2.png" alt="Learnhub" style="width: 100%;">
            </div>
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
        <div class="wrapper">
            <h2>
                <asp:LinkButton ID="highlightsBtn" runat="server" CssClass="linkStyleActive" OnClick="showHighlights"> Highlights</asp:LinkButton>
                &emsp;&emsp;
            <asp:LinkButton ID="eventsBtn" runat="server" CssClass="linkStyle" OnClick="showEvents"> Events</asp:LinkButton>
            </h2>
        </div>
        <br />
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <asp:UpdatePanel ID="eventsHighlightPanel" runat="server">
            <ContentTemplate>
                <asp:Panel ID="highlightsPanel" runat="server" Visible="true">
                    <div class="container">
                        <div class="row">
                            <div class="col-md-4">
                                <div class="well">
                                    <h2>Highlights</h2>
                                    <p>Donec id elit non mi porta gravida at eget metus. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh.</p>
                                    <div class="newsFooter"><span class="glyphicon glyphicon-chevron-right"></span>View More</div>
                                </div>

                            </div>
                            <div class="col-md-4">
                                <div class="well">
                                    <h2>Highlights </h2>
                                    <p>Etiam porta sem malesuada magna mollis euismod. Donec sed odio dui. Lorem ipsum dolor.</p>
                                    <div class="newsFooter"><span class="glyphicon glyphicon-chevron-right"></span>View More</div>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="well">
                                    <h2>Highlights</h2>
                                    <p>Vestibulum id ligula porta felis euismod semper. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh.</p>
                                    <div class="newsFooter"><span class="glyphicon glyphicon-chevron-right"></span>View More</div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <br />
                    <div class="container">
                        <div class="row">
                            <div class="col-md-4">
                                <div class="well">
                                    <h2>Highlights</h2>
                                    <p>Donec id elit non mi porta gravida at eget metus. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh.</p>
                                    <div class="newsFooter"><span class="glyphicon glyphicon-chevron-right"></span>View More</div>
                                </div>

                            </div>
                            <div class="col-md-4">
                                <div class="well">
                                    <h2>Highlights </h2>
                                    <p>Etiam porta sem malesuada magna mollis euismod. Donec sed odio dui. Lorem ipsum dolor.</p>
                                    <div class="newsFooter"><span class="glyphicon glyphicon-chevron-right"></span>View More</div>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="well">
                                    <h2>Highlights</h2>
                                    <p>Vestibulum id ligula porta felis euismod semper. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh.</p>
                                    <div class="newsFooter"><span class="glyphicon glyphicon-chevron-right"></span>View More</div>
                                </div>
                            </div>
                        </div>
                    </div>
                </asp:Panel>
                <asp:Panel ID="eventsPanel" runat="server" Visible="false">
                    <div class="container">
                        <div class="row">
                            <div class="col-md-4">
                                <div class="well">
                                    <h2>Events</h2>
                                    <p>Donec id elit non mi porta gravida at eget metus. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh.</p>
                                    <div class="newsFooter"><span class="glyphicon glyphicon-chevron-right"></span>View More</div>
                                </div>

                            </div>
                            <div class="col-md-4">
                                <div class="well">
                                    <h2>Events</h2>
                                    <p>Etiam porta sem malesuada magna mollis euismod. Donec sed odio dui. Lorem ipsum dolor.</p>
                                    <div class="newsFooter"><span class="glyphicon glyphicon-chevron-right"></span>View More</div>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="well">
                                    <h2>Events</h2>
                                    <p>Vestibulum id ligula porta felis euismod semper. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh.</p>
                                    <div class="newsFooter"><span class="glyphicon glyphicon-chevron-right"></span>View More</div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <br />
                    <div class="container">
                        <div class="row">
                            <div class="col-md-4">
                                <div class="well">
                                    <h2>Events</h2>
                                    <p>Donec id elit non mi porta gravida at eget metus. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh.</p>
                                    <div class="newsFooter"><span class="glyphicon glyphicon-chevron-right"></span>View More</div>
                                </div>

                            </div>
                            <div class="col-md-4">
                                <div class="well">
                                    <h2>Events</h2>
                                    <p>Etiam porta sem malesuada magna mollis euismod. Donec sed odio dui. Lorem ipsum dolor.</p>
                                    <div class="newsFooter"><span class="glyphicon glyphicon-chevron-right"></span>View More</div>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="well">
                                    <h2>Events</h2>
                                    <p>Vestibulum id ligula porta felis euismod semper. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh.</p>
                                    <div class="newsFooter"><span class="glyphicon glyphicon-chevron-right"></span>View More</div>
                                </div>
                            </div>
                        </div>
                    </div>
                </asp:Panel>
            </ContentTemplate>
            <Triggers>
                <%--MK pls help mi
              <asp:AsyncPostBackTrigger ControlID="eventsHighlightPanel" EventName="SelectedIndexChanged" />
                --%>
            </Triggers>
        </asp:UpdatePanel>

        <!-- Modal-->
        <div class="container">
            <div class="modal" id="myModal">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                            <h4 class="modal-title"><b>U N D E R &nbsp; C O N S T R U C T I O N</b></h4>
                        </div>
                        <div class="modal-body">
                            <div class="wrapper"><img src="img/barrier.png" style='width: 30%;' border="0"/>
                                <h3 class="text-danger">This page is currently still under construction!</h3>
                                <p>You may still navigate around but not everything is working as it should be. <br /> Team PlusMinus is trying their best to get everything
                                    up as soon as possible!
                                </p>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <div class="wrapper">
                            <button type="button" class="btn btn-warning" data-dismiss="modal">Got it!</button>
                                </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </form>
</asp:Content>
