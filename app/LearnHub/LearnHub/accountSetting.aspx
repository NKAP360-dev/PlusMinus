<%@ Page Title="" Language="C#" MasterPageFile="~/Masterpage.Master" AutoEventWireup="true" CodeBehind="accountSetting.aspx.cs" Inherits="LearnHub.accountSetting" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .form-horizontal .control-label-left {
            text-align: left;
            margin-bottom: 0;
            padding-top: 11px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">
        <h1>Account Setting</h1>
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
                        <a href="#" class="list-group-item">Change Password
                        </a>

                    </div>
                </div>
                <div class="col-md-9">
                    <div class="form-group">
                        <strong>
                            <asp:Label runat="server" CssClass="col-lg-2 control-label" Text="Username"></asp:Label></strong>
                        <asp:Label ID="lblUsername" runat="server" CssClass="col-lg-9 control-label-left" Text="Username here"></asp:Label>
                    </div>
                    <div class="form-group">
                        <strong>
                            <asp:Label runat="server" CssClass="col-lg-2 control-label" Text="Name"></asp:Label></strong>
                        <asp:Label ID="lblName" runat="server" CssClass="col-lg-9 control-label-left" Text="Name here"></asp:Label>
                    </div>
                </div>
            </div>
        </div>
    </form>



</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
