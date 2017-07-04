<%@ Page Title="" Language="C#" MasterPageFile="~/Masterpage.Master" AutoEventWireup="true" CodeBehind="trainingRequestFormPage.aspx.cs" Inherits="LearnHub.trainingRequestFormPage" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">
    <h1>Training Request Form Control</h1>
     <div class="verticalLine"></div>
        <div class="row">
            <h3>Applicant</h3><br />
            <a href="#formModal" class="btn btn-primary" data-toggle="modal" >Apply for Courses</a>
            &emsp;
            <a href="trfApplicationStatus.aspx" class="btn btn-primary">Check Application Status</a>
        </div>
        <div class="row">
            <h3>Approver</h3><br />
            <a href="pendingApproval.aspx" class="btn btn-success">View TRF Pending Approval</a>
            &emsp;
            <a href="approvedTRF.aspx" class="btn btn-success">View TRF Approval History</a>
        </div>
        </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
    <%--TRF Modal--%>
    <div id="formModal" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Choose Type of Training Request Form</h4>
                </div>
                <div class="modal-body">
                    <div class="wrapper">
                        <a href="applyCourse.aspx" class="btn btn-primary btn-lg"><span class="glyphicon glyphicon-file"></span>
                            <br />
                            <strong>Individual Training</strong></a><br /><br />
        <a href="errorPage.aspx" class="btn btn-success btn-lg"><span class="glyphicon glyphicon-duplicate"></span>
            <br />
            <strong>&emsp;Group Training&nbsp;&nbsp;&nbsp;</strong></a>
                    </div>
                </div>
                <div class="modal-footer">
                </div>
            </div>
        </div>
    </div>
</asp:Content>
