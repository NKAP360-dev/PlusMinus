using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace LearnHub.AppCode.entity
{
    public class WorkflowSub
    {
        private Workflow mainWF;
        private string wf_sub_name;
        private float amount_low;
        private float amount_high;
        private string wf_sub_id;

        public WorkflowSub() { }
        public WorkflowSub (Workflow mainWF, string wf_sub_name, float amount_low, float amount_high, string wf_sub_id)
        {
            this.mainWF = mainWF;
            this.wf_sub_name = wf_sub_name;
            this.amount_high = amount_high;
            this.amount_low = amount_low;
            this.wf_sub_id = wf_sub_id;
        }
        public Workflow getMainWF()
        {
            return mainWF;
        }

        public void setMainWF(Workflow mainWF)
        {
            this.mainWF = mainWF;
        }
        public string getWfSubName()
        {
            return wf_sub_name;
        }
 
        public void setWfSubName(string wf_sub_name)
        {
            this.wf_sub_name = wf_sub_name;
        }
        public float getAmount_low()
        {
            return amount_low;
        }
        public void setAmount_low(float amountLow)
        {
            amount_low = amountLow;
        }
        public float getAmount_high()
        {
            return amount_high;
        }
        public void setAmount_high(float amountHigh)
        {
            amount_high = amountHigh;
        }
        public string getWorkflowSubID()
        {
            return wf_sub_id;
        }
        public void setWorkflowSubID(string wf_sub_id)
        {
            this.wf_sub_id = wf_sub_id;
        }
    }
}