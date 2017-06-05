using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace LearnHub.AppCode.entity
{
    public class Department
    {
        public string dept_name { get; set; }
        public double projectedBudget { get; set; }
        public double actualBudget { get; set; }
        public User dept_head { get; set; }

        public Department (string dept_name, double projectedBudget, double actualBudget, User dept_head)
        {
            this.dept_name = dept_name;
            this.projectedBudget = projectedBudget;
            this.actualBudget = actualBudget;
            this.dept_head = dept_head;
        }
    }
}