using System;
using LearnHub.AppCode.dao;
using LearnHub.AppCode.entity;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LearnHub
{
    public partial class filledTRF : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["currentUser"] == null)
            {
                Response.Redirect("/Login.aspx");
            }
            else
            {
                if (!IsPostBack)
                {
                    User currentUser = (User)Session["currentUser"];

                    TNFDAO tnfDAO = new TNFDAO();
                    UserDAO userDAO = new UserDAO();

                    int tnfID = Convert.ToInt32(Request.QueryString["tnfid"]);

                    TNF currentTNF = tnfDAO.getIndividualTNFByID(currentUser.getUserID(), tnfID);

                    if (currentTNF == null || !currentTNF.getUser().getUserID().Equals(currentUser.getUserID()))
                    {
                        Response.Redirect("/errorPage.aspx");
                    }

                    User applicant = userDAO.getUserByID(currentUser.getUserID());

                    Course courseApplied = tnfDAO.getCourseFromTNF(tnfID);
                    Lesson lessonApplied = tnfDAO.getLessonFromTNF(tnfID);
                    TNFData tnfData = tnfDAO.getIndividualTNFDataByID(tnfID);
                    Workflow currentWorkflow = currentTNF.getWorkflow();
                    int probationPeriod = currentWorkflow.getProbationPeriod();
                    TimeSpan ts = currentTNF.getApplicationDate().Subtract(applicant.getStartDate());

                    //setting user information
                    nameOfStaffOutput.Text = applicant.getName();
                    employeeNumberOutput.Text = applicant.getUserID();
                    emailOutput.Text = applicant.getEmail();
                    designationOutput.Text = applicant.getJobTitle();
                    departmentOutput.Text = applicant.getDepartment();

                    //setting course and lesson information
                    courseOutput.Text = courseApplied.getCourseName();
                    startDate.Text = lessonApplied.getStartDate().ToString("d MMM yyyy");
                    endDate.Text = lessonApplied.getEndDate().ToString("d MMM yyyy");
                    startTime.Text = lessonApplied.getStartTime().ToString();
                    endTime.Text = lessonApplied.getEndTime().ToString();
                    venueOutput.Text = lessonApplied.getVenue();
                    instructorOutput.Text = lessonApplied.getInstructor();

                    string internalOrExternal = courseApplied.getInternalOrExternal();
                    if (internalOrExternal.ToLower().Equals("internal"))
                    {
                        inhouse.Checked = true;
                        external.Checked = false;
                        lblExternal.Visible = false;
                        externalCourseProviderOutput.Visible = false;
                    }
                    else
                    {
                        inhouse.Checked = false;
                        external.Checked = true;
                        lblExternal.Visible = true;
                        externalCourseProviderOutput.Visible = true;
                        externalCourseProviderOutput.Text = courseApplied.getCourseProvider();
                    }
                    courseFeeOutput.Text = "$" + courseApplied.getPrice();

                    //setting tnf data information
                    string prepareForNewJobRole = tnfData.getPrepareForNewJobRole();
                    if (prepareForNewJobRole.Equals("y"))
                    {
                        objectiveInput1.Checked = true;
                        objectiveElaborate1.Text = tnfData.getPrepareForNewJobRoleText();
                        completeDateOutput1.Text = tnfData.getPrepareForNewJobRoleCompletionDate().Value.ToString("MM-dd-yyyy");
                    }
                    else
                    {
                        objectiveInput1.Checked = false;
                        objectiveElaborate1.Text = "-";
                        completeDateOutput1.Text = "-";
                    }

                    string shareKnowledge = tnfData.getShareKnowledge();
                    if (shareKnowledge.Equals("y"))
                    {
                        objectiveInput2.Checked = true;
                        objectiveElaborate2.Text = tnfData.getShareKnowledgeText();
                        completeDateOutput2.Text = tnfData.getShareKnowledgeCompletionDate().Value.ToString("MM-dd-yyyy");
                    }
                    else
                    {
                        objectiveInput2.Checked = false;
                        objectiveElaborate2.Text = "-";
                        completeDateOutput2.Text = "-";
                    }

                    string otherObjectives = tnfData.getOtherObjectives();
                    if (otherObjectives.Equals("y"))
                    {
                        objectiveInput3.Checked = true;
                        objectiveElaborate3.Text = tnfData.getOtherObjectivesText();
                        completionDateOutput3.Text = tnfData.getOtherObjectivesCompletionDate().Value.ToString("MM-dd-yyyy");
                    }
                    else
                    {
                        objectiveInput3.Checked = false;
                        objectiveElaborate3.Text = "-";
                        completionDateOutput3.Text = "-";
                    }
                }
            }
        }
    }
}