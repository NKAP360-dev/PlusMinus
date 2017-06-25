using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace LearnHub.AppCode.entity
{
    public class Department
    {
        private string dept_name;
        private double projectedBudget;
        private double actualBudget;
        private User dept_head;
        private int cost_centre;

        public Department() { }
        public Department (string dept_name, double projectedBudget, double actualBudget, User dept_head, int cost_centre)
        {
            this.dept_name = dept_name;
            this.projectedBudget = projectedBudget;
            this.actualBudget = actualBudget;
            this.dept_head = dept_head;
            this.cost_centre = cost_centre;
        }
        public string getDeptName()
        {
            return dept_name;
        }
        public void setDeptName(string dept_name)
        {
            this.dept_name = dept_name;
        }
        public double getProjectedBudget()
        {
            return projectedBudget;
        }
        public void setProjectedBudget(double projectedBudget)
        {
            this.projectedBudget = projectedBudget;
        }
        public double getActualBudget()
        {
            return actualBudget;
        }
        public void setActualBudget(double actualBudget)
        {
            this.actualBudget = actualBudget;
        }
        public User getDeptHead()
        {
            return dept_head;
        }
        public void setDeptHead(User dept_head)
        {
            this.dept_head = dept_head;
        }
        public int getCostCentre()
        {
            return cost_centre;
        }
        public void setCostCentre(int cost_centre)
        {
            this.cost_centre = cost_centre;
        }
    }
}