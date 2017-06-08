using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace LearnHub.AppCode.entity
{
    public class Notification
    {
        private string uid;
        private string tnfID;
        private string status;
        public Notification() { }
        public Notification (string uid, string tnfID, string status)
        {
            this.uid = uid;
            this.tnfID = tnfID;
            this.status = status;
        }
        public string getUserID()
        {
            return uid;
        }
        public void setUserID(string uid)
        {
            this.uid = uid;
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