<%@ Page Title="" Language="C#" MasterPageFile="~/Masterpage.Master" AutoEventWireup="true" CodeBehind="suggestCourses.aspx.cs" Inherits="LearnHub.suggestCourses" %>

<%@ Import Namespace="LearnHub.AppCode.entity" %>
<%@ Import Namespace="LearnHub.AppCode.dao" %>

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
        <li class="active">Suggest Courses</li>
    </ul>

    <div class="container">
        <h1>Suggest Courses</h1>
        <div class="verticalLine"></div>
        <form class="form-horizontal" runat="server">
            <fieldset>
                <legend>Choose up to 5 Courses</legend>
                <div class="form-group required">
                    <strong>
                        <asp:Label runat="server" CssClass="col-lg-1 control-label" Text="User"></asp:Label></strong>
                    <div class="col-lg-5">
                        <%--Choose which user to suggest courses for, after choosing from ddl, the current course suggested will be displayed below, hence the updatepanel--%>
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
                        <div class="form-group">
                            <strong>
                                <asp:Label runat="server" CssClass="col-lg-1 control-label" Text="List of Courses Available"></asp:Label></strong>
                            <div class="col-lg-5">
                                <table class="table table-striped table-hover">
                                    <thead>
                                        <tr>
                                            <th></th>
                                            <th>Course Name</th>
                                            <th>Category</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td>
                                                <asp:LinkButton ID="btnAdd" runat="server"><span class="glyphicon glyphicon-plus"></span></asp:LinkButton></td>
                                            <td>I am not a gridview</td>
                                            <td>Please replace me with gridview</td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>

                        </div>

                        <div class="form-group">
                            <strong>
                                <asp:Label runat="server" CssClass="col-lg-1 control-label" Text="Suggested Courses (Max 5)"></asp:Label></strong>
                            <div class="col-lg-5">
                                <table class="table table-striped table-hover">
                                    <thead>
                                        <tr>
                                            <th></th>
                                            <th>Course Name</th>
                                            <th>Category</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td>
                                                <asp:LinkButton ID="btnRemove" runat="server"><span class="glyphicon glyphicon-minus"></span></asp:LinkButton></td>
                                            <td>I am not a gridview</td>
                                            <td>Please replace me with gridview</td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>

                        </div>
                    </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="ddlSelectUser" EventName="SelectedIndexChanged" />
                    </Triggers>
                </asp:UpdatePanel>
            </fieldset>
            <div class="form-group wrapper">
                <asp:Button ID="btnSubmit" CssClass="btn btn-primary" runat="server" Text="Submit" data-toggle="modal" href="#submitModal" OnClientClick="$('#myModal').modal();  return false;" UseSubmitBehavior="False" />
            </div>
            <div id="submitModal" class="modal fade" role="dialog">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                            <h4 class="modal-title"><b>Submit list of Suggested Courses</b></h4>
                        </div>
                        <div class="modal-body">
                            <div class="wrapper">
                                <h4>Are you sure you want to submit the current list of Suggested Courses?</h4>
                                <br />

                                <asp:Button ID="cfmSubmit" CssClass="btn btn-primary" runat="server" Text="Submit" />
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
