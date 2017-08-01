<%@ Page Title="" Language="C#" MasterPageFile="~/Masterpage.Master" AutoEventWireup="true" CodeFile="askEmmaAddAns.aspx.cs" Inherits="LearnHub.askEmmaAddAns" %>

<%@ Import Namespace="LearnHub.AppCode.entity" %>
<%@ Import Namespace="LearnHub.AppCode.dao" %>
<%@ Import Namespace="Emma.DAO" %>
<%@ Import Namespace="Emma.Entity" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="/Scripts/footable.bootstrap.min.css" rel="stylesheet" />
    <script src="/Scripts/footable.min.js"></script>
    <script>
        $(document).ready(function () {
            $("[data-toggle='tooltip']").tooltip();
        });

        jQuery(function ($) {
            var $modal = $('#editor-modal'),
                $editor = $('#editor'),
                $editorTitle = $('#editor-title'),
                ft = FooTable.init('#ansTable', {
                    editing: {
                        enabled: true,
                        addRow: function () {
                            $modal.removeData('row');
                            $editor[0].reset();
                            $editorTitle.text('Add a new row');
                            $modal.modal('show');
                        },
                        editRow: function (row) {
                            var values = row.val();
                            $editor.find('#id').val(values.id);
                            $editor.find('#txtEditAnswer').val(values.answers);
                            $editor.find('#ddlEditIntent').val(values.intent);
                            $editor.find('#txtEditEntity').val(values.entity);

                            $modal.data('row', row);
                            $editorTitle.text('Edit row #' + values.id);
                            $modal.modal('show');
                        },
                        deleteRow: function (row) {
                            if (confirm('Are you sure you want to delete the row?')) {
                                row.delete();
                            }
                        }
                    }
                }),
                uid = 10;

            $editor.on('submit', function (e) {
                if (this.checkValidity && !this.checkValidity()) return;
                e.preventDefault();
                var row = $modal.data('row'),
                    values = {
                        id: $editor.find('#id').val(),
                        answer: $editor.find('#txtEditAnswer').val(),
                        intent: $editor.find('#ddlEditIntent').val(),
                        entity: $editor.find('#extEditEntity').val()
                    };

                if (row instanceof FooTable.Row) {
                    row.val(values);
                } else {
                    values.id = uid++;
                    ft.rows.add(values);
                }
                $modal.modal('hide');
            });
        });

    </script>
    <style>
        .form-group.required .control-label:after {
            content: "*";
            color: red;
            margin-left: 4px;
        }

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
            <table class="table table-striped table-hover" id="ansTable" data-paging="true" data-paging-size="10" data-sorting="true" data-filtering="true" data-filter-position="left" data-editing="true">
                <thead>
                    <tr>
                        <th id="answers">Answers</th>
                        <th id="intent" data-breakpoints="xs sm">Intent</th>
                        <th id="entity" data-breakpoints="xs sm">Entity</th>
                        <th data-filterable="false" data-sortable="false"></th>
                    </tr>
                </thead>
                <tbody>
                    <% 
                        ChatBotAnswerDAO cbaDAO = new ChatBotAnswerDAO();
                        List<ChatBotAnswer> allAnswers = cbaDAO.getAllChatBotAnswers();
                        foreach (ChatBotAnswer cba in allAnswers)
                        {
                            Response.Write("<tr>");
                            Response.Write($"<td id=\"answers\">{cba.answer}</td>");
                            Response.Write($"<td id=\"intent\">{cba.intent}</td>");
                            if (cba.entityName == null || cba.entityName.Equals(""))
                            {
                                Response.Write($"<td id=\"entity\">-</td>");
                            }
                            else
                            {
                                Response.Write($"<td id=\"entity\">{cba.entityName}</td>");
                            }
                            Response.Write("<td>");
                            Response.Write($"<a href=\"/askEmmaEditAns.aspx?id={cba.answerID}\">Edit</a>");
                            Response.Write("</td>");
                            Response.Write("</tr>");
                        }%>
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
                        <asp:DropDownList ID="ddlIntent" runat="server" CssClass="form-control" DataSourceID="SqlDataSource1" DataTextField="intent" DataValueField="intentID"></asp:DropDownList>
                        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" SelectCommand="SELECT [intent], [intentID] FROM [ChatBotIntent] ORDER BY [intent]"></asp:SqlDataSource>
                        <br>
                        <%--<asp:RequiredFieldValidator ID="rfv_ddlIntent" runat="server" ControlToValidate="ddlIntent" ErrorMessage="Please Select a Course" InitialValue="--Select--" ForeColor="Red" ValidationGroup="ValidateForm"></asp:RequiredFieldValidator>--%>
                    </div>
                </div>
                <div class="form-group">
                    <strong>
                        <%--Entity--%>
                        <label for="txtEntity" class="col-lg-2 control-label"><span class="glyphicon glyphicon-question-sign" data-toggle='tooltip' data-placement="left" title="" data-original-title="An Entity is a......"></span>Choose an Entity to represent </label>
                    </strong>
                    <div class="col-lg-10">
                        <asp:TextBox ID="txtEntity" runat="server" CssClass="form-control" placeholder="Please Enter an Entity"></asp:TextBox>
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
                        <%-- <asp:RequiredFieldValidator ID="rfv_txtAnswers" runat="server" ErrorMessage="Please enter an answer" ControlToValidate="txtAnswers" ForeColor="Red"></asp:RequiredFieldValidator> --%>
                    </div>
                </div>
                <%--Buttons--%>
                <br />
                <div class="wrapper">
                    <div class="form-group">

                        <asp:Button ID="btnSubmit" CssClass="btn btn-primary" runat="server" Text="Submit" data-toggle="modal" href="#submitModal" OnClientClick="$('#myModal').modal(); return false;"/>
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
                                    <asp:Button ID="btnConfirmSubmit" CssClass="btn btn-primary" runat="server" Text="Submit" OnClick="btnConfirmSubmit_Click" />
                                     <asp:Button ID="btnCancel1" CssClass="btn btn-default" runat="server" class="close" data-dismiss="modal" Text="Cancel" OnClientClick="return false;" />

                                    <br />
                                </div>
                            </div>
                        </div>

                    </div>
                </div>
            </fieldset>

        </div>

        <%--Footable Modal--%>
        <div class="modal fade" id="editor-modal" tabindex="-1" role="dialog" aria-labelledby="editor-title">
            <div class="modal-dialog" role="document">
                <div class="modal-content form-horizontal" id="editor">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
                        <h4 class="modal-title" id="editor-title">Add Row</h4>
                    </div>
                    <div class="modal-body">
                        <input type="number" id="id" name="id" class="hidden" />
                        <div class="form-group required">
                            <strong>
                                <label for="ddlEditIntent" class="col-lg-3 control-label"><span class="glyphicon glyphicon-question-sign" data-toggle='tooltip' data-placement="left" title="" data-original-title="An Intent is a......"></span>&nbsp;Choose an Intent</label>
                            </strong>
                            <div class="col-lg-9">
                                <%--Mandatory Choose 1--%>
                                <asp:DropDownList ID="ddlEditIntent" runat="server" disabled="" CssClass="form-control"></asp:DropDownList>
                                <br>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="form-group">
                                <strong>
                                    <%--Entity--%>
                                    <label for="txtEditEntity" class="col-lg-3 control-label"><span class="glyphicon glyphicon-question-sign" data-toggle='tooltip' data-placement="left" title="" data-original-title="An Entity is a......"></span>&nbsp;Choose an Entity </label>
                                </strong>
                                <div class="col-lg-9">

                                    <asp:TextBox ID="txtEditEntity" runat="server" CssClass="form-control" placeholder="Please enter an Entity"></asp:TextBox>
                                    <br>
                                </div>
                            </div>
                        </div>
                        <div class="form-group required">
                            <strong>
                                <%--Answers--%>
                                <asp:Label ID="lblEditAns" CssClass="col-lg-3 control-label" runat="server" Text="Answers*"></asp:Label>
                            </strong>
                            <div class="col-lg-9">
                                <%--Mandatory text field--%>
                                <asp:TextBox ID="txtEditAns" TextMode="multiline" Columns="50" Rows="5" runat="server" CssClass="form-control" placeholder="Please enter your answers here"></asp:TextBox>
                                <%-- <asp:RequiredFieldValidator ID="validateEditAns" runat="server" ErrorMessage="Please enter an answer" ControlToValidate="txtEditAns" ForeColor="Red"></asp:RequiredFieldValidator> --%>
                            </div>
                        </div>

                    </div>
                    <div class="modal-footer">
                        <button type="submit" class="btn btn-primary">Save changes</button>
                        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    </div>
                </div>
            </div>
        </div>

    </form>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
