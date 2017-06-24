using LearnHub.AppCode.dao;
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

                externalCourseProvider.Text = "";
                courseProvider.SelectedIndex = 0;
                fromDateInput.Text = "";
                toDateInput.Text = "";
                courseFeeInput.Text = "";
                Session["selectedCourse"] = null;
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
            int lessonID = Convert.ToInt32(Request.Form["rbnLessonID"]);
            string prepareForNewJobRole = null;
            string prepareForNewJobRoleText = null;
            DateTime? prepareForNewJobRoleCompletedDate = null;
            string shareKnowledge = null;
            string shareKnowledgeText = null;
            DateTime? shareKnowledgeCompletedDate = null;
            string otherObjectives = null;
            string otherObjectivesText = null;
            DateTime? otherObjectivesCompletedDate = null;
            DateTime applicationDate = DateTime.Now.Date;


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
                otherObjectivesCompletedDate = DateTime.ParseExact(completeDateInput3.Text, "MM/dd/yyyy", CultureInfo.InvariantCulture);
            } else
            {
                otherObjectives = "n";
            }


            //creation of TNF object
            Workflow currentWF = wfDAO.getCurrentActiveWorkflow("individual");
            TNF newTNF = new TNF(currentUser, "individual", "pending", 0, currentWF, applicationDate);
            int tnfid = tnfDAO.createTNF(newTNF);
            newTNF.setTNFID(tnfid);
            tnfDAO.createTNF_Data(tnfid, courseID, prepareForNewJobRole, prepareForNewJobRoleText, prepareForNewJobRoleCompletedDate, shareKnowledge, shareKnowledgeText, shareKnowledgeCompletedDate, otherObjectives, otherObjectivesText, otherObjectivesCompletedDate, lessonID);

            //start routing

            Boolean successOrNot = Workflow_Route.routeForApproval(newTNF);
            if (successOrNot)
            {
                //to create lesson info
                Response.Redirect("~/submitTRF.aspx");
            }
            else
            {
                //do something
            }
        }

        protected void cfmCancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("applyCourse.aspx");
        }

            protected void courseInput_SelectedIndexChanged(object sender, EventArgs e)
        {
            int courseID = Convert.ToInt32(courseInput.SelectedValue);
            Session["selectedCourse"] = courseID;
            if (courseID == -1)
            {
                courseFeeInput.Text = "";
                externalCourseProvider.Text = "";
                fromDateInput.Text = "";
                toDateInput.Text = "";
            }
            else
            {
                gvLesson.DataBind();
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