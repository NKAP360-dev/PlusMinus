﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Masterpage.Master" AutoEventWireup="true" CodeBehind="askEmmaFeedback.aspx.cs" Inherits="LearnHub.askEmmaFeedback" %>

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
    <div class="container">
        <h1>Feedback for Emma
            <button type="button" data-toggle="modal" data-target="#feedbackSettings" class="btn btn-success"><span class="glyphicon glyphicon-cog"></span>&nbsp;Settings </button>
            <% if (Session["currentUser"] != null)
                {
                    User currentUser = (User)Session["currentUser"];
                    if (currentUser.getDepartment().Equals("hr"))
                    {
            %>
            <a href="emmaConfiguration.aspx" id="config"><span class="btn btn-default pull-right"><span class="glyphicon glyphicon-option-horizontal"></span></span></a>
            <%}
                }%>
        </h1>
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

            <%--Modal for Feedback Settings--%>
            <div id="feedbackSettings" class="modal fade" role="dialog">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                            <h4 class="modal-title"><b>Feedback Notification Settings</b></h4>
                        </div>
                        <div class="modal-body">
                            <div class="form-group">
                                <label class="col-lg-3 control-label">Email Settings</label>
                                <div class="col-lg-7">
                                    <asp:RadioButtonList ID="rdlEmail" runat="server" TextAlign="Right">
                                        <asp:ListItem>&emsp;Enable</asp:ListItem>
                                        <asp:ListItem>&emsp;Disable</asp:ListItem>
                                    </asp:RadioButtonList>
                                </div>
                            </div>
                             <div class="form-group">
                                <label class="col-lg-3 control-label">Frequency</label>
                                <div class="col-lg-7">
                                    <asp:DropDownList ID="ddlFreq" runat="server" CssClass="form-control">
                                        <asp:ListItem>Immediately</asp:ListItem>
                                        <asp:ListItem>Every day</asp:ListItem>
                                        <asp:ListItem>Every week</asp:ListItem>
                                        <asp:ListItem>Every month</asp:ListItem>
                                    </asp:DropDownList>                                   
                                </div>
                            </div>
                            <br />
                            <div class="wrapper">
                            <asp:Button ID="btnConfirmSubmit" CssClass="btn btn-primary" runat="server" Text="Submit" />
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
