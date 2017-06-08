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
        
        public List<WorkflowApprover> getSortedWorkflowApprovers(string workflowID, string workflow_subID)
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
                comm.CommandText = "select * from [Workflow_approvers] where wfid=@wfid and wfsid=@wfsid order by level asc";
                comm.Parameters.AddWithValue("@wfid", workflowID);
                comm.Parameters.AddWithValue("@wfsid", workflow_subID);
                SqlDataReader dr = comm.ExecuteReader();
                while (dr.Read())
                {
                    approver = new WorkflowApprover();
                    string wfid = (string)dr["wfid"];
                    Workflow wf = wfDAO.getWorkflowByID(wfid);
                    approver.setMainWF(wf);

                    string wfsid = (string)dr["wf_sub_id"];
                    WorkflowSub wfs = wfsDAO.getWorkflowSubByID(wfsid);
                    approver.setMainWFS(wfs);

                    string userID = (string)dr["userID"];
                    User user = userDAO.getUserByID(userID);
                    approver.setApprover(user);
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
    }
}