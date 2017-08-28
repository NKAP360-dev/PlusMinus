<%@ Page Title="" Language="C#" MasterPageFile="~/Masterpage.Master" AutoEventWireup="true" CodeBehind="viewAllModule.aspx.cs" Inherits="LearnHub.viewAllModule" %>

<%@ Import Namespace="LearnHub.AppCode.entity" %>
<%@ Import Namespace="LearnHub.AppCode.dao" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
      <style>
        .list-group-item {
            border-left: 1px solid white;
            border-right: 1px solid white;
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

        .breadcrumb {
            padding-top: 15px;
            margin-bottom: 0px;
            list-style: none;
            background-color: white;
            border-radius: 0px;
        }
    </style>
    <link href="/Scripts/footable.bootstrap.min.css" rel="stylesheet" />
    <script src="/Scripts/footable.min.js"></script>
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
  <ul class="breadcrumb">
        <li><a href="home.aspx">Home</a></li>
        <li class="active">Modules</li>
    </ul>
    <form id="form1" runat="server">
        <div class="container">
            <h1>View Modules

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
                    <li class="list-group-item"><span class="glyphicon glyphicon-plus"></span>&emsp;Create New Modules
                    </li>
                </a>
                <a href="manageCategories.aspx">
                    <li class="list-group-item"><span class="glyphicon glyphicon-bookmark"></span>&emsp;Manage Module Categories
                    </li>
                </a>
                <a href="viewCreatedModules.aspx">
                    <li class="list-group-item"><span class="glyphicon glyphicon-book"></span>&emsp;Manage Modules
                    </li>
                </a>
            </ul>
        </div>
            <%
                }
            %>
            <div class="verticalLine"></div>
        </div>

        <div class="container">
            <div class="row">
                <div class="col-md-3">
                    <div class="list-group">
                        <div class="wrapper">
                            <h4><strong><span class="glyphicon glyphicon-search">&emsp;</span>View Training Types</strong></h4>
                        </div>
                        <asp:SqlDataSource ID="SqlDataSourceCourseCategory" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" SelectCommand="SELECT * FROM [Elearn_courseCategory] WHERE status = 'active' "></asp:SqlDataSource>
                        <asp:ListView runat="server" DataSourceID="SqlDataSourceCourseCategory" DataTextField="category,categoryID">
                            <ItemTemplate>
                                <asp:LinkButton ID="btnModuleCategory" runat="server" CssClass="list-group-item" OnClick="btnModuleCategory_Click" CommandArgument='<%# Eval("categoryID") %>'><%# Eval("category") %></asp:LinkButton>
                            </ItemTemplate>
                        </asp:ListView>
                    </div>
                </div>
                <div class="col-md-9">
                    <h2>
                        <asp:Label ID="lblModuleCategory" runat="server" Text="Choose a category from the left"></asp:Label></h2>
                    <p>
                        <asp:SqlDataSource ID="SqlDataSourceCourse" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>"></asp:SqlDataSource>
                        <asp:GridView ID="gvCourse" runat="server" CssClass="footable table table-striped table-hover" data-paging="true" data-sorting="true" data-filtering="true" GridLines="None" AutoGenerateColumns="false" EmptyDataText="There are no modules available to choose from.">
                            <Columns>
                                <asp:BoundField DataField="elearn_courseName" HeaderText="Module Name" SortExpression="elearn_courseName" />
                                <asp:BoundField DataField="elearn_courseProvider" HeaderText="Module Provider" SortExpression="elearn_courseProvider" />
                                <asp:BoundField DataField="hoursAwarded" HeaderText="Hours Awarded" SortExpression="hoursAwarded" />
                                <asp:HyperLinkField DataNavigateUrlFields="elearn_courseID" DataNavigateUrlFormatString="viewModuleInfo.aspx?id={0}" Text="View Details" />
                            </Columns>
                        </asp:GridView>
                    </p>

                </div>
            </div>
        </div>
    </form>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
