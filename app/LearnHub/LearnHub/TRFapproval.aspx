<%@ Page Title="" Language="C#" MasterPageFile="~/Masterpage.Master" AutoEventWireup="true" CodeBehind="TRFapproval.aspx.cs" Inherits="LearnHub.TRFapproval" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.3.0/css/datepicker.css" rel="stylesheet" type="text/css" />

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.3.0/js/bootstrap-datepicker.js"></script>

    <script>

        $(function () {
            $('.input-group.date').datepicker({
                calendarWeeks: true,
                todayHighlight: true,
                autoclose: true
            });
        });

    </script>
    <style>
        #accordion .panel-heading {
            padding: 0;
        }

        #accordion .panel-title > a {
            display: block;
            padding: 0.4em 0.6em;
            outline: none;
            font-weight: bold;
            text-decoration: none;
        }

            #accordion .panel-title > a.accordion-toggle::before, #accordion a[data-toggle="collapse"]::before {
                content: "\e113";
                float: left;
                font-family: 'Glyphicons Halflings';
                margin-right: 1em;
            }

            #accordion .panel-title > a.accordion-toggle.collapsed::before, #accordion a.collapsed[data-toggle="collapse"]::before {
                content: "\e114";
            }

        .buttonAdjust {
            width: 100%;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <form class="form-horizontal" runat="server">
        <div class="container">
            <h1>Approve Training Request Form</h1>
            <div class="verticalLine"></div>
            <br />

            <%--panel-collapse collapse in = open auto when page is loaded
                panel-collapse collapse    = closed when page is loaded --%>
            <div class="row">
                Please review the form below and approve accordingly
                <br />
                <br />

                <div class="panel-group" id="accordion" role="tablist" aria-multiselectable="true">
                    <div class="panel panel-default">
                        <div class="panel-heading" role="tab" id="headingOne">
                            <h4 class="panel-title">
                                <a role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseOne" aria-expanded="true" aria-controls="collapseOne">Supervisor Approval
                    </a>
                            </h4>
                        </div>
                        <div id="collapseOne" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="headingOne">
                            <div class="panel-body">

                                <asp:Label ID="supRemarks" runat="server" Text="Remarks (if any)"></asp:Label>
                                <asp:TextBox ID="supRemarksInput" TextMode="multiline" Columns="50" Rows="5" runat="server" CssClass="form-control" placeholder="Remarks (if any)"></asp:TextBox>
                                <br />
                                <asp:LinkButton ID="supApprove" runat="server" CssClass="btn btn-success"><span class="glyphicon glyphicon-ok"></span> &nbsp;Approve</asp:LinkButton>


                            </div>
                        </div>
                    </div>
                    <div class="panel panel-default">
                        <div class="panel-heading" role="tab" id="headingTwo">
                            <h4 class="panel-title">
                                <a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">HOD Approval
                    </a>
                            </h4>
                        </div>
                        <div id="collapseTwo" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingTwo">
                            <div class="panel-body">
                                <asp:Label ID="hodRemarks" runat="server" Text="Remarks (if any)"></asp:Label>
                                <asp:TextBox ID="hodRemarksInput" TextMode="multiline" Columns="50" Rows="5" runat="server" CssClass="form-control" placeholder="Remarks (if any)"></asp:TextBox>
                                <br />
                                <asp:LinkButton ID="hodApprove" runat="server" CssClass="btn btn-success"><span class="glyphicon glyphicon-ok"></span> &nbsp;Approve</asp:LinkButton>

                            </div>
                        </div>
                    </div>
                    <div class="panel panel-default">
                        <div class="panel-heading" role="tab" id="headingThree">
                            <h4 class="panel-title">
                                <a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseThree" aria-expanded="false" aria-controls="collapseThree">For Official Use (HR Department)
                    </a>
                            </h4>
                        </div>
                        <div id="collapseThree" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingThree">
                            <div class="panel-body">
                                <div class="form-group">
                                    <table>
                                        <tr>
                                            <td>&nbsp;1.  For staff who are on probation, please specify confirmation date</td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <div class="col-lg-10">
                                                    <div class="input-group date">
                                                        <asp:TextBox ID="probationInput" runat="server" CssClass="form-control" placeholder="Target Completion Date"></asp:TextBox><span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                                                    </div>
                                                </div>
                                            </td>
                                        </tr>

                                        <tr>
                                            <td>&nbsp;2. Total Training Costs (inclusive of absentee payroll and allowances)
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <div class="col-lg-10">
                                                    <div class="input-group">
                                                        <span class="input-group-addon">$</span>
                                                        <asp:TextBox ID="trainingCost" runat="server" CssClass="form-control" placeholder="Total Training Costs"></asp:TextBox>
                                                    </div>
                                                </div>

                                            </td>
                                        </tr>

                                        <tr>
                                            <td>&nbsp;3. Balance Training Budget
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <div class="col-lg-10">
                                                    <div class="input-group">
                                                        <span class="input-group-addon">$</span>
                                                        <asp:TextBox ID="trainingBudget" runat="server" CssClass="form-control" placeholder="Balance Training Cost"></asp:TextBox>
                                                        <span class="input-group-addon">as at </span>
                                                        <div class="input-group date">
                                                            <asp:TextBox ID="TextBox1" runat="server" CssClass="form-control" placeholder="dd/mm/yyyy"></asp:TextBox><span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                                                        </div>

                                                    </div>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>&nbsp;4. MSP/Bond Applicable
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                
                                                    <div class="checkbox">
                                                        <label>
                                                            <asp:CheckBox ID="CheckBox1" runat="server" Text="MSP" />

                                                        </label>
                                                    </div>
                                                
                                            </td>
                                            <td>
                                                <div class="checkbox">
                                                    <label>
                                                        <asp:CheckBox ID="CheckBox2" runat="server" Text="Bond" />

                                                    </label>
                                                </div>
                                                </td>
                                            <td>
                                                <div class="checkbox">
                                                    <label>
                                                        <asp:CheckBox ID="CheckBox3" runat="server" Text="Not Applicable" />

                                                    </label>
                                                </div>

                                            </td>  
                                </tr>
                                    </table>




                            </div>
                        </div>
                    </div>
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="headingFour">
                        <h4 class="panel-title">
                            <a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseFour" aria-expanded="false" aria-controls="collapseFour">HR Director Approval
                    </a>
                        </h4>
                    </div>
                    <div id="collapseFour" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingFour">
                        <div class="panel-body">
                            <asp:Label ID="hrdRemarks" runat="server" Text="Remarks (if any)"></asp:Label>
                            <asp:TextBox ID="hrdRemarksInput" TextMode="multiline" Columns="50" Rows="5" runat="server" CssClass="form-control" placeholder="Remarks (if any)"></asp:TextBox>
                            <br />
                            <asp:LinkButton ID="hrdApprove" runat="server" CssClass="btn btn-success"><span class="glyphicon glyphicon-ok"></span> &nbsp;Approve</asp:LinkButton>

                        </div>
                    </div>
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="headingFive">
                        <h4 class="panel-title">
                            <a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseFive" aria-expanded="false" aria-controls="collapseFive">CEO Approval
                    </a>
                        </h4>
                    </div>
                    <div id="collapseFive" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingFive">
                        <div class="panel-body">
                            <asp:Label ID="ceoRemarks" runat="server" Text="Remarks (if any)"></asp:Label>
                            <asp:TextBox ID="ceoRemarksInput" TextMode="multiline" Columns="50" Rows="5" runat="server" CssClass="form-control" placeholder="Remarks (if any)"></asp:TextBox>
                            <br />
                            <asp:LinkButton ID="ceoApprove" runat="server" CssClass="btn btn-success"><span class="glyphicon glyphicon-ok"></span> &nbsp;Approve</asp:LinkButton>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="verticalLine"></div>
        <br />
        <br />

        <div class="row">
            <fieldset>


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
                <h4>Section B - Course Details</h4>
                <div class="form-group">
                    <strong>
                        <asp:Label ID="courseLabel" runat="server" CssClass="col-lg-2 control-label" Text="Course Title"></asp:Label></strong>
                    <div class="col-lg-5">
                        <asp:DropDownList ID="courseInput" runat="server" CssClass="form-control" placeholder="Course Title"></asp:DropDownList>
                    </div>
                </div>
                <div class="form-group">
                    <strong>
                        <asp:Label ID="sessionLabel" runat="server" CssClass="col-lg-2 control-label" Text="Session"></asp:Label></strong>
                    <div class="col-lg-5">
                        <asp:DropDownList ID="courseSession" runat="server" CssClass="form-control" placeholder="lessonID + startDate - endDate"></asp:DropDownList>
                        <strong>
                            <asp:Label ID="Label1" runat="server" CssClass="col-lg-2 control-label" Text="Venue:"></asp:Label></strong>
                        <asp:Label ID="Label2" runat="server" CssClass="col-lg-2 control-label" Text="generated"></asp:Label>&nbsp;&nbsp;
                        <strong>
                            <asp:Label ID="venue" runat="server" CssClass="col-lg-2 control-label" Text="Time:"></asp:Label></strong>
                        <asp:Label ID="time" runat="server" CssClass="col-lg-2 control-label" Text="generated"></asp:Label>

                    </div>
                </div>


                <div class="form-group">
                    <strong>
                        <asp:Label ID="courseProviderLabel" disabled="" runat="server" CssClass="col-lg-2 control-label" Text="Course Provider"></asp:Label></strong>
                    <div class="col-lg-10">
                        <div class="radio">
                            <label>
                                <asp:RadioButton ID="inhouse" GroupName="courseProvider" runat="server" Text="Inhouse" Checked="True" />
                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                <asp:RadioButton ID="external" GroupName="courseProvider" runat="server" Text="External" />
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
                            <asp:TextBox ID="fromDateInput" disabled="" runat="server" CssClass="form-control" placeholder="Start Date"></asp:TextBox>
                            <span class="input-group-addon">to</span>
                            <asp:TextBox ID="toDateInput" disabled="" runat="server" CssClass="form-control" placeholder="End Date"></asp:TextBox>
                            <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                        </div>
                    </div>
                </div>

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
                            <asp:TextBox ID="completeDateInput1" runat="server" CssClass="form-control" placeholder="Target Completion Date"></asp:TextBox><span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
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
                            <asp:TextBox ID="completeDateInput2" runat="server" CssClass="form-control" placeholder="Target Completion Date"></asp:TextBox><span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
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
                            <asp:TextBox ID="completionDateInput3" runat="server" CssClass="form-control" placeholder="Target Completion Date"></asp:TextBox><span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                        </div>
                    </div>
                </div>

            </fieldset>

        </div>
        </div>

    </form>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
