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
        private string tnfID;
        private string status;
        public Notification() { }
        public Notification (string uid_from, string uid_to, string tnfID, string status)
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
        public string getTNFID()
        {
            return tnfID;
        }
        public void setTNFID(string tnfID)
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
    }
}