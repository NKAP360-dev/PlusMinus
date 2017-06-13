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
        private string vendor;
        private string vendor_details;

        public Course()
        {

        }
        public Course (int courseID, string courseName, double price, string vendor, string vendor_details)
        {
            this.courseID = courseID;
            this.courseName = courseName;
            this.price = price;
            this.vendor = vendor;
            this.vendor_details = vendor_details;
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
        public string getVendor()
        {
            return vendor;
        }
        public void setVendor(string vendor)
        {
            this.vendor = vendor;
        }
        public string getVendorDetails()
        {
            return vendor_details;
        }
        public void setVendorDetails(string vendor_details)
        {
            this.vendor_details = vendor_details;
        }
    }
}