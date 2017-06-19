<%@ Page Title="Apply For Courses - LearnHub" Language="C#" MasterPageFile="~/Masterpage.Master" AutoEventWireup="true" CodeBehind="applyCourse.aspx.cs" Inherits="LearnHub.applyCourse" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="/bootstrap/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.3.0/css/datepicker.css" rel="stylesheet" type="text/css" />

    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
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
        <div id="myModal" class="modal fade" role="dialog">
            <div class="modal-dialog">
                <!-- Modal content-->
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title"><span class="glyphicon glyphicon-info-sign"></span>&nbsp;<b>Please read before you proceed</b></h4>
                    </div>
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
        <form class="form-horizontal" runat="server">
            <fieldset>
                <legend>Training Request Form<a class="btn" data-toggle="modal" href="#myModal"><span class="glyphicon glyphicon-info-sign"></span></a></legend>

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
                <h4>Section B - Course Details</h4>
                <div class="form-group">
                    <strong>
                        <asp:Label ID="courseLabel" runat="server" CssClass="col-lg-2 control-label" Text="Course Title"></asp:Label></strong>
                    <div class="col-lg-5">
                        <asp:TextBox ID="courseInput" runat="server" CssClass="form-control" placeholder="Course Title"></asp:TextBox>
                    </div>
                </div>
                <div class="form-group">
                    <strong>
                        <asp:Label ID="courseProviderLabel" runat="server" CssClass="col-lg-2 control-label" Text="Course Provider"></asp:Label></strong>
                    <div class="col-lg-10">
                        <div class="radio">
                            <label>
                                <asp:RadioButton ID="inhouse" GroupName="courseProvider" runat="server" Text="Inhouse" />
                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                <asp:RadioButton ID="external" GroupName="courseProvider" runat="server" Text="External" />
                            </label>
                        </div>
                    </div>
                    <asp:Label ID="empty" runat="server" CssClass="col-lg-2 control-label" Text=""></asp:Label>
                    <div class="col-lg-5">
                        <asp:TextBox ID="externalCourseProvider" runat="server" CssClass="form-control" placeholder="If external, please specify"></asp:TextBox>
                    </div>
                </div>
                <div class="form-group">
                    <strong>
                        <asp:Label ID="courseFeeLabel" runat="server" CssClass="col-lg-2 control-label" Text="Course Fees with GST"></asp:Label></strong>
                    <div class="col-lg-5">
                        <asp:TextBox ID="courseFeeInput" runat="server" CssClass="form-control" placeholder="Course Fees with GST (where applicable)"></asp:TextBox>
                    </div>
                </div>

                <div class="form-group">
                    <strong>
                        <asp:Label ID="dateLabel" runat="server" CssClass="col-lg-2 control-label" Text="Date"></asp:Label></strong>
                    <%--<div class="col-lg-15">
                        <div id="datepicker" class="input-group date" data-date-format="dd-mm-yyyy">
                            <asp:TextBox ID="dateStart" runat="server" CssClass="form-control" placeholder="Date"></asp:TextBox>
                            <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>                                             
                        </div>      --%>
                    <div class="col-lg-5">
                        <div class="input-daterange input-group" id="datepicker">
                            <asp:TextBox ID="fromDateInput" runat="server" CssClass="form-control" placeholder="Start Date"></asp:TextBox>
                            <span class="input-group-addon">to</span>
                            <asp:TextBox ID="toDateInput" runat="server" CssClass="form-control" placeholder="End Date"></asp:TextBox>
                            <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                        </div>
                    </div>
                </div>

                <br />
                <h4>Section C - Pre Training Assessment</h4>
                <div class="form-group">
                    <strong>
                        <asp:Label ID="objectiveLabel" runat="server" CssClass="col-lg-2 control-label" Text="Objective attending the course (please tick)"></asp:Label></strong>
                    <div class="col-lg-10">
                        <div class="radio">
                            <label>
                                <asp:RadioButton ID="RadioButton1" GroupName="objective" runat="server" Text="To prepare for new job role/task" />
                                <br />
                                <asp:RadioButton ID="RadioButton2" GroupName="objective" runat="server" Text="Share the knowledge and skills with fellow colleagues" />
                                <br />
                                <asp:RadioButton ID="RadioButton3" GroupName="objective" runat="server" Text="Others" />
                            </label>
                        </div>
                    </div>
                    <asp:Label ID="Label1" runat="server" CssClass="col-lg-2 control-label" Text=""></asp:Label>
                    <div class="col-lg-5">
                        <asp:TextBox ID="TextBox1" TextMode="multiline" Columns="50" Rows="5" runat="server" CssClass="form-control" placeholder="Please elaborate on your choice"></asp:TextBox>
                    </div>

                </div>
                <div class="form-group">
                    <strong>
                        <asp:Label ID="completionDateLabel" runat="server" CssClass="col-lg-2 control-label" Text="Target Completion Date"></asp:Label></strong>
                    <div class="col-lg-5">
                        <div class="input-group date">
                        <asp:TextBox ID="completeDateInput" runat="server" CssClass="form-control" placeholder="Target Completion Date"></asp:TextBox><span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                        </div>
                    </div>
                </div>






                <div class="form-group">
                    <div class="col-lg-10 col-lg-offset-2">
                        <asp:Button ID="submitBtn" CssClass="btn btn-primary" runat="server" Text="Submit" OnClick="submitBtn_Click" />
                         <asp:Button ID="resetBtn" CssClass="btn btn-default" runat="server" Text="Cancel" />
                    </div>
                </div>
            </fieldset>
        </form>
    </div>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
