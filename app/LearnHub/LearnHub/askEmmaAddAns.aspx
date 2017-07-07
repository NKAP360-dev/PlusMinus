<%@ Page Title="" Language="C#" MasterPageFile="~/Masterpage.Master" AutoEventWireup="true" CodeBehind="askEmmaAddAns.aspx.cs" Inherits="LearnHub.askEmmaAddAns" %>

<%@ Import Namespace="LearnHub.AppCode.entity" %>
<%@ Import Namespace="LearnHub.AppCode.dao" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .configure {
            position: absolute;
            right: 0px;
            padding: 10px;
        }
    </style>

    <script>

        $(document).ready(function () {
            $('#menu').hide();
        });

        function myFunction() {
            var x = document.getElementById('menu');
            if (x.style.display === 'none') {
                x.style.display = 'block';
            } else {
                x.style.display = 'none';
            }
        }

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <% if (Session["currentUser"] != null)
        {
            User currentUser = (User)Session["currentUser"];

            if (currentUser.getDepartment().Equals("hr"))
            {

    %>

    <div class="configure">
        <a href="#" id="config" onclick="myFunction()"><span class="label label-primary"><span class="glyphicon glyphicon-cog"></span>Configuration Menu</span></a>
    </div>
    <br />
    <div class="configure">
        <ul class="list-group" id="menu">
            <a href="askEmmaAddAns.aspx">
                <li class="list-group-item">Add New Answers
                </li>
            </a>
            <a href="askEmmaEditAns.aspx">
                <li class="list-group-item">Edit Answers
                </li>
            </a>
        </ul>
    </div>

    <%}
        }%>


    <div class="container">
        <h1>Add Answers</h1>
        <div class="verticalLine"></div>
    </div>

    <div class="container">
        <form class="form-horizontal" runat="server">
            <fieldset>
                <legend>Customize answers for Emma</legend>
                <div class="form-group">
                    <strong>
                        <%--Intent--%>
                        <asp:Label ID="lblIntent" CssClass="col-lg-2 control-label" runat="server" Text="Choose an intent*"></asp:Label>
                    </strong>
                    <div class="col-lg-10">
                        <%--Mandatory Choose 1--%>
                        <asp:DropDownList ID="ddlIntent" runat="server" CssClass="form-control"></asp:DropDownList>
                        <br>
                    </div>
                </div>
                <div class="form-group">
                    <strong>
                        <%--Entity--%>
                        <asp:Label ID="lblEntity" CssClass="col-lg-2 control-label" runat="server" Text="Choose an entity to represent"></asp:Label>
                    </strong>
                    <div class="col-lg-10">
                        <%--Optional Choose 1--%>
                        <asp:DropDownList ID="ddlEntity" runat="server" CssClass="form-control"></asp:DropDownList>
                        <br>
                    </div>
                </div>
                <div class="form-group">
                    <strong>
                        <%--Answers--%>
                        <asp:Label ID="lblAnswers" CssClass="col-lg-2 control-label" runat="server" Text="Answers*"></asp:Label>
                    </strong>
                    <div class="col-lg-10">
                        <%--Mandatory text field--%>
                        <asp:TextBox ID="txtAnswers" TextMode="multiline" Columns="50" Rows="5" runat="server" CssClass="form-control" placeholder="Please enter your answers here"></asp:TextBox>
                    </div>
                    <asp:Label ID="Label1" CssClass="col-lg-2 control-label" runat="server" Text="* = Compulsory fields"></asp:Label>
                </div>
                <%--Buttons--%>
                <div class="form-group">
                    <div class="col-lg-10 col-lg-offset-2">
                        <asp:Button ID="submitBtn" CssClass="btn btn-primary" runat="server" Text="Submit" data-toggle="modal" href="#submitModal" OnClientClick="$('#myModal').modal(); return false;"/>
                        <asp:Button ID="resetBtn" CssClass="btn btn-default" runat="server" Text="Clear" data-toggle="modal" href="#cancelModal" OnClientClick="$('#myModal').modal(); return false;"/>
                    </div>
                </div>

               


                <div id="submitModal" class="modal fade" role="dialog">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal">&times;</button>
                                <h4 class="modal-title"><b>Submit Answers</b></h4>
                            </div>
                            <div class="modal-body">
                                <div class="wrapper">
                                    <h4>Are you sure you want to submit?</h4>
                                    <br />
                                    <asp:Button ID="cfmSubmit" CssClass="btn btn-primary" runat="server" Text="Submit" />
                                    <br />
                                </div>
                            </div>
                        </div>

                    </div>
                </div>
                <%--Modal for Cancel Confirmation--%>
                <div id="cancelModal" class="modal fade" role="dialog">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal">&times;</button>
                                <h4 class="modal-title"><b>Clear all contents</b></h4>
                            </div>
                            <%--Modal Content--%>
                            <div class="modal-body">
                                <div class="wrapper">
                                    <h4>Are you sure you want to cancel?<br />
                                        This will clear all fields previously entered!</h4>
                                    <br />
                                    <asp:Button ID="cfmCancel" CssClass="btn btn-primary" runat="server" Text="Clear" />
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
