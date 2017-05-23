<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="LearnHub.LoginDefault" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Login</title>
    <link href="/Content/bootstrap.css" rel="stylesheet"/>
    <link href="/Content/site.css" rel="stylesheet"/>
    <script src="/Scripts/modernizr-2.6.2.js"></script>
</head>
<body>
    <form id="login" runat="server">
        <div class="container text-center">
            <asp:Label ID="lblLogin" runat="server" CssClass="h2" Text="Login"></asp:Label>
            <div class="jumbotron">
                
                <div>
                    <asp:Label ID="lblUsername" CssClass="h3" runat="server" Text="Username: "></asp:Label>
                    <asp:TextBox ID="txtUsername" CssClass="input-group" runat="server"></asp:TextBox>
                </div>
                <div>
                    <asp:Label ID="lblPassword" CssClass="h3" runat="server" Text="Password: "></asp:Label>
                    <asp:TextBox ID="txtPassword" CssClass="input-group" runat="server" TextMode="Password"></asp:TextBox>
                </div>
                <br />
        
                <asp:Button ID="btnLogin" CssClass="btn btn-primary btn-lg" runat="server" Text="Login" OnClick="btnLogin_Click" />

                <br />
                <asp:Label ID="lblErrorMsg" runat="server" CssClass="h3" ForeColor="#990000"></asp:Label>

            </div>
        </div>
    </form>
</body>
</html>
