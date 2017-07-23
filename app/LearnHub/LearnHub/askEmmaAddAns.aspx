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
            $("[data-toggle='tooltip']").tooltip();
        });


        function myFunction() {
            // Declare variables 
            var input, filter, table, tr, td, i;
            input = document.getElementById("myInput");
            filter = input.value.toUpperCase();
            table = document.getElementById("myTable");
            tr = table.getElementsByTagName("tr");

            // Loop through all table rows, and hide those who don't match the search query
            for (i = 0; i < tr.length; i++) {
                td = tr[i].getElementsByTagName("td")[0];
                if (td) {
                    if (td.innerHTML.toUpperCase().indexOf(filter) > -1) {
                        tr[i].style.display = "";
                    } else {
                        tr[i].style.display = "none";
                    }
                }
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
        <a href="emmaConfiguration.aspx" id="config"><span class="label label-primary"><span class="glyphicon glyphicon-cog"></span>Configuration Menu</span></a>
    </div>
    <br />
    

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
                    
                        <%--Intent--%>
                        <label for="ddlIntent" class="col-lg-2 control-label"><span class="glyphicon glyphicon-question-sign"  data-toggle='tooltip' data-placement="left" title="" data-original-title="An Intent is a......"></span> Choose an Intent *</label>
                    
                    <div class="col-lg-10">
                        <%--Mandatory Choose 1--%>
                        <asp:DropDownList ID="ddlIntent" runat="server" CssClass="form-control"></asp:DropDownList>
                        <br>
                        <asp:RequiredFieldValidator ID="rfv_ddlIntent" runat="server" ControlToValidate="courseInput" ErrorMessage="Please Select a Course" InitialValue="--Select--" ForeColor="Red" ValidationGroup="ValidateForm"></asp:RequiredFieldValidator>
                    </div>
                </div>
                <div class="form-group">
                    <strong>
                        <%--Entity--%>
                        <label for="ddlIntent" class="col-lg-2 control-label"> <span class="glyphicon glyphicon-question-sign" data-toggle='tooltip' data-placement="left" title="" data-original-title="An Entity is a......"></span> Choose an Entity to represent </label>
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
                        <asp:RequiredFieldValidator ID="rfv_txtAnswers" runat="server" ErrorMessage="Please enter an answer" ControlToValidate="txtAnswers" ForeColor="Red"></asp:RequiredFieldValidator>
                    </div>
                    <asp:Label ID="Label1" CssClass="col-lg-2 control-label" runat="server" Text="* = Compulsory fields"></asp:Label>
                </div>
                <%--Buttons--%>
                <br />
                <div class="wrapper">
                <div class="form-group">
                    
                        <asp:Button ID="submitBtn" CssClass="btn btn-primary" runat="server" Text="Done" data-toggle="modal" href="#submitModal" OnClientClick="$('#myModal').modal(); return false;"/>
                    <%--Make success message appear after user click submit button IN MODAL, stay at this page so that user can continue submitting answers--%>
                    <p class="text-success"><strong><span class="glyphicon glyphicon-ok"></span> Answer has been successfully added!</strong></p>
                    
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
            </fieldset>
        </form>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
