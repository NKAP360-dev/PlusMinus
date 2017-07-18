using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Collections;

namespace LearnHub.AppCode.entity
{
    public class Course_elearn
    {
        private int courseID;
        private string courseName;
        private string courseProvider;
        private DateTime startDate;
        private DateTime expiry_date;
        private string status;
        private string description;
        private ArrayList prerequisite;
        private string category;

        public Course_elearn()
        {

        }
        public Course_elearn(int courseID, string courseName, string provider,
            DateTime startDate, string status,
            string desc, ArrayList prereq, string category)
        {
            //no exp date only
            this.courseID = courseID;
            this.courseName = courseName;
            this.startDate = startDate;
            this.status = status;
            this.description = desc;
            this.prerequisite = prereq; // so if no pre req put as null value for default. 
            this.category = category; // professional, leadership or compulsory
        }
        public Course_elearn(int courseID, string courseName, string provider,
            DateTime startDate, string status,
            string desc, string category)
        {
            //no exp date, no prereq and no prov
            this.courseID = courseID;
            this.courseName = courseName;
            this.startDate = startDate;
            this.status = status;
            this.description = desc;
            this.category = category; // professional, leadership or compulsory
        }
        public Course_elearn(int courseID, string courseName, 
            DateTime startDate, DateTime endDate, string status, 
            string desc, ArrayList prereq, string category)
        {
            //no provider only
            this.courseID = courseID;
            this.courseName = courseName;
            this.startDate = startDate;
            this.expiry_date = endDate;
            this.status = status;
            this.description = desc;
            this.prerequisite = prereq; // so if no pre req put as null value for default. 
            this.category = category; // professional, leadership or compulsory
        }
        public Course_elearn(int courseID, string courseName, string provider,
            DateTime startDate, DateTime endDate, string status,
            string desc, string category)
        {
            //no prereq only
            this.courseID = courseID;
            this.courseName = courseName;
            this.courseProvider = provider;
            this.startDate = startDate;
            this.expiry_date = endDate;
            this.status = status;
            this.description = desc; 
            this.category = category; // professional, leadership or compulsory
        }

        public Course_elearn(int courseID, string courseName, 
            string courseProvider, DateTime startDate, DateTime endDate, 
            string status, string desc, ArrayList prereq, string category)
        {
            //with provider and endDate
            this.courseID = courseID;
            this.courseName = courseName;
            this.courseProvider = courseProvider;
            this.startDate = startDate;
            this.expiry_date = endDate;
            this.status = status;
            this.description = desc;
            this.prerequisite = prereq;  // so if no pre req put as null value for default. 
            this.category = category;
        }
        public int getCourseID()
        {
            return courseID;
        }
        public void setCourseID(int courseID)
        {
            this.courseID = courseID;
        }
        public string getCourseName()
        {
            return courseName;
        }
        public void setCourseName(string courseName)
        {
            this.courseName = courseName;
        }

        public string getCourseProvider()
        {
            return courseProvider;
        }
        public void setCourseProvider(string courseProvider)
        {
            this.courseProvider = courseProvider;
        }
        public DateTime getStartDate()
        {
            return startDate;
        }
        public void setStartDate(DateTime startDate)
        {
            this.startDate = startDate;
        }
        public DateTime getExpiryDate()
        {
            return expiry_date;
        }
        public void setExpiryDate(DateTime expiry_date)
        {
            this.expiry_date = expiry_date;
        }
        public string getStatus()
        {
            return status;
        }
        public void setStatus(string status)
        {
            this.status = status;
        }
        public string getDescription()
        {
            return description;
        }
        public void setDescription(string desc)
        {
            this.description = desc;
        }
        public ArrayList getPrerequisite()
        {
            return prerequisite;
        }
        public void setPrerequisite(ArrayList prereq)
        {
            this.prerequisite = prereq;
        }
        public string getCategory()
        {
            return category;
        }
        public void setCategory(string cat)
        {
            this.category = cat;
        }
    }
}