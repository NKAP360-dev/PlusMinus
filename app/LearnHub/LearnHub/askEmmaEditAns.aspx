﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Masterpage.Master" AutoEventWireup="true" CodeBehind="askEmmaEditAns.aspx.cs" Inherits="LearnHub.askEmmaEditAns" %>

<%@ Import Namespace="LearnHub.AppCode.entity" %>
<%@ Import Namespace="LearnHub.AppCode.dao" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="/Scripts/footable.bootstrap.min.css" rel="stylesheet" />
    <script src="/Scripts/footable.min.js"></script>
    <script>

        $(document).ready(function () {
            $("[data-toggle='tooltip']").tooltip();
        });

        jQuery(function ($) {
            $('.table').footable({
                "paging": {
                    "size": 1 <%--Change how many rows per page--%>
                },
                "filtering": {
                    "position": "left"
                }
            });
        });


        /*
        function ValidateRadioButton(sender, args) {
            var gv = document.getElementById("");
            var items = gv.getElementsByTagName('input');
            for (var i = 0; i < items.length; i++) {
                if (items[i].type == "radio") {
                    if (items[i].checked) {
                        args.IsValid = true;
                        return;
                    }
                    else {
                        args.IsValid = false;
                    }
                }
            }
        }
        */

    </script>
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
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">
        <h1>Edit Answers
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
    </div>
    <form class="form-horizontal" runat="server">
        <div class="container">
            <fieldset>
                <br />
                <div class="form-group required">
                    <%--Intent--%>
                    <label for="ddlIntent" class="col-lg-2 control-label"><span class="glyphicon glyphicon-question-sign" data-toggle='tooltip' data-placement="left" title="" data-original-title="An Intent is a......"></span>Choose an Intent</label>
                    <div class="col-lg-10">
                        <%--Mandatory Choose 1--%>
                        <asp:DropDownList ID="ddlIntent" runat="server" CssClass="form-control" DataSourceID="SqlDataSource1" DataTextField="intent" DataValueField="intentID"></asp:DropDownList>
                        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" SelectCommand="SELECT * FROM [ChatBotIntent]"></asp:SqlDataSource>
                        <a href="#" data-toggle="collapse" data-target="#viewTable" class="pull-right"><span class="glyphicon glyphicon-search"></span>View Answers For This Intent</a>

                        <br>
                    </div>
                </div>
                <div class="form-group">
                    <strong>
                        <%--Entity--%>
                        <label for="ddlIntent" class="col-lg-2 control-label"><span class="glyphicon glyphicon-question-sign" data-toggle='tooltip' data-placement="left" title="" data-original-title="An Entity is a......"></span>Choose an Entity </label>
                    </strong>
                    <div class="col-lg-10">
                        <asp:TextBox ID="txtEntity" runat="server" CssClass="form-control"></asp:TextBox>
                        <br>
                    </div>
                </div>
                <div class="form-group required">
                    <strong>
                        <%--Answers--%>
                        <asp:Label ID="lblAnswers" CssClass="col-lg-2 control-label" runat="server" Text="Answers"></asp:Label>
                    </strong>
                    <div class="col-lg-10">
                        <%--Mandatory text field--%>
                        <asp:TextBox ID="txtAnswers" TextMode="multiline" Columns="50" Rows="5" runat="server" CssClass="form-control" placeholder="Please enter your answers here"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfv_txtAnswers" runat="server" ErrorMessage="Please enter an answer" ControlToValidate="txtAnswers" ForeColor="Red"></asp:RequiredFieldValidator>
                    </div>
                </div>
                <%--Buttons--%>
                <div class="form-group">
                    <div class="wrapper">
                        <asp:Button ID="submitBtn" CssClass="btn btn-primary" runat="server" Text="Update" data-toggle="modal" href="#updateModal" OnClientClick="$('#myModal').modal(); return false;" />
                        <br />
                        <br />
                        <strong>
                            <asp:Label ID="successMsg" runat="server" CssClass="text-success"><span class="glyphicon glyphicon-ok"></span> Updated successfully</asp:Label></strong><br />
                        <strong>
                            <asp:Label ID="errorMsg" runat="server" CssClass="text-danger"><span class="glyphicon glyphicon-remove"></span> Something went wrong</asp:Label></strong>

                    </div>
                </div>

                <%--Modal for Deletion Confirmation--%>
                <div id="deleteModal" class="modal fade" role="dialog">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal">&times;</button>
                                <h4 class="modal-title"><span class="glyphicon glyphicon-trash"></span>&nbsp;<b>Delete Answer</b></h4>
                            </div>
                            <%--Modal Content--%>
                            <div class="modal-body">
                                <div class="wrapper">
                                    <h4>Are you sure you want to delete?</h4>
                                    <br />
                                    <asp:Button ID="cfmDelete" CssClass="btn btn-danger" runat="server" Text="Delete" />
                                    <asp:Button ID="Button1" CssClass="btn btn-default" runat="server" class="close" data-dismiss="modal" Text="Cancel" />

                                    <br />
                                </div>
                            </div>
                        </div>

                    </div>
                </div>




            </fieldset>

        </div>
        <div class="container">
            <div id="viewTable" class="collapse">
                <div class="verticalLine"></div>
                <br />
                <table class="table table-striped table-hover" data-paging="true" data-sorting="true" data-filtering="true">
                    <thead>
                        <tr>
                            <th>Answers</th>
                            <th data-breakpoints="xs sm">Intent</th>
                            <th data-breakpoints="xs sm">Entity</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>Column content</td>
                            <td>Column content</td>
                            <td>Column content</td>


                        </tr>
                        <tr>
                            <td>Column content</td>
                            <td>Column content</td>
                            <td>Column content</td>

                        </tr>
                    </tbody>
                </table>
                <asp:CustomValidator ID="cv_answers" runat="server" EnableClientScript="true" ErrorMessage="Please select an answer" ClientValidationFunction="ValidateRadioButton" ForeColor="Red"></asp:CustomValidator>
            </div>
            <br />
        </div>
        <div id="updateModal" class="modal fade" role="dialog">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title"><b>Update Answers</b></h4>
                    </div>
                    <div class="modal-body">
                        <div class="wrapper">
                            <h4>Are you sure you want to overwrite the existing answers?</h4>
                            <br />
                            <asp:Button ID="cfmSubmit" CssClass="btn btn-primary" runat="server" Text="Overwrite" OnClick="cfmSubmit_Click" />
                            <asp:Button ID="Button2" CssClass="btn btn-default" runat="server" class="close" data-dismiss="modal" Text="Cancel" OnClientClick="return false;" />

                            <br />
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </form>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
