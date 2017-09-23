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
        <li><a href="progressReport.aspx">Progress Report</a></li>
        <li><a href="manageProgress.aspx">Manage Progress Report</a></li>
        <li class="active">Suggest Courses</li>
    </ul>

    <div class="container">
        <h1>Suggest Courses</h1>
          <div class="dropdown" style="float: right;">
                <button class="dropbtn" onclick="return false;"><span class="glyphicon glyphicon-option-horizontal"></span></button>
                <div class="dropdown-content" style="right: 0;">
                    <a href="manageProgress.aspx"><span class="glyphicon glyphicon-duplicate"></span>&nbsp&nbsp; Manage Progress Reports</a>
                    <a href="suggestCourses.aspx"><span class="glyphicon glyphicon-comment"></span>&nbsp;&nbsp;Suggest Courses</a>
                </div>
            </div>
        <div class="verticalLine"></div>
        <form class="form-horizontal" runat="server">
            <fieldset>
                <legend>Choose up to 5 Courses</legend>
                <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                    <ContentTemplate>
                <div class="form-group required">
                    <strong>
                        <asp:Label runat="server" CssClass="col-lg-1 control-label" Text="User"></asp:Label></strong>
                    <div class="col-lg-5">
                        <%--Choose which user to suggest courses for, after choosing from ddl, the current course suggested will be displayed below, hence the updatepanel--%>
                        <asp:DropDownList ID="ddlSelectUser" CssClass="form-control" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlSelectUser_SelectedIndexChanged">
                        </asp:DropDownList>
                    </div>
                    <%--Open new window and link to user's progress report--%>
                    <div class="col-lg-6">
                        <asp:LinkButton ID="btnViewReport" CssClass="btn btn-info" runat="server"><span class="glyphicon glyphicon-search"></span>&nbsp; View Progress Report</asp:LinkButton>
                    </div>
                </div>
                        <div class="form-group">
                            <strong>
                                <asp:Label runat="server" CssClass="col-lg-1 control-label" Text="List of Courses Available"></asp:Label></strong>
                            <div class="col-lg-5">
                                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>">
                        </asp:SqlDataSource>
                        <asp:GridView ID="gvCourses" runat="server" AutoGenerateColumns="False" DataKeyNames="elearn_courseID,categoryID1" AllowPaging="True" CssClass="table table-striped table-hover" GridLines="None" OnRowCommand="gvCourses_RowCommand" EmptyDataText="There are no courses available to choose from.">
                            <Columns>
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <asp:LinkButton ID="btnAdd" runat="server" CausesValidation="false" CommandArgument='<%# Eval("elearn_courseID") %>'><span class="glyphicon glyphicon-plus"></span></asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="elearn_courseName" HeaderText="Course Name" SortExpression="elearn_courseName" />
                                <asp:BoundField DataField="category" HeaderText="Category" SortExpression="category" />
                                <asp:BoundField DataField="elearn_courseID" Visible="False" />
                                <asp:HyperLinkField DataNavigateUrlFields="elearn_courseID" DataNavigateUrlFormatString="viewModuleInfo.aspx?id={0}" Target="_blank" Text="View Details" />
                            </Columns>
                        </asp:GridView>
                            </div>

                        </div>

                        <div class="form-group">
                            <strong>
                                <asp:Label runat="server" CssClass="col-lg-1 control-label" Text="Suggested Courses (Max 5)"></asp:Label></strong>
                            <div class="col-lg-5">
                                <asp:SqlDataSource ID="SqlDataSourceCourseCart" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>">
                        </asp:SqlDataSource>
                        <asp:GridView ID="gvCourseCart" runat="server" CssClass="table table-striped table-hover" DataKeyNames="elearn_courseID" EmptyDataText="Please choose a Course first" GridLines="None" AutoGenerateColumns="False" OnRowCommand="gvCourseCart_RowCommand">
                            <Columns>
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <asp:LinkButton ID="btnRemove" runat="server" CausesValidation="false" CommandArgument='<%# Eval("elearn_courseID") %>'><span class="glyphicon glyphicon-minus"></span></asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <input type="hidden" name="elearn_courseID" value='<%# Eval("elearn_courseID") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="elearn_courseName" HeaderText="Name" SortExpression="elearn_courseName" />
                                <asp:BoundField DataField="elearn_courseProvider" HeaderText="Provider" SortExpression="elearn_courseProvider" />
                                <asp:BoundField DataField="hoursAwarded" HeaderText="Learning Hours" SortExpression="hoursAwarded" />
                            </Columns>
                            
                        </asp:GridView>
                            </div>

                        </div>
                    </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="ddlSelectUser" EventName="SelectedIndexChanged" />
                    </Triggers>
                </asp:UpdatePanel>
                <asp:Panel ID="panelError" runat="server" Visible="false">
                    <div class="alert alert-warning alert-dismissible" role="alert">
                        <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <strong>Warning!</strong> You can only add up to a maximum of 5 courses.
                    </div>
                </asp:Panel>
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

                                <asp:Button ID="cfmSubmit" CssClass="btn btn-primary" runat="server" Text="Submit" OnClick="cfmSubmit_Click" />
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
