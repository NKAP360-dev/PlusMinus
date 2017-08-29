<%@ Page Title="" Language="C#" MasterPageFile="~/Masterpage.Master" AutoEventWireup="true" CodeBehind="askEmmaFeedback.aspx.cs" Inherits="LearnHub.askEmmaFeedback" %>

<%@ Import Namespace="LearnHub.AppCode.entity" %>
<%@ Import Namespace="LearnHub.AppCode.dao" %>
<%@ Import Namespace="Emma.DAO" %>
<%@ Import Namespace="Emma.Entity" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .pagination li > a,
        .pagination li > span,
        .pagination li > a:focus, .pagination .disabled > a,
        .pagination .disabled > a:hover,
        .pagination .disabled > a:focus,
        .pagination .disabled > span {
            background-color: white;
            color: black;
        }

            .pagination li > a:hover {
                background-color: #96a8ba;
            }

        .pagination > .active > a,
        .pagination > .active > span,
        .pagination > .active > a:hover,
        .pagination > .active > span:hover,
        .pagination > .active > a:focus,
        .pagination > .active > span:focus {
            background-color: #576777;
        }

        .breadcrumb {
            padding-top: 15px;
            margin-bottom: 0px;
            list-style: none;
            background-color: white;
            border-radius: 0px;
        }
    </style>
    <link href="/Scripts/footable.bootstrap.min.css" rel="stylesheet" />
    <script src="/Scripts/footable.min.js"></script>
    <script>
        jQuery(function ($) {
            $('.table').footable({
                "paging": {
                    "size": 10 <%--Change how many rows per page--%>
                },
                "filtering": {
                    "position": "left"
                }
            });
        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <ul class="breadcrumb">
        <li><a href="home.aspx">Home</a></li>
        <li><a href="emmaConfiguration.aspx">Emma Configuration</a></li>
        <li class="active">Feedback for Emma</li>
    </ul>
    <div class="container">
        <h1>Feedback for Emma
            <button type="button" data-toggle="modal" data-target="#feedbackSettings" class="btn btn-success"><span class="glyphicon glyphicon-cog"></span>&nbsp;Settings </button>
        </h1>
        <div class="center-block">
            <asp:Label ID="lblSaveSuccess" runat="server" Text="Your settings have been saved" Visible="False" CssClass="label label-success text-center" Font-Size="Medium"></asp:Label>
        </div>
        <div class="verticalLine"></div>
        <form class="form-horizontal" runat="server">
            <div class="container">
                <br />
                <table class="table table-striped table-hover" data-paging="true" data-sorting="true" data-filtering="true">
                    <thead>
                        <tr>
                            <th width="55%">Feedback</th>
                            <th width="10%">Department</th>
                            <th width="10%">Given by</th>
                            <th width="25%">Date Registered</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            ChatBotFeedbackDAO cbfDAO = new ChatBotFeedbackDAO();
                            List<ChatBotFeedback> allFeedback = cbfDAO.getAllChatBotFeedback();
                            foreach (ChatBotFeedback feedback in allFeedback)
                            {
                                Response.Write("<tr>");
                                Response.Write($"<td>{feedback.feedback}</td>");
                                Response.Write($"<td>{feedback.department}</td>");
                                Response.Write($"<td>{feedback.name}</td>");
                                Response.Write($"<td>{String.Format("{0:f}", feedback.feedbackDate)}</td>");
                                Response.Write("</tr>");
                            }
                        %>
                    </tbody>
                </table>
            </div>
            <asp:ScriptManager ID="ScriptManagerCourse" runat="server" />
            <%--Modal for Feedback Settings--%>
            <div id="feedbackSettings" class="modal fade" role="dialog">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                            <h4 class="modal-title"><b>Feedback Notification Settings</b></h4>
                        </div>
                        <div class="modal-body">
                            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                            <ContentTemplate>
                            <div class="form-group">
                                <label class="col-lg-3 control-label">Email Settings</label>
                                <div class="col-lg-7">
                                    <asp:RadioButtonList ID="rdlEmail" runat="server" TextAlign="Right" OnSelectedIndexChanged="changeSelectedIndex" AutoPostBack="true">
                                        <asp:ListItem Value="y" Text="Enable" Selected="True">&emsp;Enable</asp:ListItem>
                                        <asp:ListItem Value="n" Text="Disable" Selected="False">&emsp;Disable</asp:ListItem>
                                    </asp:RadioButtonList>
                                </div>
                            </div>
                            <div class="form-group required">
                                <label class="col-lg-3 control-label">Email</label>
                                <div class="col-lg-9">
                                    <asp:TextBox ID="txtEmail" CssClass="form-control" placeholder="Email Adress To Be Sent To" runat="server"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfv_txtEmail" runat="server" ErrorMessage="Please enter an Email Address " ControlToValidate="txtEmail" ForeColor="Red" ValidationGroup="ValidateForm"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                                </ContentTemplate>
                                </asp:UpdatePanel>
                            <hr />
                            <h4><b>&emsp;SMTP Configuration</b></h4>
                            <div class="form-group required">
                                <label class="col-lg-3 control-label">Username</label>
                                <div class="col-lg-9">
                                    <asp:TextBox ID="txtSMTPUser" CssClass="form-control" placeholder="SMTP Email Username" runat="server"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfv_txtSMTPUser" runat="server" ErrorMessage="Please enter a Username" ControlToValidate="txtSMTPUser" ForeColor="Red" ValidationGroup="ValidateForm"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="form-group required">
                                <label class="col-lg-3 control-label">Password</label>
                                <div class="col-lg-9">
                                    <asp:TextBox ID="txtSMTPPassword" CssClass="form-control" placeholder="SMTP Email Password" runat="server"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfv_txtSMTPPassword" runat="server" ErrorMessage="Please enter a Password" ControlToValidate="txtSMTPPassword" ForeColor="Red" ValidationGroup="ValidateForm"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <br />
                            <div class="wrapper">
                                <asp:Button ID="btnConfirmSave" CssClass="btn btn-primary" runat="server" Text="Save" OnClick="btnConfirmSave_Click" ValidationGroup="ValidateForm"/>
                                <asp:Button ID="btnCancel1" CssClass="btn btn-default" runat="server" class="close" data-dismiss="modal" Text="Cancel" OnClientClick="return false;" />
                            </div>
                            <br />

                        </div>
                    </div>

                </div>
            </div>
            <%--Modal for Deletion Confirmation--%>
            <div id="deleteModal" class="modal fade" role="dialog">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                            <h4 class="modal-title"><span class="glyphicon glyphicon-trash"></span>&nbsp;<b>Delete Feedback</b></h4>
                        </div>
                        <%--Modal Content--%>
                        <div class="modal-body">
                            <div class="wrapper">
                                <h4>Are you sure you want to delete?</h4>
                                <br />
                                <asp:Button ID="btnCfmDelete" CssClass="btn btn-danger" runat="server" Text="Delete" />
                                <asp:Button ID="btnClose" CssClass="btn btn-default" runat="server" class="close" data-dismiss="modal" Text="Cancel" />

                                <br />
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </form>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
