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
                    User user = userDAO.getUserByID((string)dr["userID"]);
                    toReturn.setUser(user);
                    toReturn.setTNFID((int)dr["tnfid"]);
                    toReturn.setType((string)dr["type"]);
                    toReturn.setStatus((string)(dr["status"]));
                    toReturn.setWFStatus((int)dr["wf_status"]);
                    toReturn.setWorkflow(wfDAO.getWorkflowByID((int)dr["wfid"]));
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
                comm.CommandText = "select c.courseID, c.courseName, c.price, c.vendor, c.details from [Course] c inner join [TNF_data] td on c.courseID = td.courseID inner join [TNF] t on td.tnfid = t.tnfid where t.tnfid=@tnfid";
                comm.Parameters.AddWithValue("@tnfid", tnfID);
                SqlDataReader dr = comm.ExecuteReader();
                while (dr.Read())
                {
                    toReturn = new Course();
                    toReturn.setCourseID((int)dr["courseID"]);
                    toReturn.setCourseName((string)dr["courseName"]);
                    toReturn.setPrice((double)(dr["price"]));
                    if (!dr.IsDBNull(4))
                    {
                        toReturn.setVendor((string)dr["vendor"]);
                        toReturn.setVendorDetails((string)dr["details"]);
                    } else
                    {
                        toReturn.setVendor("NA");
                        toReturn.setVendorDetails("NA");
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
    }
}