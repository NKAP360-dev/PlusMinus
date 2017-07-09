<%@ Page Title="Apply For Courses - LearnHub" Language="C#" MasterPageFile="~/Masterpage.Master" AutoEventWireup="true" CodeBehind="applyCourse.aspx.cs" Inherits="LearnHub.applyCourse" %>
<%@ Import Namespace="LearnHub.AppCode.entity"%>
<%@ Import Namespace="LearnHub.AppCode.dao"%>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.3.0/css/datepicker.css" rel="stylesheet" type="text/css" />

    
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.3.0/js/bootstrap-datepicker.js"></script>
    <script type="text/javascript">
        
        $(window).load(function () {
            $('#myModal').modal('show');

            
        });
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

        function SelectRadiobutton(radio) {
            var rdBtn = document.getElementById(radio.id);
            var rdBtnList = document.getElementsByTagName("input");
            for (i = 0; i < rdBtnList.length; i++) {
                if (rdBtnList.type == "radio" && rdBtnList[i].id != rdBtn.id) {
                    rdBtnList[i].checked = false;
                }
            }
        }
    </script>

    <script type="text/javascript">
        <%--
        window.onload = function () {
            console.log("modal1");
            if (Page_ClientValidate("ValidateForm")) { 
                console.log("modal2");
                $('#myModal').modal('show');
            }
        }
        --%>


        function forObjective1Clicked(validationGroupName1, isEnable) {
            if (document.getElementById('<%=objectiveInput1.ClientID%>').checked == true) {
                objective1text.style.display = 'block';
                objective1date.style.display = 'block';
                document.getElementById('<%=rfv_objective1text.ClientID%>').enabled = true;
                document.getElementById('<%=rfv_objective1date.ClientID%>').enabled = true;
                document.getElementById('<%=cv_objective1date.ClientID%>').enabled = true;
                
                console.log("FOROBJECTIVE1CLICKED");
                if (!document.getElementById('<%= objectiveInput2.ClientID %>').checked) {
                    console.log("0");
                    document.getElementById('<%=rfv_objective2text.ClientID%>').enabled = false;
                    console.log("1");
                    document.getElementById('<%=rfv_objective2date.ClientID%>').enabled = false;
                    console.log("2");
                    document.getElementById('<%=cv_objective2date.ClientID%>').enabled = false;
                }
                if (!document.getElementById('<%= objectiveInput3.ClientID %>').checked) {
                    document.getElementById('<%=rfv_objective3text.ClientID%>').enabled = false;
                    console.log("3");
                    document.getElementById('<%=rfv_objective3date.ClientID%>').enabled = false;
                    console.log("4");
                    document.getElementById('<%=cv_objective3date.ClientID%>').enabled = false;
                }
            }
            else {
                objective1text.style.display = 'none';
                objective1date.style.display = 'none';
                console.log("FOROBJECTIVE1UNCLICKED");
                //document.getElementById('<%=rfv_objective1text.ClientID%>').enabled = false;
                ValidatorEnable(document.getElementById("<%=rfv_objective1text.ClientID %>"), false);
                console.log("Exited");
                //document.getElementById('<%=rfv_objective1date.ClientID%>').enabled = false;
                ValidatorEnable(document.getElementById("<%=rfv_objective1text.ClientID %>"), false);
                ValidatorEnable(document.getElementById("<%=rfv_objective1date.ClientID %>"), false);
                ValidatorEnable(document.getElementById('<%=cv_objective1date.ClientID%>'), false);
            }
        }

        function forObjective2Clicked(validationGroupName1, isEnable) {
            if (document.getElementById('<%=objectiveInput2.ClientID%>').checked == true) {
                objective2text.style.display = 'block';
                objective2date.style.display = 'block';
                console.log("FOROBJECTIVE2CLICKED");
                document.getElementById('<%=rfv_objective2text.ClientID%>').enabled = true;
                document.getElementById('<%=rfv_objective2date.ClientID%>').enabled = true;
                document.getElementById('<%=cv_objective2date.ClientID%>').enabled = true;
                if (!document.getElementById('<%= objectiveInput1.ClientID %>').checked) {
                    console.log("0");
                    document.getElementById('<%=rfv_objective1text.ClientID%>').enabled = false;
                    console.log("1");
                    document.getElementById('<%=rfv_objective1date.ClientID%>').enabled = false;
                    console.log("2");
                    document.getElementById('<%=cv_objective1date.ClientID%>').enabled = false;
                }
                if (!document.getElementById('<%= objectiveInput3.ClientID %>').checked) {
                    document.getElementById('<%=rfv_objective3text.ClientID%>').enabled = false;
                    console.log("3");
                    document.getElementById('<%=rfv_objective3date.ClientID%>').enabled = false;
                    console.log("4");
                    document.getElementById('<%=cv_objective3date.ClientID%>').enabled = false;
                }
            }
            else {
                objective2text.style.display = 'none';
                objective2date.style.display = 'none';
                console.log("FOROBJECTIVE2UNCLICKED");
                ValidatorEnable(document.getElementById("<%=rfv_objective2text.ClientID %>"), false);
                ValidatorEnable(document.getElementById("<%=rfv_objective2date.ClientID %>"), false);
                ValidatorEnable(document.getElementById('<%=cv_objective2date.ClientID%>'), false);
            }
        }

        function forObjective3Clicked(validationGroupName1, isEnable) {
            if (document.getElementById('<%=objectiveInput3.ClientID%>').checked == true) {
                objective3text.style.display = 'block';
                objective3date.style.display = 'block';
                console.log("FOROBJECTIVE3CLICKED");
                document.getElementById('<%=rfv_objective3text.ClientID%>').enabled = true;
                document.getElementById('<%=rfv_objective3date.ClientID%>').enabled = true;
                document.getElementById('<%=cv_objective3date.ClientID%>').enabled = true;
                if (!document.getElementById('<%= objectiveInput1.ClientID %>').checked) {
                    console.log("0");
                    document.getElementById('<%=rfv_objective1text.ClientID%>').enabled = false;
                    console.log("1");
                    document.getElementById('<%=rfv_objective1date.ClientID%>').enabled = false;
                    console.log("2");
                    document.getElementById('<%=cv_objective1date.ClientID%>').enabled = false;
                }
                if (!document.getElementById('<%= objectiveInput2.ClientID %>').checked) {
                    document.getElementById('<%=rfv_objective2text.ClientID%>').enabled = false;
                    console.log("3");
                    document.getElementById('<%=rfv_objective2date.ClientID%>').enabled = false;
                    console.log("4");
                    document.getElementById('<%=cv_objective2date.ClientID%>').enabled = false;
                }
            }
            else {
                objective3text.style.display = 'none';
                objective3date.style.display = 'none';
                console.log("FOROBJECTIVE3UNCLICKED");
                ValidatorEnable(document.getElementById("<%=rfv_objective3text.ClientID %>"), false);
                ValidatorEnable(document.getElementById("<%=rfv_objective3date.ClientID %>"), false);
                ValidatorEnable(document.getElementById('<%=cv_objective3date.ClientID%>'), false);
            }
        }

        function ValidateCheckBoxes(source, args) {
            var checker = 0;
            if (document.getElementById('<%= objectiveInput1.ClientID %>').checked) {
                checker = checker + 1;
                if (!document.getElementById('<%= objectiveInput1.ClientID %>').checked) {
                    checker = checker - 1;
                }
            }
            if (document.getElementById('<%= objectiveInput2.ClientID %>').checked) {
                checker = checker + 1;
                if (!document.getElementById('<%= objectiveInput2.ClientID %>').checked) {
                    checker = checker - 1;
                }
            }
            if (document.getElementById('<%= objectiveInput3.ClientID %>').checked) {
                checker = checker + 1;
                if (!document.getElementById('<%= objectiveInput3.ClientID %>').checked) {
                    checker = checker - 1;
                }
            }
            console.log(checker);
            if (checker > 0) {
                args.IsValid = true;
                console.log("checkboxes valid");

            }
            else {
                args.IsValid = false;
                console.log("checkboxes notvalid");
            }


        }

        function ValidateRadioButton(sender, args) {
            var gv = document.getElementById("<%= gvLesson.ClientID %>");
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

        function compareDates1(source, args) {
            var inputtedDate = document.getElementById("<%=completeDateInput1.ClientID%>").value;
            var dateToCompare = document.getElementById("<%=toDateInput.ClientID%>").value;
            var compare = dateToCompare.split("/");
            var cmonth = compare[1] - 1;
            if (cmonth.length == 1) {
                cmonth = "0" + cmonth;
            }
            var cday = compare[0];
            if (cday.length == 1) {
                cday = "0" + cday;
            }
            var cyear = compare[2];
            var finCompare = new Date();
            finCompare.setYear(cyear);
            finCompare.setMonth(cmonth);
            finCompare.setDate(cday);
            console.log(finCompare);

            var input = inputtedDate.split("/");
            var month = input[0] - 1;
            if (month.length == 1) {
                month = "0" + month;
            }
            var day = input[1];
            if (day.length == 1) {
                day = "0" + day;
            }
            var year = input[2];
            var finDateToCheck = new Date();
            finDateToCheck.setYear(year);
            finDateToCheck.setMonth(month);
            finDateToCheck.setDate(day);
            console.log(finDateToCheck);
            if (finDateToCheck <= finCompare) {
                args.IsValid = false;
                return false;
            }
            else {
                args.IsValid = true;
                return true;
            }
        }

        function compareDates2(source, args) {
            var inputtedDate = document.getElementById("<%=completeDateInput2.ClientID%>").value;
            var dateToCompare = document.getElementById("<%=toDateInput.ClientID%>").value;
            var compare = dateToCompare.split("/");
            var cmonth = compare[1] - 1;
            if (cmonth.length == 1) {
                cmonth = "0" + cmonth;
            }
            var cday = compare[0];
            if (cday.length == 1) {
                cday = "0" + cday;
            }
            var cyear = compare[2];
            var finCompare = new Date();
            finCompare.setYear(cyear);
            finCompare.setMonth(cmonth);
            finCompare.setDate(cday);
            console.log(finCompare);

            var input = inputtedDate.split("/");
            var month = input[0] - 1;
            if (month.length == 1) {
                month = "0" + month;
            }
            var day = input[1];
            if (day.length == 1) {
                day = "0" + day;
            }
            var year = input[2];
            var finDateToCheck = new Date();
            finDateToCheck.setYear(year);
            finDateToCheck.setMonth(month);
            finDateToCheck.setDate(day);
            console.log(finDateToCheck);
            if (finDateToCheck <= finCompare) {
                args.IsValid = false;
                return false;
            }
            else {
                args.IsValid = true;
                return true;
            }
        }

        function compareDates3(source, args) {
            var inputtedDate = document.getElementById("<%=completeDateInput3.ClientID%>").value;
            var dateToCompare = document.getElementById("<%=toDateInput.ClientID%>").value;
            var compare = dateToCompare.split("/");
            var cmonth = compare[1] - 1;
            if (cmonth.length == 1) {
                cmonth = "0" + cmonth;
            }
            var cday = compare[0];
            if (cday.length == 1) {
                cday = "0" + cday;
            }
            var cyear = compare[2];
            var finCompare = new Date();
            finCompare.setYear(cyear);
            finCompare.setMonth(cmonth);
            finCompare.setDate(cday);
            console.log(finCompare);

            var input = inputtedDate.split("/");
            var month = input[0] - 1;
            if (month.length == 1) {
                month = "0" + month;
            }
            var day = input[1];
            if (day.length == 1) {
                day = "0" + day;
            }
            var year = input[2];
            var finDateToCheck = new Date();
            finDateToCheck.setYear(year);
            finDateToCheck.setMonth(month);
            finDateToCheck.setDate(day);
            console.log(finDateToCheck);
            if (finDateToCheck <= finCompare) {
                args.IsValid = false;
                return false;
            }
            else {
                args.IsValid = true;
                return true;
            }
        }
        
    </script>

    <style>
        .modal-body {
    max-height: calc(100vh - 210px);
    overflow-y: auto;
}
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">
        <!-- Modal-->
        <div id="myModal" class="modal fade" role="dialog">
            <div class="modal-dialog">               
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title"><span class="glyphicon glyphicon-info-sign"></span>&nbsp;<b>Please read before you proceed</b></h4>
                    </div>
                    <%--Modal Content--%>
                    <div class="modal-body">
                        <p><b>Important Notes:</b></p>
                        <b>1.</b>&nbsp; This form is not applicable for: 
                            <ul>
                                <li>#Compulsory courses</li>
                                <li>#Sponsorship courses</li>
                            </ul>
                        <br />
                        <b>2.</b>&nbsp; Attach the relevant course information, fees and course schedule together with the form for submission to HR:
                        <ul>
                            <li>At least 2 weeks before course registration dateline</li>
                            <li>At least 1 month before course registration deadline if course fees exceeds S$20,000</li>
                        </ul>
                        <br />
                        <br />
                        <p><b>Training Guidelines:</b></p>
                        <b>3.</b>&nbsp; In the event that staff fails to attend/complete the course due to any of but not limited to the following reasons:
                        <ul>
                            <li>Withdrawal from course on own accord</li>
                            <li>Resignation; or</li>
                            <li>Fail to meet the minimum requirements from the related provider for course completion</li>
                        </ul>
                        <b>4.</b>&nbsp; Staff will be required to refund any expenses incurred.
                        <br />
                        <br />
                        <b>5.</b>&nbsp; Full course fees will be charged to the relevant department's training budget if the course provider is unable to accept any replacement staff 
                        that the department's supervisor/HOD provider for non-attendance. 

                        <br />
                        <br />
                        <p class="text-muted">
                            #Not applicable for compulsory courses, staff will be automatically scheduled by HOD/supervisor to attend.
                            <br />
                            #Please download a separate form for application of sponsorship courses on the intranet.

                        </p>

                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                    </div>
                </div>

            </div>
        </div>
    </div>

    <div class="container">
        <h1>Apply For Courses</h1>
        <div class="verticalLine"></div>
        <form class="form-horizontal" runat="server">
            <fieldset>
                <legend>Training Request Form<a class="btn" data-toggle="modal" href="#myModal"><span class="label label-danger"><span class="glyphicon glyphicon-info-sign"></span></span></a></legend>

                <%-- Section A--%>
                <h4>Section A - Staff Particulars</h4>
                <h6>Not applicable for group training. For group training, omit this section and complete the attached Annex A</h6>
                <div class="form-group">
                    <strong>
                        <asp:Label ID="nameOfStaffLabel" runat="server" CssClass="col-lg-2 control-label" Text="Name Of Staff"></asp:Label></strong>
                    <div class="col-lg-5">
                        <asp:TextBox ID="nameOfStaffInput" disabled="" runat="server" CssClass="form-control" placeholder="Name Of Staff"></asp:TextBox>
                    </div>
                </div>
                <div class="form-group">
                    <strong>
                        <asp:Label ID="employeeNoLabel" runat="server" CssClass="col-lg-2 control-label" Text="Employee No"></asp:Label></strong>
                    <div class="col-lg-5">
                        <asp:TextBox ID="employeeNoInput" disabled="" runat="server" CssClass="form-control" placeholder="Employee Number"></asp:TextBox>
                    </div>
                </div>
                <div class="form-group">
                    <strong>
                        <asp:Label ID="emailLabel" runat="server" CssClass="col-lg-2 control-label" Text="Email Address"></asp:Label></strong>
                    <div class="col-lg-5">
                        <asp:TextBox ID="emailInput" disabled="" runat="server" CssClass="form-control" placeholder="Email Address"></asp:TextBox>
                    </div>
                </div>
                <div class="form-group">
                    <strong>
                        <asp:Label ID="designationLabel" runat="server" CssClass="col-lg-2 control-label" Text="Desgination"></asp:Label></strong>
                    <div class="col-lg-5">
                        <asp:TextBox ID="designationInput" disabled="" runat="server" CssClass="form-control" placeholder="Designation"></asp:TextBox>
                    </div>
                </div>
                <div class="form-group">
                    <strong>
                        <asp:Label ID="departmentLabel" runat="server" CssClass="col-lg-2 control-label" Text="Department"></asp:Label></strong>
                    <div class="col-lg-5">
                        <asp:TextBox ID="departmentInput" disabled="" runat="server" CssClass="form-control" placeholder="Department"></asp:TextBox>
                    </div>
                </div>
                <br />

                 <%-- Section B--%>
                <asp:ScriptManager ID="ScriptManagerCourse" runat="server" />
                
                <h4>Section B - Course Details</h4>
                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                <div class="form-group">
                    <strong>
                        <asp:Label ID="courseLabel" runat="server" CssClass="col-lg-2 control-label" Text="Course Title"></asp:Label></strong>
                    <div class="col-lg-5">
                        <asp:DropDownList ID="courseInput" runat="server" CssClass="form-control" placeholder="Course Title" DataSourceID="SqlDataSourceCourse" DataTextField="courseName" DataValueField="courseID" OnSelectedIndexChanged="courseInput_SelectedIndexChanged" AutoPostBack="True" AppendDataBoundItems="true">
                            <asp:ListItem Selected="True" Value="-1" Text="Please select a course"></asp:ListItem>
                        </asp:DropDownList>
                        <asp:SqlDataSource ID="SqlDataSourceCourse" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" SelectCommand="SELECT [courseID], [courseName] FROM [Course] WHERE ([status] = @status) ORDER BY [courseName]">
                            <SelectParameters>
                                <asp:Parameter DefaultValue="open" Name="status" Type="String" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                        <asp:RequiredFieldValidator ID="rfv_courseInput" runat="server" ControlToValidate="courseInput" ErrorMessage="Please Select a Course" InitialValue="-1" ForeColor="Red" ValidationGroup="ValidateForm"></asp:RequiredFieldValidator>
                        <asp:RequiredFieldValidator ID="rfv_courseInputSummary" runat="server" ControlToValidate="courseInput" ErrorMessage="Please Select a Course" InitialValue="-1" ForeColor="Red" ValidationGroup="summaryGroup" Visible="False"></asp:RequiredFieldValidator>
                        <asp:CustomValidator ID="cus_courseInput" runat="server" EnableClientScript="true" ControlToValidate="courseInput" ErrorMessage="You have already applied for this course before. Please select another course" OnServerValidate="ValidateCourse" ForeColor="Red" ValidationGroup="ValidateForm"></asp:CustomValidator>
                    </div>
                </div>
    
                <%-- Make table dynamically appear only after course is selected from DDL--%>
                        <div class="form-group">
                            <strong>
                                <asp:Label ID="lessonSelection" runat="server" CssClass="col-lg-2 control-label" Text="Lesson Selection"></asp:Label></strong>
                            <div class="col-lg-10">
                               
                                <asp:GridView ID="gvLesson" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSourceLesson" CssClass="table table-striped table-hover" GridLines="None" EmptyDataText="Please select a course first">
                                    <Columns>
                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <input name="rbnLessonID" type="radio" onclick="javascript.SelectRadiobutton(this)" value='<%# Eval("lessonID") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="lesson_start_date" dataformatstring="{0:MMMM d, yyyy}" HeaderText="Start Date" SortExpression="lesson_start_date" />
                                        <asp:BoundField DataField="lesson_end_date" dataformatstring="{0:MMMM d, yyyy}" HeaderText="End Date" SortExpression="lesson_end_date" />
                                        <asp:BoundField DataField="lesson_start_timing"  HeaderText="Start Time" SortExpression="lesson_start_timing" />
                                        <asp:BoundField DataField="lesson_end_timing" HeaderText="End Time" SortExpression="lesson_end_timing" />
                                        <asp:BoundField DataField="instructor" HeaderText="Instructor" SortExpression="instructor" />
                                        <asp:BoundField DataField="venue" HeaderText="Venue" SortExpression="venue" />
                                    </Columns>
                                </asp:GridView>
                                <asp:SqlDataSource ID="SqlDataSourceLesson" runat="server" ConnectionString="<%$ ConnectionStrings:DBConnectionString %>" SelectCommand="SELECT * FROM [Lesson] WHERE ([courseID] = @courseID)">
                                    <SelectParameters>
                                        <asp:SessionParameter Name="courseID" SessionField="selectedCourse" Type="Int32" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                                <asp:CustomValidator ID="cv_Lessons" runat="server" EnableClientScript="true" ErrorMessage="Please select a lesson slot" ClientValidationFunction="ValidateRadioButton" ForeColor="Red" ValidationGroup="ValidateForm"></asp:CustomValidator>
                                <asp:CustomValidator ID="cv_LessonsSummary" runat="server" EnableClientScript="true" ErrorMessage="Please select a lesson slot" ClientValidationFunction="ValidateRadioButton" ForeColor="Red" ValidationGroup="summaryGroup" Visible="False"></asp:CustomValidator>
                            </div>
                            
                        </div>

                <div class="form-group">
                    <strong>
                        <asp:Label ID="courseProviderLabel" disabled="" runat="server" CssClass="col-lg-2 control-label" Text="Course Provider"></asp:Label></strong>
                    <div class="col-lg-10">
                        <div class="radio">
                            <label>
                                <!--<asp:RadioButton ID="inhouse" GroupName="courseProvider" runat="server" Text="Inhouse" Checked="True" />
                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                <asp:RadioButton ID="external" GroupName="courseProvider" runat="server" Text="External" />-->
                                <asp:radiobuttonlist id="courseProvider" runat="server" Enabled="False">
                                    <asp:listitem id="in" runat="server" value="inhouse" Text="In house"/>
                                    <asp:listitem id="ex" runat="server" value="external" Text="External" />
                                </asp:radiobuttonlist> 
                            </label>
                        </div>
                    </div>
                    <asp:RequiredFieldValidator ID="rfv_courseProvider" runat="server" ErrorMessage="Please Select a Course Provider" ControlToValidate="courseProvider" ForeColor="Red" ValidationGroup="ValidateForm"></asp:RequiredFieldValidator>
                    <asp:RequiredFieldValidator ID="rfv_courseProviderSummary" runat="server" ErrorMessage="Please Selected a Course Provider" ControlToValidate="courseProvider" ForeColor="Red" ValidationGroup="summaryGroup" Visible="False"></asp:RequiredFieldValidator>
                    <asp:Label ID="empty1" runat="server" CssClass="col-lg-2 control-label" Text=""></asp:Label>
                    <div class="col-lg-5">
                        <asp:TextBox ID="externalCourseProvider" disabled="" runat="server" CssClass="form-control" placeholder="If external, please specify"></asp:TextBox>
                    </div>
                </div>
                <div class="form-group">
                    <strong>
                        <asp:Label ID="courseFeeLabel" disabled="" runat="server" CssClass="col-lg-2 control-label" Text="Course Fees with GST"></asp:Label></strong>
                    <div class="col-lg-5">
                        <asp:TextBox ID="courseFeeInput" disabled="" runat="server" CssClass="form-control" placeholder="Course Fees with GST (where applicable)"></asp:TextBox>
                    </div>
                </div>
                <div class="form-group">
                    <strong>
                        <asp:Label ID="dateLabel" runat="server" CssClass="col-lg-2 control-label" Text="Date"></asp:Label></strong>

                    <div class="col-lg-5">
                        <div class="input-daterange input-group" id="datepicker">
                            <asp:TextBox ID="fromDateInput" disabled="" runat="server" CssClass="form-control" placeholder="MM/DD/YYYY"></asp:TextBox>
                            <span class="input-group-addon">to</span>
                            <asp:TextBox ID="toDateInput" disabled="" runat="server" CssClass="form-control" placeholder="MM/DD/YYYY"></asp:TextBox>
                            <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i>
                            </span>
                        </div>
                    </div>
                </div>
                    </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="courseInput" EventName="SelectedIndexChanged" />
                    </Triggers>
                </asp:UpdatePanel>
                <br />

                 <%-- Section C--%>
                <h4>Section C - Pre Training Assessment</h4>
                <div class="form-group">
                    <strong>
                        <asp:Label ID="objectiveLabel" runat="server" CssClass="col-lg-2 control-label" Text="Objective(s) attending the course (please tick)"></asp:Label></strong>
                    <%--First checkbox--%>
                    <div class="col-lg-10">
                        <div class="checkbox">
                            <label>
                                <asp:CheckBox ID="objectiveInput1" runat="server" Text="To prepare for new job role/task" onClick="forObjective1Clicked('Group1', true)" class="objectiveValidation"/>
                            </label>
                        </div>
                    </div>

                    <div id="objective1text"  style="display: none;">
                        <div class="col-lg-5">
                            <asp:TextBox ID="objectiveElaborate1" TextMode="multiline" Columns="50" Rows="5" runat="server" CssClass="form-control" placeholder="Please elaborate on your choice"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfv_objective1text" ControlToValidate="objectiveElaborate1" runat="server" ErrorMessage="*Required" ForeColor="Red" ValidationGroup="ValidateForm" />
                            <asp:RequiredFieldValidator ID="rfv_objective1textSummary" ControlToValidate="objectiveElaborate1" runat="server" ErrorMessage="Please do not leave the objective blank" ForeColor="Red" ValidationGroup="summaryGroup" Visible="False"/>
                        </div>
                    </div>
                </div>

                <div id="objective1date" style="display: none;">
                    <div class="form-group">
                        <asp:Label ID="completionDateLabel1" runat="server" CssClass="col-lg-2 control-label" Text="Target Completion Date"></asp:Label>
                        <div class="col-lg-5">
                            <div class="input-group date">
                                <asp:TextBox ID="completeDateInput1" runat="server" CssClass="form-control" placeholder="Target Completion Date"></asp:TextBox><span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                                <asp:RequiredFieldValidator ID="rfv_objective1date" ControlToValidate="completeDateInput1" runat="server" ErrorMessage="*Required" ForeColor="Red" ValidationGroup="ValidateForm" />
                                <asp:RequiredFieldValidator ID="rfv_objective1dateSummary" ControlToValidate="completeDateInput1" runat="server" ErrorMessage="Please fill in the date" ForeColor="Red" ValidationGroup="summaryGroup" Visible="False"/>
                            </div>
                            <asp:CustomValidator ID="cv_objective1date"  runat="server" 	ControlToValidate="completeDateInput1" ClientValidationFunction="compareDates1" ErrorMessage="Please enter a date that is after the course end date." ForeColor="Red" ValidationGroup="ValidateForm"></asp:CustomValidator>
                        </div>
                    </div>
                </div>

                 <%--Second checkbox--%>
                <div class="form-group">
                    <%--Empty label for formatting purposes--%>
                    <asp:Label ID="empty2" runat="server" CssClass="col-lg-2 control-label" Text=""></asp:Label>
                    <div class="col-lg-10">
                        <div class="checkbox">
                            <label>
                                <asp:CheckBox ID="objectiveInput2" runat="server" Text="Share the knowledge and skills with fellow colleagues"  onClick="forObjective2Clicked('Group2', true)"  class="objectiveValidation"/>
                            </label>
                        </div>
                    </div>
                    <%--Empty label for formatting purposes--%>
                    <asp:Label ID="empty3" runat="server" CssClass="col-lg-2 control-label" Text=""></asp:Label>
                    <div id="objective2text" style="display: none;">
                        <div class="col-lg-5">
                            <asp:TextBox ID="objectiveElaborate2" TextMode="multiline" Columns="50" Rows="5" runat="server" CssClass="form-control" placeholder="Please elaborate on your choice"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfv_objective2text" ControlToValidate="objectiveElaborate2" runat="server" ErrorMessage="*Required" ForeColor="Red" ValidationGroup="ValidateForm"/>
                            <asp:RequiredFieldValidator ID="rfv_objective2textSummary" ControlToValidate="objectiveElaborate2" runat="server" ErrorMessage="Please do not leave the objective blank" ForeColor="Red" ValidationGroup="summaryGroup" Visible="False"/>
                        </div>
                    </div>
                </div>

                <div id="objective2date" style="display: none;">
                    <div class="form-group">
                        <asp:Label ID="completionDateLabel2" runat="server" CssClass="col-lg-2 control-label" Text="Target Completion Date"></asp:Label>
                        <div class="col-lg-5">
                            <div class="input-group date">
                                <asp:TextBox ID="completeDateInput2" runat="server" CssClass="form-control" placeholder="Target Completion Date"></asp:TextBox><span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                                <asp:RequiredFieldValidator ID="rfv_objective2date" ControlToValidate="completeDateInput2" runat="server" ErrorMessage="*Required" ForeColor="Red" ValidationGroup="ValidateForm"/>
                                <asp:RequiredFieldValidator ID="rfv_objective2dateSummary" ControlToValidate="completeDateInput2" runat="server" ErrorMessage="Please fill in the date" ForeColor="Red" ValidationGroup="summaryGroup" Visible="False"/>
                            </div>
                            <asp:CustomValidator ID="cv_objective2date"  runat="server" 	ControlToValidate="completeDateInput2" ClientValidationFunction="compareDates2" ErrorMessage="Please enter a date that is after the course end date." ForeColor="Red" ValidationGroup="ValidateForm"></asp:CustomValidator>
                        </div>
                    </div>
                </div>

                <%--Third checkbox--%>
                <div class="form-group">
                    <%--Empty label for formatting purposes--%>
                    <asp:Label ID="empty4" runat="server" CssClass="col-lg-2 control-label" Text=""></asp:Label>
                    <div class="col-lg-10">
                        <div class="checkbox">
                            <label>
                                <asp:CheckBox ID="objectiveInput3" runat="server" Text="Others"   onClick="forObjective3Clicked('Group3', true)"  class="objectiveValidation"/>
                            </label>
                        </div>
                    </div>
                    <%--Empty label for formatting purposes--%>
                    <asp:Label ID="empty5" runat="server" CssClass="col-lg-2 control-label" Text=""></asp:Label>
                    <div id="objective3text" style="display: none;">
                        <div class="col-lg-5">
                            <asp:TextBox ID="objectiveElaborate3" TextMode="multiline" Columns="50" Rows="5" runat="server" CssClass="form-control" placeholder="Please elaborate on your choice"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfv_objective3text" ControlToValidate="objectiveElaborate3" runat="server" ErrorMessage="*Required" ForeColor="Red" ValidationGroup="ValidateForm" />
                            <asp:RequiredFieldValidator ID="rfv_objective3textSummary" ControlToValidate="objectiveElaborate3" runat="server" ErrorMessage="Please do not leave the objective blank" ForeColor="Red" ValidationGroup="summaryGroup" Visible="False"/>
                        </div>
                    </div>
                </div>

                <div id="objective3date" style="display: none;">
                    <div class="form-group">
                        <asp:Label ID="completionDateLabel3" runat="server" CssClass="col-lg-2 control-label" Text="Target Completion Date"></asp:Label>
                        <div class="col-lg-5">
                            <div class="input-group date">
                                <asp:TextBox ID="completeDateInput3" runat="server" CssClass="form-control" placeholder="Target Completion Date"></asp:TextBox><span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                                <asp:RequiredFieldValidator ID="rfv_objective3date" ControlToValidate="completeDateInput3" runat="server" ErrorMessage="*Required" ForeColor="Red" ValidationGroup="ValidateForm"/>
                                <asp:RequiredFieldValidator ID="rfv_objectibe3dateSummary" ControlToValidate="completeDateInput3" runat="server" ErrorMessage="Please fill in the date" ForeColor="Red" ValidationGroup="summaryGroup" Visible="False"/>
                            </div>
                            <asp:CustomValidator ID="cv_objective3date"  runat="server" 	ControlToValidate="completeDateInput3" ClientValidationFunction="compareDates3" ErrorMessage="Please enter a date that is after the course end date." ForeColor="Red" ValidationGroup="ValidateForm"></asp:CustomValidator>
                        </div>
                    </div>
                </div>

                <%--Modal for Submission Confirmation--%>
                <div id="submitModal" class="modal fade" role="dialog">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title"><b>Submit Training Request Form</b></h4>
                    </div>
                    <%--Modal Content--%>
                    <div class="modal-body">
                        <div class="wrapper">                            
                            <h4>Are you sure you want to submit?</h4><br />
                            <asp:Button ID="cfmSubmit" CssClass="btn btn-primary" runat="server" Text="Submit" OnClick="submitBtn_Click" />
                            <br />
                            <asp:Label ID="lblErrorMsgFinal" runat="server" CssClass="text-danger" Visible="True"></asp:Label>
                            <%-- <asp:ValidationSummary ID="ValidationSummary1" runat="server" ValidationGroup="summaryGroup" /> --%>
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
                            <h4>Are you sure you want to cancel?<br /> This will clear all fields previously entered!</h4><br />
                            <asp:Button ID="cfmCancel" CssClass="btn btn-primary" runat="server" Text="Clear" OnClick="cfmCancel_Click"/>
                        </div>                       
                    </div>                  
                </div>

            </div>
        </div>
                <%--Modal for REJECTION--%>
                <div id="rejectionModal" class="modal fade" role="dialog">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title"><b>Unsucessful</b></h4>
                    </div>
                    <%--Modal Content--%>
                    <div class="modal-body">
                        <div class="wrapper">                            
                            <h4>Your application is unable to proceed due to the following reason(s):<br /> reasonreasonreason</h4><br />
                            <asp:Button ID="Button1" CssClass="btn btn-primary" runat="server" Text="Go Back"/>
                        </div>                       
                    </div>                  
                </div>

            </div>
        </div>
        <div class="form-group">
                    <%--Empty label for formatting purposes--%>
                    <asp:Label ID="Label1" runat="server" CssClass="col-lg-2 control-label" Text=""></asp:Label>
                    <div id="forObjectiveValidator" style="color: red">
                        <asp:CustomValidator ID="cv1_objective1" runat="server" 
                            EnableClientScript="true"
                            ErrorMessage="Please select at least one objective"
                            ClientValidationFunction="ValidateCheckBoxes"
                            ValidationGroup="ValidateForm">
                        </asp:CustomValidator>
                        <asp:CustomValidator ID="cv1_objective1Summary" runat="server" 
                            EnableClientScript="true"
                            ErrorMessage="Please select at least one objective"
                            ClientValidationFunction="ValidateCheckBoxes"
                            ValidationGroup="summaryGroup" Visible="False">
                        </asp:CustomValidator>
                    </div>
                </div>


                <div class="form-group">
                    <div class="col-lg-10 col-lg-offset-2">
                        <asp:Button ID="submitBtn" CssClass="btn btn-primary" runat="server" Text="Submit" data-toggle="modal" onClientClick ="checkForm_Clicked()" href="#submitModal"/>
                        <asp:Button ID="resetBtn" CssClass="btn btn-default" runat="server" Text="Clear" data-toggle="modal" href="#cancelModal"/>
                    </div>
                </div>
            </fieldset>
        </form>
    </div>
    <script type="text/javascript">

        function checkForm_Clicked(source, args) {
            
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
                document.getElementById('<%= lblErrorMsgFinal.ClientID %>').innerHTML = " ";
                document.getElementById('<%= cfmSubmit.ClientID %>').disabled = false; 
            }
        }
</script>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
