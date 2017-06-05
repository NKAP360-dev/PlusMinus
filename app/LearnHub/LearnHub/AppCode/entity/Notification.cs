using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace LearnHub.AppCode.entity
{
    public class Notification
    {
        public string uid { get; set; }
        public string tnfID { get; set; }
        public string status { get; set; }

        public Notification (string uid, string tnfID, string status)
        {
            this.uid = uid;
            this.tnfID = tnfID;
            this.status = status;
        }
    }
}