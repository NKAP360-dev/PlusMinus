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

        $(document).ready(function () {
            Sys.WebForms.PageRequestManager.getInstance().add_endRequest(EndRequestHandler);
            function EndRequestHandler(sender, args) {
                $('.input-group.date').datepicker({
                    calendarWeeks: true,
                    todayHighlight: true,
                    autoclose: true
                });
            }
        });

        function activateDuration(sender, args) {
            document.getElementById("<%= mspBondDuration.ClientID %>").disabled = false;
            document.getElementById("<%= rfv_mspBondDuration.ClientID %>").disabled = false;
        }
        function deactivateDuration(sender, args) {
            document.getElementById("<%= mspBondDuration.ClientID %>").disabled = true;
            document.getElementById("<%= rfv_mspBondDuration.ClientID %>").disabled = true;
        }
    </script>
    <style>
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
                <%
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
                                                <asp:TextBox ID="probationDate" runat="server" CssClass="form-control" placeholder="MM/DD/YYYY" Enabled="False"></asp:TextBox><span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
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
                                                <asp:TextBox ID="trainingCost" runat="server" CssClass="form-control" placeholder="Total Training Costs" TextMode="Number"></asp:TextBox>
                                            </div>
                                            <asp:RequiredFieldValidator ID="rfv_trainingCost" runat="server" ErrorMessage="Please enter an amount" ControlToValidate="trainingCost" ForeColor="red" ValidationGroup="ValidateApproval"></asp:RequiredFieldValidator>
                                            <br />
                                            <asp:CompareValidator ID="compv_trainingCost" runat="server" ErrorMessage="Invalid amount. Please enter an amount inclusive of course fee" Operator="GreaterThan" ForeColor="red" ControlToValidate="trainingCost" ValueToCompare="courseFeeOutput" ValidationGroup="ValidateApproval"></asp:CompareValidator>
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
                                                <asp:TextBox ID="trainingBudgetBal" runat="server" CssClass="form-control" placeholder="Balance Training Cost" Enabled="false"></asp:TextBox>
                                                <span class="input-group-addon">as at </span>
                                                <div class="input-group date">
                                                    <asp:TextBox ID="trainingBudgetDate" runat="server" CssClass="form-control" placeholder="MM/DD/YYYY" Enabled="false"></asp:TextBox><span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>4. MSP/Bond Applicable</td>
                            </tr>
                            <asp:ScriptManager ID="ScriptManager1" runat="server" />
                            <tr>
                                <td>
                                    <div class="form-group">
                                        <div class="col-lg-10">
                                        <div class="checkbox">
                                            <asp:RadioButton ID="rbtnMSP" runat="server" Text="MSP" GroupName="BondMSP"></asp:RadioButton>
                                            <asp:RadioButton ID="rbtnBond" runat="server" Text="Bond" onClick="activateDuration" GroupName="BondMSP"></asp:RadioButton>      
                                            <asp:RadioButton ID="rbtnNA" runat="server" Text="Not Applicable" onClick="deactivateDuration" GroupName="BondMSP"></asp:RadioButton>      
                                        </div>
                                    </div>
                                    </div>
                                </td>
                            </tr>  
                            <tr><td>
                                <div class="form-group">
                                        <div class="col-lg-10">
                                            <div class="input-group">                                          
                                                <asp:TextBox ID="mspBondDuration" runat="server" CssClass="form-control" placeholder="Duration" TextMode="Number"></asp:TextBox>
                                                <span class="input-group-addon">months</span>
                                            </div>
                                            <asp:RequiredFieldValidator ID="rfv_mspBondDuration" runat="server" ErrorMessage="Please enter a duration" ForeColor="red" ControlToValidate="mspBondDuration" ValidationGroup="ValidateApproval"></asp:RequiredFieldValidator>
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
                                                <asp:UpdatePanel ID="fundingPanel" runat="server">
                                                    <ContentTemplate>
                                                        <asp:RadioButtonList ID="rbnlFunding" runat="server" AutoPostBack="True" OnSelectedIndexChanged="rbnlFunding_SelectedIndexChanged">
                                                            <asp:ListItem Value="y" > &nbsp; Yes</asp:ListItem>
                                                            <asp:ListItem Value="n" Selected="True">&nbsp; No</asp:ListItem>
                                                        </asp:RadioButtonList>
                                                        <asp:TextBox ID="txtSourceOfFunding" runat="server" CssClass="form-control" placeholder="Source of Funding" Enabled="false"></asp:TextBox>
                                                        <div class="input-group date">
                                                        <asp:TextBox ID="txtFundingDate" runat="server" CssClass="form-control" placeholder="Funding Date (MM/DD/YYYY)" Enabled="false"></asp:TextBox><span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                                                        </div>
                                                        <asp:RequiredFieldValidator ID="rfv_sourceOfFunding" runat="server" ErrorMessage="Please specify a source of funding" ControlToValidate="txtSourceOfFunding" ForeColor="red" Enabled="false" ValidationGroup="ValidateApproval"></asp:RequiredFieldValidator>
                                                        <br />
                                                        <asp:RequiredFieldValidator ID="rfv_fundingDate" runat="server" ErrorMessage="Please specify a funding date" ControlToValidate="txtFundingDate" ForeColor="red" Enabled="false" ValidationGroup="ValidateApproval"></asp:RequiredFieldValidator>
                                                    </ContentTemplate>
                                                    <Triggers>
                                                        <asp:AsyncPostBackTrigger ControlID="rbnlFunding" EventName="SelectedIndexChanged" />
                                                    </Triggers>
                                                </asp:UpdatePanel>
                                            </div>
                                        </div>
                                    </div>
                                </td></tr>
                            <!--
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
                                </ContentTemplate>
                                <Triggers>
                                    <asp:AsyncPostBackTrigger ControlID="rbnlFunding" EventName="SelectedIndexChanged" />
                                </Triggers>
                                </asp:UpdatePanel>
                                </td></tr>-->
                            <tr><td>
                                6. Cost Centre (for charging to department)
                                </td></tr>
                            <tr><td>
                                  <div class="form-group">
                                        <div class="col-lg-10">
                                            <div class="input-group">                                          
                                                <asp:TextBox ID="costcentre" runat="server" CssClass="form-control" placeholder="Cost Centre" Enabled="False"></asp:TextBox>
                                            </div>
                                        </div>
                                    </div>

                                </td></tr>
                        </table>

                    </fieldset>
                </asp:Panel>
                
                
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
                    <asp:LinkButton ID="approvalBtn" runat="server" CssClass="btn btn-success"  data-toggle="modal" onClientClick ="checkFormApproval_Clicked()" href="#approveModal"><span class="glyphicon glyphicon-ok"></span> &nbsp;Approve</asp:LinkButton>
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
                           <%  NotificationDAO notificationDAO = new NotificationDAO();
                               UserDAO userDAO = new UserDAO();
                               List<Notification> notificationList = new List<Notification>();
                               notificationList = notificationDAO.getApprovedNotificationByTnfID(getTNFid());

                               for (int i=0;i<notificationList.Count();i++) {
                                   Notification n = notificationList[i];
                                   if (n.getRemarks() != null)
                                   {
                                       User u = userDAO.getUserByID(n.getUserIDTo());
                                       Response.Write("<h4>Remarks by " + u.getName() + ", " + u.getJobCategory().ToUpper() + "</h4>");
                                       Response.Write("<textarea class=\"form-control\" rows=\"3\" id=\"textArea\" disabled=\"\">" + n.getRemarks() + "</textarea>");

                                       if (notificationList.Count() > 1 && i != notificationList.Count() - 1)
                                       {
                                           Response.Write(" <div class=\"verticalLine\"></div>");
                                       }
                                   }
                               }
                                %>

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
                            <br />
                            <asp:Label ID="lblErrorMsgFinal" runat="server" CssClass="text-danger" Visible="True"></asp:Label>
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
    <asp:label id="lbl_HR" runat="server" hidden="hidden"></asp:label>
    <script type="text/javascript">

        function checkFormApproval_Clicked(source, args) {
            if (document.getElementById('<%= lbl_HR.ClientID %>').Text = "Is HR") {
                Page_ClientValidate('ValidateApproval');
                //Page_ClientValidate();
                console.log("HR");

                if (!Page_IsValid) {
                    document.getElementById('<%= lblErrorMsgFinal.ClientID %>').style.display = 'inherit';
                    document.getElementById('<%= lblErrorMsgFinal.ClientID %>').innerHTML = "You have not filled up all of the required fields";
                    //Page_ClientValidate('summaryGroup');
                    document.getElementById('<%= cfmApproveBtn.ClientID %>').disabled = true;
                    //document.getElementById('<%= cfmApproveBtn.ClientID %>').onclick = returnFalse;
                    console.log("The end");
                }
                else {
                    document.getElementById('<%= lblErrorMsgFinal.ClientID %>').innerHTML = " ";
                    document.getElementById('<%= cfmApproveBtn.ClientID %>').disabled = false;
                }
                
            }


        }
</script>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
