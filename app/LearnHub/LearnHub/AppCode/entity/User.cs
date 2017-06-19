using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace LearnHub.AppCode.entity
{
    public class User
    {
        private string uid;
        private string name;
        private string jobTitle;
        private string jobCategory;
        private string supervisor;
        private string role;
        private string department;
        private string email;
        private DateTime start_Date;

        public User()
        {

        }
        public User(string uid, string name, string jobTitle, string jobCategory, string supervisor, string role, string department, string email, DateTime start_Date)
        {
            this.uid = uid;
            this.name = name;
            this.jobTitle = jobTitle;
            this.jobCategory = jobCategory;
            this.supervisor = supervisor;
            this.role = role;
            this.department = department;
            this.email = email;
            this.start_Date = start_Date;
        }
        public string getUserID()
        {
            return uid;
        }
        public void setUserID(string uid)
        {
            this.uid = uid;
        }
        public string getName()
        {
            return name;
        }
        public void setName(string name)
        {
            this.name = name;
        }
        public string getJobTitle()
        {
            return jobTitle;
        }
        public void setJobTitle(string jobTitle)
        {
            this.jobTitle = jobTitle;
        }
        public string getJobCategory()
        {
            return jobCategory;
        }
        public void setJobCategory(string jobCategory)
        {
            this.jobCategory = jobCategory;
        }
        public string getSupervisor()
        {
            return supervisor;
        }
        public void setSupervisor(string supervisor)
        {
            this.supervisor = supervisor;
        }
        public string getRole()
        {
            return role;
        }
        public void setRole(string role)
        {
            this.role = role;
        }
        public string getDepartment()
        {
            return department;
        }
        public void setDepartment(string department)
        {
            this.department = department;
        }
        public string getEmail()
        {
            return email;
        }
        public void setEmail(string email)
        {
            this.email = email;
        }
        public DateTime getStartDate()
        {
            return start_Date;
        }
        public void setStartDate(DateTime start_Date)
        {
            this.start_Date = start_Date;
        }
    }
}