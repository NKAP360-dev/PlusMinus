using LearnHub.AppCode.dao;
using LearnHub.AppCode.entity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace LearnHub.AppCode.workflow
{
    public class Workflow_Approve
    {
        private static UserDAO userDAO = new UserDAO();
        private static TNFDAO tnfDAO = new TNFDAO();
        private static DeptDAO deptDAO = new DeptDAO();
        private static BondDAO bondDAO = new BondDAO();
        private static WorkflowDAO wfDAO = new WorkflowDAO();
        private static WorkflowSubDAO wfsDAO = new WorkflowSubDAO();
        private static WorkflowApproverDAO wfaDAO = new WorkflowApproverDAO();
        private static NotificationDAO notificationDAO = new NotificationDAO();

        public static Boolean makeApproval(TNF tnf, User user, Notification noti)
        {
            //check TNF status
            if (!tnf.getStatus().ToLower().Equals("pending"))
            {
                return false;
            }

            //check budget
            Department currentDept = deptDAO.getDeptByName(tnf.getUser().getDepartment());
            Course currentCourse = tnfDAO.getCourseFromTNF(tnf.getTNFID());
            double courseCost = currentCourse.getPrice();
            Boolean gotBudget = deptDAO.checkDeptBudget(currentDept.getDeptName(), currentCourse.getPrice());
            int nextWFLevel = 0;

            if (!gotBudget)
            {
                return false;
            }

            //check if approver is last in chain
            Boolean isLastApprover = false;
            Workflow currentWorkflow = tnf.getWorkflow();
            WorkflowSub currentWFS = tnf.getWorkflowSub();
            WorkflowApprover nextApprover = new WorkflowApprover();

            WorkflowApprover lastApprover = wfaDAO.getLastApproverInChain(currentWorkflow.getWorkflowID(), currentWFS.getWorkflowSubID());
            List<WorkflowApprover> approvers = wfaDAO.getSortedWorkflowApprovers(currentWorkflow.getWorkflowID(), currentWFS.getWorkflowSubID());
            if (user.getJobCategory().Contains(lastApprover.getJobCategory()))
            {
                isLastApprover = true;
            } else if (lastApprover.getJobCategory().Equals("supervisor")) {
                User currentTNFUser = tnf.getUser();
                if (currentTNFUser.getSupervisor().Equals(user.getUserID())) {
                    isLastApprover = true;
                }
            }
            else
            {
                int levelOfUser = wfaDAO.getLevelByJobCategory(user.getJobCategory(), currentWorkflow.getWorkflowID(), currentWFS.getWorkflowSubID());
                if (levelOfUser == -1)
                {
                    nextApprover = lastApprover;
                    nextWFLevel = lastApprover.getLevel();
                }
                else
                {
                    nextApprover = approvers[levelOfUser + 1];
                    nextWFLevel = levelOfUser + 1;
                }
            }

            //If its HR, approve for all HR
            List<User> allHR = userDAO.getAllHR();
            List<Notification> allHRNotification = new List<Notification>();
            foreach (User hr in allHR)
            {
                allHRNotification.Add(notificationDAO.getPendingNotificationByTnfIDandUserID(tnf.getTNFID(), hr.getUserID()));
            }
            allHRNotification = allHRNotification.Where(x => x != null).ToList();
            if (allHRNotification.Count < 2)
            {
                if (isLastApprover)
                {
                    notificationDAO.updateNotificationStatus(noti.getNotificationID(), "approved");
                    notificationDAO.updateNotificationApprovedDate(noti.getNotificationID());
                    tnfDAO.updateTNFStatus(tnf.getTNFID(), "approved");
                    double bondCriteria = currentWorkflow.getBondCriteria();
                    if (currentCourse.getPrice() >= bondCriteria)
                    {
                        Bonds currentBond = bondDAO.getBondByTNFIDandUserID(tnf.getTNFID(), tnf.getUser().getUserID());
                        bondDAO.updateBondStatus(currentBond.getBondID(), "approved");
                    }
                }
                else
                {
                    notificationDAO.updateNotificationStatus(noti.getNotificationID(), "approved");
                    notificationDAO.updateNotificationApprovedDate(noti.getNotificationID());
                    tnfDAO.updateTNFWFStatus(tnf.getTNFID(), nextWFLevel);
                    tnf = tnfDAO.getIndividualTNFByID(tnf.getUser().getUserID(), tnf.getTNFID());
                    Workflow_Route.sendApprovalNotification(tnf, nextApprover);
                }
            } else
            {
                if (isLastApprover)
                {
                    foreach (Notification hrNoti in allHRNotification)
                    {
                        notificationDAO.updateNotificationStatus(hrNoti.getNotificationID(), "approved");
                        notificationDAO.updateNotificationApprovedDate(hrNoti.getNotificationID());
                    }
                    tnfDAO.updateTNFStatus(tnf.getTNFID(), "approved");
                    double bondCriteria = currentWorkflow.getBondCriteria();
                    if (currentCourse.getPrice() >= bondCriteria)
                    {
                        Bonds currentBond = bondDAO.getBondByTNFIDandUserID(tnf.getTNFID(), tnf.getUser().getUserID());
                        bondDAO.updateBondStatus(currentBond.getBondID(), "approved");
                    }
                }
                else
                {
                    foreach (Notification hrNoti in allHRNotification)
                    {
                        notificationDAO.updateNotificationStatus(hrNoti.getNotificationID(), "approved");
                        notificationDAO.updateNotificationApprovedDate(hrNoti.getNotificationID());
                    }
                    tnfDAO.updateTNFWFStatus(tnf.getTNFID(), nextWFLevel);
                    tnf = tnfDAO.getIndividualTNFByID(tnf.getUser().getUserID(), tnf.getTNFID());
                    Workflow_Route.sendApprovalNotification(tnf, nextApprover);
                }
            }
            return true;
        }
    }
}