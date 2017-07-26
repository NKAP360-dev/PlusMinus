﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Masterpage.Master" AutoEventWireup="true" CodeBehind="askEmmaInitializeMsg.aspx.cs" Inherits="LearnHub.askEmmaInitializeMsg" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script>
        $(document).ready(function () {
            $("[data-toggle='tooltip']").tooltip();
        });

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="configure">
        <a href="emmaConfiguration.aspx" id="config"><span class="label label-default"><span class="glyphicon glyphicon-cog"></span>Configuration Menu</span></a>
    </div>

    <div class="container">
        <h2>Configure Initialization Messages</h2>
        <div class="verticalLine"></div>
        <br />

    </div>
    <div class="container">
        <form class="form-horizontal" runat="server">
        <table class="table table-striped table-hover with-pager" id="myTable">
            <thead>
                <tr>
                    <th width="80%">Initialization Message</th>
                    <th>Message Order</th>
                    <th></th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>blahblah</td>
                    <td>
                        <select class="form-control" id="select">
                            <option>1</option>
                            <option>2</option>
                            <option>3</option>
                            <option>4</option>
                            <option>5</option>
                        </select></td>
                    <td><asp:LinkButton ID="Button1" CssClass="btn btn-danger" runat="server" Text="" data-toggle="modal" href="#deleteModal"><span class="glyphicon glyphicon-trash"></span></asp:LinkButton></td>
                </tr>
                <tr>
                    <td>kekeke</td>
                    <td>
                        <select class="form-control" id="select">
                            <option>1</option>
                            <option>2</option>
                            <option>3</option>
                            <option>4</option>
                            <option>5</option>
                        </select></td>
                   <td><asp:LinkButton ID="LinkButton1" CssClass="btn btn-danger" runat="server" Text="" data-toggle="modal" href="#deleteModal"><span class="glyphicon glyphicon-trash"></span></asp:LinkButton></td>
                </tr>

            </tbody>
        </table>
            <div class="wrapper">
                <div class="form-group">
                    <asp:LinkButton ID="saveBtn" CssClass="btn btn-success" runat="server"><span class="glyphicon glyphicon-floppy-saved"></span>&nbsp; Save</asp:LinkButton>
                    <br />
                </div>
                        <strong><asp:Label ID="successMsg" runat="server" CssClass="text-success"><span class="glyphicon glyphicon-ok"></span> Saved successfully</asp:Label></strong><br />
                        <strong><asp:Label ID="errorMsg" runat="server" CssClass="text-danger"><span class="glyphicon glyphicon-remove"></span> Something went wrong</asp:Label></strong>

            </div>
        <div class="verticalLine"></div>
        <br />
            
        <div class="form-group">
            <div class="row">
                <strong>
                        <label for="inputMsg" class="col-lg-3 control-label"><span class="glyphicon glyphicon-question-sign" data-toggle='tooltip' data-placement="left" title="" data-original-title="An Initialization Message is the message you see when you initialize :)"></span>&nbsp;Initialization Message *</label>
                </strong>
                <div class="col-lg-7">
                    <%--Mandatory text field--%>
                    <asp:TextBox ID="inputmsg" runat="server" CssClass="form-control" placeholder="Initialization Message"></asp:TextBox>
                </div>
                <div class="col-lg-1">
                 <asp:Button ID="addBtn" CssClass="btn btn-primary" runat="server" Text="Add"/>
                </div>
            </div>
            <br />
            <div class="row">
                    <div class="wrapper">
                        <strong><asp:Label ID="Label1" runat="server" CssClass="text-success"><span class="glyphicon glyphicon-ok"></span> Added successfully</asp:Label></strong><br />
                        <strong><asp:Label ID="Label2" runat="server" CssClass="text-danger"><span class="glyphicon glyphicon-remove"></span> Something went wrong</asp:Label></strong>
                    </div>
                </div>
        </div>
                <%--Modal for Deletion Confirmation--%>
                <div id="deleteModal" class="modal fade" role="dialog">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title"><span class="glyphicon glyphicon-trash"></span>&nbsp;<b>Delete Message</b></h4>
                    </div>
                    <%--Modal Content--%>
                    <div class="modal-body">
                        <div class="wrapper">                            
                            <h4>Are you sure you want to delete?</h4><br />
                            <asp:Button ID="cfmDelete" CssClass="btn btn-danger" runat="server" Text="Delete"/>
                            <asp:Button ID="Button2" CssClass="btn btn-default" runat="server" class="close" data-dismiss="modal" Text="Cancel"/>
                            
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
