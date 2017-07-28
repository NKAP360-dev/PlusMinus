﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Masterpage.Master" AutoEventWireup="true" CodeBehind="createModules.aspx.cs" Inherits="LearnHub.createModules" %>

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
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">
        <h1>Create Module</h1>
        <div class="verticalLine"></div>
    </div>

    <div class="container">
        <form class="form-horizontal" runat="server">
            <fieldset>
                <legend>Input new module information </legend>
                <div class="form-group">
                    <strong>
                        <%--Compulsory/Leadership/Professional--%>
                        <asp:Label ID="moduleTypeLabel" runat="server" CssClass="col-lg-2 control-label" Text="Module Category * "></asp:Label></strong>
                    <div class="col-lg-5">
                        <asp:DropDownList ID="moduleType" runat="server" CssClass="form-control" placeholder="Choose Category *"></asp:DropDownList>
                    </div>
                </div>

                <div class="form-group">
                    <strong>
                        <asp:Label ID="nameOfModuleLabel" runat="server" CssClass="col-lg-2 control-label" Text="Name of Module *"></asp:Label></strong>
                    <div class="col-lg-5">
                        <asp:TextBox ID="nameOfModuleInput" runat="server" CssClass="form-control" placeholder="Module Name"></asp:TextBox>
                    </div>
                </div>

                <div class="form-group">
                    <strong>
                        <asp:Label ID="descriptionModuleLabel" runat="server" CssClass="col-lg-2 control-label" Text="Description of Module *"></asp:Label></strong>
                    <div class="col-lg-5">
                        <asp:TextBox ID="descriptionModuleInput" TextMode="multiline" Columns="50" Rows="5" runat="server" CssClass="form-control" placeholder="Enter module description"></asp:TextBox>
                    </div>
                </div>

                <div class="form-group">
                    <strong>
                        <asp:Label ID="hoursLabel" runat="server" CssClass="col-lg-2 control-label" Text="Hours Awarded *"></asp:Label></strong>
                    <div class="col-lg-5">
                        <div class="input-group">
                            <asp:TextBox ID="hoursInput" runat="server" CssClass="form-control" placeholder="No. of Hours"></asp:TextBox>
                            <span class="input-group-addon">hours </span>
                        </div>
                    </div>
                </div>

                <%--Date-%>
                <%--
                <div class="form-group">
                    <strong>
                        <asp:Label ID="dateLabel" runat="server" CssClass="col-lg-2 control-label" Text="Date"></asp:Label></strong>

                    <div class="col-lg-5">
                        <div class="input-daterange input-group" id="datepicker">
                            <asp:TextBox ID="fromDateInput" runat="server" CssClass="form-control" placeholder="MM/DD/YYYY"></asp:TextBox>
                            <span class="input-group-addon">to</span>
                            <asp:TextBox ID="toDateInput" runat="server" CssClass="form-control" placeholder="MM/DD/YYYY"></asp:TextBox>
                            <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i>
                            </span>
                        </div>
                    </div>
                    <br />

                </div>
                --%>

                <%--Preq--%>
                <div class="form-group">
                    <strong>
                        <asp:Label ID="preqModuleLabel" runat="server" CssClass="col-lg-2 control-label" Text="Module Pre-requisite"></asp:Label></strong>
                    <div class="col-lg-5">
                        <table class="table table-striped table-hover" data-paging="true" data-sorting="true">
                            <thead>
                                <tr>
                                    <th>Module Name</th>
                                    <th>Module Category</th>
                                    <th data-filterable="false" data-sortable="false"></th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>Column content</td>
                                    <td>Column content</td>
                                    <td><%--View Module's Info // viewModuleInfo.aspx--%>
                                        <asp:LinkButton ID="LinkButton2" CssClass="btn btn-success btn-sm pull-right" runat="server" Text=""><span class="glyphicon glyphicon-search"></span></asp:LinkButton></td>

                                </tr>
                                <tr>
                                    <td>Column content</td>
                                    <td>Column content</td>
                                    <td>
                                        <asp:LinkButton ID="LinkButton1" CssClass="btn btn-success btn-sm pull-right" runat="server" Text=""><span class="glyphicon glyphicon-search"></span></asp:LinkButton></td>

                                </tr>
                            </tbody>
                        </table>
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

                <div class="form-group">
                    <br />
                    <div class="wrapper">
                        <asp:Button ID="submitBtn" CssClass="btn btn-primary" runat="server" Text="Submit" data-toggle="modal" href="#submitModal" OnClientClick="return false;" />
                    </div>
                </div>

                <%--Modal for Submission Confirmation--%>
                <div id="submitModal" class="modal fade" role="dialog">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal">&times;</button>
                                <h4 class="modal-title"><b>Create new module</b></h4>
                            </div>
                            <%--Modal Content--%>
                            <div class="modal-body">
                                <div class="wrapper">
                                    <h4>Are you sure you want to submit?</h4>
                                    <br />
                                    <asp:Button ID="cfmSubmit" CssClass="btn btn-primary" runat="server" OnClick="submitBtn_Click" Text="Submit" />
                                    <asp:Button ID="Button2" CssClass="btn btn-default" runat="server" class="close" data-dismiss="modal" Text="Go Back" />
                                    <%--Redirect to viewModuleInfo of newly created course--%>
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
