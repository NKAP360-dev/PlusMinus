using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace LearnHub.AppCode.entity
{
    public class CourseCategory
    {
        public int categoryID { get; set; }
        public string category { get; set; }
        public string status { get; set; }

        public string getCategory() {
            return category;
        }
    }
}