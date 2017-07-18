<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WebForm2.aspx.cs" Inherits="LearnHub.WebForm2" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            Course ID <asp:TextBox ID="id" runat="server"></asp:TextBox>
            <br />
            Course Name <asp:TextBox ID="name" runat="server"></asp:TextBox>
             <br />
            Provider <asp:TextBox ID="provider" runat="server"></asp:TextBox>
             <br />
            Expiry Date<asp:TextBox ID="expiry" runat="server"></asp:TextBox>
             <br />
            Status<asp:TextBox ID="status" runat="server" name ="status"></asp:TextBox>
             <br />
            Description<asp:TextBox ID="desc" runat="server"></asp:TextBox>
             <br />
            <asp:Button OnClick="btnSubmit_Click" Text="Submit" runat="server" /> 
        </div>
    </form>
</body>
</html>
