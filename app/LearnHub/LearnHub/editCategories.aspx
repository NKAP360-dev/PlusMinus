<%@ Page Title="" Language="C#" MasterPageFile="~/Masterpage.Master" AutoEventWireup="true" CodeBehind="editCategories.aspx.cs" Inherits="LearnHub.editCategories" %>

<%@ Import Namespace="LearnHub.AppCode.entity" %>
<%@ Import Namespace="LearnHub.AppCode.dao" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="/Scripts/footable.bootstrap.min.css" rel="stylesheet" />
    <script src="/Scripts/footable.min.js"></script>
    <script>
        $(document).ready(function () {
            $('#menu').hide();
        });

        $(document).ready(function () {
            $('#btnDelete').click(function () {
                $('.alert').show()
            })
        });

        function configuration() {
            var x = document.getElementById('menu');
            if (x.style.display === 'none') {
                x.style.display = 'block';
            } else {
                x.style.display = 'none';
            }
        }

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
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="container">
        <h1>Edit Module Category

            <%
                User currentUser = (User)Session["currentUser"];
                if (currentUser != null && (currentUser.getRole().Equals("course creator") || currentUser.getRole().Equals("superuser")))
                {
            %>
            <a href="#" id="config" onclick="configuration()" class="btn btn-default pull-right"><span class="glyphicon glyphicon-option-horizontal"></span></a>
        </h1>
        <div class="configure">
            <ul class="list-group" id="menu" style="display: none;">
                <a href="createModules.aspx">
                    <li class="list-group-item"><span class="glyphicon glyphicon-book"></span>&emsp;Create New Modules
                    </li>
                </a>
                <a href="manageCategories.aspx">
                    <li class="list-group-item"><span class="glyphicon glyphicon-bookmark"></span>&emsp;Manage Module Categories
                    </li>
                </a>
                <a href="viewCreatedModules.aspx">
                    <li class="list-group-item"><span class="glyphicon glyphicon-search"></span>&emsp;View My Created Modules
                    </li>
                </a>
            </ul>
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
                <strong>
                    <asp:Label ID="lblSaveSuccess" runat="server" CssClass="text-success"><span class="glyphicon glyphicon-ok"></span> Saved successfully</asp:Label></strong><br />
                <strong>
                    <asp:Label ID="lblError" runat="server" CssClass="text-danger"><span class="glyphicon glyphicon-remove"></span> Something went wrong</asp:Label></strong>

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
                                <asp:Button ID="btnCfmActivate" CssClass="btn btn-success" runat="server" Text="Activate"/>
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
