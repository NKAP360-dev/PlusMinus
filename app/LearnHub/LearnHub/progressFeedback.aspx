<%@ Page Title="" Language="C#" MasterPageFile="~/Masterpage.Master" AutoEventWireup="true" CodeBehind="progressFeedback.aspx.cs" Inherits="LearnHub.progressFeedback" %>

<%@ Import Namespace="LearnHub.AppCode.entity" %>
<%@ Import Namespace="LearnHub.AppCode.dao" %>

<%@ Register Assembly="CKEditor.NET" Namespace="CKEditor.NET" TagPrefix="CKEditor" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
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
        <li class="active">Provide Progress Feedback</li>
    </ul>

    <div class="container">
        <h1>Provide Progress Feedback</h1>
        <div class="verticalLine"></div>
        <form class="form-horizontal" runat="server">
            <fieldset>
                <legend>Input Progress Feedback for Users</legend>
                <div class="form-group required">
                    <strong>
                        <asp:Label runat="server" CssClass="col-lg-1 control-label" Text="User"></asp:Label></strong>
                    <div class="col-lg-5">
                        <%--Choose which user to input feedback for, after choosing from ddl, the current feedback entered will be displayed in CKEditor, hence the updatepanel--%>
                        <asp:DropDownList ID="ddlSelectUser" CssClass="form-control" runat="server">
                            <asp:ListItem>Rafid</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <%--Open new window and link to user's progress report--%>
                    <div class="col-lg-6">
                        <asp:LinkButton ID="btnViewReport" CssClass="btn btn-info" runat="server"><span class="glyphicon glyphicon-search"></span>&nbsp; View Progress Report</asp:LinkButton>
                    </div>
                </div>
                <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                    <ContentTemplate>
                        <CKEditor:CKEditorControl ID="CKEditor1" runat="server">
                        </CKEditor:CKEditorControl>
                    </ContentTemplate>
                     <Triggers>
                    <asp:AsyncPostBackTrigger  ControlID="ddlSelectUser" EventName="SelectedIndexChanged" />
                </Triggers>
                </asp:UpdatePanel>
                <br />
                <div class="form-group wrapper">
                    <asp:Button ID="btnSubmit" CssClass="btn btn-primary" runat="server" Text="Submit" data-toggle="modal" href="#submitModal" OnClientClick="$('#myModal').modal();  return false;" UseSubmitBehavior="False" />
                </div>
            </fieldset>

            <div id="submitModal" class="modal fade" role="dialog">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title"><b>Submit Progress Feedback</b></h4>
                    </div>
                    <div class="modal-body">
                        <div class="wrapper">
                            <h4>Are you sure you want to submit your progress feedback for this user?</h4>
                            <br />
                            
                            <asp:Button ID="cfmSubmit" CssClass="btn btn-primary" runat="server" Text="Submit"/>
                            <asp:Button ID="Button2" CssClass="btn btn-default" runat="server" class="close" data-dismiss="modal" Text="Cancel" OnClientClick="return false;" />

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
