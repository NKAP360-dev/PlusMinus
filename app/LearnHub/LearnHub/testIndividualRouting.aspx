<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="testIndividualRouting.aspx.cs" Inherits="LearnHub.testIndividualRouting" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
        </div>
        <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
        <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Button" />
        <br />
        <br />
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" SelectCommand="SELECT * FROM [Notifications]"></asp:SqlDataSource>
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="notif_ID" DataSourceID="SqlDataSource1">
            <Columns>
                <asp:BoundField DataField="userID_from" HeaderText="userID_from" SortExpression="userID_from" />
                <asp:BoundField DataField="userID_To" HeaderText="userID_To" SortExpression="userID_To" />
                <asp:BoundField DataField="tnfid" HeaderText="tnfid" SortExpression="tnfid" />
                <asp:BoundField DataField="status" HeaderText="status" SortExpression="status" />
                <asp:BoundField DataField="notif_ID" HeaderText="notif_ID" ReadOnly="True" SortExpression="notif_ID" />
            </Columns>
        </asp:GridView>
    </form>
</body>
</html>
