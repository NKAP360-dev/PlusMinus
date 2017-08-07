<%@ Page Title="" Language="C#" MasterPageFile="~/Masterpage.Master" AutoEventWireup="true" CodeBehind="test.aspx.cs" Inherits="LearnHub.test" %>

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
                    "size": 5 <%--Change how many rows per page--%>
                },
                "filtering": {
                    "position": "left"
                }
            });
        });

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
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
    </div>

    <div class="container">
        <div class="row">
            <div class="col-md-3">
                <div class="list-group">
                    <div class="wrapper">
                        <h4><strong><span class="glyphicon glyphicon-search">&emsp;</span>View Training Types</strong></h4>
                    </div>
                    <%
                        Course_elearnCategoryDAO cecDAO = new Course_elearnCategoryDAO();
                        List<CourseCategory> allCategory = cecDAO.getAllCategory();
                        String htmlCatStr = null;
                        if (allCategory.Count > 0) {
                            foreach (CourseCategory cc in allCategory) {
                                htmlCatStr += "<a href=\"test.aspx?category=";
                                htmlCatStr += cc.getCategory();
                                htmlCatStr += "\" class=\"list-group-item\" id=\"menu\" ";
                                htmlCatStr += "runat=\"server\" onserverclick=\"menu_Click\">";
                                htmlCatStr += cc.getCategory();
                                htmlCatStr += "</a>";
                            }
                            Response.Write(htmlCatStr);
                        }

                        %>
                </div>
            </div>
            <div class="col-md-9">
                <%--<asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                    <ContentTemplate>
                        <asp:Label ID="Label1" runat="server" Text="Label"></asp:Label>
                    </ContentTemplate>


                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="menu" />
                    </Triggers>


                </asp:UpdatePanel>
                    --%>
            </div>
        </div>
    </div>
    </form>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
