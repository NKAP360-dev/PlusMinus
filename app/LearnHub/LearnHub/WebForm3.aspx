<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WebForm3.aspx.cs" Inherits="LearnHub.WebForm3" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            Loaded
            <asp:Table ID="myTable" runat="server" Width="100%" Border="1" > 
                <asp:TableRow>
                    <asp:TableCell Font-Bold>id</asp:TableCell>
                    <asp:TableCell Font-Bold>name</asp:TableCell>
                </asp:TableRow>
            </asp:Table>  
        </div>
    </form>
</body>
</html>
