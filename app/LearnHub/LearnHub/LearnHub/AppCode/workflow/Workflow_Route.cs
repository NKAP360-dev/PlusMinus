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
        public static Boolean routeForApproval(TNF tnf)
        {
            User currentUser = null;
            Workflow currentWorkflow = wfDAO.getCurrentActiveWorkflow();
            List<User> users = new List<User>();
            string tnfType = "";
            Boolean gotBudget = false;
            
            //getting the type if it's individual or group
            if (tnf.getType().Equals("Individual"))
            {
                currentUser = tnf.getUser();
                tnfType = "Individual";
            } else
            {
                users = tnf.getUsers();
                tnfType = "Group";
            }

            // check if not group then check individual duration, else check each individual in the group
            int probationPeriod = currentWorkflow.getProbationPeriod();
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
            Workflow currentWorkflow = wfDAO.getCurrentActiveWorkflow();
            int numOfCriteria = wfDAO.getNumberOfCriteriaByWorkflow(currentWorkflow.getWorkflowID());
            string currentStatusOfTNF = tnf.getStatus();
            List<WorkflowSub> workflowSubs = wfsDAO.getSortedWorflowSubByWorkflow(currentWorkflow.getWorkflowID());
            float tnfTotalCost = 0.0F; //to get from tnfDAO and to confirm if gst is included in the fee of consideration

            if (currentStatusOfTNF.Equals("Pending"))
            {
                for (int i = 0; i < numOfCriteria; i++)
                {
                    WorkflowSub currentWFS = workflowSubs[i];
                    float low_limit = currentWFS.getAmount_low();
                    float high_limit = currentWFS.getAmount_high();
                    List<WorkflowApprover> approvers = wfaDAO.getSortedWorkflowApprovers(currentWorkflow.getWorkflowID(), currentWFS.getWorkflowSubID());
                    if (tnfTotalCost >= low_limit && tnfTotalCost <= high_limit)
                    {
                        WorkflowApprover currentWFApprover = approvers[tnf.getWFStatus()];
                        User approver = currentWFApprover.getApprover();
                        //to check if applicant's level is higher than approver's level (need to write another function to check)
                        if (currentUser != approver)
                        {
                            //sendApprovalNotification(tnf, approver);
                            return true;
                        } else
                        {
                            //do something if applicant is approver
                        }
                    }
                }

                //check bond criteria
                float bondCriteria = currentWorkflow.getBondCriteria();
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
    }
}