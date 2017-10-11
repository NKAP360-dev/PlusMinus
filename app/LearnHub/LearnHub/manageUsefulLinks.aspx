<%@ Page Title="" Language="C#" MasterPageFile="~/Masterpage.Master" AutoEventWireup="true" CodeBehind="manageUsefulLinks.aspx.cs" Inherits="LearnHub.manageUsefulLinks" %>

<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Collections" %>
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

        .pagination li > a,
        .pagination li > span,
        .pagination li > a:focus, .pagination .disabled > a,
        .pagination .disabled > a:hover,
        .pagination .disabled > a:focus,
        .pagination .disabled > span {
            background-color: white;
            color: black;
        }

            .pagination li > a:hover {
                background-color: #96a8ba;
            }

        .pagination > .active > a,
        .pagination > .active > span,
        .pagination > .active > a:hover,
        .pagination > .active > span:hover,
        .pagination > .active > a:focus,
        .pagination > .active > span:focus {
            background-color: #576777;
        }
    </style>
    <script>
        jQuery(function ($) {
            $('.table').footable({
                "paging": {
                    "size": 10 <%--Change how many rows per page--%>
                },
                "filtering": {
                    "position": "left"
                }
            });
        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <ul class="breadcrumb">
        <li><a href="home.aspx">Home</a></li>
        <li><a href="usefulLinks.aspx">Useful Links</a></li>
        <li class="active">Manage Useful Links</li>
    </ul>
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
    <div class="container">
        <h1>Manage Useful Links
        <button type="button" data-toggle="collapse" data-target="#addForm" class="btn btn-success">Add New Links</button>
        </h1>

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

    <form class="form-horizontal" runat="server">
        <div class="container">
            <div id="addForm" class="collapse">
                <fieldset>
                    <br />
                    <div class="form-group required">
                        <strong>
                            <asp:Label runat="server" CssClass="col-lg-2 control-label" Text="Link"></asp:Label></strong>
                        <div class="input-group col-lg-9">
                            <span class="input-group-addon">http://</span>
                            <asp:TextBox ID="txtLink" runat="server" CssClass="form-control" placeholder="e.g www.google.com"></asp:TextBox>
                        </div>
                    </div>

                    <div class="form-group required">
                        <strong>
                            <asp:Label runat="server" CssClass="col-lg-2 control-label" Text="Description (if any)"></asp:Label></strong>
                        <div class="input-group col-lg-9">
                            <asp:TextBox ID="txtDesc" runat="server" CssClass="form-control" TextMode="MultiLine" placeholder="Description (if any)"></asp:TextBox>
                        </div>
                    </div>

                    <br />
                    <div class="form-group wrapper">
                        <asp:Button ID="btnSubmit" CssClass="btn btn-primary" runat="server" Text="Submit" data-toggle="modal" href="#submitModal" OnClientClick="$('#myModal').modal(); return false;" UseSubmitBehavior="False" />
                    </div>
                    <br />

                </fieldset>
                <div class="verticalLine"></div>
                <br />
            </div>
            <table class="table table-striped table-hover" data-paging="true" data-sorting="true" data-filtering="true">
                <thead>
                    <tr>
                        <th>Link</th>
                        <th>Description</th>
                        <th data-filterable="false" data-sortable="false" width="10%"></th>
                    </tr>
                </thead>
                <tbody>
                    <%  LinkDAO ldao = new LinkDAO();
                        ArrayList arr = ldao.getLinks();
                        foreach (Link link in arr)
                        {%>
                    <tr>
                        <td><a href="<%=link.link_path %>" target="_blank"><%=link.link_path %>/</a></td>
                        <td><%=link.description %></td>
                        <td><a href="editUsefulLinks.aspx?id=<%=link.link_id %>" class="btn btn-sm btn-info"><span class="glyphicon glyphicon-pencil"></span></a>
                            <a href="deleteLink.aspx?id=<%=link.link_id %>" onclick="return confirm('Are you sure?')" data-toggle="modal" class="btn btn-sm btn-danger"><span class="glyphicon glyphicon-trash"></span></a>
                    </tr>
                    <%} %>
                </tbody>
            </table>
        </div>

        <%--Modal for Submission Confirmation--%>
        <div id="submitModal" class="modal fade" role="dialog">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title"><b>Submit New Useful Link</b></h4>
                    </div>
                    <div class="modal-body">
                        <div class="wrapper">
                            <h4>Are you sure you want to submit?</h4>
                            <br />
                            <asp:Button ID="btnConfirmSubmit" CssClass="btn btn-primary" runat="server" Text="Submit" OnClick="btnSubmit_Click" />
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
                        <h4 class="modal-title"><span class="glyphicon glyphicon-trash"></span>&nbsp;<b>Delete Useful Link</b></h4>
                    </div>
                    <%--Modal Content--%>
                    <div class="modal-body">
                        <div class="wrapper">
                            <h4>Are you sure you want to delete?</h4>
                            <br />
                            <asp:Button ID="cfmDelete" CssClass="btn btn-danger" runat="server" Text="Delete" />
                            <asp:Button ID="cfmCancel" CssClass="btn btn-default" runat="server" class="close" data-dismiss="modal" Text="Cancel" />

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
