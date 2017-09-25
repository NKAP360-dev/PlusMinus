    <%@ Page Title="" Language="C#" MasterPageFile="~/Masterpage.Master" AutoEventWireup="true" CodeBehind="contactUs.aspx.cs" Inherits="LearnHub.contactUs" %>

<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="LearnHub.AppCode.dao" %>
<%@ Import Namespace="LearnHub.AppCode.entity" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="/Scripts/footable.bootstrap.min.css" rel="stylesheet" />
    <script src="/Scripts/footable.min.js"></script>
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
        <li class="active">Contact Us</li>
    </ul>

    <form runat="server" class="form-horizontal">
        <div class="container">
            <h1>Contact Us</h1>
            <div class="verticalLine"></div>
            <br />
            <div class="banner wrapper">
                <img src="img/contactus.png" style='width: 100%;' border="0" />
            </div>
            <br />
             <table class="table table-striped table-hover" data-paging="true" data-sorting="true" data-filtering="true">
            <thead>
                <tr>
                    <th>Name</th>
                    <th>Department</th>
                    <th>Email</th>
                    <th>Remarks</th>
                </tr>
            </thead>
            <tbody>
                <% ContactDAO ldao = new ContactDAO();
                             ArrayList arr = ldao.getContacts();
                             foreach (Contact con in arr)
                             {%>
                        <tr>
                            <td><%=con.name %></td>
                            <td><%=con.department %></td>
                            <td><%=con.email %></td>
                            <td><%=con.remarks %></td>      
                        </tr>
                        <%} %>
            </tbody>
        </table>
        </div>
    </form>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
