using LearnHub.AppCode.entity;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace LearnHub.AppCode.dao
{
    public class TNFDAO
    {
        public TNF getIndividualTNFByID(string userID, int tnfID)
        {
            SqlConnection conn = new SqlConnection();
            TNF toReturn = null;
            try
            {
                conn = new SqlConnection();
                string connstr = ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString();
                conn.ConnectionString = connstr;
                conn.Open();
                SqlCommand comm = new SqlCommand();
                comm.Connection = conn;
                comm.CommandText = "select * from [TNF] where tnfid=@tnfid and userID=@userID and type=@type";
                comm.Parameters.AddWithValue("@tnfid", tnfID);
                comm.Parameters.AddWithValue("@userID", userID);
                comm.Parameters.AddWithValue("@type", "individual");
                SqlDataReader dr = comm.ExecuteReader();
                while (dr.Read())
                {
                    toReturn = new TNF();
                    UserDAO userDAO = new UserDAO();
                    WorkflowDAO wfDAO = new WorkflowDAO();
                    WorkflowSubDAO wfsDAO = new WorkflowSubDAO();
                    User user = userDAO.getUserByID((string)dr["userID"]);
                    toReturn.setUser(user);
                    toReturn.setTNFID((int)dr["tnfid"]);
                    toReturn.setType((string)dr["type"]);
                    toReturn.setStatus((string)(dr["status"]));
                    toReturn.setWFStatus((int)dr["wf_status"]);
                    toReturn.setWorkflow(wfDAO.getWorkflowByID((int)dr["wfid"]));
                    if (!dr.IsDBNull(6))
                    {
                        toReturn.setWorkflowSub(wfsDAO.getWorkflowSubByID((int)dr["wf_sub_id"]));
                    }
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
        public void updateTNFStatus(int tnfid, string status) // Update.
        {
            SqlConnection conn = new SqlConnection();

            try
            {
                conn = new SqlConnection();
                string connstr = ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString();
                conn.ConnectionString = connstr;
                conn.Open();
                SqlCommand comm = new SqlCommand();
                comm.Connection = conn;
                comm.CommandText =
                    "Update [TNF] SET status=@status WHERE tnfid=@tnfid";
                comm.Parameters.AddWithValue("@status", status);
                comm.Parameters.AddWithValue("@tnfid", tnfid);
                int rowsAffected = comm.ExecuteNonQuery();
            }
            catch (SqlException ex)
            {
                throw ex;
            }
            finally
            {
                conn.Close();
            }
        }
        public Course getCourseFromTNF(int tnfID)
        {
            SqlConnection conn = new SqlConnection();
            Course toReturn = null;
            try
            {
                conn = new SqlConnection();
                string connstr = ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString();
                conn.ConnectionString = connstr;
                conn.Open();
                SqlCommand comm = new SqlCommand();
                comm.Connection = conn;
                comm.CommandText = "select c.courseID, c.courseName, c.price, c.internalOrExternal, c.courseProvider, c.startDate, c.endDate, c.status, c.overseas from [Course] c inner join [TNF_data] td on c.courseID = td.courseID inner join [TNF] t on td.tnfid = t.tnfid where t.tnfid=@tnfid";
                comm.Parameters.AddWithValue("@tnfid", tnfID);
                SqlDataReader dr = comm.ExecuteReader();
                while (dr.Read())
                {
                    toReturn = new Course();
                    toReturn.setCourseID((int)dr["courseID"]);
                    toReturn.setCourseName((string)dr["courseName"]);
                    toReturn.setPrice((double)(dr["price"]));
                    toReturn.setInternalOrExternal((string)dr["internalOrExternal"]);
                    if (!dr.IsDBNull(4))
                    {
                        toReturn.setCourseProvider((string)dr["courseProvider"]);
                    }
                    toReturn.setStartDate(dr.GetDateTime(5));
                    toReturn.setEndDate(dr.GetDateTime(6));
                    toReturn.setStatus((string)dr["status"]);
                    toReturn.setOverseas((string)dr["overseas"]);
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
        public void updateTNFWFStatus(int tnfid, int wf_status) // Update.
        {
            SqlConnection conn = new SqlConnection();

            try
            {
                conn = new SqlConnection();
                string connstr = ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString();
                conn.ConnectionString = connstr;
                conn.Open();
                SqlCommand comm = new SqlCommand();
                comm.Connection = conn;
                comm.CommandText =
                    "Update [TNF] SET wf_status=@wf_status WHERE tnfid=@tnfid";
                comm.Parameters.AddWithValue("@wf_status", wf_status);
                comm.Parameters.AddWithValue("@tnfid", tnfid);
                int rowsAffected = comm.ExecuteNonQuery();
            }
            catch (SqlException ex)
            {
                throw ex;
            }
            finally
            {
                conn.Close();
            }
        }
        public int getWFStatus(int tnfID)
        {
            SqlConnection conn = new SqlConnection();
            int toReturn = 0;
            try
            {
                conn = new SqlConnection();
                string connstr = ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString();
                conn.ConnectionString = connstr;
                conn.Open();
                SqlCommand comm = new SqlCommand();
                comm.Connection = conn;
                comm.CommandText = "select wf_status from [TNF] where tnfid=@tnfid";
                comm.Parameters.AddWithValue("@tnfid", tnfID);
                SqlDataReader dr = comm.ExecuteReader();
                while (dr.Read())
                {
                    toReturn = (int)dr["wf_status"];
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
        public void updateTNFWFSub(int tnfid, int wfsID) // Update.
        {
            SqlConnection conn = new SqlConnection();

            try
            {
                conn = new SqlConnection();
                string connstr = ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString();
                conn.ConnectionString = connstr;
                conn.Open();
                SqlCommand comm = new SqlCommand();
                comm.Connection = conn;
                comm.CommandText =
                    "Update [TNF] SET wf_sub_id=@wf_sub_id WHERE tnfid=@tnfid";
                comm.Parameters.AddWithValue("@wf_sub_id", wfsID);
                comm.Parameters.AddWithValue("@tnfid", tnfid);
                int rowsAffected = comm.ExecuteNonQuery();
            }
            catch (SqlException ex)
            {
                throw ex;
            }
            finally
            {
                conn.Close();
            }
        }
        public void updateTNFIsProbation(int tnfid, string isProbation) // Update.
        {
            SqlConnection conn = new SqlConnection();

            try
            {
                conn = new SqlConnection();
                string connstr = ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString();
                conn.ConnectionString = connstr;
                conn.Open();
                SqlCommand comm = new SqlCommand();
                comm.Connection = conn;
                comm.CommandText =
                    "Update [TNF_data] SET isProbation=@probation WHERE tnfid=@tnfid";
                comm.Parameters.AddWithValue("@probation",isProbation);
                comm.Parameters.AddWithValue("@tnfid", tnfid);
                int rowsAffected = comm.ExecuteNonQuery();
            }
            catch (SqlException ex)
            {
                throw ex;
            }
            finally
            {
                conn.Close();
            }
        }
        public int createTNF(TNF tnf) // Insert.
        {
            SqlConnection conn = null;
            int toReturn = -1;
            try
            {
                conn = new SqlConnection();
                conn.ConnectionString = ConfigurationManager.ConnectionStrings["DBConnectionString"].ConnectionString;
                conn.Open();
                SqlCommand comm = new SqlCommand();
                comm.Connection = conn;
                comm.CommandText = "Insert into [TNF] (userID, status, wf_status, wfid, type) OUTPUT INSERTED.tnfid VALUES (@userID, @status, @wf_status, @wfid, @type)";
                comm.Parameters.AddWithValue("@userID", tnf.getUser().getUserID());
                comm.Parameters.AddWithValue("@status", tnf.getStatus());
                comm.Parameters.AddWithValue("@wf_status", 0);
                comm.Parameters.AddWithValue("@wfid", tnf.getWorkflow().getWorkflowID());
                comm.Parameters.AddWithValue("@type", tnf.getType());
                toReturn = (Int32)comm.ExecuteScalar();
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
        public void createTNF_Data(int tnfid, int courseID, string prepareForNewJobRole, string prepareForNewJobRoleText, 
            DateTime? prepareForNewJobRoleCompletionDate, string shareKnowledge, string shareKnowledgeText, DateTime? shareKnowledgeCompletionDate, 
            string otherObjectives, string otherObjectivesText, DateTime? otherObjectivesCompletionDate) // Insert.
        {
            SqlConnection conn = null;
            try
            {
                conn = new SqlConnection();
                conn.ConnectionString = ConfigurationManager.ConnectionStrings["DBConnectionString"].ConnectionString;
                conn.Open();
                SqlCommand comm = new SqlCommand();
                comm.Connection = conn;
                comm.CommandText = "Insert into [TNF_data] (tnfid, courseID, prepareForNewJobRole, prepareForNewJobRoleText, " +
                    "prepareForNewJobRoleCompletionDate, shareKnowledge, shareKnowledgeText, shareKnowledgeCompletionDate, otherObjectives, " +
                    "otherObjectivesText, otherObjectivesCompletionDate) VALUES (@tnfid, @courseID, @prepareForNewJobRole, @prepareForNewJobRoleText, " +
                    "@prepareForNewJobRoleCompletionDate, @shareKnowledge, @shareKnowledgeText, @shareKnowledgeCompletionDate, @otherObjectives, " +
                    "@otherObjectivesText, @otherObjectivesCompletionDate)";
                comm.Parameters.AddWithValue("@tnfid", tnfid);
                comm.Parameters.AddWithValue("@courseID", courseID);
                comm.Parameters.AddWithValue("@prepareForNewJobRole", prepareForNewJobRole);
                if (!string.IsNullOrEmpty(prepareForNewJobRoleText))
                {
                    comm.Parameters.AddWithValue("@prepareForNewJobRoleText", prepareForNewJobRoleText);
                }
                else
                {
                    comm.Parameters.AddWithValue("@prepareForNewJobRoleText", DBNull.Value);
                }
                if (prepareForNewJobRoleCompletionDate != null)
                {
                    comm.Parameters.AddWithValue("@prepareForNewJobRoleCompletionDate", prepareForNewJobRoleCompletionDate);
                }
                else
                {
                    comm.Parameters.AddWithValue("prepareForNewJobRoleCompletionDate", DBNull.Value);
                }
                comm.Parameters.AddWithValue("@shareKnowledge", shareKnowledge);
                if (!string.IsNullOrEmpty(shareKnowledgeText))
                {
                    comm.Parameters.AddWithValue("@shareKnowledgeText", shareKnowledgeText);
                }
                else
                {
                    comm.Parameters.AddWithValue("@shareKnowledgeText", DBNull.Value);
                }
                if (shareKnowledgeCompletionDate != null)
                {
                    comm.Parameters.AddWithValue("@shareKnowledgeCompletionDate", shareKnowledgeCompletionDate);
                }
                else
                {
                    comm.Parameters.AddWithValue("@shareKnowledgeCompletionDate", DBNull.Value);
                }
                comm.Parameters.AddWithValue("@otherObjectives", otherObjectives);
                if (!string.IsNullOrEmpty(otherObjectivesText))
                {
                    comm.Parameters.AddWithValue("@otherObjectivesText", otherObjectivesText);
                }
                else
                {
                    comm.Parameters.AddWithValue("@otherObjectivesText", DBNull.Value);
                }
                if (otherObjectivesCompletionDate != null)
                {
                    comm.Parameters.AddWithValue("@otherObjectivesCompletionDate", otherObjectivesCompletionDate);
                } 
                else
                {
                    comm.Parameters.AddWithValue("@otherObjectivesCompletionDate", DBNull.Value);
                }
                /*comm.Parameters.AddWithValue("@sourceOfFunding", sourceOfFunding);
                comm.Parameters.AddWithValue("@isProbation", isProbation);
                comm.Parameters.AddWithValue("@isFunding", isFunding);
                comm.Parameters.AddWithValue("@fundingApplicationDate", fundingApplicationDate);
                comm.Parameters.AddWithValue("@cost_centre", cost_centre);*/
                int rowsAffected = comm.ExecuteNonQuery();
            }
            catch (SqlException ex)
            {
                throw ex;
            }
            finally
            {
                conn.Close();
            }
        }
    }
}