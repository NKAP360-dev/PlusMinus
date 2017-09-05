using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Collections;

namespace LearnHub.AppCode.entity
{
    public class User
    {
        private string uid;
        private string name;
        private string jobTitle;
        private string jobCategory;
        private string supervisor;
        private ArrayList roles;
        private string department;
        private string email;
        private DateTime start_Date;
        private string add;
        private string contact;
        private string status;
        //private string hashedpassword;

        public User()
        {

        }
        public User(string uid, string name, string jobTitle, string jobCategory, string supervisor, ArrayList roles, string department, string email, DateTime start_Date
            , string add, string contact, string status)
        {
            this.uid = uid;
            this.name = name;
            this.jobTitle = jobTitle;
            this.jobCategory = jobCategory;
            this.supervisor = supervisor;
            this.roles = roles;
            this.department = department;
            this.email = email;
            this.start_Date = start_Date;
            this.add = add;
            this.contact = contact;
            this.status = status;
        }
        public string getStatus()
        {
            return status;
        }
        public void setStatus(string status)
        {
            this.status = status;
        }
        public string getContact()
        {
            return contact;
        }
        public void setContact(string contact)
        {
            this.contact = contact;
        }
        public string getUserID()
        {
            return uid;
        }
        public void setUserID(string uid)
        {
            this.uid = uid;
        }
        public string getAddress()
        {
            return add;
        }
        public void setAddress(string add)
        {
            this.add = add;
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
        public ArrayList getRoles()
        {
            return roles;
        }
        public void setRoles(ArrayList roles)
        {
            this.roles = roles;
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