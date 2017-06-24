using LearnHub.AppCode.dao;
using LearnHub.AppCode.entity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace LearnHub.AppCode.workflow
{
    public class Workflow_Reject
    {
        private static UserDAO userDAO = new UserDAO();
        private static TNFDAO tnfDAO = new TNFDAO();
        private static DeptDAO deptDAO = new DeptDAO();
        private static BondDAO bondDAO = new BondDAO();
        private static WorkflowDAO wfDAO = new WorkflowDAO();
        private static WorkflowSubDAO wfsDAO = new WorkflowSubDAO();
        private static WorkflowApproverDAO wfaDAO = new WorkflowApproverDAO();
        private static NotificationDAO notificationDAO = new NotificationDAO();

        public static Boolean makeRejection(TNF tnf, User approver, Notification noti, string reason)
        {
            //check TNF status
            if (!tnf.getStatus().ToLower().Equals("pending"))
            {
                return false;
            }

            Workflow currentWorkflow = tnf.getWorkflow();
            Department currentDept = deptDAO.getDeptByName(tnf.getUser().getDepartment());
            Course currentCourse = tnfDAO.getCourseFromTNF(tnf.getTNFID());
            double courseCost = currentCourse.getPrice();

            // if bond exist, reject the bond
            double bondCriteria = currentWorkflow.getBondCriteria();
            if (currentCourse.getPrice() >= bondCriteria)
            {
                Bonds currentBond = bondDAO.getBondByTNFIDandUserID(tnf.getTNFID(), tnf.getUser().getUserID());
                bondDAO.updateBondStatus(currentBond.getBondID(), "rejected");
            }

            //Handle Notification, update status, date and reason
            //If its HR, reject for all HR
            List<User> allHR = userDAO.getAllHR();
            List<Notification> allHRNotification = new List<Notification>();
            foreach (User hr in allHR)
            {
                allHRNotification.Add(notificationDAO.getPendingNotificationByTnfIDandUserID(tnf.getTNFID(), hr.getUserID()));
            }
            allHRNotification = allHRNotification.Where(x => x != null).ToList();
            if (allHRNotification.Count < 2)
            {
                notificationDAO.updateNotificationStatus(noti.getNotificationID(), "rejected");
                notificationDAO.updateNotificationApprovedDate(noti.getNotificationID());
                if (reason != null)
                {
                    notificationDAO.updateNotificationRemarks(noti.getNotificationID(), reason);
                }
            } 
            else
            {
                foreach (Notification hrNoti in allHRNotification)
                {
                    notificationDAO.updateNotificationStatus(hrNoti.getNotificationID(), "rejected");
                    notificationDAO.updateNotificationApprovedDate(hrNoti.getNotificationID());
                    if (reason != null)
                    {
                        notificationDAO.updateNotificationRemarks(hrNoti.getNotificationID(), reason);
                    }
                }
            }

            //Update TNF status
            tnfDAO.updateTNFStatus(tnf.getTNFID(), "rejected");

            return true;
        }
    }
}