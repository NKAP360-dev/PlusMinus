<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WebForm1.aspx.cs" Inherits="LearnHub.WebForm1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
            <asp:Button ID="btnSubmit" runat="server" OnClick="btnSubmit_Click" Text="Search" />
            <br />
            <br />
            <asp:Label ID="lblError" runat="server" ForeColor="#CC0000"></asp:Label>
            <asp:Panel ID="Panel1" runat="server" Visible="False">
                <asp:Label ID="Label1" runat="server" Text="Name: "></asp:Label>
                <asp:Label ID="lblName" runat="server"></asp:Label>
                <br />
                <br />
                <asp:Label ID="Label2" runat="server" Text="Lenth of Service: "></asp:Label>
                <asp:Label ID="lblLOS" runat="server"></asp:Label>
                <br />
                <br />
                <asp:Label ID="Label3" runat="server" Text="Job Title: "></asp:Label>
                <asp:Label ID="lblJobTitle" runat="server"></asp:Label>
            </asp:Panel>
        </div>
    </form>
</body>
</html>
