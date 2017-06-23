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
                <asp:Label ID="Label2" runat="server" Text="Length of Service: "></asp:Label>
                <asp:Label ID="lblLOS" runat="server"></asp:Label>
                <br />
                <br />
                <asp:Label ID="Label3" runat="server" Text="Job Title: "></asp:Label>
                <asp:Label ID="lblJobTitle" runat="server"></asp:Label>
            </asp:Panel>
        </div>
        <p>
            &nbsp;</p>
        <p>
            &nbsp;</p>
        <asp:GridView ID="GridView1" runat="server" CssClass="table table-striped table-hover" AutoGenerateColumns="False" DataKeyNames="lessonID" DataSourceID="SqlDataSource1">
            <Columns>
                <asp:BoundField DataField="lessonID" HeaderText="lessonID" InsertVisible="False" ReadOnly="True" SortExpression="lessonID" />
                <asp:BoundField DataField="courseID" HeaderText="courseID" SortExpression="courseID" />
                <asp:BoundField DataField="lesson_start_timing" HeaderText="lesson_start_timing" SortExpression="lesson_start_timing" />
                <asp:BoundField DataField="lesson_end_timing" HeaderText="lesson_end_timing" SortExpression="lesson_end_timing" />
                <asp:BoundField DataField="lesson_start_date" HeaderText="lesson_start_date" SortExpression="lesson_start_date" />
                <asp:BoundField DataField="lesson_end_date" HeaderText="lesson_end_date" SortExpression="lesson_end_date" />
                <asp:BoundField DataField="instructor" HeaderText="instructor" SortExpression="instructor" />
                <asp:BoundField DataField="venue" HeaderText="venue" SortExpression="venue" />
            </Columns>
        </asp:GridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" SelectCommand="SELECT * FROM [Lesson]"></asp:SqlDataSource>
    </form>
</body>
</html>
