<%@ Page Title="" Language="C#" MasterPageFile="~/Masterpage.Master" AutoEventWireup="true" CodeBehind="askEmmaMain.aspx.cs" Inherits="LearnHub.askEmmaMain" %>

<%@ Import Namespace="LearnHub.AppCode.entity" %>
<%@ Import Namespace="LearnHub.AppCode.dao" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .configure {
            position: absolute;
            right: 0px;
            padding: 10px;
        }
    </style>
    <script>
    <%--
        $(document).ready(function () {
            $('#menu').hide();
        });

        function myFunction() {
            var x = document.getElementById('menu');
            if (x.style.display === 'none') {
                x.style.display = 'block';
            } else {
                x.style.display = 'none';
            }
        }
        --%>
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <% if (Session["currentUser"] != null)
        {
            User currentUser = (User)Session["currentUser"];

            if (currentUser.getDepartment().Equals("hr"))
            {

    %>

    <div class="configure">

        <%--<a href="#" id="config" onclick="myFunction()"><span class="label label-primary"><span class="glyphicon glyphicon-cog"></span>Configuration Menu</span></a>--%>
        <a href="emmaConfiguration.aspx" id="config" onclick="myFunction()"><span class="label label-primary"><span class="glyphicon glyphicon-cog"></span>Configuration Menu</span></a>
    </div>
    <br />
    <%--
    <div class="configure">
        <ul class="list-group" id="menu">
            <a href="askEmmaAddAns.aspx">
                <li class="list-group-item">Add New Answers
                </li>
            </a>
            <a href="askEmmaEditAns.aspx">
                <li class="list-group-item">Edit Answers
                </li>
            </a>
        </ul>
    </div>--%>

    <%}
        }%>


    <div class="container">
        <h1>Hello! I am Emma.</h1>

        <div class="verticalLine"></div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
