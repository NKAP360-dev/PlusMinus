using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace LearnHub.AppCode.entity
{
    public class Notification
    {
        private string uid_from;
        private string uid_to;
        private int tnfID;
        private string status;
        private DateTime dateApproved;
        private string remarks;
        private int notif_ID;
        public Notification() { }
        public Notification (string uid_from, string uid_to, int tnfID, string status, int notif_ID)
        {
            this.uid_from = uid_from;
            this.uid_to = uid_to;
            this.tnfID = tnfID;
            this.status = status;
            this.notif_ID = notif_ID;
        }
        public Notification(string uid_from, string uid_to, int tnfID, string status)
        {
            this.uid_from = uid_from;
            this.uid_to = uid_to;
            this.tnfID = tnfID;
            this.status = status;
        }
        public string getUserIDFrom()
        {
            return uid_from;
        }
        public void setUserIDFrom(string uid_from)
        {
            this.uid_from = uid_from;
        }
        public string getUserIDTo()
        {
            return uid_to;
        }
        public void setUserIDTo(string uid_to)
        {
            this.uid_to = uid_to;
        }
        public int getTNFID()
        {
            return tnfID;
        }
        public void setTNFID(int tnfID)
        {
            this.tnfID = tnfID;
        }
        public string getStatus()
        {
            return status;
        }
        public void setStatus(string status)
        {
            this.status = status;
        }
        public int getNotificationID()
        {
            return notif_ID;
        }
        public void setNotificationID(int notif_ID)
        {
            this.notif_ID = notif_ID;
        }

        public DateTime getDateApproved()
        {
            return dateApproved;
        }

        public void setDateApproved(DateTime dateApproved)
        {
            if (dateApproved != null)
            {
                this.dateApproved = dateApproved;
            }
        }

        public string getRemarks()
        {
            return remarks;
        }

        public void setRemarks(string remarks)
        {
            if (remarks != null)
            {
                this.remarks = remarks;
            }
        }
    }
}