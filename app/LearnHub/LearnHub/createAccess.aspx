<%@ Page Title="" Language="C#" MasterPageFile="~/Masterpage.Master" AutoEventWireup="true" CodeBehind="createAccess.aspx.cs" Inherits="LearnHub.createAccess" %>

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
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <ul class="breadcrumb">
        <li><a href="home.aspx">Home</a></li>
        <li><a href="siteConfig.aspx">Configuration Settings</a></li>
        <li><a href="manageUsers.aspx">Manage Users</a></li>
        <li class="active">Create Users</li>
    </ul>
    <div class="container">
        <h1>Create Users</h1>
        <% 
            User currentUser = (User)Session["currentUser"];
            Boolean superuser = false;
                foreach (string s in currentUser.getRoles())
                {
                    if (s.Equals("superuser"))
                    {
                        superuser = true;
                    }
                }
            if (currentUser != null && superuser)
            {
        %>

        <div class="dropdown" style="float: right;">
            <button class="dropbtn" onclick="return false;"><span class="glyphicon glyphicon-option-horizontal"></span></button>
            <div class="dropdown-content" style="right: 0;">
                <a href="manageUsers.aspx"><span class="glyphicon glyphicon-user"></span>&nbsp;&nbsp;Manage Users</a>
                <a href="createAccess.aspx"><span class="glyphicon glyphicon-plus"></span>&nbsp;&nbsp;Add Users</a>
            </div>
        </div>

        <%} %>
        <div class="verticalLine"></div>
    </div>


    <div class="container">
        <form class="form-horizontal" runat="server" enablepartialrendering="true">
            <fieldset>
            <legend>Input information for new user</legend>
                <h4>Account Information</h4>
            <div class="form-group required">
                <strong>
                    <asp:Label runat="server" CssClass="col-lg-2 control-label" Text="Username"></asp:Label></strong>
                <div class="col-lg-5">
                    <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control" placeholder="Username"></asp:TextBox>
                </div>
            </div>
                <div class="form-group required">
                <strong>
                    <asp:Label runat="server" CssClass="col-lg-2 control-label" Text="Password"></asp:Label></strong>
                <div class="col-lg-5">
                    <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" placeholder="Password"></asp:TextBox>
                </div>
            </div>
                <div class="form-group required">
                <strong>
                    <asp:Label runat="server" CssClass="col-lg-2 control-label" Text="Re-enter Password"></asp:Label></strong>
                <div class="col-lg-5">
                    <asp:TextBox ID="txtPassword2" runat="server" CssClass="form-control" placeholder="Re-enter Password"></asp:TextBox>
                </div>
            </div>
                <br />
                <h4>User Information</h4>
            <div class="form-group required">
                <strong>
                    <asp:Label runat="server" CssClass="col-lg-2 control-label" Text="Name"></asp:Label></strong>
                <div class="col-lg-5">
                    <asp:TextBox ID="txtName" runat="server" CssClass="form-control" placeholder="Name"></asp:TextBox>
                </div>
            </div>
            <div class="form-group required">
                <strong>
                    <asp:Label runat="server" CssClass="col-lg-2 control-label" Text="Contact No"></asp:Label></strong>
                <div class="col-lg-5">
                    <asp:TextBox ID="txtContactNo" runat="server" CssClass="form-control" placeholder="Contact No"></asp:TextBox>
                </div>
            </div>
            <div class="form-group required">
                <strong>
                    <asp:Label runat="server" CssClass="col-lg-2 control-label" Text="Address"></asp:Label></strong>
                <div class="col-lg-5">
                    <asp:TextBox ID="txtAddress" runat="server" CssClass="form-control" placeholder="Address"></asp:TextBox>
                </div>
            </div>
            <div class="form-group required">
                <strong>
                    <asp:Label runat="server" CssClass="col-lg-2 control-label" Text="Email"></asp:Label></strong>
                <div class="col-lg-5">
                    <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" placeholder="Email"></asp:TextBox>
                </div>
            </div>
            <div class="form-group required">
                <strong>
                    <asp:Label runat="server" CssClass="col-lg-2 control-label" Text="Department"></asp:Label></strong>
                <div class="col-lg-5">
                    <asp:TextBox ID="txtDept" runat="server" CssClass="form-control" placeholder="Department"></asp:TextBox>
                </div>
            </div>
            <div class="form-group required">
                <strong>
                    <asp:Label runat="server" CssClass="col-lg-2 control-label" Text="Job Title"></asp:Label></strong>
                <div class="col-lg-5">
                    <asp:TextBox ID="txtJobTitle" runat="server" CssClass="form-control" placeholder="Job Title"></asp:TextBox>
                </div>
            </div>
                <br />
                <h4>User Access Rights</h4>
                 <div class="form-group required">
                <strong>
                    <asp:Label runat="server" CssClass="col-lg-2 control-label" Text="Roles"></asp:Label></strong>
                <div class="col-lg-5">
                    <asp:CheckBoxList ID="cblRoles" runat="server">
                        <asp:ListItem>course creator</asp:ListItem>
                        <asp:ListItem>superuser</asp:ListItem>
                        <asp:ListItem>user</asp:ListItem>
                    </asp:CheckBoxList>
                </div>
            </div>
            <div class="form-group">
                <div class="wrapper">
                    <br />
                        <asp:Button ID="btnSubmit" CssClass="btn btn-primary" runat="server" Text="Create User" data-toggle="modal" href="#submitModal" OnClientClick="return false" UseSubmitBehavior="False" />
                </div>
            </div>
                </fieldset>

            <%--Modal for Submission Confirmation--%>
                <div id="submitModal" class="modal fade" role="dialog">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal">&times;</button>
                                <h4 class="modal-title"><b>Create new user</b></h4>
                            </div>
                            <%--Modal Content--%>
                            <div class="modal-body">
                                <div class="wrapper">
                                    <h4>Are you sure you want to submit?</h4>
                                    <br />
                                    
                                    <asp:Button ID="btnCfmSubmit" CssClass="btn btn-primary" runat="server" Text="Submit"  OnClick = "submit_Click"  />
                                    <asp:Button ID="Button2" CssClass="btn btn-default" runat="server" class="close" data-dismiss="modal" Text="Go Back" />
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
