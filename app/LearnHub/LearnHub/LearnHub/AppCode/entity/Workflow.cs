using LearnHub.AppCode.dao;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace LearnHub.AppCode.entity
{
    public class Workflow
    {
        private string wid;
        private string wf_name;
        private int probationPeriod;
        private float bondCriteria;
        private User userCreated;
        private WorkflowSubDAO wf_subDAO = new WorkflowSubDAO();

        public Workflow() { }
        public Workflow (string wid, string wf_name, int probationPeriod, float bondCriteria, User userCreated)
        {
            this.wid = wid;
            this.wf_name = wf_name;
            this.probationPeriod = probationPeriod;
            this.bondCriteria = bondCriteria;
            this.userCreated = userCreated;
        }
        public string getWorkflowID()
        {
            return wid;
        }
        public void setWorkflowID(string wid)
        {
            this.wid = wid;
        }
        public string getWorkflowName()
        {
            return wf_name;
        }
        public void setWorkflowName(string wf_name)
        {
            this.wf_name = wf_name;
        }
        public int getProbationPeriod()
        {
            return probationPeriod;
        }
        public void setProbationPeriod(int probationPeriod)
        {
            this.probationPeriod = probationPeriod;
        }
        public float getBondCriteria()
        {
            return bondCriteria;
        }
        public void setBondCriteria(float bondCriteria)
        {
            this.bondCriteria = bondCriteria;
        }
        public User getUserCreated()
        {
            return userCreated;
        }
        public void setUserCreated(User userCreated)
        {
            this.userCreated = userCreated;
        }
        public List<WorkflowSub> getWorkflowSub()
        {
            return wf_subDAO.getSortedWorflowSubByWorkflow(wid);
        }
        
    }
}