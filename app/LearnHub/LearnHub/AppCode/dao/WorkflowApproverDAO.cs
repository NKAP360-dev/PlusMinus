using LearnHub.AppCode.entity;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace LearnHub.AppCode.dao
{
    public class WorkflowApproverDAO
    {
        private WorkflowDAO wfDAO = new WorkflowDAO();
        private WorkflowSubDAO wfsDAO = new WorkflowSubDAO();

        //TO EDIT
        
        public List<WorkflowApprover> getSortedWorkflowApprovers(int workflowID, int workflow_subID)
        {
            List<WorkflowApprover> toReturn = new List<WorkflowApprover>();
            SqlConnection conn = new SqlConnection();
            WorkflowApprover approver = null;
            UserDAO userDAO = new UserDAO();
            try
            {
                conn = new SqlConnection();
                string connstr = ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString();
                conn.ConnectionString = connstr;
                conn.Open();
                SqlCommand comm = new SqlCommand();
                comm.Connection = conn;
                comm.CommandText = "select * from [Workflow_approvers] where wfid=@wfid and wf_sub_id=@wfsid order by levels asc";
                comm.Parameters.AddWithValue("@wfid", workflowID);
                comm.Parameters.AddWithValue("@wfsid", workflow_subID);
                SqlDataReader dr = comm.ExecuteReader();
                while (dr.Read())
                {
                    approver = new WorkflowApprover();
                    int wfid = (int)dr["wfid"];
                    Workflow wf = wfDAO.getWorkflowByID(wfid);
                    approver.setMainWF(wf);

                    int wfsid = (int)dr["wf_sub_id"];
                    WorkflowSub wfs = wfsDAO.getWorkflowSubByID(wfsid);
                    approver.setMainWFS(wfs);

                    approver.setJobCategory((string)dr["job_category"]);
                    approver.setLevel((int)dr["levels"]);

                    toReturn.Add(approver);
                }
                dr.Close();
            }
            catch (SqlException ex)
            {
                throw ex;
            }
            finally
            {
                conn.Close();
            }
            return toReturn;
        }
        public WorkflowApprover getLastApproverInChain(int workflowID, int workflow_subID)
        {
            WorkflowApprover toReturn = new WorkflowApprover();
            SqlConnection conn = new SqlConnection();
            UserDAO userDAO = new UserDAO();
            try
            {
                conn = new SqlConnection();
                string connstr = ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString();
                conn.ConnectionString = connstr;
                conn.Open();
                SqlCommand comm = new SqlCommand();
                comm.Connection = conn;
                comm.CommandText = "select top 1 * from [Workflow_approvers] where wfid=@wfid and wf_sub_id=@wfsid order by levels desc";
                comm.Parameters.AddWithValue("@wfid", workflowID);
                comm.Parameters.AddWithValue("@wfsid", workflow_subID);
                SqlDataReader dr = comm.ExecuteReader();
                while (dr.Read())
                {
                    int wfid = (int)dr["wfid"];
                    Workflow wf = wfDAO.getWorkflowByID(wfid);
                    toReturn.setMainWF(wf);

                    int wfsid = (int)dr["wf_sub_id"];
                    WorkflowSub wfs = wfsDAO.getWorkflowSubByID(wfsid);
                    toReturn.setMainWFS(wfs);

                    toReturn.setJobCategory((string)dr["job_category"]);
                    toReturn.setLevel((int)dr["levels"]);
                }
                dr.Close();
            }
            catch (SqlException ex)
            {
                throw ex;
            }
            finally
            {
                conn.Close();
            }
            return toReturn;
        }
    }
}