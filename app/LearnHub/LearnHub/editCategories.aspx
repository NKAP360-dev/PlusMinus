<%@ Page Title="" Language="C#" MasterPageFile="~/Masterpage.Master" AutoEventWireup="true" CodeBehind="editCategories.aspx.cs" Inherits="LearnHub.editCategories" %>

<%@ Import Namespace="LearnHub.AppCode.entity" %>
<%@ Import Namespace="LearnHub.AppCode.dao" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="Scripts/footable.bootstrap.min.css" rel="stylesheet" />
    <script src="Scripts/footable.min.js"></script>
    <script>
        jQuery(function ($) {
            $('.table').footable({
                "paging": {
                    "size": 10 <%--Change how many rows per page--%>
                },
                "filtering": {
                    "position": "left"
                }
            });
        });
    </script>
    <style>
                  .breadcrumb {
            padding-top: 15px;
            margin-bottom: 10px;
            list-style: none;
            background-color: white;
            border-radius: 0px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
           <ul class="breadcrumb">
  <li><a href="home.aspx">Home</a></li>
  <li><a href="viewAllModule.aspx">Courses</a></li>
<li><a href="manageCategory.aspx">Manage Course Category</a></li>
  <li class="active">Edit Course Category</li>
  </ul>
    <div class="container">
        <h1>Edit Course Category</h1>

            <%
                User currentUser = (User)Session["currentUser"];
                 Boolean superuser = false;
                 Boolean course_creator = false;
                 foreach (string s in currentUser.getRoles())
                 {
                    if (s.Equals("superuser"))
                    {
                        superuser = true;
                    }
                    else if (s.Equals("course creator"))
                    {
                        course_creator = true;
                    }
                 }
                 if (currentUser != null && (course_creator || superuser))
                 {
            %>
        
        <div class="dropdown" style="float: right;">
                <button class="dropbtn" onclick="return false;"><span class="glyphicon glyphicon-option-horizontal"></span></button>
                <div class="dropdown-content" style="right: 0;">
                    <a href="createModules.aspx"><span class="glyphicon glyphicon-plus"></span>&nbsp;&nbsp;Create New Courses</a>
                    <a href="manageCategories.aspx"><span class="glyphicon glyphicon-bookmark"></span>&nbsp;&nbsp;Manage Course Categories</a>
                    <a href="viewCreatedModules.aspx"><span class="glyphicon glyphicon-book"></span>&nbsp;&nbsp;Manage Courses</a>
                </div>
            </div>
        <%
            }
        %>
        <div class="verticalLine"></div>
        <br />
    </div>

    <div class="container">
        <form class="form-horizontal" runat="server">
            <%--Inputs--%>
            <div class="form-group required">
                <label for="txtCategory" class="col-lg-2 control-label">Category Name</label>
                <div class="col-lg-10">
                    <asp:TextBox ID="txtCategory" runat="server" CssClass="form-control" placeholder="Populate value here"></asp:TextBox>
                    <asp:Label ID="lblHiddenID" runat="server" Visible="False"></asp:Label>
                    <br>
                </div>
            </div>
            <br />
            <%--Buttons--%>
            <div class="wrapper">
                <div class="form-group">
                    <asp:Button ID="btnSubmit" CssClass="btn btn-primary" runat="server" Text="Save" data-toggle="modal" href="#submitModal" OnClientClick="return false;" />
                    <asp:Button ID="btnDeactivate" CssClass="btn btn-warning" runat="server" Text="Deactivate" data-toggle="modal" href="#deactivateModal" OnClientClick="return false;" />
                    <asp:Button ID="btnActivate" CssClass="btn btn-success" runat="server" Text="Activate" data-toggle="modal" href="#activateModal" OnClientClick="return false;" />

                </div>
            </div>


            <%--Modal for Submission Confirmation--%>
            <div id="submitModal" class="modal fade" role="dialog">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                            <h4 class="modal-title"><b>Create New Module Category</b></h4>
                        </div>
                        <div class="modal-body">
                            <div class="wrapper">
                                <h4>Are you sure you want to proceed?</h4>
                                <br />
                                <asp:Button ID="btnConfirmSubmit" CssClass="btn btn-primary" runat="server" Text="Submit" OnClick="btnConfirmSubmit_Click"/>
                                <asp:Button ID="btnCancel1" CssClass="btn btn-default" runat="server" class="close" data-dismiss="modal" Text="Cancel" OnClientClick="return false;" />

                                <br />
                            </div>
                        </div>
                    </div>

                </div>
            </div>

             <%--Modal for Deactivation Confirmation--%>
            <div id="deactivateModal" class="modal fade" role="dialog">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                            <h4 class="modal-title"><b>Deactivate This Category</b></h4>
                        </div>
                        <div class="modal-body">
                            <div class="wrapper">
                                <h4>Are you sure you want to proceed?</h4>
                                
                                <h4 class="text-danger">This category will be deactivated and all modules under this category will not be visible to users!</h4>
                                <br />
                                <asp:Button ID="btnCfmDeactivate" CssClass="btn btn-warning" runat="server" Text="Deactivate" OnClick="btnCfmDeactivate_Click"/>
                                <asp:Button ID="btnCancel2" CssClass="btn btn-default" runat="server" class="close" data-dismiss="modal" Text="Cancel" OnClientClick="return false;" />

                                <br />
                            </div>
                        </div>
                    </div>

                </div>
            </div>

            <%--Modal for Activation Confirmation--%>
            <div id="activateModal" class="modal fade" role="dialog">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                            <h4 class="modal-title"><b>Activate This Category</b></h4>
                        </div>
                        <div class="modal-body">
                            <div class="wrapper">
                                <h4>Are you sure you want to proceed?</h4>
                                
                                <h4 class="text-success">This category will be activated and modules under this category will be visible to all users</h4>
                                <br />
                                <asp:Button ID="btnCfmActivate" CssClass="btn btn-success" runat="server" Text="Activate" OnClick="btnCfmActivate_Click"/>
                                <asp:Button ID="Button2" CssClass="btn btn-default" runat="server" class="close" data-dismiss="modal" Text="Cancel" OnClientClick="return false;" />

                                <br />
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </form>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
