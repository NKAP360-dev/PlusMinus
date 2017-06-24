﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Masterpage.Master" AutoEventWireup="true" CodeBehind="pendingApproval.aspx.cs" Inherits="LearnHub.pendingApproval" %>
<%@ Import Namespace="LearnHub.AppCode.entity"%>
<%@ Import Namespace="LearnHub.AppCode.dao"%>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <form id="form1" runat="server" action="/TRFapproval.aspx" method="post">

 <div class="container">
        <h1>View Notifications</h1>
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
                    <th>Department's Budget</th>
                    <th>Project Budget after Deduction</th>
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
                    List<Notification> allPendingNotifications = notificationDAO.getPendingNotificationByUserID(currentUser.getUserID());
                    if (allPendingNotifications.Count > 0)
                    {

                        foreach (Notification n in allPendingNotifications)
                        {
                            TNF currentTNF = tnfDAO.getIndividualTNFByID(n.getUserIDFrom(), n.getTNFID());
                            Course currentCourse = tnfDAO.getCourseFromTNF(currentTNF.getTNFID());
                            Department currentDept = deptDAO.getDeptByName(currentUser.getDepartment());

                            Response.Write("<tr>");
                            Response.Write("<td>" + userDAO.getUserByID(n.getUserIDFrom()).getName() + "</td>");
                            Response.Write("<td>" + userDAO.getUserByID(n.getUserIDFrom()).getDepartment() + "</td>");
                            Response.Write("<td>" + userDAO.getUserByID(n.getUserIDFrom()).getJobTitle() + "</td>");
                            Response.Write("<td>" + currentCourse.getCourseName() + "</td>");
                            Response.Write("<td> $" + currentCourse.getPrice() + "</td>");
                            Response.Write("<td> $" + currentDept.getActualBudget() + "</td>");
                            Response.Write("<td> $" + (currentDept.getActualBudget() - currentCourse.getPrice()) + "</td>");
                            //Response.Write("<td>" + "<input type=\"hidden\" name=\"tnfID\" id=\"tnfID\" value=\"" + currentTNF.getTNFID() + "\" />" + "<a href=\"/TRFapproval.aspx\"><span class=\"glyphicon glyphicon-menu-right\"></span>&nbsp;More Info</a>" + "</td>");
                            Response.Write("<td>");
                            Response.Write("<input type=\"hidden\" name=\"tnfID\" id=\"tnfID\" value=\"" + currentTNF.getTNFID() + "\" runat=\"server\" />");
                            Response.Write("<input type=\"hidden\" name=\"userID\" id=\"userID\" value=\"" + n.getUserIDFrom() + "\" runat=\"server\" />");
                            Response.Write("<input type=\"submit\" value=\"more info\" class=\"btn btn-info\" />" + "</td>");
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
