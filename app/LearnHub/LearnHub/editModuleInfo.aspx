<%@ Page Title="" Language="C#" MasterPageFile="~/Masterpage.Master" AutoEventWireup="true" CodeBehind="editModuleInfo.aspx.cs" Inherits="LearnHub.editModuleInfo" %>

<%@ Register Assembly="CKEditor.NET" Namespace="CKEditor.NET" TagPrefix="CKEditor" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.3.0/css/datepicker.css" rel="stylesheet" type="text/css" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.3.0/js/bootstrap-datepicker.js"></script>
    <link href="/Scripts/footable.bootstrap.min.css" rel="stylesheet" />
    <script src="/Scripts/footable.min.js"></script>


    <script type="text/javascript">
        $(function () {
            $('.input-daterange').datepicker({
                autoclose: true
            });
        });

        $(function () {
            $('.input-group.date').datepicker({
                calendarWeeks: true,
                todayHighlight: true,
                autoclose: true
            });
        });


        jQuery(function ($) {
            $('.table').footable({
                "paging": {
                    "size": 5 <%--Change how many rows per page--%>
                },
                "filtering": {
                    "position": "left"
                }
            });
        });


    </script>

    <style>
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

        .breadcrumb {
            padding-top: 15px;
            margin-bottom: 0px;
            list-style: none;
            background-color: white;
            border-radius: 0px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <ul class="breadcrumb">
        <li><a href="home.aspx">Home</a></li>
        <li><a href="viewAllModule.aspx">Modules</a></li>
        <li><a href="viewModuleInfo.aspx?id=<%=Request.QueryString["id"]%>">
            <asp:Label ID="lblBreadcrumbCourseName" runat="server" Text="courseName"></asp:Label></a></li>
        <li class="active">Edit Module</li>

    </ul>


    <div class="container">
        <h1>Edit Module</h1>
        <div class="verticalLine"></div>
    </div>

    <div class="container">
        <form class="form-horizontal" runat="server">
            <fieldset>
                <legend>Edit current module information </legend>
                <div class="form-group required">
                    <strong>
                        <%--Compulsory/Leadership/Professional--%>
                        <asp:Label ID="moduleTypeLabel" runat="server" CssClass="col-lg-2 control-label" Text="Module Category"></asp:Label></strong>
                    <div class="col-lg-5">
                        <asp:DropDownList ID="moduleType" runat="server" CssClass="form-control" placeholder="Choose Category *" DataSourceID="SqlDataSourceCourseCategory" DataTextField="category" DataValueField="categoryID"></asp:DropDownList>
                        <asp:SqlDataSource ID="SqlDataSourceCourseCategory" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" SelectCommand="SELECT * FROM [Elearn_courseCategory]"></asp:SqlDataSource>
                    </div>
                </div>

                <div class="form-group required">
                    <strong>
                        <asp:Label ID="nameOfModuleLabel" runat="server" CssClass="col-lg-2 control-label" Text="Name of Module"></asp:Label></strong>
                    <div class="col-lg-5">
                        <asp:TextBox ID="nameOfModuleInput" runat="server" CssClass="form-control" placeholder="Module Name"></asp:TextBox>
                    </div>
                </div>

                <div class="form-group required">
                    <strong>
                        <asp:Label ID="descriptionModuleLabel" runat="server" CssClass="col-lg-2 control-label" Text="Description of Module"></asp:Label></strong>
                    <div class="col-lg-5">
                        <%--<asp:TextBox ID="descriptionModuleInput" TextMode="multiline" Columns="50" Rows="5" runat="server" CssClass="form-control" placeholder="Enter module description"></asp:TextBox>--%>
                        <CKEditor:CKEditorControl ID="descriptionModuleInput" runat="server"></CKEditor:CKEditorControl>

                    </div>
                </div>

                <div class="form-group required">
                    <strong>
                        <asp:Label ID="hoursLabel" runat="server" CssClass="col-lg-2 control-label" Text="Learning Hours"></asp:Label></strong>
                    <div class="col-lg-5">
                        <div class="input-group">
                            <asp:TextBox ID="hoursInput" runat="server" CssClass="form-control" placeholder="No. of Hours" TextMode="Number"></asp:TextBox>
                            <span class="input-group-addon">hours </span>
                        </div>
                    </div>
                </div>

                <div class="form-group">
                    <strong>
                        <asp:Label ID="Label1" runat="server" CssClass="col-lg-2 control-label" Text="Target Audience"></asp:Label></strong>
                    <div class="col-lg-5">
                        <asp:TextBox ID="txtTargetAudience" runat="server" CssClass="form-control" placeholder="Target Audience"></asp:TextBox>
                    </div>
                </div>

                <%-- No external vendors based on latest requirement as of 24th July
                <div class="form-group">
                    <strong>
                        <asp:Label ID="courseProviderLabel" runat="server" CssClass="col-lg-2 control-label" Text="Course Provider"></asp:Label></strong>
                    <div class="col-lg-10">
                        <div class="radio">
                            <label>
                                <asp:RadioButtonList ID="courseProvider" runat="server" Enabled="True">
                                    <asp:ListItem id="in" runat="server" Value="inhouse" Text="In house" />
                                    <asp:ListItem id="ex" runat="server" Value="external" Text="External" />
                                </asp:RadioButtonList>
                            </label>
                        </div>
                    </div>
                    

                    <%--Empty label for formatting purposes%>
                    <asp:Label ID="empty1" runat="server" CssClass="col-lg-2 control-label" Text=""></asp:Label>
                    <div class="col-lg-5">
                        <asp:TextBox ID="externalCourseProvider" runat="server" CssClass="form-control" placeholder="If external, please specify"></asp:TextBox>
                    </div>
                </div>
                --%>

                <%--Date--%>
                <div class="form-group required">
                    <strong>
                        <asp:Label ID="dateLabel" runat="server" CssClass="col-lg-2 control-label" Text="Date to Display"></asp:Label></strong>

                    <div class="col-lg-5">
                        <div class="input-daterange input-group" id="datepicker">
                            <asp:TextBox ID="fromDateInput" runat="server" CssClass="form-control" placeholder="MM/DD/YYYY"></asp:TextBox>
                            <span class="input-group-addon">to</span>
                            <asp:TextBox ID="toDateInput" runat="server" CssClass="form-control" placeholder="MM/DD/YYYY"></asp:TextBox>
                            <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i>
                            </span>
                        </div>
                    </div>


                </div>



                <%--Preq--%>
                <div class="form-group">
                    <strong>
                         <a href="javascript:void(0);" class="col-lg-2 control-label" data-toggle="collapse" data-target="#preq"">Module Prerequisite Selection </a></strong>

                    <div class="col-lg-5">
                        <div id="preq" class="collapse">
                            <%--Replace from here--%>
                            <table class="table table-striped table-hover">
                                <thead>
                                    <tr>
                                        <th></th>
                                        <th>Prequisite Module Name</th>
                                        <th>Category</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td><asp:LinkButton ID="btnAdd" runat="server"><span class="glyphicon glyphicon-plus"></span></asp:LinkButton></td>
                                        <td>I am not a gridview</td>
                                        <td>Please replace me with gridview</td>
                                    </tr>
                                </tbody>
                            </table>
                            <%--to here--%>
                            <h6><em>Click on "+" to select module as a prerequisite module</em></h6>


                            <br />
                        </div>

                        <%--Replace from here--%>
                        <table class="table table-striped table-hover">
                            <thead>
                                <tr>
                                    <th></th>
                                    <th>Prequisite Module Name</th>
                                    <th>Category</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td><asp:LinkButton ID="btnRemove" runat="server"><span class="glyphicon glyphicon-minus"></span></asp:LinkButton></td>
                                    <td>I am not a gridview</td>
                                    <td>Please replace me with gridview</td>
                                </tr>
                            </tbody>
                        </table>
                        <%--to here--%>
                        <h6><em>Click on "Module Prerequisite Selection" to choose prerequisite modules</em></h6>
                    </div>
                </div>


                <div class="form-group">
                    <br />
                    <div class="wrapper">
                        <asp:Button ID="submitBtn" CssClass="btn btn-primary" runat="server" Text="Save Changes" data-toggle="modal" href="#submitModal" OnClientClick="return false;" />
                        <%--READ ME: If course status = activated, show deactivate button
                                     If course status = deactivated, show activate button--%>
                        <asp:Button ID="btnDeactivate" CssClass="btn btn-warning" runat="server" Text="Deactivate Module" data-toggle="modal" href="#deactivateModal" OnClientClick="return false;" />
                        <asp:Button ID="btnActivate" CssClass="btn btn-success" runat="server" Text="Activate Module" data-toggle="modal" href="#activateModal" OnClientClick="return false;" />
                    </div>
                </div>

                <%--Modal for Submission Confirmation--%>
                <div id="submitModal" class="modal fade" role="dialog">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal">&times;</button>
                                <h4 class="modal-title"><b>Save Changes</b></h4>
                            </div>
                            <%--Modal Content--%>
                            <div class="modal-body">
                                <div class="wrapper">
                                    <h4>Are you sure you want to save existing changes?</h4>
                                    <br />
                                    <asp:Button ID="cfmSubmit" CssClass="btn btn-primary" runat="server" Text="Save changes" OnClick="cfmSubmit_Click" />
                                    <asp:Button ID="Button3" CssClass="btn btn-default" runat="server" class="close" data-dismiss="modal" Text="Go Back" />
                                    <%--Redirect to viewModuleInfo of newly created course--%>
                                    <br />
                                </div>
                            </div>
                        </div>

                    </div>
                </div>

                <%--Modal for Deactivation Confirmation--%>
                <div id="deactivateModal" class="modal fade" role="dialog">
                    <div class="modal-dialog">
                        <div class="modal-content panel-warning">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal">&times;</button>
                                <h4 class="modal-title"><b>Deactivate this module</b></h4>
                            </div>
                            <%--Modal Content--%>
                            <div class="modal-body">
                                <div class="wrapper">
                                    <h4>Are you sure you want to deactivate this module?</h4>
                                    <br />
                                    <asp:Button ID="btnCfmDeactivate" CssClass="btn btn-warning" runat="server" Text="Deactivate" />
                                    <asp:Button ID="Button2" CssClass="btn btn-default" runat="server" class="close" data-dismiss="modal" Text="Go Back" />
                                    <br />
                                </div>
                            </div>
                        </div>

                    </div>
                </div>
           
                <%--Modal for Activation Confirmation--%>
                <div id="activateModal" class="modal fade" role="dialog">
                    <div class="modal-dialog">
                        <div class="modal-content panel-warning">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal">&times;</button>
                                <h4 class="modal-title"><b>Activate this module</b></h4>
                            </div>
                            <%--Modal Content--%>
                            <div class="modal-body">
                                <div class="wrapper">
                                    <h4>Are you sure you want to activate this module?</h4>
                                    <br />
                                    <asp:Button ID="btnCfmActivate" CssClass="btn btn-success" runat="server" Text="Activate" />
                                    <asp:Button ID="Button5" CssClass="btn btn-default" runat="server" class="close" data-dismiss="modal" Text="Go Back" />
                                    <br />
                                </div>
                            </div>
                        </div>

                    </div>
                </div>
    
            </fieldset>
        </form>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
