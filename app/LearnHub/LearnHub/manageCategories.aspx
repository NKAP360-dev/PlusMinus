<%@ Page Title="" Language="C#" MasterPageFile="~/Masterpage.Master" AutoEventWireup="true" CodeBehind="manageCategories.aspx.cs" Inherits="LearnHub.manageCategories" %>

<%@ Import Namespace="LearnHub.AppCode.entity" %>
<%@ Import Namespace="LearnHub.AppCode.dao" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="/Scripts/footable.bootstrap.min.css" rel="stylesheet" />
    <script src="/Scripts/footable.min.js"></script>
    <script>
        $(document).ready(function () {
            $('#menu').hide();
        });

        function configuration() {
            var x = document.getElementById('menu');
            if (x.style.display === 'none') {
                x.style.display = 'block';
            } else {
                x.style.display = 'none';
            }
        }

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


        function checkForm_Clicked(source, args) {

            Page_ClientValidate('ValidateForm');
            //Page_ClientValidate();

            if (!Page_IsValid) {
                document.getElementById('<%= lblErrorMsgFinal.ClientID %>').style.display = 'inherit';
                document.getElementById('<%= lblErrorMsgFinal.ClientID %>').innerHTML = "You have not filled up all of the required fields";
                //Page_ClientValidate('summaryGroup');
                document.getElementById('<%= btnConfirmSubmit.ClientID %>').disabled = true;
                console.log("The end");
            }
            else {
                document.getElementById('<%= lblErrorMsgFinal.ClientID %>').innerHTML = "";
                document.getElementById('<%= btnConfirmSubmit.ClientID %>').disabled = false;
            }
            return false;
        }
    </script>
    <style>
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
  <li class="active">Manage Module Category</li>
  </ul>

    <div class="container">
        <h1>Module Category
                        <button type="button" data-toggle="collapse" data-target="#addForm" class="btn btn-success"><span class="glyphicon glyphicon-plus"></span>&nbsp; New</button>

            <%
                User currentUser = (User)Session["currentUser"];
                if (currentUser != null && (currentUser.getRole().Equals("course creator") || currentUser.getRole().Equals("superuser")))
                {
            %>
            <a href="#" id="config" onclick="configuration()" class="btn btn-default pull-right"><span class="glyphicon glyphicon-option-horizontal"></span></a>
        </h1>
        <div class="configure">
            <ul class="list-group" id="menu" style="display: none;">
                <a href="createModules.aspx">
                    <li class="list-group-item"><span class="glyphicon glyphicon-book"></span>&emsp;Create New Modules
                    </li>
                </a>
                <a href="manageCategories.aspx">
                    <li class="list-group-item"><span class="glyphicon glyphicon-bookmark"></span>&emsp;Manage Module Categories
                    </li>
                </a>
                <a href="viewCreatedModules.aspx">
                    <li class="list-group-item"><span class="glyphicon glyphicon-search"></span>&emsp;View My Created Modules
                    </li>
                </a>
            </ul>
        </div>
        <%
            }
        %>
        <div class="verticalLine"></div>
    </div>


    <div class="container">
        <form class="form-horizontal" runat="server">
            <div id="addForm" class="collapse">
                <fieldset>
                    <br />
                    <%--Inputs--%>
                    <div class="form-group required">
                        <label for="txtCategory" class="col-lg-2 control-label">Category Name</label>
                        <div class="col-lg-10">
                            <asp:TextBox ID="txtCategory" runat="server" CssClass="form-control" placeholder="Category Name"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfv_txtCategory" runat="server" ErrorMessage="Please enter a category name" ControlToValidate="txtCategory" ForeColor="Red" ValidationGroup="ValidateForm"></asp:RequiredFieldValidator>
                            <br>
                        </div>
                    </div>
                    <br />
                    <%--Buttons--%>
                    <div class="wrapper">
                        <div class="form-group">

                            <asp:Button ID="btnSubmit" CssClass="btn btn-primary" runat="server" Text="Create" data-toggle="modal" href="#submitModal" OnClientClick="return checkForm_Clicked();" CausesValidation="True" UseSubmitBehavior="False" />
                        </div>
                        
                    </div>
                </fieldset>
                <div class="verticalLine"></div>
                <br />
            </div>

            <table class="table table-striped table-hover" id="catTable" data-paging="true" data-sorting="true" data-filtering="true">
                <thead>
                    <tr>
                        <th id="categories" width="80%">Current Module Categories</th>
                        <th id="status" width="10%">Status</th>
                        <th data-filterable="false" data-sortable="false" width="10%"></th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        Course_elearnCategoryDAO cecDAO = new Course_elearnCategoryDAO();
                        List<CourseCategory> categories = cecDAO.getAllCategory();
                        foreach (CourseCategory cc in categories)
                        {
                            Response.Write("<tr>");
                            Response.Write($"<td>{cc.category}</td>");
                            Response.Write($"<td>{cc.status}</td>");
                            Response.Write($"<td><a href=\"/editCategories.aspx?id={cc.categoryID}\" class=\"btn btn-info btn-sm pull-right\"><span class=\"glyphicon glyphicon-pencil\"></span></a></td>");
                            Response.Write("</tr>");
                        }
                    %>
                </tbody>
            </table>



            <%--Modal for Submission Confirmation--%>
            <div id="submitModal" class="modal fade" role="dialog">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                            <h4 class="modal-title"><b>Create New Module Category</b></h4>
                        </div>
                        <div class="modal-body">
                            <div class="wrapper">
                                <h4>Are you sure you want to proceed?</h4>
                                <br />
                                <asp:Label ID="lblErrorMsgFinal" runat="server" CssClass="text-danger" Visible="True"></asp:Label>
                                <br />
                                <asp:Button ID="btnConfirmSubmit" CssClass="btn btn-primary" runat="server" Text="Submit" OnClick="btnConfirmSubmit_Click"/>
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
