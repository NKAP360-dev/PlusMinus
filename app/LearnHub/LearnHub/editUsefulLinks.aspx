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
    <script type="text/javascript">
        function openModal() {
            console.log("submitModal");
            $("#submitModal").modal();
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <ul class="breadcrumb">
        <li><a href="home.aspx">Home</a></li>
        <li><a href="usefulLinks.aspx">Useful Links</a></li>
        <li><a href="manageUsefulLinks.aspx">Manage Useful Links</a></li>
        <li class="active">Edit Useful Link</li>
    </ul>

    <div class="container">
        <h1>Edit Useful Link</h1>
        <%
            User currentUser = (User)Session["currentUser"];
            Boolean superuser = false;
            Boolean content_creator = false;
            if (currentUser != null)
            {
                foreach (string s in currentUser.getRoles())
                {
                    if (s.Equals("superuser"))
                    {
                        superuser = true;
                    }
                    else if (s.Equals("content creator"))
                    {
                        content_creator = true;
                    }
                }
                if (currentUser != null && (content_creator || superuser))
                {
        %>
        <div class="dropdown" style="float: right;">
            <button class="dropbtn" onclick="return false;"><span class="glyphicon glyphicon-option-horizontal"></span></button>
            <div class="dropdown-content" style="right: 0;">
                <div class="dropHeader">Content Management</div>
                <a href="editAboutUs.aspx"><span class="glyphicon glyphicon-pencil"></span>&nbsp;&nbsp;Edit About Us</a>
                <a href="manageArticles.aspx"><span class="glyphicon glyphicon-duplicate"></span>&nbsp;&nbsp;Manage Articles</a>
                <a href="manageUsefulLinks.aspx"><span class="glyphicon glyphicon-globe"></span>&nbsp;&nbsp;Manage Links</a>
                <a href="manageContactUs.aspx"><span class="glyphicon glyphicon-earphone"></span>&nbsp;&nbsp;Manage Contact Us</a>
                <a href="uploadTrainingCalendar.aspx"><span class="glyphicon glyphicon-calendar"></span>&nbsp;&nbsp; Upload Training Calendar</a>
                <a href="manageNewsBanners.aspx"><span class="glyphicon glyphicon-picture"></span>&nbsp;&nbsp; Manage News Banners</a>
                <a href="manageNews.aspx"><span class="glyphicon glyphicon-blackboard"></span>&nbsp;&nbsp; Manage News</a>

            </div>
        </div>
        <%
                }
            }
        %>
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
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Please input a Link" ControlToValidate="txtLink" ForeColor="Red" ValidationGroup="ValidateForm" Display="Dynamic"></asp:RequiredFieldValidator>
                    </div>
                </div>
                <div class="form-group">
                    <strong>
                        <asp:Label runat="server" CssClass="col-lg-2 control-label" Text="Description (if any)"></asp:Label></strong>
                    <div class="col-lg-9">
                        <asp:TextBox ID="txtDesc" runat="server" CssClass="form-control" TextMode="MultiLine" placeholder="Description (if any)"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfv_txtDesc" runat="server" ErrorMessage="Please input a Description" ControlToValidate="txtDesc" ForeColor="Red" ValidationGroup="ValidateForm" Display="Dynamic"></asp:RequiredFieldValidator>
                    </div>
                </div>

                <br />
                <div class="form-group wrapper">
                    <asp:Button ID="btnSubmit" CssClass="btn btn-primary" runat="server" Text="Save" OnClick="checkForm" CausesValidation="True" UseSubmitBehavior="False" ValidationGroup="ValidateForm" />
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
                        <h4 class="modal-title"><b>Save Useful Link</b></h4>
                    </div>
                    <div class="modal-body">
                        <div class="wrapper">
                            <h4>Are you sure you want to save your changes and overwrite the current useful link details?</h4>
                            <br />
                            <asp:Label ID="lblErrorMsgFinal" runat="server" CssClass="text-danger" Visible="True"></asp:Label>
                            <br />
                            <asp:Button ID="btnConfirmSubmit" CssClass="btn btn-primary" runat="server" Text="Save Changes" OnClick="btnSave_Click" />
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
