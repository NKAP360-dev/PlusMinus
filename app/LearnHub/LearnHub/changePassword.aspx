<%@ Page Title="" Language="C#" MasterPageFile="~/Masterpage.Master" AutoEventWireup="true" CodeBehind="changePassword.aspx.cs" Inherits="LearnHub.changePassword" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
        <style>
        .form-horizontal .control-label-left {
            text-align: left;
            margin-bottom: 0;
            padding-top: 11px;
        }

         .breadcrumb {
            padding-top: 15px;
            margin-bottom: 0px;
            list-style: none;
            background-color: white;
            border-radius: 0px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <ul class="breadcrumb">
  <li><a href="home.aspx">Home</a></li>
  <li class="active">Account Settings</li>
  </ul>
    <div class="container">
        <h1>Account Setting</h1>
        <div class="verticalLine"></div>
    </div>
    <form class="form-horizontal" runat="server">
        <div class="container">
            <div class="row">
                <div class="col-md-3">
                    <div class="list-group">
                        <a href="accountSetting.aspx" class="list-group-item">
                            Account Information
                        </a>
                        <a href="#" class="list-group-item active">
                            <span class="glyphicon glyphicon-menu-right"></span>&emsp;Change Password
                        </a>

                    </div>
                </div>
                <div class="col-md-9">
                    <br />
                    <div class="form-group">
                        <strong>
                            <asp:Label runat="server" CssClass="col-lg-4 control-label" Text="Current Password"></asp:Label></strong>
                        <div class="col-lg-6">
                            <asp:TextBox ID="txtPassword_now" runat="server" CssClass="form-control" placeholder="Current Password" TextMode="Password"></asp:TextBox>
                        </div>
                    </div>
                    <div class="form-group">
                        <strong>
                            <asp:Label runat="server" CssClass="col-lg-4 control-label" Text="New Password"></asp:Label></strong>
                        <div class="col-lg-6">
                            <asp:TextBox ID="txtPassword_new" runat="server" CssClass="form-control" placeholder="New Password" TextMode="Password"></asp:TextBox>
                        </div>
                    </div>
                    <div class="form-group">
                        <strong>
                            <asp:Label runat="server" CssClass="col-lg-4 control-label" Text="Re-type New Password"></asp:Label></strong>
                        <div class="col-lg-6">
                            <asp:TextBox ID="txtPassword_newConfirm" runat="server" CssClass="form-control" placeholder="Re-type Password" TextMode="Password"></asp:TextBox>
                        </div>
                    </div>
                    <div class="form-group">
                        <h6> <asp:Label runat="server" CssClass="control-label text-muted" Text="Password must include at least 8 characters, inclusive of numerical and special..blahblah password rules"></asp:Label></h6>
                    </div>
                    <div class="form-group">
                        <div class="wrapper">
                            <br />
                            <asp:Button ID="btnSave" runat="server" CssClass="btn btn-primary" Text="Save" OnClick="submit_new_password"/>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
