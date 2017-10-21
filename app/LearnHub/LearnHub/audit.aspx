<%@ Page Title="" Language="C#" MasterPageFile="~/Masterpage.Master" AutoEventWireup="true" CodeBehind="audit.aspx.cs" Inherits="LearnHub.audit" %>

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
            $('.input-daterange').datepicker({
                format: 'dd/mm/yyyy',
                autoclose: true
            });
        });

        $(function () {
            $('.input-group.date').datepicker({
                format: 'dd/mm/yyyy',
                calendarWeeks: true,
                todayHighlight: true,
                autoclose: true
            });
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
                            <asp:ListItem Text="-- Select --" Selected="true" Value="none"></asp:ListItem>
                            <asp:ListItem Text="All" Selected="false" Value="all"></asp:ListItem>
                            <asp:ListItem Text="About Us" Selected="False" Value="about us"></asp:ListItem>
                            <asp:ListItem Text="Articles" Selected="false" Value="articles"></asp:ListItem>
                            <asp:ListItem Text="Contact Us" Selected="false" Value="contact us"></asp:ListItem>
                            <asp:ListItem Text="Course" Selected="false" Value="course"></asp:ListItem>
                            <asp:ListItem Text="Course Category" Selected="false" Value="course category"></asp:ListItem>
                            <asp:ListItem Text="Learny Answers" Selected="false" Value="learny answers"></asp:ListItem>
                            <asp:ListItem Text="Learny Feedback" Selected="false" Value="learny feedback"></asp:ListItem>
                            <asp:ListItem Text="Learny Help Questions" Selected="false" Value="learny help questions"></asp:ListItem>
                            <asp:ListItem Text="Learny Instructions" Selected="false" Value="learny instructions"></asp:ListItem>
                            <asp:ListItem Text="Learny Intents" Selected="false" Value="learny intents"></asp:ListItem>
                            <asp:ListItem Text="Learny Initialization Message" Selected="false" Value="learny initialization message"></asp:ListItem>
                            <asp:ListItem Text="News" Selected="false" Value="news"></asp:ListItem>
                            <asp:ListItem Text="News Banner" Selected="false" Value="news banner"></asp:ListItem>
                            <asp:ListItem Text="Quiz" Selected="false" Value="quiz"></asp:ListItem>
                            <asp:ListItem Text="Training Calendar" Selected="false" Value="training calendar"></asp:ListItem>
                            <asp:ListItem Text="Userful Links" Selected="false" Value="useful links"></asp:ListItem>
                            <asp:ListItem Text="User" Selected="false" Value="user"></asp:ListItem>


                        </asp:DropDownList>
                    </div>
                </div>

                <div class="form-group required">
                    <strong>
                        <asp:Label runat="server" CssClass="col-lg-2 control-label" Text="Operation"></asp:Label></strong>
                    <div class="col-lg-5">
                        <asp:DropDownList ID="ddlOperation" CssClass="form-control" runat="server">
                            <asp:ListItem Text="-- Select --" Selected="true" Value="none"></asp:ListItem>
                            <asp:ListItem Text="All" Selected="false" Value="all"></asp:ListItem>
                            <asp:ListItem Text="Create" Selected="false" Value="create"></asp:ListItem>
                            <asp:ListItem Text="Read" Selected="false" Value="read"></asp:ListItem>
                            <asp:ListItem Text="Update" Selected="false" Value="update"></asp:ListItem>
                            <asp:ListItem Text="Delete" Selected="false" Value="delete"></asp:ListItem>
                            <asp:ListItem Text="Activate" Selected="false" Value="activate"></asp:ListItem>
                            <asp:ListItem Text="Deactivate" Selected="false" Value="deactivate"></asp:ListItem>
                        </asp:DropDownList>
                    </div>
                </div>

                <div class="form-group required">
                    <strong>
                        <asp:Label runat="server" CssClass="col-lg-2 control-label" Text="Date"></asp:Label></strong>
                    <div class="col-lg-5">
                        <div class="input-daterange input-group" id="datepicker">
                            <asp:TextBox ID="fromDateInput" runat="server" CssClass="form-control" placeholder="DD/MM/YYYY" ReadOnly="False"></asp:TextBox>
                            <span class="input-group-addon">to</span>
                            <asp:TextBox ID="toDateInput" runat="server" CssClass="form-control" placeholder="DD/MM/YYYY" ReadOnly="False"></asp:TextBox>
                            <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i>
                            </span>
                        </div>
                        <h6><em>Click on the textbox to choose a date</em></h6>
                    </div>
                </div>
                <br />
                <div class="wrapper">
                <asp:Button ID="btnDownload" runat="server" CssClass="btn btn-primary" Text="Download" OnClick="btnDownload_Click"/>
                    </div>
            </fieldset>
        </form>
    </div>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
