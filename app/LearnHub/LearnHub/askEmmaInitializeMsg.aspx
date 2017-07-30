<%@ Page Title="" Language="C#" MasterPageFile="~/Masterpage.Master" AutoEventWireup="true" CodeBehind="askEmmaInitializeMsg.aspx.cs" Inherits="LearnHub.askEmmaInitializeMsg" %>

<%@ Import Namespace="LearnHub.AppCode.entity" %>
<%@ Import Namespace="LearnHub.AppCode.dao" %>

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
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="container">
        <h1>Configure Initialization Messages
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
        <br />

    </div>
    <div class="container">
        <form class="form-horizontal" runat="server">
            <table class="table table-striped table-hover" data-paging="true" data-sorting="true" data-filtering="true">
                <thead>
                    <tr>
                        <th width="80%">Initialization Message</th>
                        <th>Message Order</th>
                        <th data-filterable="false" data-sortable="false"></th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>blahblah</td>
                        <td>
                            <select class="form-control" id="select">
                                <option>1</option>
                                <option>2</option>
                                <option>3</option>
                                <option>4</option>
                                <option>5</option>
                            </select></td>
                        <td>
                            <asp:LinkButton ID="btnDel" CssClass="btn btn-danger btn-sm pull-right" runat="server" Text="" data-toggle="modal" href="#deleteModal"><span class="glyphicon glyphicon-trash"></span></asp:LinkButton>
                            <asp:LinkButton ID="btnEdit" CssClass="btn btn-info btn-sm pull-right" runat="server" Text="" data-toggle="modal" href="#editModal"><span class="glyphicon glyphicon-pencil"></span></asp:LinkButton></td>

                    </tr>
                    <tr>
                        <td>kekeke</td>
                        <td>
                            <select class="form-control" id="select">
                                <option>1</option>
                                <option>2</option>
                                <option>3</option>
                                <option>4</option>
                                <option>5</option>
                            </select></td>
                        <td>
                            <asp:LinkButton ID="LinkButton1" CssClass="btn btn-danger btn-sm pull-right" runat="server" Text="" data-toggle="modal" href="#deleteModal"><span class="glyphicon glyphicon-trash"></span></asp:LinkButton>
                            <asp:LinkButton ID="LinkButton3" CssClass="btn btn-info btn-sm pull-right" runat="server" Text="" data-toggle="modal" href="#editModal"><span class="glyphicon glyphicon-pencil"></span></asp:LinkButton></td>

                    </tr>

                </tbody>
            </table>
            <div class="wrapper">
                <div class="form-group">
                    <asp:LinkButton ID="btnSave" CssClass="btn btn-success" runat="server"><span class="glyphicon glyphicon-floppy-saved"></span>&nbsp; Save</asp:LinkButton>
                    <br />
                </div>
                <strong>
                    <asp:Label ID="lblSaveSuccess" runat="server" CssClass="text-success"><span class="glyphicon glyphicon-ok"></span> Saved successfully</asp:Label></strong><br />
                <strong>
                    <asp:Label ID="lblSaveError" runat="server" CssClass="text-danger"><span class="glyphicon glyphicon-remove"></span> Something went wrong</asp:Label></strong>

            </div>
            <div class="verticalLine"></div>
            <br />

            <div class="form-group">
                <div class="container">
                    <div class="row">
                        <strong>
                            <label for="txtMsgInput" class="col-lg-3 control-label"><span class="glyphicon glyphicon-question-sign" data-toggle='tooltip' data-placement="left" title="" data-original-title="An Initialization Message is the message you see when you initialize :)"></span>&nbsp;Initialization Message *</label>
                        </strong>
                        <div class="col-lg-7">
                            <%--Mandatory text field--%>
                            <asp:TextBox ID="txtMsgInput" runat="server" CssClass="form-control" placeholder="Initialization Message"></asp:TextBox>
                        </div>
                        <div class="col-lg-1">
                            <asp:Button ID="btnAdd" CssClass="btn btn-primary" runat="server" Text="Add" />
                        </div>
                    </div>
                    <br />
                    <div class="row">
                        <div class="wrapper">
                            <strong>
                                <asp:Label ID="lblAddSuccess" runat="server" CssClass="text-success"><span class="glyphicon glyphicon-ok"></span> Added successfully</asp:Label></strong><br />
                            <strong>
                                <asp:Label ID="lblAddError" runat="server" CssClass="text-danger"><span class="glyphicon glyphicon-remove"></span> Something went wrong</asp:Label></strong>
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
                            <h4 class="modal-title"><span class="glyphicon glyphicon-trash"></span>&nbsp;<b>Delete Message</b></h4>
                        </div>
                        <%--Modal Content--%>
                        <div class="modal-body">
                            <div class="wrapper">
                                <h4>Are you sure you want to delete?</h4>
                                <br />
                                <asp:Button ID="btnCfmDel" CssClass="btn btn-danger" runat="server" Text="Delete" />
                                <asp:Button ID="btnClose" CssClass="btn btn-default" runat="server" class="close" data-dismiss="modal" Text="Cancel" />

                                <br />
                            </div>
                        </div>
                    </div>

                </div>
            </div>

              <%--Modal for Edit--%>
        <div id="editModal" class="modal fade" role="dialog">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title"><span class="glyphicon glyphicon-pencil"></span>&nbsp;<b>Edit Initialization Message</b></h4>
                    </div>
                    <%--Modal Content--%>
                    <div class="modal-body">
                        <div class="form-group">
                            <strong>
                                <asp:Label ID="lblEditMsg" runat="server" CssClass="col-lg-3 control-label">Edit Initialization Message </asp:Label></strong>
                            <div class="col-lg-8">
                                <%--Mandatory text field--%>
                                <asp:TextBox ID="txtEditMsg" runat="server" CssClass="form-control" placeholder="Current Message goes here"></asp:TextBox>
                            </div>

                        </div>
                        <div class="wrapper">
                            <br />
                            <asp:Button ID="btnEditSubmit" CssClass="btn btn-primary" runat="server" Text="Submit Edits" />
                            <br />
                            <br />
                            <strong>
                                <asp:Label ID="lblUpdated" runat="server" CssClass="text-success"><span class="glyphicon glyphicon-ok"></span> Updated successfully</asp:Label></strong><br />
                            <strong>
                                <asp:Label ID="lblUpdateError" runat="server" CssClass="text-danger"><span class="glyphicon glyphicon-remove"></span> Something went wrong</asp:Label></strong>

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
