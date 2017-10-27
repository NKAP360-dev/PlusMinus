﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Masterpage.Master" AutoEventWireup="true" CodeBehind="manageNewsBanners.aspx.cs" Inherits="LearnHub.manageNewsBanners" %>

<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Collections" %>
<%@ Import Namespace="LearnHub.AppCode.dao" %>
<%@ Import Namespace="LearnHub.AppCode.entity" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="Scripts/footable.bootstrap.min.css" rel="stylesheet" />
    <script src="Scripts/footable.min.js"></script>
    <style>
        .breadcrumb {
            padding-top: 15px;
            margin-bottom: 10px;
            list-style: none;
            background-color: white;
            border-radius: 0px;
        }

        .pagination li > a,
        .pagination li > span,
        .pagination li > a:focus, .pagination .disabled > a,
        .pagination .disabled > a:hover,
        .pagination .disabled > a:focus,
        .pagination .disabled > span {
            background-color: white;
            color: black;
        }

            .pagination li > a:hover {
                background-color: #96a8ba;
            }

        .pagination > .active > a,
        .pagination > .active > span,
        .pagination > .active > a:hover,
        .pagination > .active > span:hover,
        .pagination > .active > a:focus,
        .pagination > .active > span:focus {
            background-color: #576777;
        }

        .dropdown {
            z-index: 100;
        }
    </style>

    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>
    <link rel="stylesheet" href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.8.24/themes/smoothness/jquery-ui.css" />
    <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.8.24/jquery-ui.min.js"></script>

    <script type="text/javascript">
        var unsaved = false;

        $(function () {
            $(".table").sortable({
                items: 'tr:not(tr:first-child)',
                cursor: 'pointer',
                axis: 'y',
                dropOnEmpty: false,
                start: function (e, ui) {
                    ui.item.addClass("selected");
                    unsaved = true;
                },
                stop: function (e, ui) {
                    ui.item.removeClass("selected");
                    unsaved = true;
                },
                receive: function (e, ui) {
                    $(this).find("tbody").append(ui.item);
                    unsaved = true;
                }
            });
        });

        function btnSaveClick() {
            unsaved = false;
        }

        $(document).ready(function () {
            function unloadPage() {
                if (unsaved) {
                    return "You have unsaved changes on this page. Do you want to leave this page and discard your changes or stay on this page?";
                }
            }

            window.onbeforeunload = unloadPage;
        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <ul class="breadcrumb">
        <li><a href="home.aspx">Home</a></li>
        <li class="active">Manage News Banners</li>
    </ul>

    <div class="container">
        <h1>Manage News Banner
        <button type="button" data-toggle="collapse" data-target="#addForm" class="btn btn-success">Upload New Banner</button>
        </h1>

        <div class="dropdown" style="float: right;">
            <button class="dropbtn" onclick="return false;"><span class="glyphicon glyphicon-option-horizontal"></span></button>
            <div class="dropdown-content" style="right: 0;">
                <div class="dropHeader">Content Management</div>
                <a href="editAboutUs.aspx"><span class="glyphicon glyphicon-pencil"></span>&nbsp;&nbsp;Edit About Us</a>
                <a href="manageArticles.aspx"><span class="glyphicon glyphicon-duplicate"></span>&nbsp;&nbsp;Manage Articles</a>
                <a href="manageUsefulLinks.aspx"><span class="glyphicon glyphicon-globe"></span>&nbsp;&nbsp;Manage Links</a>
                <a href="manageContactUs.aspx"><span class="glyphicon glyphicon-earphone"></span>&nbsp;&nbsp;Manage Contact Us</a>
                <a href="uploadTrainingCalendar.aspx"><span class="glyphicon glyphicon-calendar"></span>&nbsp;&nbsp; Upload Training Calendar</a>
                <a href="manageNewsBanners.aspx"><span class="glyphicon glyphicon-picture"></span>&nbsp;&nbsp; Manage News Banners</a>
                <a href="manageNews.aspx"><span class="glyphicon glyphicon-blackboard"></span>&nbsp;&nbsp; Manage News</a>

            </div>
        </div>
        <div class="verticalLine"></div>
    </div>
    <form class="form-horizontal" runat="server">
        <div class="container">
            <div id="addForm" class="collapse">
                <br />
                <div class="form-group required">
                    <strong>
                        <asp:Label runat="server" CssClass="col-lg-2 control-label" Text="Banner Name"></asp:Label></strong>
                    <div class="input-group col-lg-9">
                        <asp:TextBox ID="txtName" runat="server" CssClass="form-control" placeholder="Banner Name"></asp:TextBox>
                    </div>
                </div>

                <div class="form-group required">
                    <strong>
                        <asp:Label runat="server" CssClass="col-lg-2 control-label" Text="Banner Link"></asp:Label></strong>
                    <div class="input-group col-lg-9">
                        <asp:TextBox ID="txtLink" runat="server" CssClass="form-control" placeholder="Page that user will land upon clicking the banner"></asp:TextBox>
                    </div>
                </div>

                <div class="form-group required">
                      <strong>
                        <asp:Label runat="server" CssClass="col-lg-2 control-label" Text="Upload Banner Image"></asp:Label></strong>
                    <div class="col-lg-9">
                     <asp:FileUpload ID="FileUpload1" runat="server"/>
                        </div>

                </div>
                <div class="wrapper">
                    <asp:Button runat="server" CssClass="btn btn-primary" Text="Upload" OnClick="btnUpload_Click"/>
                    <%--Please integrate the displaying of banners at home.aspx as well--%>
                </div>
                 <div class="verticalLine"></div>
            </div>
           
        </div>
        <div class="container">
            <h4><b>Drag and drop to reorder banners</b></h4>
            <%--For some reason item 1 can't be dragged, not sure if this issue will be resolved with gridview as learny initialize msg uses same javascript
                to reorder but works well w gridview--%>
           <asp:SqlDataSource ID="SqlDataSourceMessages" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" SelectCommand="SELECT * FROM [News] where status = 'Active' ORDER BY levels"></asp:SqlDataSource>
            <asp:GridView ID="gvMessages" runat="server" AutoGenerateColumns="False" DataKeyNames="banner_name" DataSourceID="SqlDataSourceMessages" GridLines="None" CssClass="table table-striped table-hover">
                <Columns>
                    <asp:BoundField DataField="banner_name" HeaderText="Banner Name" SortExpression="banner_name" />

                    <asp:TemplateField>
                        <ItemTemplate>
                            <input type="hidden" name="banner_id" value='<%# Eval("banner_id") %>' />
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField>
                        <ItemTemplate>
                            <a href="deleteNews.aspx?id=<%# Eval("banner_id") %>" class="btn btn-sm btn-danger pull-right" onclick="return confirm('Are you sure?')"><span class="glyphicon glyphicon-trash"></span></a>
                        </ItemTemplate>
                    </asp:TemplateField>

                </Columns>
                <EmptyDataTemplate>
                </EmptyDataTemplate>
            </asp:GridView>
             <div class="wrapper">
                <div class="form-group">
                    <asp:LinkButton ID="btnSave" CssClass="btn btn-primary" runat="server" OnClick="btnSave_Click" OnClientClick="btnSaveClick()">Save Order</asp:LinkButton>
                    <br />
                </div>
                
            </div>
        </div>

        <%--Modal for Deletion Confirmation--%>
        <div id="deleteModal" class="modal fade" role="dialog">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title"><span class="glyphicon glyphicon-trash"></span>&nbsp;<b>Delete Message</b></h4>
                    </div>
                    <%--Modal Content--%>
                    <div class="modal-body">
                        <div class="wrapper">
                            <h4>Are you sure you want to delete?</h4>
                            <br />
                            <asp:Button ID="btnCfmDel" CssClass="btn btn-danger" runat="server" Text="Delete" />
                            <asp:Button ID="btnClose" CssClass="btn btn-default" runat="server" class="close" data-dismiss="modal" Text="Cancel" />

                            <br />
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </form>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
