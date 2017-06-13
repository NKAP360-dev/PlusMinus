<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="testIndividualRouting.aspx.cs" Inherits="LearnHub.testIndividualRouting" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Label ID="Label2" runat="server" Text="Enter userid of approver: "></asp:Label>
            <asp:TextBox ID="txtApprover" runat="server"></asp:TextBox>
            <asp:Button ID="btnApprover" runat="server" Text="(Remember to select the notification before submitting) Submit" OnClick="btnApprover_Click" Width="782px" />
            <br />
            <br />
            This is to trigger the first notification sending (will be automated during tnf registration process):<br />
        </div>
        <asp:Label ID="Label3" runat="server" Text="Enter TNF UserID: "></asp:Label>
        <asp:TextBox ID="txtTNFUser" runat="server"></asp:TextBox>
        <br />
        <asp:Label ID="Label1" runat="server" Text="Enter TNF ID: "></asp:Label>
        <asp:TextBox ID="txtTNF" runat="server"></asp:TextBox>
        <asp:Button ID="btnTNF" runat="server" OnClick="btnTNF_Click" Text="Submit" />
        <br />
        <br />
        <br />
        Notification table<br />
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" SelectCommand="SELECT * FROM [Notifications]"></asp:SqlDataSource>
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="notif_ID" DataSourceID="SqlDataSource1">
            <Columns>
                <asp:CommandField ShowSelectButton="True" />
                <asp:BoundField DataField="userID_from" HeaderText="userID_from" SortExpression="userID_from" />
                <asp:BoundField DataField="userID_To" HeaderText="userID_To" SortExpression="userID_To" />
                <asp:BoundField DataField="tnfid" HeaderText="tnfid" SortExpression="tnfid" />
                <asp:BoundField DataField="status" HeaderText="status" SortExpression="status" />
                <asp:BoundField DataField="notif_ID" HeaderText="notif_ID" ReadOnly="True" SortExpression="notif_ID" />
            </Columns>
            <SelectedRowStyle BackColor="Silver" />
        </asp:GridView>
        <br />
        <br />
        TNF Table<asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" SelectCommand="SELECT * FROM [TNF]"></asp:SqlDataSource>
        <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" DataKeyNames="tnfid,userID" DataSourceID="SqlDataSource2">
            <Columns>
                <asp:BoundField DataField="tnfid" HeaderText="tnfid" InsertVisible="False" ReadOnly="True" SortExpression="tnfid" />
                <asp:BoundField DataField="userID" HeaderText="userID" ReadOnly="True" SortExpression="userID" />
                <asp:BoundField DataField="status" HeaderText="status" SortExpression="status" />
                <asp:BoundField DataField="wf_status" HeaderText="wf_status" SortExpression="wf_status" />
                <asp:BoundField DataField="wfid" HeaderText="wfid" SortExpression="wfid" />
                <asp:BoundField DataField="type" HeaderText="type" SortExpression="type" />
            </Columns>
        </asp:GridView>
    </form>
</body>
</html>
