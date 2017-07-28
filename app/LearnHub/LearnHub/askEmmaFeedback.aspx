<%@ Page Title="" Language="C#" MasterPageFile="~/Masterpage.Master" AutoEventWireup="true" CodeBehind="askEmmaFeedback.aspx.cs" Inherits="LearnHub.askEmmaFeedback" %>
<%@ Import Namespace="LearnHub.AppCode.entity" %>
<%@ Import Namespace="LearnHub.AppCode.dao" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
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
        jQuery(function ($) {
            $('.table').footable({
                "paging": {
                    "size": 1 <%--Change how many rows per page--%>
                },
                "filtering": {
                    "position": "left"
                }
            });
        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">
        <h1>View Feedback for Emma
                         <% if (Session["currentUser"] != null)
                             {
                                 User currentUser = (User)Session["currentUser"];
                                 if (currentUser.getDepartment().Equals("hr"))
                                 {
                         %>
            <a href="emmaConfiguration.aspx" id="config"><span class="btn btn-default pull-right"><span class="glyphicon glyphicon-option-horizontal"></span></span></a>
            <%}
                }%>
        </h1>
        <div class="verticalLine"></div>
        <form class="form-horizontal" runat="server">
            <div class="container">
                <br />
                <table class="table table-striped table-hover" data-paging="true" data-sorting="true" data-filtering="true">
                    <thead>
                        <tr>
                            <th width="80%">Feedback</th>
                            <th width="10%">Given by</th>
                            <th data-filterable="false" data-sortable="false"></th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>Good good very good Good good very good Good good very good Good good very good Good good very good Good good very good Good good very good Good good very good Good good very good Good good very good Good good very good Good good very good </td>
                            <td>Ber</td>
                            <td>
                                <asp:LinkButton ID="LinkButton1" CssClass="btn btn-danger pull-right btn-sm" runat="server" Text="" data-toggle="modal" href="#deleteModal"><span class="glyphicon glyphicon-trash"></span></asp:LinkButton></td>

                        </tr>
                        <tr>
                            <td>ayeee</td>
                            <td>Rafid</td>
                            <td>
                                <asp:LinkButton ID="LinkButton2" CssClass="btn btn-danger pull-right btn-sm" runat="server" Text="" data-toggle="modal" href="#deleteModal"><span class="glyphicon glyphicon-trash"></span></asp:LinkButton></td>

                        </tr>
                    </tbody>
                </table>
            </div>
        </form>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
