<%@ Page Title="" Language="C#" MasterPageFile="~/Masterpage.Master" AutoEventWireup="true" CodeBehind="viewModuleInfo.aspx.cs" Inherits="LearnHub.viewModuleInfo" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">
        <h1>
            <asp:Label ID="lblCourseNameHeader" runat="server" Text="courseName"></asp:Label></h1>

        <div class="verticalLine"></div>
    </div>

    <div class="container">
        <div class="row">
            <div class="col-md-3">
                <div class="wrapper">
                    <h4><strong><span class="glyphicon glyphicon-menu-hamburger">&emsp;</span>View Module Information</strong></h4>
                </div>
            </div>
           


        </div>
        <div class="row">
            <div class="col-md-3">
                <div class="list-group">

                    <a href="viewModuleInfo.aspx" class="list-group-item active">
                        <span class="glyphicon glyphicon-info-sign"></span>&emsp;Module Info&emsp;
                    </a>
                    <a href="#" class="list-group-item">
                        <span class="glyphicon glyphicon-folder-open"></span>&emsp;Learning Materials
                    </a>
                    <a href="#" class="list-group-item">
                        <span class="glyphicon glyphicon-pencil"></span>&emsp; Quizzes
                    </a>

                </div>
            </div>


            <div class="col-md-6">
                <div class="panel panel-primary">

                    <div class="panel-heading">
                        <h3 class="panel-title"><asp:Label ID="lblCourseName" runat="server" Text="courseDescription"></asp:Label></h3>
                        
                    </div>
                    <div class="panel-body">
                        <asp:Label ID="lblCourseDescription" runat="server" Text="courseDescription"></asp:Label>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="panel panel-primary">
                    <div class="panel-heading">
                        <h3 class="panel-title">Details</h3>
                    </div>
                    <div class="panel-body">
                        <strong>
                            <asp:Label ID="venueLabel" runat="server" Text="Venue"></asp:Label></strong><br />
                        <asp:Label ID="venueOutput" runat="server" Text="Venue"></asp:Label>
                        <br />
                        <br />
                        blahblah any other info timing date etc etc 
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
