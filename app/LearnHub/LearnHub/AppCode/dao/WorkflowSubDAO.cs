using LearnHub.AppCode.entity;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace LearnHub.AppCode.dao
{
    public class WorkflowSubDAO
    {
        private WorkflowDAO wfDAO = new WorkflowDAO();
        
        public List<WorkflowSub> getSortedWorflowSubByWorkflowIDandType(int workflowID, string type)
        {
            List<WorkflowSub> toReturn = new List<WorkflowSub>();
            SqlConnection conn = new SqlConnection();
            WorkflowSub wfs = null;
            try
            {
                conn = new SqlConnection();
                string connstr = ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString();
                conn.ConnectionString = connstr;
                conn.Open();
                SqlCommand comm = new SqlCommand();
                comm.Connection = conn;
                comm.CommandText = "select * from [Workflow_Sub] where wfid=@wfid and type=@type order by criteria_lower_limit asc";
                comm.Parameters.AddWithValue("@wfid", workflowID);
                comm.Parameters.AddWithValue("@type", type);
                SqlDataReader dr = comm.ExecuteReader();
                while (dr.Read())
                {
                    wfs = new WorkflowSub();
                    wfs.setMainWF(wfDAO.getWorkflowByID(workflowID));
                    wfs.setAmount_low((double)(dr["criteria_lower_limit"]));
                    wfs.setAmount_high((double)(dr["criteria_upper_limit"]));
                    wfs.setWorkflowSubID((int)dr["wf_sub_id"]);
                    toReturn.Add(wfs);
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
        public WorkflowSub getWorkflowSubByID(int wf_sub_ID)
        {
            SqlConnection conn = new SqlConnection();
            WorkflowSub toReturn = null;
            try
            {
                conn = new SqlConnection();
                string connstr = ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString();
                conn.ConnectionString = connstr;
                conn.Open();
                SqlCommand comm = new SqlCommand();
                comm.Connection = conn;
                comm.CommandText = "select * from [Workflow_sub] where wf_sub_id=@wf_sub_id";
                comm.Parameters.AddWithValue("@wf_sub_id", wf_sub_ID);
                SqlDataReader dr = comm.ExecuteReader();
                while (dr.Read())
                {
                    toReturn = new WorkflowSub();
                    Workflow wf = wfDAO.getWorkflowByID((int)dr["wfid"]);
                    toReturn.setMainWF(wf);
                    toReturn.setAmount_low((double)(dr["criteria_lower_limit"]));
                    toReturn.setAmount_high((double)(dr["criteria_upper_limit"]));
                    toReturn.setWorkflowSubID((int)dr["wf_sub_id"]);
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
        public string getWorkflowSubType(int wf_sub_ID)
        {
            SqlConnection conn = new SqlConnection();
            string toReturn = "";
            try
            {
                conn = new SqlConnection();
                string connstr = ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString();
                conn.ConnectionString = connstr;
                conn.Open();
                SqlCommand comm = new SqlCommand();
                comm.Connection = conn;
                comm.CommandText = "select type from [Workflow_sub] where wf_sub_id=@wf_sub_id";
                comm.Parameters.AddWithValue("@wf_sub_id", wf_sub_ID);
                SqlDataReader dr = comm.ExecuteReader();
                while (dr.Read())
                {
                    toReturn = (string)dr["type"];
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