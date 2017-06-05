using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace LearnHub.AppCode.entity
{
    public class WorkflowApprover
    {
        public Workflow mainWF { get; set; } 
        public WorkflowSub mainWFS { get; set; }
        public User approver { get; set; }
        public int level { get; set; } //this is to identify which level of approver routing it is

        public WorkflowApprover (Workflow mainWF, WorkflowSub mainWFS, User approver, int level)
        {
            this.mainWF = mainWF;
            this.mainWFS = mainWFS;
            this.approver = approver;
            this.level = level;
        }
    }
}