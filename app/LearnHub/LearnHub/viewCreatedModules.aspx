<%@ Page Title="" Language="C#" MasterPageFile="~/Masterpage.Master" AutoEventWireup="true" CodeBehind="viewCreatedModules.aspx.cs" Inherits="LearnHub.viewCreatedModules" %>
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
        <%
        User currentUser = (User)Session["currentUser"];
        if (currentUser != null && (currentUser.getRole().Equals("course creator") || currentUser.getRole().Equals("superuser")))
        {
    %>
    <div class="configure">
        <a href="#" id="config" onclick="configuration()"><span class="label label-default"><span class="glyphicon glyphicon-cog"></span>Configuration Menu</span></a>
    </div>
    <br />
    <div class="configure">
        <ul class="list-group" id="menu" style="display: none;">
            <a href="createModules.aspx">
                <li class="list-group-item"><span class="glyphicon glyphicon-plus"></span>&emsp;Create New Modules
                </li>
            </a>
            <a href="viewCreatedModules.aspx">
                <li class="list-group-item"><span class="glyphicon glyphicon-book"></span>&emsp; My Created Modules
                </li>
            </a>
        </ul>
    </div>
    <%
        }
    %>
    <div class="container">
        <h1>View My Created Modules</h1>

        <div class="verticalLine"></div>
    </div>
    <div class="container">
        <form runat="server">
        <table class="table table-striped table-hover" data-paging="true" data-sorting="true" data-filtering="true">
                        <thead>
                            <tr>
                                <th>Course Name</th>
                                <th>Course Category</th>
                                <th data-breakpoints="xs sm">Course Provider</th>
                                <th data-breakpoints="xs sm">Start Date</th>
                                <th data-breakpoints="xs sm">End Date</th>
                                <th data-filterable="false" data-sortable="false"></th>

                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>How to be Ming Kuang</td>
                                <td>Compulsory</td>
                                <td>Eugene Pte Ltd</td>
                                <td>938498234</td>
                                <td>ksdfkdjsfn</td>
                                <td><asp:LinkButton ID="btnDelete" CssClass="btn btn-danger btn-sm pull-right" runat="server" Text="" data-toggle="modal" href="#deleteModal"><span class="glyphicon glyphicon-trash"></span></asp:LinkButton>
                                    <asp:LinkButton ID="btnEdit" CssClass="btn btn-info btn-sm pull-right" runat="server" Text="" href="#"><span class="glyphicon glyphicon-pencil"></span></asp:LinkButton>
                                </td>
                            </tr>
                        </tbody>
                    </table>

              <%--Modal for Deletion Confirmation--%>
        <div id="deleteModal" class="modal fade" role="dialog">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title"><span class="glyphicon glyphicon-trash"></span>&nbsp;<b>Delete Module</b></h4>
                    </div>
                    <%--Modal Content--%>
                    <div class="modal-body">
                        <div class="wrapper">
                            <h4>Are you sure you want to delete?</h4>
                            <br />
                            <asp:Button ID="cfmDelete" CssClass="btn btn-danger" runat="server" Text="Delete" />
                            <asp:Button ID="Button2" CssClass="btn btn-default" runat="server" class="close" data-dismiss="modal" Text="Cancel" />

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
