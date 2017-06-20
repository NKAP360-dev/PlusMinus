using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace LearnHub.AppCode.entity
{
    public class Course
    {
        private int courseID;
        private string courseName;
        private double price;
        private string internalOrExternal;
        private string courseProvider;
        private DateTime startDate;
        private DateTime endDate;
        private string status;
        private string overseas;

        public Course()
        {

        }
        public Course (int courseID, string courseName, double price, string internalOrExternal, DateTime startDate, DateTime endDate, string status, string overseas)
        {
            this.courseID = courseID;
            this.courseName = courseName;
            this.price = price;
            this.internalOrExternal = internalOrExternal;
            this.startDate = startDate;
            this.endDate = endDate;
            this.status = status;
            this.overseas = overseas;
        }
        public Course(int courseID, string courseName, double price, string internalOrExternal, string courseProvider, DateTime startDate, DateTime endDate, string status, string overseas)
        {
            this.courseID = courseID;
            this.courseName = courseName;
            this.price = price;
            this.internalOrExternal = internalOrExternal;
            this.courseProvider = courseProvider;
            this.startDate = startDate;
            this.endDate = endDate;
            this.status = status;
            this.overseas = overseas;
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
        public double getPrice()
        {
            return price;
        }
        public void setPrice(double price)
        {
            this.price = price;
        }
        public string getInternalOrExternal()
        {
            return internalOrExternal;
        }
        public void setInternalOrExternal(string internalOrExternal)
        {
            this.internalOrExternal = internalOrExternal;
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
        public string getOverseas()
        {
            return overseas;
        }
        public void setOverseas(string overseas)
        {
            this.overseas = overseas;
        }
    }
}