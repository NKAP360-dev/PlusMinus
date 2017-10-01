<%@ Page Title="" Language="C#" MasterPageFile="~/Masterpage.Master" AutoEventWireup="true" CodeBehind="usefulLinks.aspx.cs" Inherits="LearnHub.usefulLinks" %>

<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="System.Data" %>
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

        .banner img {
            border-radius: 5px;
            max-height: 280px;
            max-width: 850px;
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
    <script>
        $(window).on('load', function () {
            $('#myModal').modal('show');
        });

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
        <li class="active">Useful Links</li>
    </ul>
    <form runat="server" class="form-horizontal">
        <div class="container">
            <h1>Useful Links</h1>
            <div class="verticalLine"></div>
            <br />

             <table class="table table-striped table-hover" data-paging="true" data-sorting="true" data-filtering="true">
            <thead>
                <tr>
                    <th>Link</th>
                    <th>Description</th>

                </tr>
            </thead>
            <tbody>
                <%  LinkDAO ldao = new LinkDAO();
                        ArrayList arr = ldao.getLinks();
                        foreach (Link link in arr)
                        {%>
                    <tr>
                        <td><a href="<%=link.link_path %>" target="_blank"><%=link.link_path %>/</a></td>
                        <td><%=link.description %></td>
                    </tr>
                    <%} %>
            </tbody>
        </table>
        </div>
    </form>

        <div class="container">
            <div class="modal" id="myModal">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                            <h4 class="modal-title"><b>U N D E R &nbsp; C O N S T R U C T I O N</b></h4>
                        </div>
                        <div class="modal-body">
                            <div class="wrapper"><img src="img/barrier.png" style='width: 30%;' border="0"/>
                                <h3 class="text-danger">This page is currently still under construction!</h3>
                                <p>You may still navigate around but not everything is working as it should be. <br /> Team PlusMinus is trying their best to get everything
                                    up as soon as possible!
                                </p>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <div class="wrapper">
                            <button type="button" class="btn btn-warning" data-dismiss="modal">Got it!</button>
                                </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
