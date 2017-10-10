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
            margin-bottom: 10px;
            list-style: none;
            background-color: white;
            border-radius: 0px;
        }

        .coursesBanner img {
            border-radius: 5px;
            max-height: 300px;
            max-width: 700px;
        }
    </style>
    <link href="Scripts/footable.bootstrap.min.css" rel="stylesheet" />
    <script src="Scripts/footable.min.js"></script>
    <script>
        jQuery(function ($) {
            $('[id*=gvCourse]').footable({
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
        <li class="active">Courses</li>
    </ul>
    <form id="form1" runat="server">
        <div class="container">
            <h1>View Courses</h1>

            <%
                User currentUser = (User)Session["currentUser"];
                Boolean superuser = false;
                Boolean course_creator = false;
                if (currentUser != null)
                {
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
                    <div class="dropHeader">Course Management</div>
                    <a href="createModules.aspx"><span class="glyphicon glyphicon-plus"></span>&nbsp;&nbsp;Create New Courses</a>
                    <a href="manageCategories.aspx"><span class="glyphicon glyphicon-bookmark"></span>&nbsp;&nbsp;Manage Course Categories</a>
                    <a href="viewCreatedModules.aspx"><span class="glyphicon glyphicon-book"></span>&nbsp;&nbsp;Manage Courses</a>
                </div>
            </div>

            <%
                    }
                }
            %>
            <div class="verticalLine"></div>
        </div>

        <div class="container">
            <div class="row">
                <div class="col-md-3">
                    <div class="list-group">
                        <div class="wrapper">
                            <h4><strong><span class="glyphicon glyphicon-education">&emsp;</span>Course Categories</strong></h4>
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
                    <br />
                    <div class="coursesBanner wrapper">
                        <img src="img/courses.png" style='width:100%;' border="0"/>
                    </div>
                    <h2>
                        <asp:Label ID="lblModuleCategory" runat="server"></asp:Label></h2>
                    <p>
                        <asp:SqlDataSource ID="SqlDataSourceCourse" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>"></asp:SqlDataSource>
                        <asp:GridView ID="gvCourse" runat="server" CssClass="footable table table-striped table-hover" data-paging="true" data-sorting="true" data-filtering="true" GridLines="None" AutoGenerateColumns="false" EmptyDataText="There are no courses available to choose from.">
                            <Columns>
                                <asp:BoundField DataField="elearn_courseName" HeaderText="Course Name" SortExpression="elearn_courseName" />
                                <asp:BoundField DataField="elearn_courseProvider" HeaderText="Course Provider" SortExpression="elearn_courseProvider" />
                                <asp:BoundField DataField="hoursAwarded" HeaderText="Learning Hours" SortExpression="hoursAwarded" />
                                <asp:BoundField DataField="courseType" HeaderText="Course Type" SortExpression="courseType" />
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
