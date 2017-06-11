﻿using LearnHub.AppCode.entity;
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
        public static Boolean routeForApproval(TNF tnf)
        {
            User currentUser = null;
            Workflow currentWorkflow = wfDAO.getCurrentActiveWorkflow(tnf.getType());
            List<User> users = new List<User>();
            string tnfType = "";
            Boolean gotBudget = true;
            
            //getting the type if it's individual or group
            if (tnf.getType().Equals("individual"))
            {
                currentUser = tnf.getUser();
                tnfType = "Individual";
            } else
            {
                users = tnf.getUsers();
                tnfType = "Group";
            }

            // check if not group then check individual duration, else check each individual in the group
            double probationPeriod = currentWorkflow.getProbationPeriod();
            if (!users.Any())
            {
                if (currentUser.getLengthOfSevice() < probationPeriod)
                {
                    // to do logic for > probationPeriod
                }
            }
            else
            {
                foreach (User user in users) {
                    // check duration for each user
                    // to do logic if user’s duration is < probationPeriod
                }
            }

            //To check budget, variable checking is gotBudget
            if (gotBudget)
            {
                if (tnfType.Equals("Individual")) {
                    return routeIndividual(tnf);
                }
                else
                {
                    return routeGroup(tnf);
                }
            }
            else
            {
                //updateTNFStatus("Rejected.Department no budget");
                //to use tnfDAO to update status
                return false;
            }
        }

        public static Boolean routeIndividual(TNF tnf)
        {
            User currentUser = tnf.getUser();
            UserDAO userDAO = new UserDAO();
            Workflow currentWorkflow = wfDAO.getCurrentActiveWorkflow("individual");
            int numOfCriteria = wfDAO.getNumberOfCriteriaByWorkflow(currentWorkflow.getWorkflowID());
            string currentStatusOfTNF = tnf.getStatus();
            List<WorkflowSub> workflowSubs = wfsDAO.getSortedWorflowSubByWorkflow(currentWorkflow.getWorkflowID());
            float tnfTotalCost = 0.0F; //to get from tnfDAO and to confirm if gst is included in the fee of consideration

            if (currentStatusOfTNF.Equals("pending"))
            {
                for (int i = 0; i < numOfCriteria; i++)
                {
                    WorkflowSub currentWFS = workflowSubs[i];
                    double low_limit = currentWFS.getAmount_low();
                    double high_limit = currentWFS.getAmount_high();
                    List<WorkflowApprover> approvers = wfaDAO.getSortedWorkflowApprovers(currentWorkflow.getWorkflowID(), currentWFS.getWorkflowSubID());
                    if (tnfTotalCost >= low_limit && tnfTotalCost <= high_limit)
                    {
                        WorkflowApprover currentWFApprover = approvers[tnf.getWFStatus()];
                        string approver_job_category = currentWFApprover.getJobCategory();
                        //to check if applicant's level is higher than approver's level (need to write another function to check)
                        Boolean checkJobCategoryLevel = checkJobLevelHigher(currentUser.getJobCategory(), approver_job_category);
                        if (!checkJobCategoryLevel)
                        {
                            sendApprovalNotification(tnf, currentWFApprover);
                            return true;
                        } else
                        {
                            //do something if applicant is approver
                        }
                    }
                }

                //check bond criteria
                double bondCriteria = currentWorkflow.getBondCriteria();
                if (tnfTotalCost >= bondCriteria)
                {
                    //create new bond object
                    return true;
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
        public static void sendApprovalNotification(TNF tnf, User approver)
        {

        }

        public static Boolean checkJobLevelHigher(string checkFrom, string checkTo)
        {
            if (checkFrom.Equals("ceo") || checkFrom.Equals("admin"))
            {
                return true;
            }
            else if (checkFrom.Equals("director") || checkFrom.Equals("hr director"))
            {
                if (checkTo.Equals("CEO")) {
                    return false;
                }
                else
                {
                    return true;
                }
            }
            else if (checkFrom.Equals("hod"))
            {
                if (checkTo.Equals("ceo") || checkTo.Equals("director"))
                {
                    return false;
                } else
                {
                    return true;
                }
            }
            else if (checkFrom.Equals("hr"))
            {
                if (checkTo.Equals("hr director") || checkTo.Equals("ceo"))
                {
                    return false;
                } else
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
                if (wfa.getLevel() == current_wf_status)
                {
                    //get out who to send next
                    string approverJobCat = wfa.getJobCategory();

                    if (approverJobCat.ToLower().Equals("ceo"))
                    {
                        approver = userDAO.getCEO();
                    }
                    else if (approverJobCat.ToLower().Equals("director"))
                    {
                        approver = userDAO.getDirectorbyDepartment(currentUser.getDepartment());
                    }
                    else if (approverJobCat.ToLower().Equals("hod"))
                    {
                        approver = userDAO.getHODbyDepartment(currentUser.getDepartment());
                    }
                    else if (approverJobCat.ToLower().Equals("hr director"))
                    {
                        approver = userDAO.getHRDirector();
                    }
                    else if (approverJobCat.ToLower().Equals("hr"))
                    {
                        hrApprovers = userDAO.getAllHR();
                    }

                    //insert notification
                    if (!hrApprovers.Any())
                    {
                        Notification newNotification = new Notification(currentUser.getUserID(), approver.getUserID(), tnf.getTNFID(), "pending");
                        notiDAO.createNotification(newNotification);
                    } else
                    {
                        foreach (User hrUser in hrApprovers)
                        {
                            Notification newNotification = new Notification(currentUser.getUserID(), hrUser.getUserID(), tnf.getTNFID(), "pending");
                            notiDAO.createNotification(newNotification);
                        }
                    }

                }
            }
        }
    }
}