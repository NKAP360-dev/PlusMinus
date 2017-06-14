<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TestCipher.aspx.cs" Inherits="LearnHub.TestCipher" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
        </div>
        Encrypt<br />
        <br />
        Text String: <asp:TextBox ID="txtString" runat="server"></asp:TextBox>
        <br />
        Passphrase:
        <asp:TextBox ID="txtPass" runat="server"></asp:TextBox>
        <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Button" />
        <br />
        <br />
        <asp:Label ID="lblDisplay" runat="server"></asp:Label>
        <br />
        <br />
        <br />
        <br />
        <br />
        Decrypt<br />
        <br />
        Cipher Text:
        <asp:TextBox ID="txtCipher" runat="server"></asp:TextBox>
        <br />
        Passphrase:
        <asp:TextBox ID="txtCipherPass" runat="server"></asp:TextBox>
        <asp:Button ID="Button2" runat="server" OnClick="Button2_Click" Text="Button" />
        <br />
        <br />
        <br />
        <asp:Label ID="lblDisplay2" runat="server"></asp:Label>
        <br />
    </form>
</body>
</html>
