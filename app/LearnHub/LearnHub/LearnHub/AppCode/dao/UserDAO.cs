using LearnHub.AppCode.entity;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace LearnHub.AppCode.dao
{
    public class UserDAO
    {
        public User getUserByID(string userID)
        {
            SqlConnection conn = new SqlConnection();
            User toReturn = null;
            try
            {
                conn = new SqlConnection();
                string connstr = ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString();
                conn.ConnectionString = connstr;
                conn.Open();
                SqlCommand comm = new SqlCommand();
                comm.Connection = conn;
                comm.CommandText = "select * from [User] where userID=@userID";
                comm.Parameters.AddWithValue("@userID", userID);
                SqlDataReader dr = comm.ExecuteReader();
                while (dr.Read())
                {
                    toReturn = new User();
                    toReturn.setUserID((string)dr["userID"]);
                    toReturn.setName((string)dr["name"]);
                    toReturn.setLengthOfService(Convert.ToSingle(dr["lengthOfService"]));
                    toReturn.setJobTitle((string)dr["job_title"]);
                    if (!dr.IsDBNull(5))
                    {
                        toReturn.setSupervisor((string)dr["supervisor"]);
                    }
                    toReturn.setRole((string)dr["role"]);
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

        public List<User> getAllUsers()
        {
            List<User> toReturn = new List<User>();
            SqlConnection conn = new SqlConnection();
            User u = null;
            try
            {
                conn = new SqlConnection();
                string connstr = ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString();
                conn.ConnectionString = connstr;
                conn.Open();
                SqlCommand comm = new SqlCommand();
                comm.Connection = conn;
                comm.CommandText = "select * from [User]";
                SqlDataReader dr = comm.ExecuteReader();
                while (dr.Read())
                {
                    u = new User();
                    u = new User();
                    u.setUserID((string)dr["userID"]);
                    u.setName((string)dr["name"]);
                    u.setLengthOfService(Convert.ToSingle(dr["lengthOfService"]));
                    u.setJobTitle((string)dr["job_title"]);
                    if (!dr.IsDBNull(5))
                    {
                        u.setSupervisor((string)dr["supervisor"]);
                    }
                    u.setRole((string)dr["role"]);

                    toReturn.Add(u);
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