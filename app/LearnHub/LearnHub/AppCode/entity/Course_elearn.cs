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
        private DateTime entry_date;
        private DateTime startDate;
        private DateTime expiry_date;
        private string status;
        private string description;
        private ArrayList prerequisite;
        private int categoryID;
        private User courseCreator;
        private double hoursAwarded;
        private string targetAudience;

        public Course_elearn()
        {

        }
        public Course_elearn(string courseName, string provider, DateTime entry_date,
            DateTime startDate, DateTime endDate,  string status,
            string desc, int categoryID, User courseCreator, double hoursAwarded, string targetAudience)
        {
            //no need id, with entry date and expiry date
            this.courseName = courseName;
            this.courseProvider = provider;
            this.entry_date = entry_date;
            this.startDate = startDate;
            this.expiry_date = endDate;
            this.status = status;
            this.description = desc;
            //this.prerequisite = prereq; // so if no pre req put as null value for default. 
            this.categoryID = categoryID; // professional, leadership or compulsory
            this.courseCreator = courseCreator;
            this.hoursAwarded = hoursAwarded;
            this.targetAudience = targetAudience;
        }

        public Course_elearn(int courseID, string courseName, string provider,
            DateTime startDate, string status,
            string desc, ArrayList prereq, int categoryID)
        {
            //no exp date only
            this.courseID = courseID;
            this.courseName = courseName;
            this.startDate = startDate;
            this.status = status;
            this.description = desc;
            this.prerequisite = prereq; // so if no pre req put as null value for default. 
            this.categoryID = categoryID; // professional, leadership or compulsory
        }
        public Course_elearn(int courseID, string courseName, string provider,
            DateTime startDate, string status,
            string desc, int categoryID)
        {
            //no exp date, no prereq and no prov
            this.courseID = courseID;
            this.courseName = courseName;
            this.startDate = startDate;
            this.status = status;
            this.description = desc;
            this.categoryID = categoryID; // professional, leadership or compulsory
        }
        public Course_elearn(int courseID, string courseName,
            DateTime startDate, DateTime endDate, string status,
            string desc, ArrayList prereq, int categoryID)
        {
            //no provider only
            this.courseID = courseID;
            this.courseName = courseName;
            this.startDate = startDate;
            this.expiry_date = endDate;
            this.status = status;
            this.description = desc;
            this.prerequisite = prereq; // so if no pre req put as null value for default. 
            this.categoryID = categoryID; // professional, leadership or compulsory
        }
        public Course_elearn(int courseID, string courseName, string provider,
            DateTime startDate, DateTime endDate, string status,
            string desc, int categoryID)
        {
            //no prereq only
            this.courseID = courseID;
            this.courseName = courseName;
            this.courseProvider = provider;
            this.startDate = startDate;
            this.expiry_date = endDate;
            this.status = status;
            this.description = desc;
            this.categoryID = categoryID; // professional, leadership or compulsory
        }

        public Course_elearn(int courseID, string courseName,
            string courseProvider, DateTime startDate, DateTime endDate,
            string status, string desc, ArrayList prereq, int categoryID)
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
            this.categoryID = categoryID;
        }

        public DateTime getEntryDate()
        {
            return entry_date;
        }
        public void setEntryDate(DateTime entry_date)
        {
            this.entry_date = entry_date;
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
        public int getCategoryID()
        {
            return categoryID;
        }
        public void setCategoryID(int cat)
        {
            this.categoryID = cat;
        }
        public User getCourseCreator()
        {
            return courseCreator;
        }
        public void setCourseCreator(User courseCreator)
        {
            this.courseCreator = courseCreator;
        }
        public double getHoursAwarded()
        {
            return hoursAwarded;
        }
        public void setHoursAwarded(double hoursAwarded)
        {
            this.hoursAwarded = hoursAwarded;
        }
        public string getTargetAudience()
        {
            return targetAudience;
        }
        public void setTargetAudience(string targetAudience)
        {
            this.targetAudience = targetAudience;
        }
    }
}