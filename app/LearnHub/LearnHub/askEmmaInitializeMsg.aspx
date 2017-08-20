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

                .breadcrumb {
            padding-top: 15px;
            margin-bottom: 0px;
            list-style: none;
            background-color: white;
            border-radius: 0px;
        }
    </style>

    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>
    <link rel="stylesheet" href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.8.24/themes/smoothness/jquery-ui.css" />
    <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.8.24/jquery-ui.min.js"></script>
    <script type="text/javascript">

        var unsaved = false;

        $(function () {
            $("[id*=gvMessages]").sortable({
                items: 'tr:not(tr:first-child)',
                cursor: 'pointer',
                axis: 'y',
                dropOnEmpty: false,
                start: function (e, ui) {
                    ui.item.addClass("selected");
                    unsaved = true;
                },
                stop: function (e, ui) {
                    ui.item.removeClass("selected");
                    unsaved = true;
                },
                receive: function (e, ui) {
                    $(this).find("tbody").append(ui.item);
                    unsaved = true;
                }
            });
        });


        function checkForm_Clicked(source, args) {
            console.log("ValidateForm");
            Page_ClientValidate('ValidateForm');
            //Page_ClientValidate();
            
            if (!Page_IsValid) {
                document.getElementById('<%= lblErrorMsgFinal.ClientID %>').style.display = 'inherit';
                document.getElementById('<%= lblErrorMsgFinal.ClientID %>').innerHTML = "You have not filled up all of the required fields";
                //Page_ClientValidate('summaryGroup');
                document.getElementById('<%= btnConfirmSubmit.ClientID %>').disabled = true;
                console.log("The end");
            }
            else {
                document.getElementById('<%= lblErrorMsgFinal.ClientID %>').innerHTML = "";
                document.getElementById('<%= btnConfirmSubmit.ClientID %>').disabled = false;
            }
            return false;
        }

        function btnSaveClick() {
            unsaved = false;
        }

        $(document).ready(function () {
            function unloadPage() {
                if (unsaved) {
                    return "You have unsaved changes on this page. Do you want to leave this page and discard your changes or stay on this page?";
                }
            }

            window.onbeforeunload = unloadPage;
        });

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
            <ul class="breadcrumb">
  <li><a href="home.aspx">Home</a></li>
  <li><a href="emmaConfiguration.aspx">Emma Configuration</a></li>
  <li class="active">Configure Initialization Messages</li>
  </ul>
    <div class="container">
        <h1>Configure Initialization Messages
                                    <button type="button" data-toggle="collapse" data-target="#addForm" class="btn btn-success"><span class="glyphicon glyphicon-plus"></span>&nbsp;New </button>
        </h1>
        <div class="verticalLine"></div>
        <br />
    </div>
    <form class="form-horizontal" runat="server">
        <div class="container">
            <div id="addForm" class="collapse">
                <fieldset>
                    
                        <div class="form-group required">
                            <strong>
                                <label for="txtMsgInput" class="col-lg-3 control-label"><span class="glyphicon glyphicon-question-sign" data-toggle='tooltip' data-placement="left" title="" data-original-title="An Initialization Message is the message you see when you initialize :)"></span>&nbsp;Initialization Message </label>
                            </strong>
                            <div class="col-lg-8">
                                <%--Mandatory text field--%>
                                <asp:TextBox ID="txtMsgInput" runat="server" CssClass="form-control" placeholder="Initialization Message"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfv_txtMsgInput" runat="server" ErrorMessage="Please enter an Initialization Message" ControlToValidate="txtMsgInput" ForeColor="Red" ValidationGroup="ValidateForm"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                        <br />
                        <div class="row">
                            <div class="wrapper">
                            <asp:Button ID="btnSubmit" CssClass="btn btn-primary" runat="server" Text="Submit" data-toggle="modal" href="#submitModal" OnClientClick="return checkForm_Clicked(); $('#myModal').modal(); " CausesValidation="True" UseSubmitBehavior="False" />
                                <br /><br />
                            </div>
                        </div>
                    
                </fieldset>

                <div class="verticalLine"></div>
            </div>
        </div>
        <div class="container">
            <h4><b>Drag and drop to reorder messages</b></h4>
            
            <asp:SqlDataSource ID="SqlDataSourceMessages" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" SelectCommand="SELECT * FROM [ChatBotInitialization] ORDER BY levels"></asp:SqlDataSource>
            <asp:GridView ID="gvMessages" runat="server" AutoGenerateColumns="False" DataKeyNames="messageID" DataSourceID="SqlDataSourceMessages" GridLines="None" CssClass="table table-striped table-hover">
                <Columns>
                    
                    <asp:TemplateField>
                        <ItemTemplate>
                            <input type="hidden" name="messageID" value='<%# Eval("messageID") %>' />
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:BoundField DataField="message" HeaderText="Message" SortExpression="message" />

                    <asp:TemplateField>
                        <ItemTemplate>
                            <a href="askEmmaEditInitializeMsg.aspx?id=<%# Eval("messageID") %>" class="btn btn-info btn-sm pull-right"><span class="glyphicon glyphicon-pencil"></span></a>
                        </ItemTemplate>
                    </asp:TemplateField>

                </Columns>
                <EmptyDataTemplate>
                </EmptyDataTemplate>
            </asp:GridView>

            <div class="wrapper">
                <div class="form-group">
                    <asp:LinkButton ID="btnSave" CssClass="btn btn-success" runat="server" OnClientClick="btnSaveClick()" OnClick="btnSave_Click">Save Order</asp:LinkButton>
                    <br />
                </div>
                
            </div>

            <br />
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

        <%--Modal for Submission Confirmation--%>
        <div id="submitModal" class="modal fade" role="dialog">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title"><b>Submit Initialization Message</b></h4>
                    </div>
                    <div class="modal-body">
                        <div class="wrapper">
                            <h4>Are you sure you want to submit?</h4>
                            <br />
                            <asp:Label ID="lblErrorMsgFinal" runat="server" CssClass="text-danger" Visible="True"></asp:Label>
                            <br />
                            <asp:Button ID="btnConfirmSubmit" CssClass="btn btn-primary" runat="server" Text="Submit" OnClick="btnConfirmSubmit_Click"/>
                            <asp:Button ID="btnCancel1" CssClass="btn btn-default" runat="server" class="close" data-dismiss="modal" Text="Cancel" OnClientClick="return false;" />

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
