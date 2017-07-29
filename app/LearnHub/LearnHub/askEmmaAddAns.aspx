<%@ Page Title="" Language="C#" MasterPageFile="~/Masterpage.Master" AutoEventWireup="true" CodeBehind="askEmmaAddAns.aspx.cs" Inherits="LearnHub.askEmmaAddAns" %>

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
        <h1>Add Answers
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
            <table class="table table-striped table-hover" data-paging="true" data-sorting="true" data-filtering="true">
                <thead>
                    <tr>
                        <th>Answers</th>
                        <th data-breakpoints="xs sm">Intent</th>
                        <th data-breakpoints="xs sm">Entity</th>
                        <th data-filterable="false" data-sortable="false"></th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>Column content</td>
                        <td>Column content</td>
                        <td>Column content</td>
                        <td>
                            <asp:LinkButton ID="btnDelete" CssClass="btn btn-danger btn-sm pull-right" runat="server" Text="" data-toggle="modal" href="#deleteModal"><span class="glyphicon glyphicon-trash"></span></asp:LinkButton>
                            <asp:LinkButton ID="btnEdit" CssClass="btn btn-info btn-sm pull-right" runat="server" Text="" data-toggle="modal" href="#editModal"><span class="glyphicon glyphicon-pencil"></span></asp:LinkButton></td>

                    </tr>
                    <tr>
                        <td>Column content</td>
                        <td>Column content</td>
                        <td>Column content</td>
                        <td>
                            <asp:LinkButton ID="LinkButton1" CssClass="btn btn-danger btn-sm pull-right" runat="server" Text="" data-toggle="modal" href="#deleteModal"><span class="glyphicon glyphicon-trash"></span></asp:LinkButton>
                            <asp:LinkButton ID="LinkButton2" CssClass="btn btn-info btn-sm pull-right" runat="server" Text="" data-toggle="modal" href="#editModal"><span class="glyphicon glyphicon-pencil"></span></asp:LinkButton></td>

                    </tr>
                </tbody>
            </table>
        </div>



        <div class="container">
            <div class="verticalLine"></div>
            <br />
            <fieldset>
                <legend>Add answers for Emma</legend>
                <div class="form-group">

                    <%--Intent--%>
                    <label for="ddlIntent" class="col-lg-2 control-label"><span class="glyphicon glyphicon-question-sign" data-toggle='tooltip' data-placement="left" title="" data-original-title="An Intent is a......"></span>Choose an Intent *</label>

                    <div class="col-lg-10">
                        <%--Mandatory Choose 1--%>
                        <asp:DropDownList ID="ddlIntent" runat="server" CssClass="form-control"></asp:DropDownList>
                        <br>
                        <asp:RequiredFieldValidator ID="rfv_ddlIntent" runat="server" ControlToValidate="ddlIntent" ErrorMessage="Please Select a Course" InitialValue="--Select--" ForeColor="Red" ValidationGroup="ValidateForm"></asp:RequiredFieldValidator>
                    </div>
                </div>
                <div class="form-group">
                    <strong>
                        <%--Entity--%>
                        <label for="ddlIntent" class="col-lg-2 control-label"><span class="glyphicon glyphicon-question-sign" data-toggle='tooltip' data-placement="left" title="" data-original-title="An Entity is a......"></span>Choose an Entity to represent </label>
                    </strong>
                    <div class="col-lg-10">
                        <%--Optional Choose 1--%>
                        <asp:DropDownList ID="ddlEntity" runat="server" CssClass="form-control"></asp:DropDownList>
                        <br>
                    </div>
                </div>
                <div class="form-group">
                    <strong>
                        <%--Answers--%>
                        <asp:Label ID="lblAnswers" CssClass="col-lg-2 control-label" runat="server" Text="Answers *"></asp:Label>
                    </strong>
                    <div class="col-lg-10">
                        <%--Mandatory text field--%>
                        <asp:TextBox ID="txtAnswers" TextMode="multiline" Columns="50" Rows="5" runat="server" CssClass="form-control" placeholder="Please enter your answers here"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfv_txtAnswers" runat="server" ErrorMessage="Please enter an answer" ControlToValidate="txtAnswers" ForeColor="Red"></asp:RequiredFieldValidator>
                    </div>
                </div>
                <%--Buttons--%>
                <br />
                <div class="wrapper">
                    <div class="form-group">

                        <asp:Button ID="btnSubmit" CssClass="btn btn-primary" runat="server" Text="Submit" data-toggle="modal" href="#submitModal" OnClientClick="$('#myModal').modal(); return false;" />
                        <%--Make success message appear after user click submit button IN MODAL, stay at this page so that user can continue submitting answers--%>
                    </div>
                    <strong>
                        <asp:Label ID="lblSuccess" runat="server" CssClass="text-success"><span class="glyphicon glyphicon-ok"></span> Added successfully</asp:Label></strong><br />
                    <strong>
                        <asp:Label ID="lblError" runat="server" CssClass="text-danger"><span class="glyphicon glyphicon-remove"></span> Something went wrong</asp:Label></strong>

                </div>


                <div id="submitModal" class="modal fade" role="dialog">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal">&times;</button>
                                <h4 class="modal-title"><b>Submit Answers</b></h4>
                            </div>
                            <div class="modal-body">
                                <div class="wrapper">
                                    <h4>Are you sure you want to submit?</h4>
                                    <br />
                                    <asp:Button ID="btnCfmSubmit" CssClass="btn btn-primary" runat="server" Text="Submit" />
                                    <asp:Button ID="btnCancel1" CssClass="btn btn-default" runat="server" class="close" data-dismiss="modal" Text="Cancel" OnClientClick="return false;" />

                                    <br />
                                </div>
                            </div>
                        </div>

                    </div>
                </div>
            </fieldset>

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
                            <asp:Button ID="btnCfmDelete" CssClass="btn btn-danger" runat="server" Text="Delete" />
                            <asp:Button ID="btnCancel2" CssClass="btn btn-default" runat="server" class="close" data-dismiss="modal" Text="Cancel" />

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
                        <h4 class="modal-title"><span class="glyphicon glyphicon-pencil"></span>&nbsp;<b>Edit Answer</b></h4>
                    </div>
                    <%--Modal Content--%>
                    <div class="modal-body">
                        <div class="form-group">
                            <%--Intent--%>
                            <strong>
                                <label for="ddlEditIntent" class="col-lg-3 control-label"><span class="glyphicon glyphicon-question-sign" data-toggle='tooltip' data-placement="left" title="" data-original-title="An Intent is a......"></span>Choose an Intent *</label>
                            </strong>
                            <div class="col-lg-8">
                                <%--Mandatory Choose 1--%>
                                <asp:DropDownList ID="ddlEditIntent" runat="server" disabled="" CssClass="form-control"></asp:DropDownList>
                                <br>
                            </div>
                        </div>

                        <div class="form-group">
                            <strong>
                                <%--Entity--%>
                                <label for="ddlEditEntity" class="col-lg-3 control-label"><span class="glyphicon glyphicon-question-sign" data-toggle='tooltip' data-placement="left" title="" data-original-title="An Entity is a......"></span>Choose an Entity </label>
                            </strong>
                            <div class="col-lg-8">
                                <%--Optional Choose 1--%>
                                <asp:DropDownList ID="ddlEditEntity" runat="server" disabled="" CssClass="form-control"></asp:DropDownList>
                                <br>
                            </div>
                        </div>
                        <div class="form-group">
                            <strong>
                                <%--Answers--%>
                                <asp:Label ID="lblAns" CssClass="col-lg-3 control-label" runat="server" Text="Answers*"></asp:Label>
                            </strong>
                            <div class="col-lg-8">
                                <%--Mandatory text field--%>
                                <asp:TextBox ID="txtEditAnswers" TextMode="multiline" Columns="50" Rows="5" runat="server" CssClass="form-control" placeholder="Please enter your answers here"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Please enter an answer" ControlToValidate="txtEditAnswers" ForeColor="Red"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                        <div class="wrapper">
                            <asp:Button ID="btnEditSubmit" CssClass="btn btn-primary" runat="server" Text="Submit Edits" />
                            <br />
                            <br />
                            <strong>
                                <asp:Label ID="successMsg" runat="server" CssClass="text-success"><span class="glyphicon glyphicon-ok"></span> Updated successfully</asp:Label></strong><br />
                            <strong>
                                <asp:Label ID="errorMsg" runat="server" CssClass="text-danger"><span class="glyphicon glyphicon-remove"></span> Something went wrong</asp:Label></strong>

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
