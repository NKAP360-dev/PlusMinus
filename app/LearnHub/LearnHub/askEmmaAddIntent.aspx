<%@ Page Title="" Language="C#" MasterPageFile="~/Masterpage.Master" AutoEventWireup="true" CodeBehind="askEmmaAddIntent.aspx.cs" Inherits="LearnHub.askEmmaAddIntent" %>

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
        $(document).ready(function () {
            $("[data-toggle='tooltip']").tooltip();
        });

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

        function checkForm_Clicked(source, args) {

            Page_ClientValidate('ValidateForm');
            //Page_ClientValidate();

            if (!Page_IsValid) {
                document.getElementById('<%= lblErrorMsgFinal.ClientID %>').style.display = 'inherit';
                document.getElementById('<%= lblErrorMsgFinal.ClientID %>').innerHTML = "You have not filled up all of the required fields";
                //Page_ClientValidate('summaryGroup');
                document.getElementById('<%= btnSubmitIntent.ClientID %>').disabled = true;
                console.log("The end");
            }
            else {
                document.getElementById('<%= lblErrorMsgFinal.ClientID %>').innerHTML = "";
                document.getElementById('<%= btnSubmitIntent.ClientID %>').disabled = false;
            }
            return false;
        }
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
        <ul class="breadcrumb">
  <li><a href="home.aspx">Home</a></li>
  <li><a href="emmaConfiguration.aspx">Emma Configuration</a></li>
  <li class="active">Manage Categories</li>
  </ul>
    <div class="container">
        <h1>Manage Categories
                                    <button type="button" data-toggle="collapse" data-target="#addForm" class="btn btn-success"><span class="glyphicon glyphicon-plus"></span>&nbsp; New</button>

        </h1>
        <div class="verticalLine"></div>
    </div>
    <form class="form-horizontal" runat="server">
        <div class="container">
            <div id="addForm" class="collapse">
                <fieldset>
                    <br />
                    <div class="form-group required">
                            <strong>
                                <%--Intent--%>
                                <label for="intentInput" class="col-lg-3 control-label"><span class="glyphicon glyphicon-question-sign" data-toggle='tooltip' data-placement="bottom" title="" data-original-title="A Category is used for categorising Answers. For example, 'greeting', 'course enquiry'"></span>&nbsp;Name of Category</label>
                            </strong>
                            <div class="col-lg-8">
                                <%--Mandatory text field--%>
                                <asp:TextBox ID="txtIntentInput" runat="server" CssClass="form-control" placeholder="e.g Course Enquiry"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfv_txtIntentInput" runat="server" ErrorMessage="Please enter a Category" ControlToValidate="txtIntentInput" ForeColor="Red" ValidationGroup="ValidateForm"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                        <br />

                            <div class="wrapper">
                               <div class="form-group">
                                <asp:Button ID="btnSubmit" CssClass="btn btn-primary" runat="server" Text="Submit" data-toggle="modal" href="#submitModal" OnClientClick="$('#myModal').modal();  return checkForm_Clicked();" CausesValidation="True" UseSubmitBehavior="False" />
                                </div>
                                   <br />
                                <%--<strong>
                                    <asp:Label ID="lblSuccess" runat="server" CssClass="text-success"><span class="glyphicon glyphicon-ok"></span> Added successfully</asp:Label></strong><br />
                                <strong>
                                    <asp:Label ID="lblError" runat="server" CssClass="text-danger"><span class="glyphicon glyphicon-remove"></span> Something went wrong</asp:Label></strong>
                                --%>
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
                        <th width="90%">Category</th>
                        <th data-filterable="false" data-sortable="false"></th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        ChatBotIntentDAO cbiDAO = new ChatBotIntentDAO();
                        List<ChatBotIntent> allChatBotIntents = cbiDAO.getAllChatBotIntent();
                        foreach (ChatBotIntent cbi in allChatBotIntents)
                        {
                            Response.Write("<tr>");
                            Response.Write($"<td>{cbi.intent}</td>");
                            Response.Write($"<td><a href=\"/askEmmaEditIntent.aspx?id={cbi.intentID}\" class=\"btn btn-info btn-sm pull-right\"><span class=\"glyphicon glyphicon-pencil\"></span></a></td>");
                            Response.Write("</tr>");
                        }
                    %>
                </tbody>
            </table>
        </div>

        <%--Modal for Submission Confirmation--%>
        <div id="submitModal" class="modal fade" role="dialog">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title"><b>Submit Category</b></h4>
                    </div>
                    <div class="modal-body">
                        <div class="wrapper">
                            <h4>Are you sure you want to submit?</h4>
                            <br />
                            <asp:Label ID="lblErrorMsgFinal" runat="server" CssClass="text-danger" Visible="True"></asp:Label>
                            <br />
                            <asp:Button ID="btnSubmitIntent" CssClass="btn btn-primary" runat="server" Text="Submit" OnClick="btnSubmitIntent_Click" />
                            <asp:Button ID="btnCancel1" CssClass="btn btn-default" runat="server" class="close" data-dismiss="modal" Text="Cancel" OnClientClick="return false;" />

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
                        <h4 class="modal-title"><span class="glyphicon glyphicon-trash"></span>&nbsp;<b>Delete Category</b></h4>
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
