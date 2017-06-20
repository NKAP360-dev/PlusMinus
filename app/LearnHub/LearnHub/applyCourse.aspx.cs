﻿using LearnHub.AppCode.dao;
using LearnHub.AppCode.entity;
using LearnHub.AppCode.workflow;
using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LearnHub
{
    public partial class applyCourse : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["currentUser"] == null)
            {
                Response.Redirect("/Login.aspx");
            } else
            {
                User currentUser = (User)Session["currentUser"];
                nameOfStaffInput.Text = currentUser.getName();
                employeeNoInput.Text = currentUser.getUserID();
                emailInput.Text = currentUser.getEmail();
                designationInput.Text = currentUser.getJobTitle();
                departmentInput.Text = currentUser.getDepartment();
            }
        }

        protected void submitBtn_Click(object sender, EventArgs e)
        {
            //To do validations here

            //Assume all fields entered correctly
            //declaration of variables
            WorkflowDAO wfDAO = new WorkflowDAO();
            TNFDAO tnfDAO = new TNFDAO();
            User currentUser = (User)Session["currentUser"];
            int courseID = Convert.ToInt32(courseInput.SelectedValue);
            string prepareForNewJobRole = null;
            string prepareForNewJobRoleText = null;
            DateTime? prepareForNewJobRoleCompletedDate = null;
            string shareKnowledge = null;
            string shareKnowledgeText = null;
            DateTime? shareKnowledgeCompletedDate = null;
            string otherObjectives = null;
            string otherObjectivesText = null;
            DateTime? otherObjectivesCompletedDate = null;


            if (objectiveInput1.Checked)
            {
                prepareForNewJobRole = "y";
                prepareForNewJobRoleText = objectiveElaborate1.Text;
                prepareForNewJobRoleCompletedDate = DateTime.ParseExact(completeDateInput1.Text, "MM/dd/yyyy", CultureInfo.InvariantCulture);
            } else
            {
                prepareForNewJobRole = "n";
            }
            if (objectiveInput2.Checked)
            {
                shareKnowledge = "y";
                shareKnowledgeText = objectiveElaborate2.Text;
                shareKnowledgeCompletedDate = DateTime.ParseExact(completeDateInput2.Text, "MM/dd/yyyy", CultureInfo.InvariantCulture);
            } else
            {
                shareKnowledge = "n";
            }
            if (objectiveInput3.Checked)
            {
                otherObjectives = "y";
                otherObjectivesText = objectiveElaborate3.Text;
                otherObjectivesCompletedDate = DateTime.ParseExact(completionDateInput3.Text, "MM/dd/yyyy", CultureInfo.InvariantCulture);
            } else
            {
                otherObjectives = "n";
            }


            //creation of TNF object
            Workflow currentWF = wfDAO.getCurrentActiveWorkflow("individual");
            TNF newTNF = new TNF(currentUser, "individual", "pending", 0, currentWF);
            int tnfid = tnfDAO.createTNF(newTNF);
            newTNF.setTNFID(tnfid);
            tnfDAO.createTNF_Data(tnfid, courseID, prepareForNewJobRole, prepareForNewJobRoleText, prepareForNewJobRoleCompletedDate, shareKnowledge, shareKnowledgeText, shareKnowledgeCompletedDate, otherObjectives, otherObjectivesText, otherObjectivesCompletedDate);

            //start routing
            Workflow_Route.routeForApproval(newTNF);
        }

        protected void courseInput_SelectedIndexChanged(object sender, EventArgs e)
        {
            int courseID = Convert.ToInt32(courseInput.SelectedValue);
            if (courseID == -1)
            {
                courseFeeInput.Text = "";
                externalCourseProvider.Text = "";
                fromDateInput.Text = "";
                toDateInput.Text = "";
            }
            else
            {
                CourseDAO courseDAO = new CourseDAO();
                Course selectedCourse = courseDAO.getCourseByID(courseID);

                if (selectedCourse != null)
                {
                    courseFeeInput.Text = selectedCourse.getPrice().ToString();
                    if (selectedCourse.getCourseProvider() != null)
                    {
                        courseProvider.SelectedIndex = 1;
                        externalCourseProvider.Text = selectedCourse.getCourseProvider();
                    } else
                    {
                        externalCourseProvider.Text = "";
                        courseProvider.SelectedIndex = 0;
                    }
                    fromDateInput.Text = selectedCourse.getStartDate().ToShortDateString();
                    toDateInput.Text = selectedCourse.getEndDate().ToShortDateString();
                }
            }
        }
    }
}