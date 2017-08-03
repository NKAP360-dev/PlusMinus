<%@ Page Title="" Language="C#" MasterPageFile="~/Masterpage.Master" AutoEventWireup="true" CodeBehind="askEmmaAddIntent.aspx.cs" Inherits="LearnHub.askEmmaAddIntent" %>

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
        <h1>Manage Intents
                                    <button type="button" data-toggle="collapse" data-target="#addForm" class="btn btn-success"><span class="glyphicon glyphicon-plus"></span>&nbsp; New</button>

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
            <div id="addForm" class="collapse">
                <fieldset>
                    <br />
                    <div class="form-group required">
                        <div class="row">
                            <strong>
                                <%--Intent--%>
                                <label for="intentInput" class="col-lg-3 control-label"><span class="glyphicon glyphicon-question-sign" data-toggle='tooltip' data-placement="left" title="" data-original-title="An Intent is a......"></span>&nbsp;Name of Intent</label>
                            </strong>
                            <div class="col-lg-7">
                                <%--Mandatory text field--%>
                                <asp:TextBox ID="txtIntentInput" runat="server" CssClass="form-control" placeholder="Enter New Intent"></asp:TextBox>
                            </div>
                            <div class="col-lg-1">
                                <asp:Button ID="btnSubmitIntent" CssClass="btn btn-primary" runat="server" Text="Submit" />

                            </div>
                        </div>
                        <br />
                        <br />
                        <div class="row">
                            <div class="wrapper">
                                <strong>
                                    <asp:Label ID="lblSuccess" runat="server" CssClass="text-success"><span class="glyphicon glyphicon-ok"></span> Added successfully</asp:Label></strong><br />
                                <strong>
                                    <asp:Label ID="lblError" runat="server" CssClass="text-danger"><span class="glyphicon glyphicon-remove"></span> Something went wrong</asp:Label></strong>
                            </div>
                        </div>
                    </div>




                </fieldset>
                <div class="verticalLine"></div>
                <br />
            </div>
        </div>



        <div class="container">
            <br />
            <table class="table table-striped table-hover" data-paging="true" data-sorting="true" data-filtering="true">
                <thead>
                    <tr>
                        <th width="90%">Intent</th>
                        <th data-filterable="false" data-sortable="false"></th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>blahblah</td>
                        <td>
                            <asp:LinkButton ID="btnEdit" CssClass="btn btn-info btn-sm pull-right" runat="server" Text="" href="askEmmaEditIntent.aspx"><span class="glyphicon glyphicon-pencil"></span></asp:LinkButton></td>

                    </tr>
                    <tr>
                        <td>ayeee</td>
                        <td>
                            <asp:LinkButton ID="LinkButton2" CssClass="btn btn-danger btn-sm pull-right" runat="server" Text="" data-toggle="modal" href="#deleteModal"><span class="glyphicon glyphicon-trash"></span></asp:LinkButton>
                            <asp:LinkButton ID="LinkButton1" CssClass="btn btn-info btn-sm pull-right" runat="server" Text="" data-toggle="modal" href="#editModal"><span class="glyphicon glyphicon-pencil"></span></asp:LinkButton></td>

                    </tr>
                </tbody>
            </table>      
        </div>

  

        <%--Modal for Deletion Confirmation--%>
        <div id="deleteModal" class="modal fade" role="dialog">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title"><span class="glyphicon glyphicon-trash"></span>&nbsp;<b>Delete Intent</b></h4>
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
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
