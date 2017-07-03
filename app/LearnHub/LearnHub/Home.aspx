<%@ Page Title="Home - LearnHub" Language="C#" MasterPageFile="~/Masterpage.Master" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="LearnHub.Home" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .carousel-inner{
  width:100%;
  max-height: 350px !important;
}

        .newsFooter {
            padding-top: 20px;
            border-top: 1px solid #dddddd;
            text-align: right;
        }

        .well {
    background-color: #fff;
}
        .navbar {
            margin-bottom: 0;
        }
    </style>
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
    <div class="alert alert-dismissible alert-warning">
    <a href="#">Highlights </a><a href="#"> Events</a></div>

    <div class="container">
	<div class="row">
		<div class="col-md-4">
			<div class="well">
			<h2>Highlights</h2>
			<p>Donec id elit non mi porta gravida at eget metus. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh.</p>
		    <div class="newsFooter"><span class="glyphicon glyphicon-chevron-right"></span> View More</div>
            </div>
            
		</div>
		<div class="col-md-4">
			<div class="well">
            <h2>Highlights </h2>
			<p>Etiam porta sem malesuada magna mollis euismod. Donec sed odio dui. Lorem ipsum dolor.</p>
                <div class="newsFooter"><span class="glyphicon glyphicon-chevron-right"></span> View More</div>
			</div>
		</div>
		<div class="col-md-4">
			<div class="well">
			<h2>Highlights</h2>
			<p>Vestibulum id ligula porta felis euismod semper. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh.</p>
		    <div class="newsFooter"><span class="glyphicon glyphicon-chevron-right"></span> View More</div>
            </div>
            </div>
	</div>
    </div><br />
    <div class="container">
	<div class="row">
		<div class="col-md-4">
			<div class="well">
			<h2>Highlights</h2>
			<p>Donec id elit non mi porta gravida at eget metus. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh.</p>
		    <div class="newsFooter"><span class="glyphicon glyphicon-chevron-right"></span> View More</div>
            </div>
            
		</div>
		<div class="col-md-4">
			<div class="well">
            <h2>Highlights </h2>
			<p>Etiam porta sem malesuada magna mollis euismod. Donec sed odio dui. Lorem ipsum dolor.</p>
                <div class="newsFooter"><span class="glyphicon glyphicon-chevron-right"></span> View More</div>
			</div>
		</div>
		<div class="col-md-4">
			<div class="well">
			<h2>Highlights</h2>
			<p>Vestibulum id ligula porta felis euismod semper. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh.</p>
		    <div class="newsFooter"><span class="glyphicon glyphicon-chevron-right"></span> View More</div>
            </div>
            </div>
	</div>
</div>
</asp:Content>
