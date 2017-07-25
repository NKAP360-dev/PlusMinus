<%@ Page Title="" Language="C#" MasterPageFile="~/Masterpage.Master" AutoEventWireup="true" CodeBehind="askEmmaEditAns.aspx.cs" Inherits="LearnHub.askEmmaEditAns" %>

<%@ Import Namespace="LearnHub.AppCode.entity" %>
<%@ Import Namespace="LearnHub.AppCode.dao" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script>

        $(document).ready(function () {
            $("[data-toggle='tooltip']").tooltip();
        });

        /*
        function ValidateRadioButton(sender, args) {
            var gv = document.getElementById("");
            var items = gv.getElementsByTagName('input');
            for (var i = 0; i < items.length; i++) {
                if (items[i].type == "radio") {
                    if (items[i].checked) {
                        args.IsValid = true;
                        return;
                    }
                    else {
                        args.IsValid = false;
                    }
                }
            }
        }
        */

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
        <a href="emmaConfiguration.aspx" id="config"><span class="label label-default"><span class="glyphicon glyphicon-cog"></span>Configuration Menu</span></a>
    </div>
    <br />

    <%}
        }%>


    <div class="container">
        <h1>Edit Answers</h1>
        <div class="verticalLine"></div>
    </div>
    <form class="form-horizontal" runat="server">
    <div class="container">
        <br />
    <table class="table table-striped table-hover ">
  <thead>
    <tr>
      <th>Select</th>
      <th>Answers</th>
      <th>Intent</th>
      <th>Entity</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><asp:RadioButton ID="RadioButton1" runat="server" groupname="select"/></td>
      <td>Column content</td>
      <td>Column content</td>
      <td>Column content</td>
    </tr>
    <tr>
      <td><asp:RadioButton ID="RadioButton2" runat="server" groupname="select"/></td>
      <td>Column content</td>
      <td>Column content</td>
      <td>Column content</td>
    </tr>
        </tbody>
</table>
        <asp:CustomValidator ID="cv_answers" runat="server" EnableClientScript="true" ErrorMessage="Please select an answer" ClientValidationFunction="ValidateRadioButton" ForeColor="Red"></asp:CustomValidator>
        <div class="verticalLine"></div>
      </div>
    <br />

    <div class="container">
        
            <fieldset>
                <legend>Customize answers for Emma</legend>
                <div class="form-group">
                    
                        <%--Intent--%>
                        <label for="ddlIntent" class="col-lg-2 control-label"><span class="glyphicon glyphicon-question-sign"  data-toggle='tooltip' data-placement="left" title="" data-original-title="An Intent is a......"></span> Choose an Intent *</label>
                    
                    <div class="col-lg-10">
                        <%--Mandatory Choose 1--%>
                        <asp:DropDownList ID="ddlIntent" runat="server" disabled="" CssClass="form-control"></asp:DropDownList>
                        <br>
                    </div>
                </div>
                <div class="form-group">
                    <strong>
                        <%--Entity--%>
                        <label for="ddlIntent" class="col-lg-2 control-label"> <span class="glyphicon glyphicon-question-sign" data-toggle='tooltip' data-placement="left" title="" data-original-title="An Entity is a......"></span> Choose an Entity </label>
                    </strong>
                    <div class="col-lg-10">
                        <%--Optional Choose 1--%>
                        <asp:DropDownList ID="ddlEntity" runat="server" disabled="" CssClass="form-control"></asp:DropDownList>
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
                        <asp:RequiredFieldValidator ID="rfv_txtAnswers" runat="server" ErrorMessage="Please enter an answer" ControlToValidate="txtAnswers" ForeColor="Red"></asp:RequiredFieldValidator>
                    </div>
                    <asp:Label ID="Label1" CssClass="col-lg-2 control-label" runat="server" Text="* = Compulsory fields"></asp:Label>
                </div>
                <%--Buttons--%>
                <div class="form-group">
                    <div class="col-lg-10 col-lg-offset-2">
                        <asp:Button ID="submitBtn" CssClass="btn btn-primary" runat="server" Text="Update" data-toggle="modal" href="#updateModal" OnClientClick="$('#myModal').modal(); return false;"/>
                        <asp:Button ID="resetBtn" CssClass="btn btn-default" runat="server" Text="Clear" data-toggle="modal" href="#cancelModal" OnClientClick="$('#myModal').modal(); return false;"/>
                    </div>
                </div>

               


                <div id="updateModal" class="modal fade" role="dialog">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal">&times;</button>
                                <h4 class="modal-title"><b>Update Answers</b></h4>
                            </div>
                            <div class="modal-body">
                                <div class="wrapper">
                                    <h4>Are you sure you want to overwrite the existing answers?</h4>
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
        
    </div>
        </form>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
