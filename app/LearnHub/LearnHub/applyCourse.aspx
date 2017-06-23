<%@ Page Title="Apply For Courses - LearnHub" Language="C#" MasterPageFile="~/Masterpage.Master" AutoEventWireup="true" CodeBehind="applyCourse.aspx.cs" Inherits="LearnHub.applyCourse" %>

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
                <legend>Training Request Form<a class="btn" data-toggle="modal" href="#myModal"><span class="glyphicon glyphicon-info-sign"></span></a></legend>

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
                    </div>
                </div>
    
                <%-- Make table dynamically appear only after course is selected from DDL--%>
                        <div class="form-group">
                            <strong>
                                <asp:Label ID="lessonSelection" runat="server" CssClass="col-lg-2 control-label" Text="Lesson Selection"></asp:Label></strong>
                            <div class="col-lg-10">
                                <table class="table table-striped table-hover ">
                                    <thead>
                                        <tr>
                                            <th>Select</th>
                                            <th>Start Date</th>
                                            <th>End Date</th>
                                            <th>Start Time</th>
                                            <th>End Time</th>
                                            <th>Venue</th>
                                            <th>Instructor</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td>
                                                <asp:RadioButton ID="RadioButton1" runat="server" GroupName="lesson" /></td>
                                            <td>MM/DD/YYYY</td>
                                            <td>MM/DD/YYYY</td>
                                            <td>Time</td>
                                            <td>Time</td>
                                            <td>Venue</td>
                                            <td>Instructor</td>
                                        </tr>
                                        <tr>
                                        <tr>
                                            <td>
                                                <asp:RadioButton ID="RadioButton2" runat="server" GroupName="lesson" /></td>
                                            <td>MM/DD/YYYY</td>
                                            <td>MM/DD/YYYY</td>
                                            <td>Time</td>
                                            <td>Time</td>
                                            <td>Venue</td>
                                            <td>Instructor</td>
                                        </tr>
                                        <tr>
                                    </tbody>


                                </table>
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
                                <asp:CheckBox ID="objectiveInput1" runat="server" Text="To prepare for new job role/task" />
                            </label>
                        </div>
                    </div>

                    <div class="col-lg-5">
                        <asp:TextBox ID="objectiveElaborate1" TextMode="multiline" Columns="50" Rows="5" runat="server" CssClass="form-control" placeholder="Please elaborate on your choice"></asp:TextBox>
                    </div>
                </div>

                <div class="form-group">

                    <asp:Label ID="completionDateLabel1" runat="server" CssClass="col-lg-2 control-label" Text="Target Completion Date"></asp:Label>
                    <div class="col-lg-5">
                        <div class="input-group date">
                            <asp:TextBox ID="completeDateInput1" runat="server" CssClass="form-control" placeholder="MM/DD/YYYY"></asp:TextBox><span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
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
                                <asp:CheckBox ID="objectiveInput2" runat="server" Text="Share the knowledge and skills with fellow colleagues" />
                            </label>
                        </div>
                    </div>
                    <%--Empty label for formatting purposes--%>
                    <asp:Label ID="empty3" runat="server" CssClass="col-lg-2 control-label" Text=""></asp:Label>
                    <div class="col-lg-5">
                        <asp:TextBox ID="objectiveElaborate2" TextMode="multiline" Columns="50" Rows="5" runat="server" CssClass="form-control" placeholder="Please elaborate on your choice"></asp:TextBox>
                    </div>
                </div>

                <div class="form-group">
                    <asp:Label ID="completionDateLabel2" runat="server" CssClass="col-lg-2 control-label" Text="Target Completion Date"></asp:Label>
                    <div class="col-lg-5">
                        <div class="input-group date">
                            <asp:TextBox ID="completeDateInput2" runat="server" CssClass="form-control" placeholder="MM/DD/YYYY"></asp:TextBox><span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
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
                                <asp:CheckBox ID="objectiveInput3" runat="server" Text="Others" />
                            </label>
                        </div>
                    </div>
                    <%--Empty label for formatting purposes--%>
                    <asp:Label ID="empty5" runat="server" CssClass="col-lg-2 control-label" Text=""></asp:Label>
                    <div class="col-lg-5">
                        <asp:TextBox ID="objectiveElaborate3" TextMode="multiline" Columns="50" Rows="5" runat="server" CssClass="form-control" placeholder="Please elaborate on your choice"></asp:TextBox>
                    </div>
                </div>

                <div class="form-group">
                    <asp:Label ID="completionDateLabel3" runat="server" CssClass="col-lg-2 control-label" Text="Target Completion Date"></asp:Label>
                    <div class="col-lg-5">
                        <div class="input-group date">
                            <asp:TextBox ID="completionDateInput3" runat="server" CssClass="form-control" placeholder="MM/DD/YYYY"></asp:TextBox><span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
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
                    <div class="col-lg-10 col-lg-offset-2">
                        <asp:Button ID="submitBtn" CssClass="btn btn-primary" runat="server" Text="Submit" data-toggle="modal" href="#submitModal"/>
                        <asp:Button ID="resetBtn" CssClass="btn btn-default" runat="server" Text="Clear" data-toggle="modal" href="#cancelModal"/>
                    </div>
                </div>
            </fieldset>
        </form>
    </div>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
