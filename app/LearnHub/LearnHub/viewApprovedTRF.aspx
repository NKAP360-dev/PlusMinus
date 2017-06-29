<%@ Page Title="" Language="C#" MasterPageFile="~/Masterpage.Master" AutoEventWireup="true" CodeBehind="viewApprovedTRF.aspx.cs" Inherits="LearnHub.viewApprovedTRF" %>
<%@ Import Namespace="LearnHub.AppCode.entity"%>
<%@ Import Namespace="LearnHub.AppCode.dao"%>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
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
            <h1>Training Request Form</h1>
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

                <div class="verticalLine"></div>

                <%
                    NotificationDAO notificationDAO = new NotificationDAO();
                    UserDAO userDAO = new UserDAO();
                    List<Notification> notificationList = new List<Notification>();
                    notificationList = notificationDAO.getApprovedNotificationByTnfID(getTNFid());

                    for (int i = 0; i < notificationList.Count(); i++)
                    {
                        Notification n = notificationList[i];
                        if (n.getRemarks() != null)
                        {
                            User u = userDAO.getUserByID(n.getUserIDTo());
                            Response.Write("<h4>Remarks by " + u.getName() + ", " + u.getJobCategory().ToUpper() + "</h4>");
                            Response.Write("<textarea class=\"form-control\" rows=\"3\" id=\"textArea\" disabled=\"\">" + n.getRemarks() + "</textarea>");
                            Response.Write("</br>");
                           
                        }
                    }
                    %>
            
                

            </div>
        </form>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
