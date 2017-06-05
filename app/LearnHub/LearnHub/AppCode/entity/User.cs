using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace LearnHub.AppCode.entity
{
    public class User
    {
        public string uid { get; set; }
        public string name { get; set; }
        public int length_of_service { get; set; }
        public string jobTitle { get; set; }
        public string supervisor { get; set; }
        public string role { get; set; }

        public User(string uid, string name, int length_of_service, string jobTitle, string supervisor, string role)
        {
            this.uid = uid;
            this.name = name;
            this.length_of_service = length_of_service;
            this.jobTitle = jobTitle;
            this.supervisor = supervisor;
            this.role = role;
        }
    }
}