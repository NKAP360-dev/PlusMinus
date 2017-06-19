using LearnHub.AppCode.entity;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace LearnHub.AppCode.dao
{
    public class WorkflowDAO
    {
        private UserDAO userDAO = new UserDAO();
        public Workflow getCurrentActiveWorkflow(string category)
        {
            SqlConnection conn = new SqlConnection();
            Workflow toReturn = null;
            try
            {
                conn = new SqlConnection();
                string connstr = ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString();
                conn.ConnectionString = connstr;
                conn.Open();
                SqlCommand comm = new SqlCommand();
                comm.Connection = conn;
                comm.CommandText = "select * from [Workflow] where status=@status and category=@category";
                comm.Parameters.AddWithValue("@status", "active");
                comm.Parameters.AddWithValue("@category", category);
                SqlDataReader dr = comm.ExecuteReader();
                while (dr.Read())
                {
                    toReturn = new Workflow();
                    toReturn.setWorkflowID((int)dr["wfid"]);
                    toReturn.setProbationPeriod((int)(dr["probation_period"]));
                    toReturn.setBondCriteria((double)(dr["bond_criteria"]));
                    string userCreatedID = (string)dr["userID"];
                    toReturn.setUserCreated(userDAO.getUserByID(userCreatedID));
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

        public Workflow getWorkflowByID(int workflowID)
        {
            SqlConnection conn = new SqlConnection();
            Workflow toReturn = null;
            try
            {
                conn = new SqlConnection();
                string connstr = ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString();
                conn.ConnectionString = connstr;
                conn.Open();
                SqlCommand comm = new SqlCommand();
                comm.Connection = conn;
                comm.CommandText = "select * from [Workflow] where wfid=@wfid";
                comm.Parameters.AddWithValue("@wfid", workflowID);
                SqlDataReader dr = comm.ExecuteReader();
                while (dr.Read())
                {
                    toReturn = new Workflow();
                    toReturn.setWorkflowID((int)dr["wfid"]);
                    toReturn.setProbationPeriod((int)(dr["probation_period"]));
                    toReturn.setBondCriteria((double)(dr["bond_criteria"]));
                    string userCreatedID = (string)dr["userID"];
                    toReturn.setUserCreated(userDAO.getUserByID(userCreatedID));
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

        public int getNumberOfCriteriaByWorkflow(int workflowID, string type)
        {
            SqlConnection conn = new SqlConnection();
            Int32 toReturn;
            try
            {
                conn = new SqlConnection();
                string connstr = ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString();
                conn.ConnectionString = connstr;
                conn.Open();
                SqlCommand comm = new SqlCommand();
                comm.Connection = conn;
                comm.CommandText = "select count(*) from [Workflow_sub] where wfid=@wfid and type=@type";
                comm.Parameters.AddWithValue("@wfid", workflowID);
                comm.Parameters.AddWithValue("@type", type);
                toReturn = Convert.ToInt32(comm.ExecuteScalar());
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