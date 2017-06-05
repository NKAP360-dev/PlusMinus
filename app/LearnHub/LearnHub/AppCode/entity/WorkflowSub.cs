using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace LearnHub.AppCode.entity
{
    public class WorkflowSub
    {
        public Workflow mainWF { get; set; }
        public string criteriaName { get; set; }
        public double amount_low { get; set; }
        public double amount_high { get; set; }

        public WorkflowSub (Workflow mainWF, string criteriaName, double amount_low, double amount_high)
        {
            this.mainWF = mainWF;
            this.criteriaName = criteriaName;
            this.amount_high = amount_high;
            this.amount_low = amount_low;
        }
    }
}