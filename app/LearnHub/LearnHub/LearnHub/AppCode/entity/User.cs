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
        private float length_of_service;
        private string jobTitle;
        private string supervisor;
        private string role;

        public User()
        {

        }
        public User(string uid, string name, float length_of_service, string jobTitle, string supervisor, string role)
        {
            this.uid = uid;
            this.name = name;
            this.length_of_service = length_of_service;
            this.jobTitle = jobTitle;
            this.supervisor = supervisor;
            this.role = role;
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
        public float getLengthOfSevice()
        {
            return length_of_service;
        }
        public void setLengthOfService(float length_of_service)
        {
            this.length_of_service = length_of_service;
        }
        public string getJobTitle()
        {
            return jobTitle;
        }
        public void setJobTitle(string jobTitle)
        {
            this.jobTitle = jobTitle;
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
    }
}