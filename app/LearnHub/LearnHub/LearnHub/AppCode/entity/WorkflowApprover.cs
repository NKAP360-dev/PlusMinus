using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace LearnHub.AppCode.entity
{
    public class WorkflowApprover
    {
        private Workflow mainWF;
        private WorkflowSub mainWFS;
        private User approver;
        private int level;//this is to identify which level of approver routing it is

        public WorkflowApprover() { }
        public WorkflowApprover (Workflow mainWF, WorkflowSub mainWFS, User approver, int level)
        {
            this.mainWF = mainWF;
            this.mainWFS = mainWFS;
            this.approver = approver;
            this.level = level;
        }
        public Workflow getMainWF()
        {
            return mainWF;
        }
        public void setMainWF(Workflow mainWF)
        {
            this.mainWF = mainWF;
        }
        public WorkflowSub getMainWFS()
        {
            return mainWFS;
        }
        public void setMainWFS(WorkflowSub mainWFS)
        {
            this.mainWFS = mainWFS;
        }
        public User getApprover()
        {
            return approver;
        }
        public void setApprover(User approver)
        {
            this.approver = approver;
        }
        public int getLevel()
        {
            return level;
        }
        public void setLevel(int level)
        {
            this.level = level;
        }
    }
}