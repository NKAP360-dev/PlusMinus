<%@ Page Title="" Language="C#" MasterPageFile="~/Masterpage.Master" AutoEventWireup="true" CodeBehind="askEmmaEditInitializeMsg.aspx.cs" Inherits="LearnHub.askEmmaEditInitializeMsg" %>
<%@ Import Namespace="LearnHub.AppCode.entity" %>
<%@ Import Namespace="LearnHub.AppCode.dao" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
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
           <li><a href="askEmmaInitializeMsg.aspx">Configure Initialization Messages</a></li>
  <li class="active">Edit Initialization Message</li>
  </ul>
   <div class="container">
        <h1>Edit Initialization Message
             
        </h1>
          <div class="verticalLine"></div>
          </div>
    <form class="form-horizontal" runat="server">
        <Br />
    <div class="container">          
                <fieldset>
                    
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
                        
                            <div class="wrapper">
                            <asp:Button ID="btnSubmit" CssClass="btn btn-primary" runat="server" Text="Update" data-toggle="modal" href="#submitModal" OnClientClick="$('#myModal').modal(); return false;" />
                            <asp:Button ID="deleteBtn" CssClass="btn btn-danger" runat="server" Text="Delete" data-toggle="modal" href="#deleteModal" OnClientClick="$('#myModal').modal(); return false;" />

                                <br /><br />
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
