<%@ Page Title="" Language="C#" MasterPageFile="~/Masterpage.Master" AutoEventWireup="true" CodeBehind="askEmmaInstruction.aspx.cs" Inherits="LearnHub.askEmmaInstruction" %>
<%@ Register Assembly="CKEditor.NET" Namespace="CKEditor.NET" TagPrefix="CKEditor" %>

<%@ Import Namespace="LearnHub.AppCode.entity" %>
<%@ Import Namespace="LearnHub.AppCode.dao" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="https://cdn.ckeditor.com/4.7.1/standard/ckeditor.js"></script>
    <script>

        function displayText() {
            var preview = CKEDITOR.instances.CKEDITOR1.getData();
            document.getElementById('myField').innerHTML = preview;
            $('#previewModal').modal('show');
            return false;
        }


    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <br />

    <div class="container">
        <h1>Emma's Instructions
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
        <form runat="server">
            <CKEditor:CKEditorControl ID="CKEditor1" runat="server">
            </CKEditor:CKEditorControl>
            <br />
            <asp:Button ID="btnSave" CssClass="btn btn-primary pull-right" runat="server" Text="Save" />
            <asp:Button ID="btnPreview" CssClass="btn btn-primary" runat="server" Text="Preview" OnClientClick="return displayText();" UseSubmitBehavior="False" />

            <div id="previewModal" class="modal fade" role="dialog">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                            <h4 class="modal-title"><b>Preview</b></h4>
                        </div>
                        <div class="modal-body">
                            <div class="wrapper">
                                <label id="myField" />
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
