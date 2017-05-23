<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="LearnHub.LoginDefault" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Login</title>
    <link href="/bootstrap/css/bootstrap.css" rel="stylesheet" />
</head>
<body>
    <form id="login" runat="server">
        <div class="container text-center">

            <asp:Label ID="lblLogin" runat="server" CssClass="h2" Text="Login"></asp:Label>
            <div class="well offset4 span4">
                <div>
                    <asp:Label ID="lblUsername" CssClass="h3" runat="server" Text="Username: "></asp:Label>
                    <asp:TextBox ID="txtUsername" CssClass="input-group" runat="server"></asp:TextBox>
                </div>
                <div>
                    <asp:Label ID="lblPassword" CssClass="h3" runat="server" Text="Password: "></asp:Label>
                    <asp:TextBox ID="txtPassword" CssClass="input-group" runat="server" TextMode="Password"></asp:TextBox>
                </div>
                <br />

                <asp:Button ID="btnLogin" CssClass="btn btn-success" runat="server" Text="Login" OnClick="btnLogin_Click" />

                <br />

                <div class="alert alert-dismissible alert-danger">
                    <button type="button" class="close" data-dismiss="alert">&times;</button>
                    <asp:Label ID="lblErrorMsg" runat="server" CssClass="h3" ForeColor="#990000"></asp:Label>
                </div>
            </div>
        </div>
    </form>
</body>
<script src='https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js'></script>
<script src='/bootstrap/js/bootstrap.js'></script>
</html>
