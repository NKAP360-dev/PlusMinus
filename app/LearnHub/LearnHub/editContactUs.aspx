<%@ Page Title="" Language="C#" MasterPageFile="~/Masterpage.Master" AutoEventWireup="true" CodeBehind="editContactUs.aspx.cs" Inherits="LearnHub.editContactUs" %>

<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="LearnHub.AppCode.dao" %>
<%@ Import Namespace="LearnHub.AppCode.entity" %>


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
        <li><a href="contactUs.aspx">Contact Us</a></li>
        <li><a href="manageContactUs.aspx">Manage Contact Us</a></li>
        <li class="active">Edit Contact Details</li>
    </ul>

    <div class="container">
        <h1>Edit Contact Details</h1>

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

                </div>
        </div>

        <%
                }
            }
            %>

        <div class="verticalLine"></div>
        <br />
        <form class="form-horizontal" runat="server">
            <div class="form-group required">
                <strong>
                    <asp:Label runat="server" CssClass="col-lg-2 control-label" Text="Name"></asp:Label></strong>
                <div class="col-lg-9">
                    <asp:TextBox ID="txtName" runat="server" CssClass="form-control" placeholder="Name of Contact"></asp:TextBox>
                </div>
            </div>

            <div class="form-group required">
                <strong>
                    <asp:Label runat="server" CssClass="col-lg-2 control-label" Text="Department"></asp:Label></strong>
                <div class="col-lg-9">
                    <asp:DropDownList ID="lblDept" runat="server" CssClass="form-control">
                            <asp:ListItem>--select--</asp:ListItem>
                 </asp:DropDownList>
                </div>
            </div>

            <div class="form-group required">
                <strong>
                    <asp:Label runat="server" CssClass="col-lg-2 control-label" Text="Email"></asp:Label></strong>
                <div class="col-lg-9">
                    <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" placeholder="Email of Contact"></asp:TextBox>
                </div>
            </div>

            <div class="form-group">
                <strong>
                    <asp:Label runat="server" CssClass="col-lg-2 control-label" Text="Remarks (if any)"></asp:Label></strong>
                <div class="col-lg-9">
                    <asp:TextBox ID="txtRemarks" runat="server" CssClass="form-control" TextMode="MultiLine" placeholder="Remarks (if any)"></asp:TextBox>
                </div>
            </div>
            <br />
            <div class="form-group wrapper">
                <asp:Button ID="btnSubmit" CssClass="btn btn-primary" runat="server" Text="Save Changes" data-toggle="modal" href="#submitModal" OnClientClick="$('#myModal').modal(); return false;" UseSubmitBehavior="False" />
            </div>

            <%--Modal for Submission Confirmation--%>
            <div id="submitModal" class="modal fade" role="dialog">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                            <h4 class="modal-title"><b>Save Contact Details</b></h4>
                        </div>
                        <div class="modal-body">
                            <div class="wrapper">
                                <h4>Are you sure you want to save your changes and overwrite the current contact details?</h4>
                                <br />
                                 <asp:Button ID="btnConfirmSubmit" CssClass="btn btn-primary" runat="server" Text="Save Changes" OnClick="btnEdit_Click"/>
                                <asp:Button ID="btnCancel1" CssClass="btn btn-default" runat="server" class="close" data-dismiss="modal" Text="Cancel" OnClientClick="return false;" />

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
