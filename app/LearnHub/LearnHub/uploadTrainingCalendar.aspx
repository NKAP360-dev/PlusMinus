<%@ Page Title="" Language="C#" MasterPageFile="~/Masterpage.Master" AutoEventWireup="true" CodeBehind="uploadTrainingCalendar.aspx.cs" Inherits="LearnHub.uploadTrainingCalendar" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script>
        $('#uploadModal').modal({
            backdrop: 'static',
            keyboard: false
        });

        $(window).on('load', function () {
            $('#uploadModal').modal('show');
        });

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <form runat="server">
        <div id="uploadModal" class="modal fade" role="dialog" data-backdrop="static" data-keyboard="false">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h4 class="modal-title"><span class="glyphicon glyphicon-open"></span>&emsp;Upload Training Calendar</h4>
                    </div>
                    <div class="modal-body">
                        
                       <p>Please note that this upload will overwrite the current uploaded file.</p><br />
                        <asp:FileUpload ID="FileUpload1" runat="server" />
                        <asp:RequiredFieldValidator ID="rfv_FileUpload1" runat="server" ErrorMessage="Please select an item to upload!" ControlToValidate="FileUpload1" ForeColor="Red" Display="Dynamic" ValidationGroup="ValidateForm"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator id="reg_FileUpload1" runat="server" ErrorMessage="Only xlsx, xlsm, doc, docx, pdf, and csv files are allowed!" ValidationExpression ="^.+(.xlsx|.XLSX|.pdf|.PDF|.csv|.CSV|.doc|.DOC|.docx|.DOCX|.xlsm|.XLSM)$" ControlToValidate="FileUpload1" ForeColor="Red" Display="Dynamic" ValidationGroup="ValidateForm"> </asp:RegularExpressionValidator>
                        <%--HELLO WHOEVER IS INTEGRATION FOR THIS, PLEASE GO TO MASTERPAGE - TRAINING CALENDAR TO ALLOW DOWNLOAD OF THE UPLOADED FILE 
                            AS WELL!!!!! THANKS
                            
                            REMOVE THIS WHEN DONE--%>
                        <br />

                        <div class="modal-footer">

                            <asp:Button ID="Button1" class="btn btn-primary" runat="server" Text="Upload" OnClick="btnUpload_Click"/>
                            <a href='Home.aspx' class="btn btn-default">&nbsp; Go Back</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        </form>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
