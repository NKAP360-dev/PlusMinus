using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace LearnHub.AppCode.entity
{
    public class Course
    {
        public string courseID { get; set; }
        public string courseName { get; set; }
        public double price { get; set; }
        public string vendor { get; set; }
        public string vendor_details { get; set; }

        public Course (string courseID, string courseName, double price, string vendor, string vendor_details)
        {
            this.courseID = courseID;
            this.courseName = courseName;
            this.price = price;
            this.vendor = vendor;
            this.vendor_details = vendor_details;
        }
    }
}