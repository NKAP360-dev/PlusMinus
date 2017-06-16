<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TestHash.aspx.cs" Inherits="LearnHub.TestHash" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <br />
            <asp:Button ID="btnSalt" runat="server" OnClick="btnSalt_Click" Text="Generate Salt" />
            <br />
            <br />
        </div>
        Salt: <asp:TextBox ID="txtSalt" runat="server"></asp:TextBox>
        <br />
        Password:
        <asp:TextBox ID="txtHash" runat="server"></asp:TextBox>
        <asp:Button ID="btnSubmit" runat="server" OnClick="btnSubmit_Click" Text="Get Hash" />
        <br />
        <br />
        <br />
        <asp:Label ID="lblHash" runat="server"></asp:Label>
    </form>
</body>
</html>
