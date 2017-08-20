<%@ Page Title="" Language="C#" MasterPageFile="~/Masterpage.Master" AutoEventWireup="true" CodeBehind="trfApplicationStatus.aspx.cs" Inherits="LearnHub.trfApplicationStatus" %>
<%@ Import Namespace="LearnHub.AppCode.entity"%>
<%@ Import Namespace="LearnHub.AppCode.dao"%>
<%@ Import Namespace="System.Globalization"%>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">
        <h1>Application Status</h1>
        <div class="verticalLine"></div>
        <h3>Training Request Form</h3>

        <table class="table table-striped table-hover ">
            <thead>
                <tr>
                    <th>Application ID</th>
                    <th>Course Applied</th>
                    <th>Application Date</th>
                    <th>Application Type</th>
                    <%--Individual or Group--%>
                    <th>Status</th>
                    <%-- Approved/Pending--%>
                    <th>Approver</th>
                    <th></th>
                </tr>
            </thead>
            <tbody>
                <%
                    if (Session["currentUser"] != null) {
                        User currentUser = (User)Session["currentUser"];
                        UserDAO userDAO = new UserDAO();
                        TNFDAO tnfDAO = new TNFDAO();
                        WorkflowApproverDAO wfaDAO = new WorkflowApproverDAO();
                        TextInfo textInfo = new CultureInfo("en-US", false).TextInfo;

                        List<TNF> allTNF = tnfDAO.getAllTNFByUserID(currentUser.getUserID());
                        foreach (TNF tnf in allTNF)
                        {
                            string approverName = "-";
                            User nextApprover = null;
                            int tnfid = tnf.getTNFID();
                            string courseName = tnfDAO.getCourseFromTNF(tnfid).getCourseName();
                            courseName = textInfo.ToTitleCase(courseName);
                            string application_type = tnf.getType();
                            application_type = textInfo.ToTitleCase(application_type);
                            string status = tnf.getStatus();
                            status = textInfo.ToTitleCase(status);

                            //if (tnf.getStatus().Equals("pending"))
                            //{
                                string approverCategory = wfaDAO.getJobCategory(tnf.getWorkflow().getWorkflowID(), tnf.getWorkflowSub().getWorkflowSubID(), tnf.getWFStatus());

                                if (approverCategory.ToLower().Equals("supervisor"))
                                {
                                    nextApprover = userDAO.getSupervisorbyDepartment(currentUser.getDepartment());
                                    approverName = nextApprover.getName();
                                }
                                else if (approverCategory.ToLower().Equals("hod"))
                                {
                                    nextApprover = userDAO.getHODbyDepartment(currentUser.getDepartment());
                                    approverName = nextApprover.getName();
                                }
                                else if (approverCategory.ToLower().Equals("ceo"))
                                {
                                    nextApprover = userDAO.getCEO();
                                    approverName = nextApprover.getName();
                                }
                                else if (approverCategory.ToLower().Equals("superior"))
                                {
                                    string supervisorID = userDAO.getSupervisorIDOfUser(currentUser.getUserID());
                                    nextApprover = userDAO.getUserByID(supervisorID);
                                    approverName = nextApprover.getName();
                                }
                                else if (approverCategory.ToLower().Equals("hr hod"))
                                {
                                    nextApprover = userDAO.getHRHOD();
                                    approverName = nextApprover.getName();
                                }
                                else
                                {
                                    nextApprover = null;
                                    approverName = "HR";
                                }
                            //}

                            //print out the table
                            if (status.Equals("approved")) {
                                Response.Write("<tr class=\"success\">");
                            } else
                            {
                                Response.Write("<tr>");
                            }
                            Response.Write("<td>" + tnf.getTNFID() + "</td>");
                            Response.Write("<td>" + courseName + "</td>");
                            Response.Write("<td>" + tnf.getApplicationDate().ToString("MM-dd-yyyy")+ "</td>");
                            Response.Write("<td>" + application_type + "</td>");
                            Response.Write("<td>" + status + "</td>");
                            if (nextApprover != null && !approverName.Equals(""))
                            {
                                Response.Write("<td>" + approverName + " (" + nextApprover.getJobTitle() + ")" + "</td>");
                            } else if (nextApprover == null && !approverName.Equals(""))
                            {
                                Response.Write("<td>" + approverName + "</td>");
                            } else
                            {
                                Response.Write("<td>" + "-" + "</td>");
                            }

                            Response.Write("<td>" + "<a href=\"filledTRF.aspx?tnfid=" + tnf.getTNFID() + "\"><span class=\"glyphicon glyphicon-menu-right\"></span>&nbsp;View Form</a>" + "</td>");

                        }
                    }
                %>
            </tbody>
        </table>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
