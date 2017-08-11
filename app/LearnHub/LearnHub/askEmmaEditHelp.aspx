<%@ Page Title="" Language="C#" MasterPageFile="~/Masterpage.Master" AutoEventWireup="true" CodeBehind="askEmmaEditHelp.aspx.cs" Inherits="LearnHub.askEmmEditHelp" %>

<%@ Import Namespace="LearnHub.AppCode.entity" %>
<%@ Import Namespace="LearnHub.AppCode.dao" %>
<%@ Import Namespace="Emma.DAO" %>
<%@ Import Namespace="Emma.Entity" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script>
        function checkForm_Clicked(source, args) {

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
    </script>
    <style>
        .breadcrumb {
            padding-top: 15px;
            margin-bottom: 0px;
            list-style: none;
            background-color: white;
            border-radius: 0px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <ul class="breadcrumb">
        <li><a href="home.aspx">Home</a></li>
        <li><a href="emmaConfiguration.aspx">Emma Configuration</a></li>
        <li><a href="askEmmaHelpQn.aspx">Manage Help Questions</a></li>
        <li class="active">Edit Help Question</li>
    </ul>
    <div class="container">
        <h1>Edit Help Question        
        </h1>
        <div class="verticalLine"></div>
        <br />
        <form class="form-horizontal" runat="server">
            <fieldset>
                <div class="form-group required">
                    <strong>
                        <%--Help Question--%>
                        <label for="txtHelpInput" class="col-lg-3 control-label"><span class="glyphicon glyphicon-question-sign" data-toggle='tooltip' data-placement="left" title="" data-original-title="What the hell is a help question? Beats me"></span>&nbsp;Help Question</label>
                    </strong>
                    <div class="col-lg-7">
                        <%--Mandatory text field--%>
                        <asp:TextBox ID="txtHelpInput" runat="server" CssClass="form-control" placeholder="initial value goes here"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfv_txtHelpInput" runat="server" ErrorMessage="Please enter a Help Question" ControlToValidate="txtHelpInput" ForeColor="Red" ValidationGroup="ValidateForm"></asp:RequiredFieldValidator>
                    </div>
                    <br />
                </div>

                <div class="row">
                    <div class="wrapper">
                        <asp:Button ID="btnSubmit" CssClass="btn btn-primary" runat="server" Text="Update" data-toggle="modal" href="#submitModal" OnClientClick="$('#myModal').modal();   return checkForm_Clicked();" CausesValidation="True" UseSubmitBehavior="False" />
                        <asp:Button ID="btnDelete" CssClass="btn btn-danger" runat="server" Text="Delete" data-toggle="modal" href="#deleteModal" OnClientClick="$('#myModal').modal(); return false;" />
                        <br />
                        <br />
                        <%--<strong>
                                    <asp:Label ID="lblSuccess" runat="server" CssClass="text-success"><span class="glyphicon glyphicon-ok"></span> Added successfully</asp:Label></strong><br />
                                <strong>
                                    <asp:Label ID="lblError" runat="server" CssClass="text-danger"><span class="glyphicon glyphicon-remove"></span> Something went wrong</asp:Label></strong>
                        --%>
                    </div>
                </div>
            </fieldset>

            <%--Modal for Submission Confirmation--%>
            <div id="submitModal" class="modal fade" role="dialog">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                            <h4 class="modal-title"><b>Update Help Question</b></h4>
                        </div>
                        <div class="modal-body">
                            <div class="wrapper">
                                <h4>Are you sure you want to overwrite the existing question?</h4>
                                <br />
                                <asp:Label ID="lblErrorMsgFinal" runat="server" CssClass="text-danger" Visible="True"></asp:Label>
                                <br />
                                <asp:Button ID="btnConfirmSubmit" CssClass="btn btn-primary" runat="server" Text="Overwrite" OnClick="btnConfirmSubmit_Click" />
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
                            <h4 class="modal-title"><span class="glyphicon glyphicon-trash"></span>&nbsp;<b>Delete Help Question</b></h4>
                        </div>
                        <%--Modal Content--%>
                        <div class="modal-body">
                            <div class="wrapper">
                                <h4>Are you sure you want to delete?</h4>
                                <br />
                                <asp:Button ID="btnCfmDelete" CssClass="btn btn-danger" runat="server" Text="Delete" OnClick="btnCfmDelete_Click" />
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
