using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace LearnHub.AppCode.entity
{
    public class Contact
    {
        public int contact_id { get; set; }
        public string name { get; set; }
        public string department { get; set; }
        public User user { get; set; }
        public DateTime upload_datetime { get; set; }
        public string status { get; set; }
        public string email { get; set; }
        public string remarks { get; set; }

        public Contact() { }
        public Contact(int id, string name, string department, User user, DateTime upload, string status, string email, string remarks)
        {
            this.contact_id = id;
            this.name = name;
            this.department = department;
            this.user = user;
            this.upload_datetime = upload;
            this.status = status;
            this.email = email;
            this.remarks = remarks;
        }
        public Contact(string name, string department, User user, DateTime upload, string status, string email, string remarks)
        {
            //this.contact_id = id;
            this.name = name;
            this.department = department;
            this.user = user;
            this.upload_datetime = upload;
            this.status = status;
            this.email = email;
            this.remarks = remarks;
        }
    }
}