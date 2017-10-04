<%@ Page Title="" Language="C#" MasterPageFile="~/Masterpage.Master" AutoEventWireup="true" CodeBehind="editModuleInfo.aspx.cs" Inherits="LearnHub.editModuleInfo" %>

<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="LearnHub.AppCode.dao" %>
<%@ Import Namespace="LearnHub.AppCode.entity" %>

<%@ Register Assembly="CKEditor.NET" Namespace="CKEditor.NET" TagPrefix="CKEditor" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.3.0/css/datepicker.css" rel="stylesheet" type="text/css" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.3.0/js/bootstrap-datepicker.js"></script>
    <link href="Scripts/footable.bootstrap.min.css" rel="stylesheet" />
    <script src="Scripts/footable.min.js"></script>


    <script type="text/javascript">
        $(function () {
            $('.input-daterange').datepicker({
                format: 'dd/mm/yyyy',
                autoclose: true
            });
        });

        $(function () {
            $('.input-group.date').datepicker({
                format: 'dd/mm/yyyy',
                calendarWeeks: true,
                todayHighlight: true,
                autoclose: true
            });
        });


        jQuery(function ($) {
            $('[id*=gvPrereq]').footable({
                "paging": {
                    "size": 10 <%--Change how many rows per page--%>
                },
                "filtering": {
                    "position": "left"
                }
            });
        });


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

        function ValidateHours(sender, args) {
            console.log("validateHours");
            var hours = document.getElementById("<%= hoursInput.ClientID %>").value;
            console.log("hours " + hours);
            if (hours >= 0 && hours < 100000) {
                args.IsValid = true;

            }
            else {
                args.IsValid = false;
            }
        }

        function ValidateHoursFormat(sender, args) {
            console.log("validateHoursFormat");
            var hours = document.getElementById("<%= hoursInput.ClientID %>").value;
            console.log("hours " + hours);
            if (isNaN(hours)) {
                args.IsValid = false;
                console.log("NaN");
                return false;
            }
            else {
                if (hours.indexOf('.') != -1) {
                    console.log("has .");
                    var indexes = hours.split(".");
                    if (indexes[1].length > 1) {
                        console.log("more than 1 dec");
                        console.log(indexes[1].length);
                        args.IsValid = false;
                        return false;
                    }
                    else {
                        console.log("1 dec");
                        console.log(indexes[1]);
                        console.log(indexes[1].length);
                        args.IsValid = true;
                        return true;
                    }
                }
                else {
                    console.log("is whole number");
                    args.IsValid = true;
                    return true;
                }
            }
            if (hours >= 0 && hours < 100000) {
                args.IsValid = true;
                return true;

            }
            else {
                args.IsValid = false;
            }
        }

        function compareDates(sender, args) {
            var toDate = document.getElementById("<%=toDateInput.ClientID%>").value;
            var fromDate = document.getElementById("<%=fromDateInput.ClientID%>").value;
            console.log(toDate);
            console.log(fromDate);
            if (toDate == "" || fromDate == "") {
                args.IsValid = true;
                return true;
            }
            else {
                var compare = fromDate.split("/");

                var cmonth = compare[1] - 1;
                if (cmonth.length == 1) {
                    cmonth = "0" + cmonth;
                }
                console.log(cmonth);
                var cday = compare[0];
                if (cday.length == 1) {
                    cday = "0" + cday;
                }
                console.log(cday);
                var cyear = compare[2];
                console.log(cyear);
                var fromDateFinal = new Date();
                fromDateFinal.setYear(cyear);
                fromDateFinal.setMonth(cmonth);
                fromDateFinal.setDate(cday);
                console.log(fromDateFinal);

                var input = toDate.split("/");
                var month = input[1] - 1;
                if (month.length == 1) {
                    month = "0" + month;
                }
                var day = input[0];
                if (day.length == 1) {
                    day = "0" + day;
                }
                var year = input[2];
                var toDateFinal = new Date();
                toDateFinal.setYear(year);
                toDateFinal.setMonth(month);
                toDateFinal.setDate(day);
                console.log(toDateFinal);
                if (toDateFinal <= fromDateFinal) {
                    args.IsValid = false;
                    return false;
                }
                else {
                    args.IsValid = true;
                    return true;
                }
            }
        }

        function checkForm_Clicked(source, args) {

            console.log("Checkform");
            Page_ClientValidate('ValidateForm');

            //Page_ClientValidate();

            if (!Page_IsValid) {
                document.getElementById('<%= lblErrorMsgFinal.ClientID %>').style.display = 'inherit';
                document.getElementById('<%= lblErrorMsgFinal.ClientID %>').innerHTML = "You have not filled up all of the required fields";
                //Page_ClientValidate('summaryGroup');
                document.getElementById('<%= cfmSubmit.ClientID %>').disabled = true;
                console.log("The end");
            }
            else {
                if (document.getElementById('<%= lbl_nameValidate.ClientID %>').innerHTML == "") {
                    console.log("no error");
                    document.getElementById('<%= lblErrorMsgFinal.ClientID %>').innerHTML = "";
                    document.getElementById('<%= cfmSubmit.ClientID %>').disabled = false;
                }
                else {
                    console.log(" error");
                    document.getElementById('<%= lblErrorMsgFinal.ClientID %>').style.display = 'inherit';
                    document.getElementById('<%= lblErrorMsgFinal.ClientID %>').innerHTML = "You have not filled up all of the required fields";
                    //Page_ClientValidate('summaryGroup');
                    document.getElementById('<%= cfmSubmit.ClientID %>').disabled = true;
                }

            }
            return false;
        }


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
        <li><a href="viewAllModule.aspx">Courses</a></li>
        <li><a href="viewModuleInfo.aspx?id=<%=Request.QueryString["id"]%>">
            <asp:Label ID="lblBreadcrumbCourseName" runat="server" Text="courseName"></asp:Label></a></li>
        <li class="active">Edit Course</li>

    </ul>


    <div class="container">
        <h1>Edit Course</h1>
                         <% 
 int courseID = Convert.ToInt32(Request.QueryString["id"]);
                    User currentUser = (User)Session["currentUser"];
                    Course_elearnDAO ceDAO = new Course_elearnDAO();
                    User courseCreator = ceDAO.get_course_by_id(courseID).getCourseCreator();
                    Boolean superuser = false;
                    foreach (string s in currentUser.getRoles())
                    {
                        if (s.Equals("superuser"))
                        {
                            superuser = true;
                        }
                    }
                    if (currentUser != null && (currentUser.getUserID() == courseCreator.getUserID() || superuser))
                    {
             %>    
         <div class="dropdown" style="float: right;">
                <button class="dropbtn" onclick="return false;"><span class="glyphicon glyphicon-option-horizontal"></span></button>
                <div class="dropdown-content" style="right: 0;">
                    <a href="createModules.aspx"><span class="glyphicon glyphicon-plus"></span>&nbsp;&nbsp;Create New Courses</a>
                    <a href="manageCategories.aspx"><span class="glyphicon glyphicon-bookmark"></span>&nbsp;&nbsp;Manage Course Categories</a>
                    <a href="viewCreatedModules.aspx"><span class="glyphicon glyphicon-book"></span>&nbsp;&nbsp;Manage Courses</a>
                </div>
            </div>
        <%} %>
        <div class="verticalLine"></div>
    </div>

    <div class="container">
        <form class="form-horizontal" runat="server">
            <fieldset>
                <legend>Edit current course information </legend>
                <div class="form-group required">
                    <strong>
                        <%--Compulsory/Leadership/Professional--%>
                        <asp:Label ID="moduleTypeLabel" runat="server" CssClass="col-lg-2 control-label" Text="Course Category"></asp:Label></strong>
                    <div class="col-lg-5">
                        <asp:DropDownList ID="moduleType" runat="server" CssClass="form-control" placeholder="Choose Category *" DataSourceID="SqlDataSourceCourseCategory" DataTextField="category" DataValueField="categoryID"></asp:DropDownList>
                        <asp:SqlDataSource ID="SqlDataSourceCourseCategory" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" SelectCommand="SELECT * FROM [Elearn_courseCategory]"></asp:SqlDataSource>
                    </div>
                </div>
                <br />
                 <div class="form-group required">
                    <strong><asp:Label runat="server" CssClass="col-lg-2 control-label" Text="Course Type"></asp:Label></strong>
                    <div class="col-lg-5">
                        <asp:DropDownList ID="ddlCourseType" disabled="" runat="server" CssClass="form-control">
                            <asp:ListItem Text="Classroom Learning" Value="Classroom Learning"></asp:ListItem>
                             <asp:ListItem Text="Online Learning" Value="Online Learning"></asp:ListItem>
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="rfv_ddlCourseType" runat="server" ControlToValidate="ddlCourseType" ErrorMessage="Please select a Course Type" InitialValue="0" ForeColor="Red" ValidationGroup="ValidateForm" EnableClientScript="True"></asp:RequiredFieldValidator>
                    </div>
                </div>
                <br />
                <div class="form-group required">
                    <strong>
                        <asp:Label ID="nameOfModuleLabel" runat="server" CssClass="col-lg-2 control-label" Text="Name of Course"></asp:Label></strong>
                    <div class="col-lg-5">
                        <asp:TextBox ID="nameOfModuleInput" runat="server" CssClass="form-control" placeholder="Course Name" AutoPostBack="True" OnTextChanged="validateNameExists"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfv_nameOfModuleInput" runat="server" ErrorMessage="Please enter a Course Name" ControlToValidate="nameOfModuleInput" ForeColor="Red" ValidationGroup="ValidateForm"></asp:RequiredFieldValidator>
                        <asp:Label ID="lbl_nameValidate" runat="server" Text="" ForeColor="Red"></asp:Label>
                    </div>
                </div>

                <div class="form-group required">
                    <strong>
                        <asp:Label ID="descriptionModuleLabel" runat="server" CssClass="col-lg-2 control-label" Text="Description of Course"></asp:Label></strong>
                    <div class="col-lg-5">
                        <%--<asp:TextBox ID="descriptionModuleInput" TextMode="multiline" Columns="50" Rows="5" runat="server" CssClass="form-control" placeholder="Enter module description"></asp:TextBox>--%>
                        <CKEditor:CKEditorControl ID="descriptionModuleInput" runat="server"></CKEditor:CKEditorControl>
                        <asp:CustomValidator ID="cv_descriptionModuleInput" runat="server" EnableClientScript="true" ErrorMessage="Please input a Course Description" ClientValidationFunction="ValidateModuleDescription" ForeColor="Red" ValidationGroup="ValidateForm"></asp:CustomValidator>
                    </div>
                </div>

                <div class="form-group">
                    <strong>
                        <asp:Label ID="Label1" runat="server" CssClass="col-lg-2 control-label" Text="Target Audience"></asp:Label></strong>
                    <div class="col-lg-5">
                        <asp:TextBox ID="txtTargetAudience" runat="server" CssClass="form-control" placeholder="Target Audience"></asp:TextBox>
                    </div>
                </div>
                <br />

                <div class="form-group required">
                    <strong>
                        <asp:Label ID="hoursLabel" runat="server" CssClass="col-lg-2 control-label" Text="Learning Hours"></asp:Label></strong>
                    <div class="col-lg-5">
                        <div class="input-group">
                            <asp:TextBox ID="hoursInput" runat="server" CssClass="form-control" placeholder="No. of Hours"></asp:TextBox>
                            <span class="input-group-addon">hours </span>
                        </div>
                        <asp:RequiredFieldValidator ID="rfv_hoursInput" runat="server" ErrorMessage="Please Input the Number of Learning Hours" ControlToValidate="hoursInput" ForeColor="Red" ValidationGroup="ValidateForm"></asp:RequiredFieldValidator>
                        <br />    
                        <asp:CustomValidator ID="cv_hoursInputFormat" runat="server" EnableClientScript="true" ErrorMessage="Please enter hours in either whole number or with only one decimal place e.g (15.5)" ClientValidationFunction="ValidateHoursFormat" ForeColor="Red" ValidationGroup="ValidateForm"></asp:CustomValidator>
                        <br />
                        <asp:CustomValidator ID="cv_hoursInput" runat="server" EnableClientScript="true" ErrorMessage="Please enter a value between 0.0 and 100000.0" ClientValidationFunction="ValidateHours" ForeColor="Red" ValidationGroup="ValidateForm"></asp:CustomValidator>
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
                            <asp:TextBox ID="fromDateInput" runat="server" CssClass="form-control" placeholder="DD/MM/YYYY"></asp:TextBox>
                            <span class="input-group-addon">to</span>
                            <asp:TextBox ID="toDateInput" runat="server" CssClass="form-control" placeholder="DD/MM/YYYY"></asp:TextBox>
                            <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i>
                            </span>
                        </div>
                        <asp:RequiredFieldValidator ID="rfv_fromDateInput" ControlToValidate="fromDateInput" runat="server" ErrorMessage="Please enter the Start Date of the Module" ForeColor="Red" ValidationGroup="ValidateForm" />
                        <br />
                        <asp:RequiredFieldValidator ID="rfv_toDateInput" ControlToValidate="toDateInput" runat="server" ErrorMessage="Please enter the End Date of the Module" ForeColor="Red" ValidationGroup="ValidateForm" />
                        <br />
                        <asp:CustomValidator ID="cv_dateInput" runat="server" ClientValidationFunction="compareDates" ErrorMessage="Please enter a Module Start Date that is Before the Module End Date." ForeColor="Red" ValidationGroup="ValidateForm"></asp:CustomValidator>
                    </div>


                </div>



                <%--Preq--%>
                <div class="form-group">
                    <strong>
                         <a href="javascript:void(0);" class="col-lg-2 control-label" data-toggle="collapse" data-target="#preq"">Course Prerequisite Selection </a></strong>

                    <div class="col-lg-5">
                        <div id="preq" class="collapse">
                            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>">
                        </asp:SqlDataSource>
                        <asp:GridView ID="gvPrereq" runat="server" AutoGenerateColumns="False" DataKeyNames="elearn_courseID,categoryID1" AllowPaging="False" CssClass="footable table table-striped table-hover" data-paging="true" GridLines="None" OnRowCommand="gvPrereq_RowCommand" EmptyDataText="There are no courses available to choose from.">
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
                            <h6><em>Click on "+" to select course as a prerequisite course</em></h6>


                            <br />
                        </div>

                        <asp:SqlDataSource ID="SqlDataSourcePrereqCart" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>">
                        </asp:SqlDataSource>
                        <asp:GridView ID="gvPrereqCart" runat="server" CssClass="table table-striped table-hover" DataKeyNames="elearn_courseID" EmptyDataText="Please choose a prerequisite first" GridLines="None" AutoGenerateColumns="False" OnRowCommand="gvPrereqCart_RowCommand">
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
                        <h6><em>Click on "Course Prerequisite Selection" to choose prerequisite courses</em></h6>
                    </div>
                </div>


                <div class="form-group">
                    <br />
                    <div class="wrapper">
                        <asp:Button ID="submitBtn" CssClass="btn btn-primary" runat="server" Text="Save Changes" data-toggle="modal" href="#submitModal" OnClientClick="return checkForm_Clicked();" CausesValidation="True" UseSubmitBehavior="False" />
                        <%--READ ME: If course status = activated, show deactivate button
                                     If course status = deactivated, show activate button--%>
                        <%Course_elearnDAO ceDAO = new Course_elearnDAO();
                            Course_elearn currentCourse = ceDAO.get_course_by_id(Convert.ToInt32(Request.QueryString["id"]));
                            if (currentCourse.getStatus().Equals("active"))
                            {%>
                        <asp:Button ID="btnDeactivate" CssClass="btn btn-warning" runat="server" Text="Deactivate Course" data-toggle="modal" href="#deactivateModal" OnClientClick="return false;"/>
                        <%}
                        else
                        { %>
                        <asp:Button ID="btnActivate" CssClass="btn btn-success" runat="server" Text="Activate Course" data-toggle="modal" href="#activateModal" OnClientClick="return false;" />
                    </div>
                    <%} %>
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
                                    <asp:Label ID="lblErrorMsgFinal" runat="server" CssClass="text-danger" Visible="True"></asp:Label>
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
                                <h4 class="modal-title"><b>Deactivate this course</b></h4>
                            </div>
                            <%--Modal Content--%>
                            <div class="modal-body">
                                <div class="wrapper">
                                    <h4>Are you sure you want to deactivate this course?</h4>
                                    <br />
                                    <asp:Button ID="btnCfmDeactivate" CssClass="btn btn-warning" runat="server" Text="Deactivate" OnClick="btnCfmDeactivate_Click" CausesValidation="false" />
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
                                <h4 class="modal-title"><b>Activate this course</b></h4>
                            </div>
                            <%--Modal Content--%>
                            <div class="modal-body">
                                <div class="wrapper">
                                    <h4>Are you sure you want to activate this course?</h4>
                                    <br />
                                    <asp:Button ID="btnCfmActivate" CssClass="btn btn-success" runat="server" Text="Activate" OnClick ="cfmActivate_Click" CausesValidation="false"/>
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
