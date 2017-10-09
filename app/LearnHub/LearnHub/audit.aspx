﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Masterpage.Master" AutoEventWireup="true" CodeBehind="audit.aspx.cs" Inherits="LearnHub.audit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.3.0/css/datepicker.css" rel="stylesheet" type="text/css" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.3.0/js/bootstrap-datepicker.js"></script>

    <style>
        .breadcrumb {
            padding-top: 15px;
            margin-bottom: 10px;
            list-style: none;
            background-color: white;
            border-radius: 0px;
        }
    </style>
    <script type="text/javascript">
        $(function () {
            $("#datepicker").datepicker({
                autoclose: true,
                todayHighlight: true
            }).datepicker('update', new Date());
        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <ul class="breadcrumb">
        <li><a href="home.aspx">Home</a></li>
        <li><a href="siteConfig.aspx">Configuration Settings</a></li>
        <li class="active">Audit</li>
    </ul>
    <div class="container">
        <h1>Audit</h1>
        <div class="verticalLine">
        </div>
        <form class="form-horizontal" runat="server">
            <fieldset>
                <legend>Download Audit Trail</legend>
                <div class="form-group required">
                    <strong>
                        <asp:Label runat="server" CssClass="col-lg-2 control-label" Text="Function"></asp:Label></strong>
                    <div class="col-lg-5">
                        <asp:DropDownList ID="ddlFunction" CssClass="form-control" runat="server">
                            <asp:ListItem Text="-- Select --" Selected="true" Value="0"></asp:ListItem>
                        </asp:DropDownList>
                    </div>
                </div>

                <div class="form-group required">
                    <strong>
                        <asp:Label runat="server" CssClass="col-lg-2 control-label" Text="Operation"></asp:Label></strong>
                    <div class="col-lg-5">
                        <asp:DropDownList ID="ddlOperation" CssClass="form-control" runat="server">
                            <asp:ListItem Text="-- Select --" Selected="true" Value="0"></asp:ListItem>
                            <asp:ListItem Text="All" Selected="false"></asp:ListItem>
                            <asp:ListItem Text="Create" Selected="false"></asp:ListItem>
                            <asp:ListItem Text="Read" Selected="false"></asp:ListItem>
                            <asp:ListItem Text="Update" Selected="false"></asp:ListItem>
                            <asp:ListItem Text="Delete" Selected="false"></asp:ListItem>
                            <asp:ListItem Text="Activate" Selected="false"></asp:ListItem>
                            <asp:ListItem Text="Deactivate" Selected="false"></asp:ListItem>
                        </asp:DropDownList>
                    </div>
                </div>

                <div class="form-group required">
                    <strong>
                        <asp:Label runat="server" CssClass="col-lg-2 control-label" Text="Date"></asp:Label></strong>
                    <div class="col-lg-5">
                        <div id="datepicker" class="input-group date" data-date-format="dd-mm-yyyy">
                            <asp:TextBox runat="server" ID="txtDate" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                            <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                        </div>
                    </div>
                </div>
                <br />
                <div class="wrapper">
                <asp:Button ID="btnDownload" runat="server" CssClass="btn btn-primary" Text="Download"/>
                    </div>
            </fieldset>
        </form>
    </div>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
