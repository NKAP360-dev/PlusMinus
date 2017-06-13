using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace LearnHub.AppCode.entity
{
    public class WorkflowSub
    {
        private Workflow mainWF;
        private double amount_low;
        private double amount_high;
        private int wf_sub_id;

        public WorkflowSub() { }
        public WorkflowSub (Workflow mainWF, double amount_low, double amount_high, int wf_sub_id)
        {
            this.mainWF = mainWF;
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
        public double getAmount_low()
        {
            return amount_low;
        }
        public void setAmount_low(double amountLow)
        {
            amount_low = amountLow;
        }
        public double getAmount_high()
        {
            return amount_high;
        }
        public void setAmount_high(double amountHigh)
        {
            amount_high = amountHigh;
        }
        public int getWorkflowSubID()
        {
            return wf_sub_id;
        }
        public void setWorkflowSubID(int wf_sub_id)
        {
            this.wf_sub_id = wf_sub_id;
        }
    }
}