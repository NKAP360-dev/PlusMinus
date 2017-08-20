<%@ Page Title="" Language="C#" MasterPageFile="~/Masterpage.Master" AutoEventWireup="true" CodeBehind="approvedTRF.aspx.cs" Inherits="LearnHub.approvedTRF" %>
<%@ Import Namespace="LearnHub.AppCode.entity"%>
<%@ Import Namespace="LearnHub.AppCode.dao"%>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <form id="form1" runat="server" action="/TRFapproval.aspx" method="post">

 <div class="container">
        <h1>View Previously Approved and Rejected Training Request Form</h1>
         <div class="verticalLine">
             
        </div>

        <table class="table table-striped table-hover ">
            <thead>
                <tr>
                    <th>Name</th>
                    <th>Department</th>
                    <th>Job Title</th>
                    <th>Course Name</th>
                    <th>Course Price</th>
                    <th>Date Approved By Me</th>
                    <th>Current TRF Status</th>
                    <th></th>
                </tr>
            </thead>
            <tbody>
                <%
                    UserDAO userDAO = new UserDAO();
                    NotificationDAO notificationDAO = new NotificationDAO();
                    DeptDAO deptDAO = new DeptDAO();
                    TNFDAO tnfDAO = new TNFDAO();

                    User currentUser = (User)Session["currentUser"];
                    List<Notification> allApprovedTRF = notificationDAO.getApprovedNotificationByUserID(currentUser.getUserID());
                    List<Notification> allRejectedTRF = notificationDAO.getRejectedNotificationByUserID(currentUser.getUserID());
                    List<Notification> allTRF = new List<Notification>();

                    foreach (Notification n in allApprovedTRF) {
                        allTRF.Add(n);
                    }

                    foreach (Notification n in allRejectedTRF) {
                        allTRF.Add(n);
                    }

                    if (allTRF.Count > 0)
                    {

                        foreach (Notification n in allTRF)
                        {
                            User approver = userDAO.getUserByID(n.getUserIDFrom());
                            TNF currentTNF = tnfDAO.getIndividualTNFByID(approver.getUserID(), n.getTNFID());
                            Course currentCourse = tnfDAO.getCourseFromTNF(currentTNF.getTNFID());
                            Department currentDept = deptDAO.getDeptByName(approver.getDepartment());

                            Response.Write("<tr>");
                            Response.Write("<td>" + userDAO.getUserByID(n.getUserIDFrom()).getName() + "</td>");
                            Response.Write("<td>" + userDAO.getUserByID(n.getUserIDFrom()).getDepartment() + "</td>");
                            Response.Write("<td>" + userDAO.getUserByID(n.getUserIDFrom()).getJobTitle() + "</td>");
                            Response.Write("<td>" + currentCourse.getCourseName() + "</td>");
                            Response.Write("<td> $" + currentCourse.getPrice() + "</td>");
                            Response.Write("<td>"+ n.getDateApproved() + "</td>");
                            Response.Write("<td>" + tnfDAO.getIndividualTNFByID(approver.getUserID(), n.getTNFID()).getStatus());
                            Response.Write("<td>" + "<a href=\"viewApprovedTRF.aspx?tnfid=" + currentTNF.getTNFID() +"&applicant="+currentTNF.getUser().getUserID()+"\"><span class=\"glyphicon glyphicon-menu-right\"></span>&nbsp;View Form</a>" + "</td>");
                            Response.Write("</tr>");
                        }
                    }
                %>
            </tbody>
        </table>
    </div>

    </form>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
