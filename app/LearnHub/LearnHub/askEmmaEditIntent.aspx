<%@ Page Title="" Language="C#" MasterPageFile="~/Masterpage.Master" AutoEventWireup="true" CodeBehind="askEmmaEditIntent.aspx.cs" Inherits="LearnHub.askEmmaEditIntent" %>

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
        $(document).ready(function () {
            $("[data-toggle='tooltip']").tooltip();
        });

        jQuery(function ($) {
            $('.table').footable({
                "paging": {
                    "size": 5 <%--Change how many rows per page--%>
                },
                "filtering": {
                    "position": "left"
                }
            });
        });

        function checkForm_Clicked(source, args) {

            Page_ClientValidate('ValidateForm');
            //Page_ClientValidate();

            if (!Page_IsValid) {
                document.getElementById('<%= lblErrorMsgFinal.ClientID %>').style.display = 'inherit';
                document.getElementById('<%= lblErrorMsgFinal.ClientID %>').innerHTML = "You have not filled up all of the required fields";
                //Page_ClientValidate('summaryGroup');
                document.getElementById('<%= cfmSubmit.ClientID %>').disabled = true;
                console.log("The end");
            }
            else {
                document.getElementById('<%= lblErrorMsgFinal.ClientID %>').innerHTML = "";
                document.getElementById('<%= cfmSubmit.ClientID %>').disabled = false;
            }
            return false;
        }
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">
        <h1>Edit Intents
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

    <form class="form-horizontal" runat="server">
        <div class="form-group required">
            <div class="row">
                <strong>
                    <%--Intent--%>
                    <label for="intentInput" class="col-lg-3 control-label"><span class="glyphicon glyphicon-question-sign" data-toggle='tooltip' data-placement="left" title="" data-original-title="An Intent is a......"></span>&nbsp;Name of Intent</label>
                </strong>
                <div class="col-lg-7">
                    <%--Mandatory text field--%>
                    <asp:TextBox ID="txtIntentInput" runat="server" CssClass="form-control" placeholder="intent value"></asp:TextBox>
                    <a href="#" data-toggle="collapse" data-target="#viewTable" class="pull-right"><span class="glyphicon glyphicon-search"></span>View available Intents</a>
                    <br />
                    <asp:RequiredFieldValidator ID="rfv_txtIntentInput" runat="server" ErrorMessage="Please enter the Intent Name" ControlToValidate="txtIntentInput" ForeColor="Red" ValidationGroup="ValidateForm"></asp:RequiredFieldValidator>
                </div>


            </div>
            <br />
            <br />
            <div class="row">
                <%--Buttons--%>
                <div class="form-group">
                    <div class="wrapper">
                        <asp:Button ID="submitBtn" CssClass="btn btn-primary" runat="server" Text="Update" data-toggle="modal" href="#updateModal" OnClientClick="$('#myModal').modal(); return checkForm_Clicked();" CausesValidation="True" UseSubmitBehavior="False" />
                        <asp:Button ID="deleteBtn" CssClass="btn btn-danger" runat="server" Text="Delete" data-toggle="modal" href="#deleteModal" OnClientClick="$('#myModal').modal(); return false;" />

                        <br />
                        <br />
                        <%--<strong>
                                    <asp:Label ID="lblSuccess" runat="server" CssClass="text-success"><span class="glyphicon glyphicon-ok"></span> Added successfully</asp:Label></strong><br />
                            <strong>
                                <asp:Label ID="lblError" runat="server" CssClass="text-danger"><span class="glyphicon glyphicon-remove"></span> Something went wrong</asp:Label></strong>
                            --%>
                    </div>
                </div>
            </div>
        </div>

        <%--Collapsible Table--%>
        <div class="container">
            <div id="viewTable" class="collapse">
                <div class="verticalLine"></div>
                <br />
                <table class="table table-striped table-hover" data-paging="true" data-sorting="true" data-filtering="true">
                    <thead>
                        <tr>
                            <th width="90%">Intent</th>
                            <th data-filterable="false" data-sortable="false"></th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            ChatBotIntentDAO cbiDAO = new ChatBotIntentDAO();
                            List<ChatBotIntent> allIntents = cbiDAO.getAllChatBotIntent();
                            foreach (ChatBotIntent cbi in allIntents)
                        {
                            Response.Write("<tr>");
                            Response.Write($"<td>{cbi.intent}</td>");
                            Response.Write("</tr>");
                        }
                        %>
                        <tr>
                            <td>lalalalala </td>
                        </tr>
                        <tr>
                            <td>sseolsa</td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>

        <%--Update Modal--%>
        <div id="updateModal" class="modal fade" role="dialog">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title"><b>Update Intents</b></h4>
                    </div>
                    <div class="modal-body">
                        <div class="wrapper">
                            <h4>Are you sure you want to overwrite the existing intent?</h4>
                            <br />
                            <asp:Label ID="lblErrorMsgFinal" runat="server" CssClass="text-danger" Visible="True"></asp:Label>
                            <br />
                            <asp:Button ID="cfmSubmit" CssClass="btn btn-primary" runat="server" Text="Overwrite" OnClick="cfmSubmit_Click" />
                            <asp:Button ID="Button2" CssClass="btn btn-default" runat="server" class="close" data-dismiss="modal" Text="Cancel" OnClientClick="return false;" />

                            <br />
                        </div>
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
                        <h4 class="modal-title"><span class="glyphicon glyphicon-trash"></span>&nbsp;<b>Delete Intent</b></h4>
                    </div>
                    <%--Modal Content--%>
                    <div class="modal-body">
                        <div class="wrapper">
                            <h4>Are you sure you want to delete?</h4>
                      <br />
                            <div class="alert alert-danger"role="alert">
                                <span style="font-size:30px;" class="glyphicon glyphicon-warning-sign"></span><br />
                                Notice: This will <b>DELETE ALL ANSWERS</b> relating to this intent.
                            </div>
                            <br />
                            <asp:Button ID="btnCfmDelete" CssClass="btn btn-danger" runat="server" Text="Delete" OnClick="btnCfmDelete_Click"/>
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
