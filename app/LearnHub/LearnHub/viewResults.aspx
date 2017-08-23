<%@ Page Title="" Language="C#" MasterPageFile="~/Masterpage.Master" AutoEventWireup="true" CodeBehind="viewResults.aspx.cs" Inherits="LearnHub.viewResults" %>

<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="LearnHub.AppCode.dao" %>
<%@ Import Namespace="LearnHub.AppCode.entity" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .breadcrumb {
            padding-top: 15px;
            margin-bottom: 0px;
            list-style: none;
            background-color: white;
            border-radius: 0px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <ul class="breadcrumb">
        <li><a href="home.aspx">Home</a></li>
        <li><a href="viewAllModule.aspx">Modules</a></li>
        <%int courseID = Convert.ToInt32(Request.QueryString["id"]); %>
        <li><a href="viewModuleInfo.aspx?id=<%=courseID%>">
            <asp:Label ID="lblBreadcrumbCourseName" runat="server" Text="courseName"></asp:Label></a></li>
        <li class="active">View Quiz Results</li>
    </ul>

    <form class="form-horizontal" runat="server">
        <div class="container">

            <h1>View Quiz Results</h1>
            <h4>Attempt 
            <asp:Label ID="lblAttemptNo" runat="server">1</asp:Label>
                -
            <asp:Label ID="lblQuizDate" runat="server">Date</asp:Label>

            </h4>
            <div class="verticalLine"></div>
            <br />
        </div>

        <div class="container">
            <div class="pull-right">
                <strong>Status:</strong>&nbsp;
                <asp:Label ID="lblStatusPass" runat="server" CssClass="label label-success" Font-Size="Large">Pass</asp:Label>
                <asp:Label ID="lblStatusFail" runat="server" CssClass="label label-danger" Font-Size="Large">Fail</asp:Label>&emsp;
                <strong>Quiz Score:</strong>&nbsp; 
                <asp:Label ID="lblScore" runat="server" CssClass="label label-default" Font-Size="Large">1/2</asp:Label>
            </div>
            <br />
            <br />
            <br />
            <table class="table">
                <tbody>
                    <tr class="active">
                        <td><strong>
                            Question <asp:Label ID="lblQuestionNo" runat="server" Text="1"></asp:Label></strong></td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lblQuestion" runat="server">What is the nicest fruit on earth?</asp:Label></td>
                    </tr>
                    <tr>
                        <td>
                            <asp:RadioButtonList ID="rblAnswers" runat="server">
                                <asp:ListItem style="color: lightseagreen" Selected="True" Enabled="false" Text="Watermelon"></asp:ListItem>
                                <asp:ListItem style="color: tomato" Enabled="false">Pineapple</asp:ListItem>
                                <asp:ListItem style="color: tomato" Enabled="false">Dragonfruit</asp:ListItem>
                                <asp:ListItem style="color: tomato" Enabled="false">Apple</asp:ListItem>
                            </asp:RadioButtonList>
                        </td>
                    </tr>
                    <tr class="pull-right">
                        <td>Score: 1/1</td>
                    </tr>

                    <%--Loop--%>
                    <tr class="active">
                        <td><strong>
                            Question <asp:Label ID="Label1" runat="server" Text="2"></asp:Label></strong></td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="Label2" runat="server">What does Rafid like?</asp:Label></td>
                    </tr>
                    <tr>
                        <td>
                            <asp:RadioButtonList ID="RadioButtonList1" runat="server">
                                <asp:ListItem style="color: tomato" Selected="True" Enabled="false" Text="Being Positive"></asp:ListItem>
                                <asp:ListItem style="color: tomato" Enabled="false">Sleeping</asp:ListItem>
                                <asp:ListItem style="color: lightseagreen" Enabled="false">Bugs</asp:ListItem>
                                <asp:ListItem style="color: tomato" Enabled="false">Drinking Water</asp:ListItem>
                            </asp:RadioButtonList>
                        </td>
                    </tr>
                    <tr class="pull-right">
                        <td>Score: 0/1</td>
                    </tr>
                </tbody>

            </table>
            <br /><br />
            <div class="pull-right">
                <button type="button" onclick="javascript:history.back()" class="btn btn-primary"><span class="glyphicon glyphicon-chevron-left"></span>&nbsp;Back to Quiz Attempts</button>
            </div>
        </div>
    </form>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
