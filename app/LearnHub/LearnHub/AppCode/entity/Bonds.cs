using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace LearnHub.AppCode.entity
{
    public class Bonds
    {
        private int bondID;
        private string userID;
        private int tnfid;
        private DateTime startDate;
        private DateTime endDate;
        private string status;

        public Bonds() { }
        public Bonds (int bondID, string userID, int tnfid, DateTime startDate, DateTime endDate, string status)
        {
            this.bondID = bondID;
            this.userID = userID;
            this.tnfid = tnfid;
            this.startDate = startDate;
            this.endDate = endDate;
            this.status = status;
        }
        public Bonds(string userID, int tnfid, string status)
        {
            this.userID = userID;
            this.tnfid = tnfid;
            this.status = status;
        }
        public int getBondID()
        {
            return bondID;
        }
        public void setBondID(int bondID)
        {
            this.bondID = bondID;
        }
        public string getUserID()
        {
            return userID;
        }
        public void setUserID(string userID)
        {
            this.userID = userID;
        }
        public int getTNFID()
        {
            return tnfid;
        }
        public void setTNFID(int tnfid)
        {
            this.tnfid = tnfid;
        }
        public DateTime getStartDate()
        {
            return startDate;
        }
        public void setStartDate(DateTime startDate)
        {
            this.startDate = startDate;
        }
        public DateTime getEndDate()
        {
            return endDate;
        }
        public void setEndDate(DateTime endDate)
        {
            this.endDate = endDate;
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