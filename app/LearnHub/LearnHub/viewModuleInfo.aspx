<%@ Page Title="" Language="C#" MasterPageFile="~/Masterpage.Master" AutoEventWireup="true" CodeBehind="viewModuleInfo.aspx.cs" Inherits="LearnHub.viewModuleInfo" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">
        <h1><asp:Label ID="lblCourseNameHeader" runat="server" Text="courseName"></asp:Label></h1>

        <div class="verticalLine"></div>
    </div>

     <div class="row">
        <div class="col-md-2">
            <div class="list-group">
                <div class="wrapper"><h4><strong>Module Homepage</strong></h4></div>

                <a href="viewModuleInfo.aspx" class="list-group-item active">
                    <span class="glyphicon glyphicon-info-sign"></span> &emsp;Module Info
                </a>
                <a href="#" class="list-group-item">
                    <span class="glyphicon glyphicon-folder-open"></span> &emsp;Learning Materials
                </a>
                <a href="#" class="list-group-item">
                   <span class="glyphicon glyphicon-pencil"></span> &emsp; Quizzes
                </a>

            </div>
        </div>
        <div class="container">
            <h2><asp:Label ID="lblCourseName" runat="server" Text="courseName"></asp:Label></h2>
            <asp:Label ID="lblCourseDescription" runat="server" Text="courseDescription"></asp:Label>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
