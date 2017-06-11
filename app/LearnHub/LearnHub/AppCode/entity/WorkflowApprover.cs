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
        private string job_category;
        private int level;//this is to identify which level of approver routing it is

        public WorkflowApprover() { }
        public WorkflowApprover (Workflow mainWF, WorkflowSub mainWFS, string job_category, int level)
        {
            this.mainWF = mainWF;
            this.mainWFS = mainWFS;
            this.job_category = job_category;
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
        public string getJobCategory()
        {
            return job_category;
        }
        public void setJobCategory(string job_category)
        {
            this.job_category = job_category;
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