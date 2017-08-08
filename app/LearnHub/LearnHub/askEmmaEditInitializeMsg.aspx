<%@ Page Title="" Language="C#" MasterPageFile="~/Masterpage.Master" AutoEventWireup="true" CodeBehind="askEmmaEditInitializeMsg.aspx.cs" Inherits="LearnHub.askEmmaEditInitializeMsg" %>
<%@ Import Namespace="LearnHub.AppCode.entity" %>
<%@ Import Namespace="LearnHub.AppCode.dao" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
   <div class="container">
        <h1>Edit Initialization Messages
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
        <Br />
    <div class="container">          
                <fieldset>
                    <div class="row">
                        <div class="form-group required">
                            <strong>
                                <label for="txtMsgInput" class="col-lg-3 control-label"><span class="glyphicon glyphicon-question-sign" data-toggle='tooltip' data-placement="left" title="" data-original-title="An Initialization Message is the message you see when you initialize :)"></span>&nbsp;Initialization Message </label>
                            </strong>
                            <div class="col-lg-8">
                                <%--Mandatory text field--%>
                                <asp:TextBox ID="txtMsgInput" runat="server" CssClass="form-control" placeholder="Initialization Message"></asp:TextBox>
                            </div>
                        </div>
                        <br />
                        <div class="row">
                            <div class="wrapper">
                            <asp:Button ID="btnSubmit" CssClass="btn btn-primary" runat="server" Text="Update" data-toggle="modal" href="#submitModal" OnClientClick="$('#myModal').modal(); return false;" />
                                                        <asp:Button ID="deleteBtn" CssClass="btn btn-danger" runat="server" Text="Delete" data-toggle="modal" href="#deleteModal" OnClientClick="$('#myModal').modal(); return false;" />

                                <br /><br />
                                <strong>
                                    <asp:Label ID="lblAddSuccess" runat="server" CssClass="text-success"><span class="glyphicon glyphicon-ok"></span> Saved successfully</asp:Label></strong><br />
                                <strong>
                                    <asp:Label ID="lblAddError" runat="server" CssClass="text-danger"><span class="glyphicon glyphicon-remove"></span> Something went wrong</asp:Label></strong>
                            </div>
                        </div>
                    </div>
                </fieldset>

        </div>

         <%--Modal for Submission Confirmation--%>
        <div id="submitModal" class="modal fade" role="dialog">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title"><b>Save Initialization Message</b></h4>
                    </div>
                    <div class="modal-body">
                        <div class="wrapper">
                            <h4>Are you sure you want to overwrite?</h4>
                            <br />
                            <asp:Button ID="btnConfirmSubmit" CssClass="btn btn-primary" runat="server" Text="Overwrite" OnClick="btnConfirmSubmit_Click"/>
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
                                <h4 class="modal-title"><span class="glyphicon glyphicon-trash"></span>&nbsp;<b>Delete Initialization Message</b></h4>
                            </div>
                            <%--Modal Content--%>
                            <div class="modal-body">
                                <div class="wrapper">
                                    <h4>Are you sure you want to delete?</h4>
                                    <br />
                                    <asp:Button ID="cfmDelete" CssClass="btn btn-danger" runat="server" Text="Delete" OnClick="cfmDelete_Click"/>
                                    <asp:Button ID="Button1" CssClass="btn btn-default" runat="server" class="close" data-dismiss="modal" Text="Cancel" />

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
