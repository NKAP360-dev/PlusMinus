<%@ Page Title="" Language="C#" MasterPageFile="~/Masterpage.Master" AutoEventWireup="true" CodeBehind="editNews.aspx.cs" Inherits="LearnHub.editNews" %>

<%@ Register Assembly="CKEditor.NET" Namespace="CKEditor.NET" TagPrefix="CKEditor" %>

<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Collections" %>
<%@ Import Namespace="LearnHub.AppCode.dao" %>
<%@ Import Namespace="LearnHub.AppCode.entity" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
<script src="//cdn.ckeditor.com/4.7.3/full/ckeditor.js"></script>
    <style>
        .breadcrumb {
            padding-top: 15px;
            margin-bottom: 10px;
            list-style: none;
            background-color: white;
            border-radius: 0px;
        }
    </style>
    <script>
        function limitText(limitField, limitNum) {
            var limitCount = document.getElementById("<%=countdown.ClientID%>");
            if (limitField.value.length > limitNum) {
                limitField.value = limitField.value.substring(0, limitNum);
            } else {
                limitCount.value = limitNum - limitField.value.length;
            }


        }

        function ValidateModuleDescription(sender, args) {
            console.log("validateModuleDesc");
            var moduleDescription = document.getElementById("<%= descriptionModuleInput.ClientID %>").value;
            console.log("moduledesc" + moduleDescription);
            if (moduleDescription == "") {
                console.log("no desc");
                args.IsValid = false;
            }
            else {
                console.log("Yes desc");
                args.IsValid = true;
            }
        }
        function openModal() {
            console.log("submitModal");
            $("#submitModal").modal();
        }

        function checkForm_Clicked(source, args) {

            Page_ClientValidate('ValidateForm');
            //Page_ClientValidate();

            if (!Page_IsValid) {
                document.getElementById('<%= lblErrorMsgFinal.ClientID %>').style.display = 'inherit';
                document.getElementById('<%= lblErrorMsgFinal.ClientID %>').innerHTML = "You have not filled up all of the required fields";
                //Page_ClientValidate('summaryGroup');
                document.getElementById('<%= cfmSave.ClientID %>').disabled = true;
                console.log("The end");
            }
            else {
                document.getElementById('<%= lblErrorMsgFinal.ClientID %>').innerHTML = "";
                document.getElementById('<%= cfmSave.ClientID %>').disabled = false;
            }
            return false;
        }
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
  <ul class="breadcrumb">
        <li><a href="home.aspx">Home</a></li>
        <li><a href="manageNews.aspx">Manage News</a></li>
        <li class="active">Edit News</li>
    </ul>

    <form class="form-horizontal" runat="server">
        <div class="container">
            <h1>Edit News
            </h1>

            <%
                User currentUser = (User)Session["currentUser"];
                Boolean superuser = false;
                Boolean content_creator = false;
                if (currentUser != null)
                {
                    foreach (string s in currentUser.getRoles())
                    {
                        if (s.Equals("superuser"))
                        {
                            superuser = true;
                        }
                        else if (s.Equals("content creator"))
                        {
                            content_creator = true;
                        }
                    }
                    if (currentUser != null && (content_creator || superuser))
                    {
            %>
            <div class="dropdown" style="float: right;">
                <button class="dropbtn" onclick="return false;"><span class="glyphicon glyphicon-option-horizontal"></span></button>
                <div class="dropdown-content" style="right: 0;">
                    <div class="dropHeader">Resource Management</div>
                    <a href="editAboutUs.aspx"><span class="glyphicon glyphicon-pencil"></span>&nbsp;&nbsp;Edit About Us</a>
                    <a href="manageArticles.aspx"><span class="glyphicon glyphicon-duplicate"></span>&nbsp;&nbsp;Manage Articles</a>
                    <a href="manageUsefulLinks.aspx"><span class="glyphicon glyphicon-globe"></span>&nbsp;&nbsp;Manage Links</a>
                    <a href="manageContactUs.aspx"><span class="glyphicon glyphicon-earphone"></span>&nbsp;&nbsp;Manage Contact Us</a>
                    <a href="uploadTrainingCalendar.aspx"><span class="glyphicon glyphicon-calendar"></span>&nbsp;&nbsp; Upload Training Calendar</a>
                    <a href="manageNewsBanners.aspx"><span class="glyphicon glyphicon-picture"></span>&nbsp;&nbsp; Manage News Banners</a>
                    <a href="manageNews.aspx"><span class="glyphicon glyphicon-blackboard"></span>&nbsp;&nbsp; Manage News</a>

                </div>
            </div>

            <%
                    }
                }
            %>

            <div class="verticalLine"></div>
            <br />

            <div class="form-group required">
                <strong>
                    <asp:Label runat="server" CssClass="col-lg-2 control-label" Text="News Type"></asp:Label></strong>
                <div class="col-lg-9">
                    <asp:DropDownList ID="ddlType" runat="server" CssClass="form-control">
                        <asp:ListItem Text="-- Select --" Selected="true" Value="none"></asp:ListItem>
                        <asp:ListItem>News</asp:ListItem>
                        <asp:ListItem>Update</asp:ListItem>
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator ID="rfv_ddlType" runat="server" ControlToValidate="ddlType" ErrorMessage="Please select a News Type" InitialValue="none" ForeColor="Red" Display="Dynamic" ValidationGroup="ValidateForm"></asp:RequiredFieldValidator>
                </div>
            </div>

            <div class="form-group required">
                <strong>
                    <asp:Label runat="server" CssClass="col-lg-2 control-label" Text="News Title"></asp:Label></strong>
                <div class="col-lg-9">
                    <asp:TextBox ID="txtTitle" runat="server" CssClass="form-control" placeholder="Banner Name"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfv_txtTitle" runat="server" ErrorMessage="Please enter a Title" ControlToValidate="txtTitle" ForeColor="Red" Display="Dynamic" ValidationGroup="ValidateForm"></asp:RequiredFieldValidator>
                </div>
            </div>

            <div class="form-group">
                <strong>
                    <asp:Label runat="server" CssClass="col-lg-2 control-label" Text="Upload News Image"></asp:Label></strong>
                <div class="col-lg-9">
                    <asp:FileUpload ID="FileUpload1" runat="server" />
                    <asp:RequiredFieldValidator ID="rfv_FileUpload1" runat="server" ErrorMessage="Please select an item to upload!" ControlToValidate="FileUpload1" ForeColor="Red" Display="Dynamic" ValidationGroup="ValidateForm"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator id="reg_FileUpload1" runat="server" ErrorMessage="Only jpeg and png file is allowed!" ValidationExpression ="^.+(.jpeg|.JPEG|.jpg|.JPG|.png|.PNG)$" ControlToValidate="FileUpload1" ForeColor="Red" Display="Dynamic" ValidationGroup="ValidateForm"> </asp:RegularExpressionValidator>
                </div>
            </div>

            <div class="form-group required">
                <strong>
                    <asp:Label runat="server" CssClass="col-lg-2 control-label" Text="Short Description  (Max characters: 130)"></asp:Label></strong>
                <div class="col-lg-9">
                    <asp:TextBox ID="txtDesc" TextMode="MultiLine" runat="server" CssClass="form-control" placeholder="Enter front page description"
                        onKeyDown="limitText(this, 130);" onKeyUp="limitText((this, 130);"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfv_txtDesc" runat="server" ErrorMessage="Please enter a Description" ControlToValidate="txtDesc" ForeColor="Red" Display="Dynamic" ValidationGroup="ValidateForm"></asp:RequiredFieldValidator>
                    <div class="pull-right">
                        <p>
                            You have
                            <asp:TextBox runat="server" ID="countdown" size="3" value="130" Enabled="False" />
                            characters left.
                        </p>
                    </div>
                </div>
            </div>

            <div class="form-group required">
                <strong>
                    <asp:Label runat="server" CssClass="col-lg-2 control-label" Text="News Content"></asp:Label></strong>
                <div class="col-lg-9">
                    <CKEditor:CKEditorControl ID="descriptionModuleInput" runat="server"></CKEditor:CKEditorControl>
                    <asp:CustomValidator ID="cv_descriptionModuleInput" runat="server" EnableClientScript="true" ErrorMessage="Please input a Course Description" ClientValidationFunction="ValidateModuleDescription" ForeColor="Red" ValidationGroup="ValidateForm"></asp:CustomValidator>
                </div>
            </div>
        </div>
        <div class="form-group">
            <br />

            <div class="wrapper">
                
                <asp:Button ID="saveBtn" CssClass="btn btn-primary" runat="server" Text="Submit" data-toggle="modal" href="#saveModal" UseSubmitBehavior="False" OnClientClick="return checkForm_Clicked();" CausesValidation="True" />
            </div>
        </div>

        <%--Modal for Submission Confirmation--%>
        <div id="saveModal" class="modal fade" role="dialog">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title"><b>Edit news</b></h4>
                    </div>
                    <%--Modal Content--%>
                    <div class="modal-body">
                        <div class="wrapper">
                            <h4>Are you sure you want to overwrite and save?</h4>
                            <br />
                            <asp:Label ID="lblErrorMsgFinal" runat="server" CssClass="text-danger" Visible="True"></asp:Label>
                            <br />
                            <asp:Button ID="cfmSave" CssClass="btn btn-primary" runat="server" Text="Submit" OnClick="btnSubmit_Click" />
                            <asp:Button ID="Button2" CssClass="btn btn-default" runat="server" class="close" data-dismiss="modal" Text="Go Back" />
                            <%--Redirect to viewModuleInfo of newly created course--%>
                            <br />
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </form>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
