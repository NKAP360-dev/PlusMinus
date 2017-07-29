<%@ Page Title="" Language="C#" MasterPageFile="~/Masterpage.Master" AutoEventWireup="true" CodeBehind="askEmmaInstruction.aspx.cs" Inherits="LearnHub.askEmmaInstruction" %>
<%@ Import Namespace="LearnHub.AppCode.entity" %>
<%@ Import Namespace="LearnHub.AppCode.dao" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="http://netdna.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css" rel="stylesheet">
    <link href="/Scripts/editor.css" rel="stylesheet" type="text/css" />
    <script src="/Scripts/editor.js"></script>
    <script>
        <%--https://github.com/suyati/line-control--%>
        $(document).ready(function () {
            $("#txtEditor").Editor();
            $("#txtEditor").Editor("setText", "Hello this field shall be configured to display the current instructions so that users can edit from existing instruction")

        });

        <%--Just for you to see the html code output by editor--%>
        function displayText() {
            alert($("#txtEditor").Editor("getText"));
        }

        <%--To retrieve text from editor--%>
        <%--
        
        $("#txtEditor").Editor("getText");

        --%>
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <br />

    <div class="container">
        <h1>Emma's Instructions
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
        <form runat="server">
            <div id="txtEditor"></div>
            <br />
            <asp:Button ID="btnSave" CssClass="btn btn-primary pull-right" runat="server" Text="Save" OnClientClick="displayText()" />
        </form>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
