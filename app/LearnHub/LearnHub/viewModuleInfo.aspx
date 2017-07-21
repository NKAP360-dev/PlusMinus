<%@ Page Title="" Language="C#" MasterPageFile="~/Masterpage.Master" AutoEventWireup="true" CodeBehind="viewModuleInfo.aspx.cs" Inherits="LearnHub.viewModuleInfo" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script>
        $(document).ready(function () {
            $('#menu').hide();
        });

        function configuration() {
            var x = document.getElementById('menu');
            if (x.style.display === 'none') {
                x.style.display = 'block';
            } else {
                x.style.display = 'none';
            }
        }

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    
     <div class="configure">
        <a href="#" id="config" onclick="configuration()"><span class="label label-primary"><span class="glyphicon glyphicon-cog"></span>Configuration Menu</span></a>
    </div>
    <br />
    <div class="configure">
        <ul class="list-group" id="menu">
            <a href="#">
                <li class="list-group-item">Edit Module Information
                </li>
            </a>
            <a href="#uploadModal" data-toggle="modal">
                <li class="list-group-item">Upload Learning Materials
                </li>
            </a>
        </ul>
    </div>

    <form runat="server">
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
        <asp:Panel ID="viewInfo" runat="server" Visible="true">
        <div class="row">
            <div class="col-md-3">
                <div class="list-group">
                    <asp:LinkButton ID="LinkButton1" runat="server" class="list-group-item active" OnClick="moduleInfo_Click"><span class="glyphicon glyphicon-info-sign"></span>&emsp;Module Info&emsp;</asp:LinkButton>
                    <asp:LinkButton ID="LinkButton2" runat="server" class="list-group-item" OnClick="learningMat_Click">Learning Materials &emsp;</asp:LinkButton>
                    <asp:LinkButton ID="LinkButton3" runat="server" class="list-group-item" OnClick="quizzes_Click">Quizzes &emsp;</asp:LinkButton>
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
            </asp:Panel>
        <asp:Panel ID="viewLearningMaterial" runat="server" Visible="false">
        <div class="row">
            <div class="col-md-3">
                <div class="list-group">
                    <asp:LinkButton ID="LinkButton4" runat="server" class="list-group-item" OnClick="moduleInfo_Click">Module Info&emsp;</asp:LinkButton>
                    <asp:LinkButton ID="LinkButton5" runat="server" class="list-group-item active" OnClick="learningMat_Click"><span class="glyphicon glyphicon-folder-open"></span>&emsp;Learning Materials &emsp;</asp:LinkButton>
                    <asp:LinkButton ID="LinkButton6" runat="server" class="list-group-item" OnClick="quizzes_Click">Quizzes &emsp;</asp:LinkButton>

                </div>
            </div>


            <div class="col-md-9">
                <%--Each panel for one upload--%>
                <div class="panel panel-primary">
                    <div class="panel-heading">
                        <h3 class="panel-title"><asp:Label ID="lblUploadTitle" runat="server" Text="Upload Title"></asp:Label></h3>                     
                    </div>
                    <div class="panel-body">
                        Uploaded on: <asp:Label ID="lblUploadDate" runat="server" Text="24th July"></asp:Label><br />
                        <asp:Label ID="lblUploadDescription" runat="server" Text="Upload Description"></asp:Label>
                        <br /><br />
                        <a href="#">Link to download</a><br />
                        <a href="#">Link to download</a>
                    </div>
                </div>
                <div class="panel panel-primary">
                    <div class="panel-heading">
                        <h3 class="panel-title"><asp:Label ID="Label1" runat="server" Text="Upload Title"></asp:Label></h3>                     
                    </div>
                    <div class="panel-body">
                        Uploaded on: <asp:Label ID="Label2" runat="server" Text="24th July"></asp:Label><br />
                        <asp:Label ID="Label3" runat="server" Text="Upload Description"></asp:Label>
                        <br /><br />
                        <a href="#">Link to download</a><br />
                        <a href="#">Link to download</a>
                    </div>
                </div>
                <div class="panel panel-primary">
                    <div class="panel-heading">
                        <h3 class="panel-title"><asp:Label ID="Label4" runat="server" Text="Upload Title"></asp:Label></h3>                     
                    </div>
                    <div class="panel-body">
                        Uploaded on: <asp:Label ID="Label5" runat="server" Text="24th July"></asp:Label><br />
                        <asp:Label ID="Label6" runat="server" Text="Upload Description"></asp:Label>
                        <br /><br />
                        <a href="#">Link to download</a><br />
                        <a href="#">Link to download</a>
                    </div>
                </div>
            </div>
            
        </div>
            </asp:Panel>
    </div>



         <%--Upload Modal--%>
    <div id="uploadModal" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title"><span class="glyphicon glyphicon-open"></span>&nbsp;Upload Learning Materials</h4>
                </div>
                <div class="modal-body">
                    
                    <div class="form-group">
                        
                    <div class="col-lg-12">
                        <p>
                        <asp:TextBox ID="uploadTitleInput"  runat="server" CssClass="form-control" placeholder="Enter Upload Title"></asp:TextBox>
                          </p><br />   
                    </div>
                        
                       
                    </div>
                    <div class="form-group">
                    <div class="col-lg-12">
                        <p>
                        <asp:TextBox ID="uploadDescriptionInput"  TextMode="multiline" Columns="50" Rows="5" runat="server" CssClass="form-control" placeholder="Enter Upload Description"></asp:TextBox>
                    </p><br />
                            </div>
                    </div>
                    <%--Positioning for buttons--%>
                    <a href="#" class="btn btn-success btn-xs">Choose File</a> &emsp;<a href=#>Show uploaded file link here...</a>
                    <br />
                    
                <div class="modal-footer">

                    <a href="#" class="btn btn-success">Upload</a>

                </div>
                </div>
            </div>
        </div>
    </div>


        </form>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
