using System;
using LearnHub.AppCode.dao;
using LearnHub.AppCode.entity;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using LearnHub.AppCode.workflow;
using System.Globalization;

namespace LearnHub
{
    public partial class TRFapproval : System.Web.UI.Page
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
                    NotificationDAO notificationDAO = new NotificationDAO();

                    int notificationID = Convert.ToInt32(Request.QueryString["n"]);

                    Notification currentNotification = notificationDAO.getNotificationByID(notificationID);

                    if (currentNotification == null || !currentNotification.getUserIDTo().Equals(currentUser.getUserID()))
                    {
                        Response.Redirect("/pendingApproval.aspx");
                    }

                    TNF currentTNF = tnfDAO.getIndividualTNFByID(currentNotification.getUserIDFrom(), currentNotification.getTNFID());
                    User applicant = userDAO.getUserByID(currentNotification.getUserIDFrom());

                    Course courseApplied = tnfDAO.getCourseFromTNF(currentNotification.getTNFID());
                    Lesson lessonApplied = tnfDAO.getLessonFromTNF(currentNotification.getTNFID());
                    TNFData tnfData = tnfDAO.getIndividualTNFDataByID(currentNotification.getTNFID());
                    Workflow currentWorkflow = currentTNF.getWorkflow();
                    int probationPeriod = currentWorkflow.getProbationPeriod();
                    TimeSpan ts = currentTNF.getApplicationDate().Subtract(applicant.getStartDate());

                    //show warning if overseas, probation, > 10000
                    if (courseApplied.getPrice() > 10000)
                    {
                        warningPanelPrice.Visible = true;
                        lblWarningPrice.Visible = true;
                        lblWarningPrice.Text = "This course is over $10,000";
                    }
                    if (courseApplied.getOverseas().ToLower().Equals("y"))
                    {
                        warningPanelOverseas.Visible = true;
                        lblWarningOverseas.Visible = true;
                        lblWarningOverseas.Text = "This course is an overseas course";
                    }
                    if (ts.TotalDays < probationPeriod)
                    {
                        warningPanelProbation.Visible = true;
                        lblWarningProbation.Visible = true;
                        probationDate.Enabled = true;
                        lblWarningProbation.Text = "Applicant is under probation";
                    }

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

                    //all HR will view HR approval section
                    if (currentUser.getJobCategory().Equals("hr"))
                    {
                        hrApprovalView.Visible = true;
                        BondDAO bondDAO = new BondDAO();
                        DeptDAO deptDAO = new DeptDAO();
                        Bonds checkBond = bondDAO.getBondByTNFIDandUserID(currentTNF.getTNFID(), applicant.getUserID());
                        Department currentDept = deptDAO.getDeptByName(applicant.getDepartment());

                        if (checkBond != null)
                        {
                            rbtnBond.Checked = true;
                            rbtnMSP.Enabled = false;
                            rbtnNA.Enabled = false;
                            mspBondDuration.Text = string.Empty;
                            mspBondDuration.Enabled = true;
                        }
                        else
                        {
                            rbtnBond.Checked = false;
                            rbtnBond.Enabled = false;
                        }

                        costcentre.Text = currentDept.getCostCentre().ToString();
                        double balance = currentDept.getActualBudget() - courseApplied.getPrice();
                        trainingBudgetBal.Text = balance.ToString();
                        trainingBudgetDate.Text = DateTime.Now.ToString("MM/dd/yyyy");
                    }
                }
            }
        }
        protected void cfmApproveBtn_Click(object sender, EventArgs e)
        {
            TNFDAO tnfDAO = new TNFDAO();
            UserDAO userDAO = new UserDAO();
            BondDAO bondDAO = new BondDAO();
            NotificationDAO notificationDAO = new NotificationDAO();

            int notificationID = Convert.ToInt32(Request.QueryString["n"]);

            Notification currentNotification = notificationDAO.getNotificationByID(notificationID);
            TNF currentTNF = tnfDAO.getIndividualTNFByID(currentNotification.getUserIDFrom(), currentNotification.getTNFID());
            User applicant = userDAO.getUserByID(currentNotification.getUserIDFrom());
            User approver = userDAO.getUserByID(currentNotification.getUserIDTo());
            Bonds checkBond = bondDAO.getBondByTNFIDandUserID(currentTNF.getTNFID(), applicant.getUserID());
            User currentUser = (User)Session["currentUser"];

            if (currentUser.getJobCategory().Equals("hr"))
            {
                //to save HR form
                string probationText = "n";
                string isFunding = "n";
                string isMSP = "n";
                string duration = "";
                string sourceOfFunding = txtSourceOfFunding.Text;
                DateTime? fundingApplicationDate = null;
                Workflow currentWorkflow = currentTNF.getWorkflow();
                int probationPeriod = currentWorkflow.getProbationPeriod();
                TimeSpan ts = currentTNF.getApplicationDate().Subtract(applicant.getStartDate());

                if (ts.TotalDays < probationPeriod)
                {
                    probationText = "y";
                }
                if (rbnlFunding.SelectedValue.Equals("y"))
                {
                    isFunding = "y";
                }
                if (!txtFundingDate.Text.Equals(""))
                {
                    fundingApplicationDate = DateTime.ParseExact(txtFundingDate.Text, "MM/dd/yyyy", CultureInfo.InvariantCulture);
                }
                if (rbtnMSP.Checked)
                {
                    isMSP = "y";
                    duration = mspBondDuration.Text;
                    tnfDAO.updateTNFDataHRFields(currentTNF.getTNFID(), probationText, Convert.ToDouble(trainingCost.Text), isFunding, sourceOfFunding, fundingApplicationDate, isMSP, duration);
                }
                else
                {
                    tnfDAO.updateTNFDataHRFields(currentTNF.getTNFID(), probationText, Convert.ToDouble(trainingCost.Text), isFunding, sourceOfFunding, fundingApplicationDate, "n", null);
                }

                if (checkBond != null)
                {
                    //update Bond end date to correspond to number of months entered
                    DateTime endDate = checkBond.getStartDate();
                    endDate = endDate.AddMonths(Convert.ToInt32(mspBondDuration.Text));
                    bondDAO.updateBondEndDate(checkBond.getBondID(), endDate);
                }

            }
            Workflow_Approve.makeApproval(currentTNF, approver, currentNotification, remarksInput.Text);
            Response.Redirect("/pendingApproval.aspx");
        }
        protected void cfmRejectBtn_Click(object sender, EventArgs e)
        {
            TNFDAO tnfDAO = new TNFDAO();
            UserDAO userDAO = new UserDAO();
            NotificationDAO notificationDAO = new NotificationDAO();
            
            int notificationID = Convert.ToInt32(Request.QueryString["n"]);

            Notification currentNotification = notificationDAO.getNotificationByID(notificationID);
            TNF currentTNF = tnfDAO.getIndividualTNFByID(currentNotification.getUserIDFrom(), currentNotification.getTNFID());
            User approver = userDAO.getUserByID(currentNotification.getUserIDTo());


            Workflow_Reject.makeRejection(currentTNF, approver, currentNotification, remarksInput.Text);
            Response.Redirect("/pendingApproval.aspx");
        }
        protected void rbnlFunding_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (rbnlFunding.SelectedValue.Equals("y"))
            {
                txtSourceOfFunding.Enabled = true;
                txtFundingDate.Enabled = true;
            } else
            {
                txtSourceOfFunding.Enabled = false;
                txtSourceOfFunding.Text = string.Empty;
                txtFundingDate.Enabled = false;
                txtFundingDate.Text = string.Empty;
            }
        }

        protected int getTNFid()
        {
            TNFDAO tnfDAO = new TNFDAO();           
            NotificationDAO notificationDAO = new NotificationDAO();

            int notificationID = Convert.ToInt32(Request.QueryString["n"]);
            Notification currentNotification = notificationDAO.getNotificationByID(notificationID);
            TNF currentTNF = tnfDAO.getIndividualTNFByID(currentNotification.getUserIDFrom(), currentNotification.getTNFID());

            return currentTNF.getTNFID();
        }
    }
}