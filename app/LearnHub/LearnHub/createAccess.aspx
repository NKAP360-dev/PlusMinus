<%@ Page Title="" Language="C#" MasterPageFile="~/Masterpage.Master" AutoEventWireup="true" CodeBehind="createAccess.aspx.cs" Inherits="LearnHub.createAccess" MaintainScrollPositionOnPostback="true" %>
<%@ Import Namespace="LearnHub.AppCode.dao" %>
<%@ Import Namespace="LearnHub.AppCode.entity" %>

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
    <script type="text/javascript">
        function checkForm_Clicked(source, args) {
            Page_ClientValidate('ValidateForm');
            //Page_ClientValidate();

            if (!Page_IsValid) {
                document.getElementById('<%= lblErrorMsgFinal.ClientID %>').style.display = 'inherit';
                document.getElementById('<%= lblErrorMsgFinal.ClientID %>').innerHTML = "You have not filled up all of the required fields";
                //Page_ClientValidate('summaryGroup');
                document.getElementById('<%= btnCfmSubmit.ClientID %>').disabled = true;
                console.log("The end");
            }
            else {
                document.getElementById('<%= lblErrorMsgFinal.ClientID %>').innerHTML = "";
                document.getElementById('<%= btnCfmSubmit.ClientID %>').disabled = false;
            }
            return false;
        }

        function ValidateModuleList(source, args) {
            var chkListModules = document.getElementById('<%= cblRoles.ClientID %>');
            var chkListinputs = chkListModules.getElementsByTagName("input");
            for (var i = 0; i < chkListinputs.length; i++) {
                if (chkListinputs[i].checked) {
                    args.IsValid = true;
                    return;
                }
            }
            args.IsValid = false;
        }

        function openModal() {
            console.log("submitModal");
            $("#submitModal").modal();
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <ul class="breadcrumb">
        <li><a href="home.aspx">Home</a></li>
        <li><a href="siteConfig.aspx">Configuration Settings</a></li>
        <li><a href="manageUsers.aspx">Manage Users</a></li>
        <li class="active">Create Users</li>
    </ul>
    <div class="container">
        <h1>Create Users</h1>
        <% 
            User currentUser = (User)Session["currentUser"];
            Boolean superuser = false;
            foreach (string s in currentUser.getRoles())
            {
                if (s.Equals("superuser"))
                {
                    superuser = true;
                }
            }
            if (currentUser != null && superuser)
            {
        %>

        <div class="dropdown" style="float: right;">
            <button class="dropbtn" onclick="return false;"><span class="glyphicon glyphicon-option-horizontal"></span></button>
            <div class="dropdown-content" style="right: 0;">
                 <div class="dropHeader">Users Management</div>
                <a href="manageUsers.aspx"><span class="glyphicon glyphicon-user"></span>&nbsp;&nbsp;Manage Users</a>
                <a href="createAccess.aspx"><span class="glyphicon glyphicon-plus"></span>&nbsp;&nbsp;Add Users</a>
            </div>
        </div>

        <%} %>
        <div class="verticalLine"></div>
    </div>

    <div class="container">
        <form class="form-horizontal" runat="server" enablepartialrendering="true">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            
            <fieldset>
                <legend>Input information for new user</legend>
                <h4>Account Information</h4>
                <div class="form-group required">
                    <strong>
                        <asp:Label runat="server" CssClass="col-lg-2 control-label" Text="Username"></asp:Label></strong>
                    <div class="col-lg-5">
                        <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control" placeholder="Username"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfv_txtUsername" runat="server" ErrorMessage="Please input a Username" ControlToValidate="txtUsername" ForeColor="Red" ValidationGroup="ValidateForm" Display="Dynamic"></asp:RequiredFieldValidator>
                    </div>
                </div>
                <div class="form-group required">
                    <strong>
                        <asp:Label runat="server" CssClass="col-lg-2 control-label" Text="Password"></asp:Label></strong>
                    <div class="col-lg-5">
                        <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" placeholder="Password" TextMode="Password"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfv_txtPassword" runat="server" ErrorMessage="Please input a password" ControlToValidate="txtPassword" ForeColor="Red" ValidationGroup="ValidateForm" Display="Dynamic"></asp:RequiredFieldValidator>
                        <asp:CustomValidator ID="cv_txtPassword" runat="server" ErrorMessage="Your password do not match the requirements" OnServerValidate="cv_checkPasswordFormat_ServerValidate" ControlToValidate ="txtPassword" ForeColor="Red" ValidationGroup="ValidateForm" Display="Dynamic" ></asp:CustomValidator>
                    </div>
                </div>
                <div class="form-group required">
                    <strong>
                        <asp:Label runat="server" CssClass="col-lg-2 control-label" Text="Re-enter Password"></asp:Label></strong>
                    <div class="col-lg-5">
                        <asp:TextBox ID="txtPassword2" runat="server" CssClass="form-control" placeholder="Re-enter Password" TextMode="Password"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfv_txtPassword2" runat="server" ErrorMessage="Please input a password" ControlToValidate="txtPassword2" ForeColor="Red" ValidationGroup="ValidateForm" Display="Dynamic"></asp:RequiredFieldValidator>
                        <asp:CompareValidator ID="comp_matchPass" runat="server" ErrorMessage="Please re-enter the same password" ControlToCompare="txtPassword" ControlToValidate="txtPassword2" Operator="Equal" ValidationGroup="ValidateForm" Display="Dynamic" ForeColor="Red"></asp:CompareValidator>
                    </div>
                </div>
                <br />
                <div class="form-group">
                        <h6> <asp:Label runat="server" CssClass="control-label text-muted" Text="Password must include at least 8 characters, inclusive of 1 upper case letter, 1 lower case letter, 1 numerical character and 1 special character."></asp:Label></h6>
                    </div>
                <br />
                <h4>User Information</h4>
                <div class="form-group required">
                    <strong>
                        <asp:Label runat="server" CssClass="col-lg-2 control-label" Text="Name"></asp:Label></strong>
                    <div class="col-lg-5">
                        <asp:TextBox ID="txtName" runat="server" CssClass="form-control" placeholder="Name"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfv_txtName" runat="server" ErrorMessage="Please input a Name" ControlToValidate="txtName" ForeColor="Red" ValidationGroup="ValidateForm" Display="Dynamic"></asp:RequiredFieldValidator>
                    </div>
                </div>
                <div class="form-group required">
                    <strong>
                        <asp:Label runat="server" CssClass="col-lg-2 control-label" Text="Contact No"></asp:Label></strong>
                    <div class="col-lg-5">
                        <asp:TextBox ID="txtContactNo" runat="server" CssClass="form-control" placeholder="Contact No" TextMode="Number"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfv_txtContactNo" runat="server" ErrorMessage="Please input a Contact Number" ControlToValidate="txtContactNo" ForeColor="Red" ValidationGroup="ValidateForm" Display="Dynamic"></asp:RequiredFieldValidator>
                    </div>
                </div>
                <div class="form-group required">
                    <strong>
                        <asp:Label runat="server" CssClass="col-lg-2 control-label" Text="Address"></asp:Label></strong>
                    <div class="col-lg-5">
                        <asp:TextBox ID="txtAddress" runat="server" CssClass="form-control" placeholder="Address"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfv_txtAddress" runat="server" ErrorMessage="Please input an Address" ControlToValidate="txtAddress" ForeColor="Red" ValidationGroup="ValidateForm" Display="Dynamic"></asp:RequiredFieldValidator>
                    </div>
                </div>
                <div class="form-group required">
                    <strong>
                        <asp:Label runat="server" CssClass="col-lg-2 control-label" Text="Email"></asp:Label></strong>
                    <div class="col-lg-5">
                        <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" placeholder="Email"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfv_txtEmail" runat="server" ErrorMessage="Please input an Email Address" ControlToValidate="txtEmail" ForeColor="Red" ValidationGroup="ValidateForm" Display="Dynamic"></asp:RequiredFieldValidator>
                        <asp:CustomValidator ID="cv_checkEmailExist" runat="server" ErrorMessage="The email address is already in use" ControlToValidate="txtEmail" ForeColor="Red" ValidationGroup="ValidateForm" Display="Dynamic" OnServerValidate="cv_checkEmailExist_ServerValidate"></asp:CustomValidator>
                    </div>
                </div>
                <div class="form-group required">
                    <strong>
                        <asp:Label runat="server" CssClass="col-lg-2 control-label" Text="Department"></asp:Label></strong>
                    <div class="col-lg-5">
                        <asp:DropDownList ID="lblDept" runat="server" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="lblDept_SelectedIndexChanged">
                            <asp:ListItem Value="none">--select--</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                </div>
                <div class="form-group required">
                    <strong>
                        <asp:Label runat="server" CssClass="col-lg-2 control-label" Text="Job Title"></asp:Label></strong>
                    <div class="col-lg-5">
                        <asp:TextBox ID="txtJobTitle" runat="server" CssClass="form-control" placeholder="Job Title"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfv_txtJobTitle" runat="server" ErrorMessage="Please input a Job Title" ControlToValidate="txtJobTitle" ForeColor="Red" ValidationGroup="ValidateForm" Display="Dynamic"></asp:RequiredFieldValidator>
                    </div>
                </div>
                <div class="form-group">
                    <strong>
                        <asp:Label runat="server" CssClass="col-lg-2 control-label" Text="Supervisor"></asp:Label></strong>
                    <div class="col-lg-5">
                        <asp:DropDownList ID="ddlSup" runat="server" CssClass="form-control">
                            <asp:ListItem>--select--</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                </div>
                <br />
                <h4>User Access Rights</h4>
                <div class="form-group required">
                    <strong>
                        <asp:Label runat="server" CssClass="col-lg-2 control-label" Text="Roles"></asp:Label></strong>
                    <div class="col-lg-5">
                        <asp:CheckBoxList ID="cblRoles" runat="server">
                            <asp:ListItem Value="superuser">superuser</asp:ListItem>
                            <asp:ListItem Value="course creator">course creator</asp:ListItem>
                            <asp:ListItem Value="content creator">content creator</asp:ListItem>
                            <asp:ListItem Value="user">user</asp:ListItem>
                        </asp:CheckBoxList>
                        <asp:CustomValidator runat="server" ID="cvmodulelist" ClientValidationFunction="ValidateModuleList" ErrorMessage="Please Select at least One Role" ForeColor="Red" ValidationGroup="ValidateForm" Display="Dynamic" ></asp:CustomValidator>
                    </div>
                </div>
                <div class="form-group">
                    <div class="wrapper">
                        <br />
                        <asp:Button ID="btnSubmit" CssClass="btn btn-primary" runat="server" Text="Create User" onclick="checkForm" UseSubmitBehavior="False" ValidationGroup="ValidateForm" causesValidation="true"/>
                    </div>
                </div>
            </fieldset>

            <%--Modal for Submission Confirmation--%>
            <div id="submitModal" class="modal fade" role="dialog">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                            <h4 class="modal-title"><b>Create new user</b></h4>
                        </div>
                        <%--Modal Content--%>
                        <div class="modal-body">
                            <div class="wrapper">
                                <h4>Are you sure you want to submit?</h4>
                                <br />
                                <asp:Label ID="lblErrorMsgFinal" runat="server" CssClass="text-danger" Visible="True"></asp:Label>
                                <br />
                                <asp:Button ID="btnCfmSubmit" CssClass="btn btn-primary" runat="server" Text="Submit" OnClick="submit_Click" />
                                <asp:Button ID="Button2" CssClass="btn btn-default" runat="server" class="close" data-dismiss="modal" Text="Go Back" />
                                <br />
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </ContentTemplate>
        <Triggers>
            <asp:AsyncPostBackTrigger ControlID="lblDept" EventName="SelectedIndexChanged" />
        </Triggers>
    </asp:UpdatePanel>
    
        </form>
    </div>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
