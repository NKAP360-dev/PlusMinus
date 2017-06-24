<%@ Page Title="" Language="C#" MasterPageFile="~/Masterpage.Master" AutoEventWireup="true" CodeBehind="TRFapproval.aspx.cs" Inherits="LearnHub.TRFapproval" %>
<%@ PreviousPageType VirtualPath="~/pendingApproval.aspx" %> 

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <%@ Import Namespace="LearnHub.AppCode.entity" %>
    <%@ Import Namespace="LearnHub.AppCode.dao" %>

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

          .form-horizontal .control-label-left {
    text-align: left;
    margin-bottom: 0;
    padding-top: 11px;
  }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <form class="form-horizontal" runat="server">
        <div class="container">
            <h1>Approve Training Request Form</h1>
            <div class="verticalLine"></div>
            <asp:Label ID="lblHiddenNotificationID" runat="server" Visible="False"></asp:Label>
            <asp:Label ID="lblHiddenTNFID" runat="server" Visible="False"></asp:Label>
            <br />

            <div class="row">
                

                
                    <%-- Section A--%>
                    <h4>Section A - Staff Particulars</h4>

                    <div class="form-group">
                                <strong>
                            <asp:Label ID="nameOfStaffLabel" runat="server" CssClass="col-lg-2 control-label" Text="Name Of Staff"></asp:Label></strong>
                                 
                                  <asp:Label ID="nameOfStaffOutput" runat="server" CssClass="col-lg-2 control-label-left"></asp:Label>    
                                 
                                </div>
                    <div class="form-group">
                        <strong>
                            <asp:Label ID="employeeNoLabel" runat="server" CssClass="col-lg-2 control-label" Text="Employee No"></asp:Label></strong>
                        
                            <asp:Label ID="employeeNumberOutput" runat="server" CssClass="col-lg-2 control-label-left"></asp:Label>
                        
                    </div>
                    <div class="form-group">
                        <strong>
                            <asp:Label ID="emailLabel" runat="server" CssClass="col-lg-2 control-label" Text="Email Address"></asp:Label></strong>
                        
                            <asp:Label ID="emailOutput" runat="server" CssClass="col-lg-2 control-label-left"></asp:Label>
                        
                    </div>
                    <div class="form-group">
                        <strong>
                            <asp:Label ID="designationLabel" runat="server" CssClass="col-lg-2 control-label" Text="Desgination"></asp:Label></strong>
                        
                            <asp:Label ID="designationOutput" runat="server" CssClass="col-lg-2 control-label-left"></asp:Label>
                        
                    </div>
                    <div class="form-group">
                        <strong>
                            <asp:Label ID="departmentLabel" runat="server" CssClass="col-lg-2 control-label" Text="Department"></asp:Label></strong>
                        
                            <asp:Label ID="departmentOutput" runat="server" CssClass="col-lg-2 control-label-left"></asp:Label>
                        
                    </div>
                    <br />

                    <%-- Section B--%>
                    <h4>Section B - Course Details</h4>
                    <div class="form-group">
                        <strong>
                            <asp:Label ID="courseLabel" runat="server" CssClass="col-lg-2 control-label" Text="Course Title"></asp:Label></strong>
                        
                            <asp:Label ID="courseOutput" runat="server" CssClass="col-lg-2 control-label-left"></asp:Label>
                       
                    </div>
                    <div class="form-group">
                        <strong>
                            <asp:Label ID="dateLabel" runat="server" CssClass="col-lg-2 control-label" Text="Date"></asp:Label></strong>

                              <asp:Label ID="startDate" runat="server" CssClass="col-lg-1 control-label-left"></asp:Label>  
                        <asp:Label ID="toDate" runat="server" CssClass="col-lg-1 control-label-left" Text="to"></asp:Label> 
                              <asp:Label ID="endDate" runat="server" CssClass="col-lg-1 control-label-left"></asp:Label>

                        </div>
                    <div class="form-group">
                        <strong>
                            <asp:Label ID="timeLabel" runat="server" CssClass="col-lg-2 control-label" Text="Time"></asp:Label></strong>

                              <asp:Label ID="startTime" runat="server" CssClass="col-lg-1 control-label-left"></asp:Label>  
                        <asp:Label ID="toTime" runat="server" CssClass="col-lg-1 control-label-left" Text="to"></asp:Label> 
                              <asp:Label ID="endTime" runat="server" CssClass="col-lg-1 control-label-left"></asp:Label>

                        </div>
                    <div class="form-group">
                        <strong>
                            <asp:Label ID="venueLabel" runat="server" CssClass="col-lg-2 control-label" Text="Venue"></asp:Label></strong>
                        
                            <asp:Label ID="venueOutput" runat="server" CssClass="col-lg-2 control-label-left"></asp:Label>
                       
                    </div>
                    <div class="form-group">
                        <strong>
                            <asp:Label ID="instructorLabel" runat="server" CssClass="col-lg-2 control-label" Text="Instructor"></asp:Label></strong>
                        
                            <asp:Label ID="instructorOutput" runat="server" CssClass="col-lg-2 control-label-left"></asp:Label>
                       
                    </div>
                    <div class="form-group">
                        <strong>
                            <asp:Label ID="courseProviderLabel" disabled="" runat="server" CssClass="col-lg-2 control-label" Text="Course Provider"></asp:Label></strong>
                        <div class="col-lg-10">
                            <div class="radio">
                                <label>
                                    <asp:RadioButton ID="inhouse" GroupName="courseProvider" runat="server" Text="Inhouse" Checked="True" Enabled="False" />
                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                <asp:RadioButton ID="external" GroupName="courseProvider" runat="server" Text="External" Enabled="False" />
                                </label>
                            </div>
                        </div>
                        <asp:Label ID="lblExternal" runat="server" CssClass="col-lg-2 control-label" Text="External vendor, if any: "></asp:Label>
                        
                            <asp:Label ID="externalCourseProviderOutput" runat="server" CssClass="col-lg-2 control-label-left"></asp:Label>
                        
                    </div>
                    <div class="form-group">
                        <strong>
                            <asp:Label ID="courseFeeLabel" disabled="" runat="server" CssClass="col-lg-2 control-label" Text="Course Fees with GST"></asp:Label></strong>
                       
                            <asp:Label ID="courseFeeOutput" runat="server" CssClass="col-lg-2 control-label-left"></asp:Label>
                        
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
                                    <asp:CheckBox ID="objectiveInput1" runat="server" Text="To prepare for new job role/task" Enabled="False" />
                                </label>
                            </div>
                        </div>

                        <div class="col-lg-5">
                            <asp:TextBox ID="objectiveElaborate1" disabled="" TextMode="multiline" Columns="50" Rows="5" runat="server" CssClass="form-control" placeholder="Please elaborate on your choice"></asp:TextBox>
                        </div>
                    </div>
                    <div class="form-group">

                        <asp:Label ID="completionDateLabel1" runat="server" CssClass="col-lg-2 control-label" Text="Target Completion Date"></asp:Label>

                                <asp:Label ID="completeDateOutput1" runat="server" CssClass="col-lg-2 control-label-left" Text="Target Completion Date"></asp:Label>
                            
                    </div>

                    <%--Second checkbox--%>
                    <div class="form-group">
                        <%--Empty label for formatting purposes--%>
                        <asp:Label ID="empty2" runat="server" CssClass="col-lg-2 control-label" Text=""></asp:Label>
                        <div class="col-lg-10">
                            <div class="checkbox">
                                <label>
                                    <asp:CheckBox ID="objectiveInput2" runat="server" Text="Share the knowledge and skills with fellow colleagues" Enabled="False" />
                                </label>
                            </div>
                        </div>
                        <%--Empty label for formatting purposes--%>
                        <asp:Label ID="empty3" runat="server" CssClass="col-lg-2 control-label" Text=""></asp:Label>
                        <div class="col-lg-5">
                            <asp:TextBox ID="objectiveElaborate2" disabled="" TextMode="multiline" Columns="50" Rows="5" runat="server" CssClass="form-control" placeholder="Please elaborate on your choice"></asp:TextBox>
                        </div>
                    </div>
                    <div class="form-group">
                        <asp:Label ID="completionDateLabel2" runat="server" CssClass="col-lg-2 control-label" Text="Target Completion Date"></asp:Label>
                                <asp:Label ID="completeDateOutput2" runat="server" CssClass="col-lg-2 control-label-left" Text="Target Completion Date"></asp:Label>
                            
                    </div>

                    <%--Third checkbox--%>
                    <div class="form-group">
                        <%--Empty label for formatting purposes--%>
                        <asp:Label ID="empty4" runat="server" CssClass="col-lg-2 control-label" Text=""></asp:Label>
                        <div class="col-lg-10">
                            <div class="checkbox">
                                <label>
                                    <asp:CheckBox ID="objectiveInput3" runat="server" Text="Others" Enabled="False" />
                                </label>
                            </div>
                        </div>
                        <%--Empty label for formatting purposes--%>
                        <asp:Label ID="empty5" runat="server" CssClass="col-lg-2 control-label" Text=""></asp:Label>
                        <div class="col-lg-5">
                            <asp:TextBox ID="objectiveElaborate3" disabled="" TextMode="multiline" Columns="50" Rows="5" runat="server" CssClass="form-control" placeholder="Please elaborate on your choice"></asp:TextBox>
                        </div>
                    </div>
                    <div class="form-group">
                        <asp:Label ID="completionDateLabel3" runat="server" CssClass="col-lg-2 control-label" Text="Target Completion Date"></asp:Label>

                                <asp:Label ID="completionDateOutput3" runat="server" CssClass="col-lg-2 control-label-left" Text="Target Completion Date"></asp:Label>

                    </div>
            
                

            </div>
            <br />
        <div class="container">
            <div class="verticalLine"></div>
            <br />
            <div class="row">
                <table>
                    <tr>
                        <td>
                            <h3><strong>For Official Use:</strong></h3>
                        </td>
                        <td>&nbsp;&nbsp;</td>
                        <td>
                            <asp:Button ID="viewComments" runat="server" Text="View More Info" CssClass="btn btn-primary" data-toggle="modal" href="#infoModal" />
                        </td>
                    </tr>
                </table>
                <h4><%
                        User currentUser = (User)Session["currentUser"];
                        string category = currentUser.getJobCategory();

                        if (category.Equals("hod") || category.Equals("director"))
                        {
                            Response.Write("HOD Approval");
                        }
                        else if (category.Equals("ceo"))
                        {
                            Response.Write("CEO Approval");
                        }
                        else if (category.Equals("hr director"))
                        {
                            Response.Write("HR Director Approval");
                        }
                %>
                <asp:Panel ID="hrApprovalView" runat="server" Visible="false">
                    <h4>HR Department</h4>
                    <fieldset>
                        <table>
                            <tr>
                                <td>1.  For staff who are on probation, please specify confirmation date</td>
                            </tr>
                            <tr>
                                <td>
                                    <div class="form-group">
                                        <div class="col-lg-10">
                                            <div class="input-group date">
                                                <asp:TextBox ID="probationDate" runat="server" CssClass="form-control" placeholder="MM/DD/YYYY"></asp:TextBox><span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                                            </div>
                                        </div>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>2. Total Training Costs (inclusive of absentee payroll and allowances)</td>
                            </tr>
                            <tr>
                                <td>
                                    <div class="form-group">
                                        <div class="col-lg-10">
                                            <div class="input-group">
                                                <span class="input-group-addon">$</span>
                                                <asp:TextBox ID="trainingCost" runat="server" CssClass="form-control" placeholder="Total Training Costs"></asp:TextBox>
                                            </div>
                                        </div>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>3. Balance Training Budget</td>
                            </tr>
                            <tr>
                                <td>
                                    <div class="form-group">
                                        <div class="col-lg-10">
                                            <div class="input-group">
                                                <span class="input-group-addon">$</span>
                                                <asp:TextBox ID="trainingBudgetBal" runat="server" CssClass="form-control" placeholder="Balance Training Cost"></asp:TextBox>
                                                <span class="input-group-addon">as at </span>
                                                <div class="input-group date">
                                                    <asp:TextBox ID="trainingBudgetDate" runat="server" CssClass="form-control" placeholder="MM/DD/YYYY"></asp:TextBox><span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>4. MSP/Bond Applicable</td>
                            </tr>
                            <tr>
                                <td>
                                    <div class="form-group">
                                        <div class="col-lg-10">
                                        <div class="checkbox">
                                            <label>
                                                <asp:CheckBox ID="mspCheck" runat="server" Text="MSP" />
                                                
                                            </label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                            <label>
                                                <asp:CheckBox ID="bondCheck" runat="server" Text="Bond" />
                                            </label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                            <label>
                                                <asp:CheckBox ID="nilCheck" runat="server" Text="Not Applicable" />
                                            </label>
                                        </div>
                                    </div>
                                    </div>
                                </td>
                            </tr>
                            <tr><td>
                                <div class="form-group">
                                        <div class="col-lg-10">
                                            <div class="input-group">                                          
                                                <asp:TextBox ID="mspBondDuration" runat="server" CssClass="form-control" placeholder="Duration"></asp:TextBox>
                                                <span class="input-group-addon">months</span>
                                            </div>
                                        </div>
                                    </div>
                                </td></tr>
                            <tr><td>
                                5.  If this course is eligible for funding, please specify
                                </td></tr>
                            <tr><td>
                                <div class="form-group">
                                        <div class="col-lg-10">
                                            <div class="input-group">                                          
                                                <asp:TextBox ID="fundingEligible" runat="server" CssClass="form-control" placeholder="Yes/No"></asp:TextBox>
                                            </div>
                                        </div>
                                    </div>
                                </td></tr>
                            <tr><td>
                                6. Funding Application Date
                                </td></tr>
                            <tr><td>
                                     <div class="form-group">
                                        <div class="col-lg-10">
                                            <div class="input-group date">
                                                <asp:TextBox ID="fundingDate" runat="server" CssClass="form-control" placeholder="MM/DD/YYYY"></asp:TextBox><span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                                            </div>
                                        </div>
                                    </div>

                                </td></tr>
                            <tr><td>
                                7. Cost Centre (for charging to department)
                                </td></tr>
                            <tr><td>
                                  <div class="form-group">
                                        <div class="col-lg-10">
                                            <div class="input-group">                                          
                                                <asp:TextBox ID="costcentre" runat="server" CssClass="form-control" placeholder="Cost Centre"></asp:TextBox>
                                            </div>
                                        </div>
                                    </div>

                                </td></tr>
                        </table>

                    </fieldset>
                    <asp:LinkButton ID="hrApprove" runat="server" CssClass="btn btn-success"><span class="glyphicon glyphicon-floppy-disk"></span> &nbsp;Save</asp:LinkButton>
                </asp:Panel>
                </h4>
                
                <asp:Panel ID="normalApprovalView" runat="server">
                    Remarks (if any):
               <asp:TextBox ID="remarksInput" TextMode="multiline" Columns="50" Rows="5" runat="server" CssClass="form-control" placeholder="Remarks (if any)"></asp:TextBox>    
                    <asp:Panel ID="warningPanelPrice" runat="server" Visible="false">
                        <p class="text-danger">
                            <span class="label label-danger">!</span>
                            <asp:Label ID="lblWarningPrice" runat="server" Text="" Visible="false"></asp:Label> <br />
                        </p>
                     </asp:Panel>
                    <asp:Panel ID="warningPanelOverseas" runat="server" Visible="false">
                        <p class="text-danger">
                            <span class="label label-danger">!</span>
                            <asp:Label ID="lblWarningOverseas" runat="server" Text="" Visible="false"></asp:Label> <br />
                        </p>
                    </asp:Panel>
                    <asp:Panel ID="warningPanelProbation" runat="server" Visible="false">
                        <p class="text-danger">
                            <span class="label label-danger">!</span>
                            <asp:Label ID="lblWarningProbation" runat="server" Text="" Visible="false"></asp:Label>
                        </p>
                    </asp:Panel>
                    <br /><br />
                    <asp:LinkButton ID="approvalBtn" runat="server" CssClass="btn btn-success"  data-toggle="modal" href="#approveModal"><span class="glyphicon glyphicon-ok"></span> &nbsp;Approve</asp:LinkButton>
                    <asp:LinkButton ID="rejectBtn" runat="server" CssClass="btn btn-danger" data-toggle="modal" href="#rejectModal"><span class="glyphicon glyphicon-remove"></span> &nbsp;Reject</asp:LinkButton>

                </asp:Panel>
                <br />
            </div>

            <!-- Modal for approval info-->
            <div id="infoModal" class="modal fade" role="dialog">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                            <h4 class="modal-title">&nbsp;<b>Approvals</b></h4>
                        </div>
                        <%--Modal Content--%>
                        <div class="modal-body">
                            <strong>Remarks by _____: </strong>
                           <asp:TextBox ID="TextBox1" disabled="" TextMode="multiline" Columns="50" Rows="5" runat="server" CssClass="form-control" placeholder="Remarks"></asp:TextBox>
                            <div class="verticalLine"></div>
                            <strong>Remarks by _____: </strong>
                           <asp:TextBox ID="TextBox2" disabled="" TextMode="multiline" Columns="50" Rows="5" runat="server" CssClass="form-control" placeholder="Remarks"></asp:TextBox>

                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                        </div>
                    </div>

                </div>
            </div>
            <%--Modal for Approval Confirmation--%>
                <div id="approveModal" class="modal fade" role="dialog">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title"><b>Approve Training Request Form</b></h4>
                    </div>
                    <%--Modal Content--%>
                    <div class="modal-body">
                        <div class="wrapper">                            
                            <h4>Are you sure you want to approve this form?</h4><br />
                                <asp:LinkButton ID="cfmApproveBtn" runat="server" CssClass="btn btn-success" onclick="cfmApproveBtn_Click"><span class="glyphicon glyphicon-ok"></span> &nbsp;Approve</asp:LinkButton>
                        </div>                       
                    </div>                  
                </div>

            </div>
        </div>
            <%--Modal for Rejection Confirmation--%>
                <div id="rejectModal" class="modal fade" role="dialog">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title"><b>Reject Training Request Form</b></h4>
                    </div>
                    <%--Modal Content--%>
                    <div class="modal-body">
                        <div class="wrapper">                            
                            <h4>Are you sure you want to reject this form?</h4><br />
                                <asp:LinkButton ID="cfmRejectBtn" runat="server" CssClass="btn btn-danger" OnClick="cfmRejectBtn_Click"><span class="glyphicon glyphicon-remove"></span> &nbsp;Reject</asp:LinkButton>
                        </div>                       
                    </div>                  
                </div>

            </div>
        </div>
        </div>

    </form>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
