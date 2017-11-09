<%@ Page Title="" Language="C#" MasterPageFile="~/Masterpage.Master" AutoEventWireup="true" CodeBehind="accountSetting.aspx.cs" Inherits="LearnHub.accountSetting" %>
<%@ Import Namespace="LearnHub.AppCode.dao" %>
<%@ Import Namespace="LearnHub.AppCode.entity" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .form-horizontal .control-label-left {
            text-align: left;
            margin-bottom: 0;
            padding-top: 11px;
        }

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
  <li class="active">Account Settings</li>
  </ul>
    <div class="container">
        <h1>Account Settings</h1>
        <div class="verticalLine"></div>
    </div>
    <form class="form-horizontal" runat="server">
        <div class="container">
            <div class="row">
                <div class="col-md-3">
                    <div class="list-group">
                        <a href="#" class="list-group-item active">
                            <span class="glyphicon glyphicon-menu-right"></span>&emsp;Account Information
                        </a>
                        <a href="changePassword.aspx" class="list-group-item">Change Password
                        </a>

                    </div>
                </div>
                <div class="col-md-9">
                    <br />
                    <div class="form-group">
                        <strong>
                            <asp:Label runat="server" CssClass="col-lg-3 control-label" Text="Username"></asp:Label></strong>
                        <asp:Label ID="lblUsername" runat="server" CssClass="col-lg-6 control-label-left"><%=currentUser.getUserID() %></asp:Label>
                    </div>
                    <div class="form-group">
                        <strong>
                            <asp:Label runat="server" CssClass="col-lg-3 control-label" Text="Name"></asp:Label></strong>
                        <asp:Label ID="lblName" runat="server" CssClass="col-lg-6 control-label-left"><%=currentUser.getName() %></asp:Label>
                    </div>
                    <br />
                    <div class="form-group required">
                        <strong>
                            <asp:Label runat="server" CssClass="col-lg-3 control-label" Text="Contact No"></asp:Label></strong>
                        <div class="col-lg-6">
                            <asp:TextBox ID="txtContactNo" runat="server" CssClass="form-control" placeholder="Contact No" TextMode="Number"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfv_txtContactNo" runat="server" ErrorMessage="Please enter a Contact Number" ControlToValidate="txtContactNo" ForeColor="Red" ValidationGroup="ValidateForm"></asp:RequiredFieldValidator>
                        </div>
                    </div>
                    <div class="form-group required">
                        <strong>
                            <asp:Label runat="server" CssClass="col-lg-3 control-label" Text="Address"></asp:Label></strong>
                        <div class="col-lg-6">
                            <asp:TextBox ID="txtAddress" runat="server" CssClass="form-control" placeholder="Address"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfv_txtAddress" runat="server" ErrorMessage="Please enter an Address" ControlToValidate="txtAddress" ForeColor="Red" ValidationGroup="ValidateForm"></asp:RequiredFieldValidator>
                        </div>
                    </div>
                     <div class="form-group">
                        <strong>
                            <asp:Label runat="server" CssClass="col-lg-3 control-label" Text="Email"></asp:Label></strong>
                        <asp:Label ID="lblEmail" runat="server" CssClass="col-lg-6 control-label-left"><%=currentUser.getEmail() %></asp:Label>
                    </div>
                    <div class="form-group">
                        <strong>
                            <asp:Label runat="server" CssClass="col-lg-3 control-label" Text="Department"></asp:Label></strong>
                        <asp:Label ID="lblDepartment" runat="server" CssClass="col-lg-6 control-label-left"><%=System.Globalization.CultureInfo.CurrentCulture.TextInfo.ToTitleCase(currentUser.getDepartment().ToLower()) %></asp:Label>
                    </div>
                    <div class="form-group">
                        <strong>
                            <asp:Label runat="server" CssClass="col-lg-3 control-label" Text="Job Title"></asp:Label></strong>
                        <asp:Label ID="lblJobTitle" runat="server" CssClass="col-lg-6 control-label-left"><%=currentUser.getJobTitle() %></asp:Label>
                    </div>
                    <div class="form-group">
                        <div class="wrapper">
                            <br />
                            <asp:Button ID="btnSave" runat="server" CssClass="btn btn-primary" Text="Save" OnClick="updateInfo_Click" UseSubmitBehavior="false" ValidationGroup="ValidateForm"/><br /><br />
                            <asp:Label ID="lblSettingSaved" runat="server" CssClass="label label-success" Text="Information has been changed successfully!" Font-Size="Medium" Visible="false"></asp:Label>

                            </div>
                    </div>
                </div>
            </div>
        </div>
    </form>



</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
