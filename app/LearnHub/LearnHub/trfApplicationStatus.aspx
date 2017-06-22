<%@ Page Title="" Language="C#" MasterPageFile="~/Masterpage.Master" AutoEventWireup="true" CodeBehind="trfApplicationStatus.aspx.cs" Inherits="LearnHub.trfApplicationStatus" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">
        <h1>Application Status</h1>
        <h3>Training Request Form</h3>

        <table class="table table-striped table-hover ">
            <thead>
                <tr>
                    <th>#</th>
                    <th>Course Applied</th>
                    <th>Application Date</th>
                    <th>Course Type</th>
                    <%--Individual or Group--%>
                    <th>Status</th>
                    <%-- Approved/Pending--%>
                    <th>View Form</th>
                </tr>
            </thead>
            <tbody>
                <tr class="success">
                    <%--Approved --%>
                    <td>1</td>
                    <td>Column content</td>
                    <td>Column content</td>
                    <td>Individual</td>
                    <td>Approved</td>
                    <td><a href="#">View</a></td>
                </tr>
                <tr>
                    <%--Pending--%>
                    <td>2</td>
                    <td>Column content</td>
                    <td>Column content</td>
                    <td>Group</td>
                    <td>Pending</td>
                    <td><a href="#">View</a></td>
                </tr>
            </tbody>
        </table>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
