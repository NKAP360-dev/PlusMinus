<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="testIndividualRouting.aspx.cs" Inherits="LearnHub.testIndividualRouting" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <br />
        TNF Table<asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" SelectCommand="SELECT * FROM [TNF]"></asp:SqlDataSource>
        <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" DataKeyNames="tnfid,userID" DataSourceID="SqlDataSource2">
            <Columns>
                <asp:CommandField ShowSelectButton="True" />
                <asp:BoundField DataField="tnfid" HeaderText="tnfid" InsertVisible="False" ReadOnly="True" SortExpression="tnfid" />
                <asp:BoundField DataField="userID" HeaderText="userID" ReadOnly="True" SortExpression="userID" />
                <asp:BoundField DataField="status" HeaderText="status" SortExpression="status" />
                <asp:BoundField DataField="wf_status" HeaderText="wf_status" SortExpression="wf_status" />
                <asp:BoundField DataField="wfid" HeaderText="wfid" SortExpression="wfid" />
                <asp:BoundField DataField="type" HeaderText="type" SortExpression="type" />
                <asp:BoundField DataField="wf_sub_id" HeaderText="wf_sub_id" SortExpression="wf_sub_id" />
            </Columns>
            <SelectedRowStyle BackColor="Silver" />
        </asp:GridView>
        <p>
            This is to trigger the first notification sending (will be automated during tnf registration process):
        </p>
        <p>
        <asp:Button ID="btnTNF" runat="server" OnClick="btnTNF_Click" Text="Submit" />
        </p>
        <p>
            &nbsp;</p>
        <p>
            <asp:Label ID="lblNoti" runat="server" Text="Notification Table" Visible="False"></asp:Label>
        </p>
        <p>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" SelectCommand="SELECT * FROM [Notifications]"></asp:SqlDataSource>
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="notif_ID" DataSourceID="SqlDataSource1" Visible="False">
            <Columns>
                <asp:CommandField ShowSelectButton="True" />
                <asp:BoundField DataField="userID_from" HeaderText="userID_from" SortExpression="userID_from" />
                <asp:BoundField DataField="userID_To" HeaderText="userID_To" SortExpression="userID_To" />
                <asp:BoundField DataField="tnfid" HeaderText="tnfid" SortExpression="tnfid" />
                <asp:BoundField DataField="status" HeaderText="status" SortExpression="status" />
                <asp:BoundField DataField="dateApproved" HeaderText="dateApproved" SortExpression="dateApproved" />
                <asp:BoundField DataField="remarks" HeaderText="remarks" SortExpression="remarks" />
                <asp:BoundField DataField="notif_ID" HeaderText="notif_ID" InsertVisible="False" ReadOnly="True" SortExpression="notif_ID" />
            </Columns>
            <SelectedRowStyle BackColor="Silver" />
        </asp:GridView>
        </p>
        <p>
            <asp:Button ID="btnApprover" runat="server" Text="Approve" OnClick="btnApprover_Click" Width="138px" Visible="False" />
            </p>
        <p>
            &nbsp;</p>
        <p>
            &nbsp;</p>
        <p>
            <asp:Label ID="lblBond" runat="server" Text="Bond Table" Visible="False"></asp:Label>
        </p>
        <p>
            <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" SelectCommand="SELECT * FROM [Bonds]"></asp:SqlDataSource>
            <asp:GridView ID="GridView3" runat="server" AutoGenerateColumns="False" DataKeyNames="bondID" DataSourceID="SqlDataSource3" Visible="False">
                <Columns>
                    <asp:BoundField DataField="bondID" HeaderText="bondID" InsertVisible="False" ReadOnly="True" SortExpression="bondID" />
                    <asp:BoundField DataField="uid" HeaderText="uid" SortExpression="uid" />
                    <asp:BoundField DataField="tnfid" HeaderText="tnfid" SortExpression="tnfid" />
                    <asp:BoundField DataField="startDate" HeaderText="startDate" SortExpression="startDate" />
                    <asp:BoundField DataField="endDate" HeaderText="endDate" SortExpression="endDate" />
                    <asp:BoundField DataField="status" HeaderText="status" SortExpression="status" />
                </Columns>
            </asp:GridView>
        </p>
    </form>
</body>
</html>
