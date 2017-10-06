<%@ Page Title="" Language="C#" MasterPageFile="~/Masterpage.Master" AutoEventWireup="true" CodeBehind="editUsefulLinks.aspx.cs" Inherits="LearnHub.editUsefulLinks" %>

<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="LearnHub.AppCode.dao" %>
<%@ Import Namespace="LearnHub.AppCode.entity" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="Scripts/footable.bootstrap.min.css" rel="stylesheet" />
    <script src="Scripts/footable.min.js"></script>

    <style>
        .breadcrumb {
            padding-top: 15px;
            margin-bottom: 10px;
            list-style: none;
            background-color: white;
            border-radius: 0px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
        <ul class="breadcrumb">
        <li><a href="home.aspx">Home</a></li>
        <li><a href="siteConfig.aspx">Configuration Settings</a></li>
        <li><a href="manageUsefulLinks.aspx">Manage Useful Links</a></li>
        <li class="active">Edit Useful Link</li>
    </ul>

    <div class="container">
        <h1>Edit Useful Link</h1>
         <div class="verticalLine"></div>
    </div>
    <br />

    
    <form class="form-horizontal" runat="server">
        <div class="container">
                <fieldset>
                    <br />
                    <div class="form-group required">
                        <strong>
                            <asp:Label runat="server" CssClass="col-lg-2 control-label" Text="Link"></asp:Label></strong>
                        <div class="col-lg-9">
                            <asp:TextBox ID="txtLink" runat="server" CssClass="form-control" placeholder="e.g www.google.com"></asp:TextBox>
                        </div>
                    </div>

                    <div class="form-group">
                        <strong>
                            <asp:Label runat="server" CssClass="col-lg-2 control-label" Text="Description (if any)"></asp:Label></strong>
                        <div class="input-group col-lg-9">
                            <asp:TextBox ID="txtDesc" runat="server" CssClass="form-control" TextMode="MultiLine" placeholder="Description (if any)"></asp:TextBox>
                        </div>
                    </div>

                    <br />
                    <div class="form-group wrapper">
                        <asp:Button ID="btnSubmit" CssClass="btn btn-primary" runat="server" Text="Save" data-toggle="modal" href="#submitModal" OnClientClick="$('#myModal').modal(); return false;" UseSubmitBehavior="False" />
                    </div>
                    <br />

                </fieldset>
                <br />
            </div>

          <%--Modal for Submission Confirmation--%>
        <div id="submitModal" class="modal fade" role="dialog">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title"><b> Save Useful Link</b></h4>
                    </div>
                    <div class="modal-body">
                        <div class="wrapper">
                                <h4>Are you sure you want to save your changes and overwrite the current useful link details?</h4>
                            <br />
                            <asp:Button ID="btnConfirmSubmit" CssClass="btn btn-primary" runat="server" Text="Save Changes" OnClick="btnSave_Click"/>
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
