using LearnHub.AppCode.entity;
using LearnHub.AppCode.dao;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace LearnHub.AppCode.workflow
{
    public class Workflow_Route
    {
        private static WorkflowDAO wfDAO = new WorkflowDAO();
        private static WorkflowSubDAO wfsDAO = new WorkflowSubDAO();
        private static WorkflowApproverDAO wfaDAO = new WorkflowApproverDAO();
        private static TNFDAO tnfDAO = new TNFDAO();
        private static DeptDAO deptDAO = new DeptDAO();
        public static Boolean routeForApproval(TNF tnf)
        {
            User currentUser = null;
            Workflow currentWorkflow = wfDAO.getCurrentActiveWorkflow(tnf.getType());
            List<User> users = new List<User>();
            string tnfType = "";
            Boolean gotBudget = false;

            //getting the type if it's individual or group
            if (tnf.getType().Equals("individual"))
            {
                currentUser = tnf.getUser();
                tnfType = "Individual";
            }
            else
            {
                users = tnf.getUsers();
                tnfType = "Group";
            }

            //To check budget
            if (tnfType.Equals("Individual"))
            {
                Department currentDept = deptDAO.getDeptByName(tnf.getUser().getDepartment());
                Course currentCourse = tnfDAO.getCourseFromTNF(tnf.getTNFID());
                double courseCost = currentCourse.getPrice();
                gotBudget = deptDAO.checkDeptBudget(currentDept.getDeptName(), currentCourse.getPrice());
            }
            else
            {
                //check budget for each member of group
            }
            if (gotBudget)
            {
                if (tnfType.Equals("Individual"))
                {
                    return routeIndividual(tnf);
                }
                else
                {
                    return routeGroup(tnf);
                }
            }
            else
            {
                tnfDAO.updateTNFStatus(tnf.getTNFID(), "Rejected. Department no budget.");
                return false;
            }
        }

        public static Boolean routeIndividual(TNF tnf)
        {
            User currentUser = tnf.getUser();
            UserDAO userDAO = new UserDAO();
            Workflow currentWorkflow = wfDAO.getCurrentActiveWorkflow("individual");
            //int numOfCriteria = wfDAO.getNumberOfCriteriaByWorkflow(currentWorkflow.getWorkflowID());
            string currentStatusOfTNF = tnf.getStatus();
            int probationPeriod = currentWorkflow.getProbationPeriod();
            TimeSpan ts = DateTime.Now.Subtract(currentUser.getStartDate());
            Course currentCourse = tnfDAO.getCourseFromTNF(tnf.getTNFID());

            List<WorkflowSub> workflowSubs;
            if (ts.TotalDays < probationPeriod)
            {
                workflowSubs = wfsDAO.getSortedWorflowSubByWorkflowIDandType(currentWorkflow.getWorkflowID(), "ceo");
            }
            else if (currentCourse.getOverseas().Equals("y"))
            {
                workflowSubs = wfsDAO.getSortedWorflowSubByWorkflowIDandType(currentWorkflow.getWorkflowID(), "ceo");
            }
            else
            {
                workflowSubs = wfsDAO.getSortedWorflowSubByWorkflowIDandType(currentWorkflow.getWorkflowID(), "normal");
            }

            double tnfTotalCost = tnfDAO.getCourseFromTNF(tnf.getTNFID()).getPrice(); //to get from tnfDAO and to confirm if gst is included in the fee of consideration

            if (currentStatusOfTNF.Equals("pending"))
            {
                //check bond criteria
                double bondCriteria = currentWorkflow.getBondCriteria();
                if (tnfTotalCost >= bondCriteria)
                {
                    //create new bond object
                    BondDAO bondDAO = new BondDAO();
                    Bonds newBond = new Bonds(currentUser.getUserID(), tnf.getTNFID(), "pending");
                    int bondID = bondDAO.createBond(newBond);
                    DateTime bondStartDate = currentCourse.getEndDate();
                    bondStartDate = bondStartDate.AddDays(1);
                    bondDAO.updateBondStartDate(bondID, bondStartDate);
                    
                }

                for (int i = 0; i < workflowSubs.Count; i++)
                {
                    if (wfsDAO.getWorkflowSubType(workflowSubs[i].getWorkflowSubID()).Equals("superior"))
                    {
                        i = 0;
                    }
                    WorkflowSub currentWFS = workflowSubs[i];
                    double low_limit = currentWFS.getAmount_low();
                    double high_limit = currentWFS.getAmount_high();
                    List<WorkflowApprover> approvers = wfaDAO.getSortedWorkflowApprovers(currentWorkflow.getWorkflowID(), currentWFS.getWorkflowSubID());
                    if (tnfTotalCost >= low_limit && tnfTotalCost <= high_limit)
                    {
                        WorkflowApprover currentWFApprover = approvers[tnf.getWFStatus()];
                        string currentUser_job_category = currentUser.getJobCategory();
                        WorkflowApprover checkApprover = wfaDAO.getWorkflowApproverByJobCategory(currentUser_job_category, currentWorkflow.getWorkflowID(), currentWFS.getWorkflowSubID());
                        Boolean checkIfLevelHigher = checkJobLevelHigher(currentUser_job_category, currentWFApprover.getJobCategory());
                        //to check if applicant's level is higher than approver's level (need to write another function to check)
                        WorkflowApprover lastWFApprover = wfaDAO.getLastApproverInChain(currentWorkflow.getWorkflowID(), currentWFS.getWorkflowSubID());
                        int levelOfUser = wfaDAO.getLevelByJobCategory(currentUser.getJobCategory(), currentWorkflow.getWorkflowID(), currentWFS.getWorkflowSubID());
                        if (checkApprover.getJobCategory() == null)
                        {
                            if (!checkIfLevelHigher)
                            {
                                tnfDAO.updateTNFWFSub(tnf.getTNFID(), currentWFS.getWorkflowSubID());
                                sendApprovalNotification(tnf, currentWFApprover);
                                return true;
                            } else
                            {
                                Boolean checkIfLevelHigherThanLastApprover = checkJobLevelHigher(currentUser_job_category, lastWFApprover.getJobCategory());
                                if (!checkIfLevelHigherThanLastApprover)
                                {
                                    for(int j = 0; i < approvers.Count; j++)
                                    {
                                        Boolean checkLevelWithCurrentApprover = checkJobLevelHigher(currentUser_job_category, approvers[j].getJobCategory());
                                        if (checkLevelWithCurrentApprover)
                                        {
                                            continue;
                                        }
                                        else
                                        {
                                            WorkflowApprover nextWFApprover = approvers[j];
                                            tnfDAO.updateTNFWFStatus(tnf.getTNFID(), j);
                                            tnfDAO.updateTNFWFSub(tnf.getTNFID(), currentWFS.getWorkflowSubID());
                                            sendApprovalNotification(tnf, nextWFApprover);
                                            return true;
                                        }
                                    }
                                } else
                                {
                                    workflowSubs = wfsDAO.getSortedWorflowSubByWorkflowIDandType(currentWorkflow.getWorkflowID(), "superior");
                                }
                            }
                        }
                        else
                        {
                            if (!currentUser.getJobCategory().Equals("ceo"))
                            {
                                if (levelOfUser < lastWFApprover.getLevel())
                                {
                                    WorkflowApprover nextWFApprover = approvers[levelOfUser + 1];
                                    tnfDAO.updateTNFWFSub(tnf.getTNFID(), currentWFS.getWorkflowSubID());
                                    tnfDAO.updateTNFWFStatus(tnf.getTNFID(), levelOfUser + 1);
                                    sendApprovalNotification(tnf, nextWFApprover);
                                    return true;
                                }
                                else
                                {
                                    //handle last person in chain
                                    workflowSubs = wfsDAO.getSortedWorflowSubByWorkflowIDandType(currentWorkflow.getWorkflowID(), "superior");

                                }
                            }
                            else
                            {
                                //no need handle CEO
                            }
                        }
                    }
                }

            }
            return false;
        }

        public static Boolean routeGroup(TNF tnf)
        {
            /*
             * TNFDAO tnfDAO = new TNFDAO();
             * List<User> users = tnfDAO.getAllUsers(tnf);
             * List<Boolean> statuses = new List<Boolean>();
             * foreach (User user in users) {
             *      statuses.add(routeIndividual(tnf, user);
             * }
             * 
             * if (statuses contains false) {
             *      updateTNFStatus("Error in processing");
             *      return false;
             * } else {
             *      return true;
             * }
             */
            return false;
        }

        public static Boolean checkJobLevelHigher(string checkFrom, string checkTo)
        {
            if (checkFrom.Equals("ceo") || checkFrom.Equals("admin"))
            {
                return true;
            }
            else if (checkFrom.Equals("hod"))
            {
                if (checkTo.Equals("ceo") || checkTo.Equals("hr") || checkTo.Equals("superior"))
                {
                    return false;
                }
                else
                {
                    return true;
                }
            }
            else if (checkFrom.Equals("hr hod"))
            {
                if (checkTo.Equals("ceo") || checkTo.Equals("superior"))
                {
                    return false;
                }
                else
                {
                    return true;
                }
            }
            else if (checkFrom.Equals("supervisor"))
            {
                if (checkTo.Equals("ceo") || checkTo.Equals("hod") || checkTo.Equals("hr") || checkTo.Equals("superior"))
                {
                    return false;
                }
                else
                {
                    return true;
                }
            }
            else if (checkFrom.Equals("hr"))
            {
                if (checkTo.Equals("hr director") || checkTo.Equals("ceo") || checkTo.Equals("superior"))
                {
                    return false;
                }
                else
                {
                    return true;
                }
            }
            else
            {
                return false;
            }
        }
        public static void sendApprovalNotification(TNF tnf, WorkflowApprover wfa)
        {
            User currentUser = tnf.getUser();
            UserDAO userDAO = new UserDAO();
            NotificationDAO notiDAO = new NotificationDAO();
            User approver = new User();
            List<User> hrApprovers = new List<User>();
            if (tnf.getStatus().Equals("pending"))
            {
                int current_wf_status = tnf.getWFStatus();
                int wfaLevel = wfa.getLevel();
                //if (wfa.getLevel() == current_wf_status)
                //{
                //get out who to send next
                string approverJobCat = wfa.getJobCategory();

                if (approverJobCat.ToLower().Equals("ceo"))
                {
                    approver = userDAO.getCEO();
                }
                else if (approverJobCat.ToLower().Equals("hod"))
                {
                    approver = userDAO.getHODbyDepartment(currentUser.getDepartment());
                }
                else if (approverJobCat.ToLower().Equals("supervisor"))
                {
                    approver = userDAO.getSupervisorbyDepartment(currentUser.getDepartment());
                }
                else if (approverJobCat.ToLower().Equals("hr hod"))
                {
                    approver = userDAO.getHRHOD();
                }
                else if (approverJobCat.ToLower().Equals("hr"))
                {
                    hrApprovers = userDAO.getAllHR();
                }
                else if (approverJobCat.ToLower().Equals("superior"))
                {
                    string supervisorID = userDAO.getSupervisorIDOfUser(currentUser.getUserID());
                    approver = userDAO.getUserByID(supervisorID);
                }

                //insert notification
                if (!hrApprovers.Any())
                {
                    Notification newNotification = new Notification(currentUser.getUserID(), approver.getUserID(), tnf.getTNFID(), "pending");
                    notiDAO.createNotification(newNotification);
                }
                else
                {
                    foreach (User hrUser in hrApprovers)
                    {
                        Notification newNotification = new Notification(currentUser.getUserID(), hrUser.getUserID(), tnf.getTNFID(), "pending");
                        notiDAO.createNotification(newNotification);
                    }
                }

                //}
            }
        }
    }
}