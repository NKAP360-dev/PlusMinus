using LearnHub.AppCode.dao;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace LearnHub.AppCode.entity
{
    public class Workflow
    {
        private int wid;
        private string wf_name;
        private double probationPeriod;
        private double bondCriteria;
        private User userCreated;
        private WorkflowSubDAO wf_subDAO = new WorkflowSubDAO();

        public Workflow() { }
        public Workflow (int wid, string wf_name, double probationPeriod, double bondCriteria, User userCreated)
        {
            this.wid = wid;
            this.wf_name = wf_name;
            this.probationPeriod = probationPeriod;
            this.bondCriteria = bondCriteria;
            this.userCreated = userCreated;
        }
        public int getWorkflowID()
        {
            return wid;
        }
        public void setWorkflowID(int wid)
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
        public double getProbationPeriod()
        {
            return probationPeriod;
        }
        public void setProbationPeriod(double probationPeriod)
        {
            this.probationPeriod = probationPeriod;
        }
        public double getBondCriteria()
        {
            return bondCriteria;
        }
        public void setBondCriteria(double bondCriteria)
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
        public List<WorkflowSub> getWorkflowSub(string type)
        {
            return wf_subDAO.getSortedWorflowSubByWorkflowIDandType(wid, type);
        }
        
    }
}