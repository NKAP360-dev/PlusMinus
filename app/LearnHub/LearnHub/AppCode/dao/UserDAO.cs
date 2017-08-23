﻿using LearnHub.AppCode.entity;
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
        public Boolean updatePassword(string password, User user)
        {
            SqlConnection conn = new SqlConnection();
            Boolean done = false;
            try
            {
                conn = new SqlConnection();
                string connstr = ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString();
                conn.ConnectionString = connstr;
                conn.Open();
                SqlCommand comm = new SqlCommand();
                comm.Connection = conn;
                comm.CommandText =
                    "update [User] set password=@pw where userID = @userid";
                comm.Parameters.AddWithValue("@pw", password);
                comm.Parameters.AddWithValue("@userid", user.getUserID());
                int rowsAffected = comm.ExecuteNonQuery();
                done = true;
            }
            catch (SqlException ex)
            {
                throw ex;
            }
            finally
            {
                conn.Close();
            }
            return done;
        }
        public string getPassword(string userID)
        {
            SqlConnection conn = new SqlConnection();
            string toReturn = null;
            try
            {
                conn = new SqlConnection();
                string connstr = ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString();
                conn.ConnectionString = connstr;
                conn.Open();
                SqlCommand comm = new SqlCommand();
                comm.Connection = conn;
                comm.CommandText = "select password from [User] where userID=@userID";
                comm.Parameters.AddWithValue("@userID", userID);
                SqlDataReader dr = comm.ExecuteReader();
                while (dr.Read())
                {
                   toReturn = (string)dr["password"];
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
                    toReturn.setJobTitle((string)dr["job_title"]);
                    toReturn.setJobCategory((string)dr["job_category"]);
                    if (!dr.IsDBNull(6))
                    {
                        toReturn.setSupervisor((string)dr["supervisor"]);
                    } else
                    {
                        toReturn.setSupervisor("NA");
                    }
                    toReturn.setRole((string)dr["role"]);
                    if (!dr.IsDBNull(8))
                    {
                        toReturn.setDepartment((string)dr["dept_name"]);
                    } else
                    {
                        toReturn.setDepartment("NA");
                    }
                    toReturn.setEmail((string)dr["email"]);
                    toReturn.setContact((string)dr["contactNumber"]);
                    toReturn.setAddress((string)dr["address"]);
                    toReturn.setStartDate(dr.GetDateTime(3));
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

        public User updateInfo(string contact, string add, User user)
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
                    "update [User] set contactNumber=@contact, address=@add where userID = @userID";
                comm.Parameters.AddWithValue("@contact", contact);
                comm.Parameters.AddWithValue("@add", add);
                comm.Parameters.AddWithValue("@userID", user.getUserID());
                user.setAddress(add);
                user.setContact(contact);
                int rowsAffected = comm.ExecuteNonQuery();
                return user;
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
                    u.setJobTitle((string)dr["job_title"]);
                    u.setJobCategory((string)dr["job_category"]);
                    if (!dr.IsDBNull(5))
                    {
                        u.setSupervisor((string)dr["supervisor"]);
                    } else
                    {
                        u.setSupervisor("NA");
                    }
                    u.setRole((string)dr["role"]);
                    u.setDepartment((string)dr["dept_name"]);
                    u.setEmail((string)dr["email"]);
                    u.setStartDate(dr.GetDateTime(3));

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
        public User getSupervisorbyDepartment(string dept_name)
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
                comm.CommandText = "select * from [User] where dept_name=@dept_name and job_category=@job_category";
                comm.Parameters.AddWithValue("@dept_name", dept_name);
                comm.Parameters.AddWithValue("@job_category", "supervisor");
                SqlDataReader dr = comm.ExecuteReader();
                while (dr.Read())
                {
                    toReturn = new User();
                    toReturn.setUserID((string)dr["userID"]);
                    toReturn.setName((string)dr["name"]);
                    toReturn.setJobTitle((string)dr["job_title"]);
                    toReturn.setJobCategory((string)dr["job_category"]);
                    if (!dr.IsDBNull(5))
                    {
                        toReturn.setSupervisor((string)dr["supervisor"]);
                    } else
                    {
                        toReturn.setSupervisor("NA");
                    }
                    toReturn.setRole((string)dr["role"]);
                    toReturn.setDepartment((string)dr["dept_name"]);
                    toReturn.setEmail((string)dr["email"]);
                    toReturn.setStartDate(dr.GetDateTime(3));
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
        public User getHODbyDepartment(string dept_name)
        {
            SqlConnection conn = new SqlConnection();
            User hod = getSupervisorbyDepartment(dept_name);
            string supervisorID = getSupervisorIDOfUser(hod.getUserID());
            return getUserByID(supervisorID);
        }
        public string getSupervisorIDOfUser(string userID)
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
                comm.CommandText = "select supervisor from [User] where userID=@userID";
                comm.Parameters.AddWithValue("@userID", userID);
                SqlDataReader dr = comm.ExecuteReader();
                while (dr.Read())
                { 
                    toReturn = (string)dr["supervisor"];
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
        public User getCEO()
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
                comm.CommandText = "select * from [User] where job_category=@job_category";
                comm.Parameters.AddWithValue("@job_category", "ceo");
                SqlDataReader dr = comm.ExecuteReader();
                while (dr.Read())
                {
                    toReturn = new User();
                    toReturn.setUserID((string)dr["userID"]);
                    toReturn.setName((string)dr["name"]);
                    toReturn.setJobTitle((string)dr["job_title"]);
                    toReturn.setJobCategory((string)dr["job_category"]);
                    if (!dr.IsDBNull(6))
                    {
                        toReturn.setSupervisor((string)dr["supervisor"]);
                    }
                    else
                    {
                        toReturn.setSupervisor("NA");
                    }
                    toReturn.setRole((string)dr["role"]);
                    toReturn.setDepartment((string)dr["dept_name"]);
                    toReturn.setEmail((string)dr["email"]);
                    toReturn.setStartDate(dr.GetDateTime(3));
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
        public User getHRHOD()
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
                comm.CommandText = "select * from [User] where job_category=@job_category";
                comm.Parameters.AddWithValue("@job_category", "hr hod");
                SqlDataReader dr = comm.ExecuteReader();
                while (dr.Read())
                {
                    toReturn = new User();
                    toReturn.setUserID((string)dr["userID"]);
                    toReturn.setName((string)dr["name"]);
                    toReturn.setJobTitle((string)dr["job_title"]);
                    toReturn.setJobCategory((string)dr["job_category"]);
                    if (!dr.IsDBNull(5))
                    {
                        toReturn.setSupervisor((string)dr["supervisor"]);
                    }
                    else
                    {
                        toReturn.setSupervisor("NA");
                    }
                    toReturn.setRole((string)dr["role"]);
                    toReturn.setDepartment((string)dr["dept_name"]);
                    toReturn.setEmail((string)dr["email"]);
                    toReturn.setStartDate(dr.GetDateTime(3));
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
        public List<User> getAllHR()
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
                comm.CommandText = "select * from [User] where job_category=@job_category";
                comm.Parameters.AddWithValue("@job_category", "hr");
                SqlDataReader dr = comm.ExecuteReader();
                while (dr.Read())
                {
                    u = new User();
                    u = new User();
                    u.setUserID((string)dr["userID"]);
                    u.setName((string)dr["name"]);
                    u.setJobTitle((string)dr["job_title"]);
                    u.setJobCategory((string)dr["job_category"]);
                    if (!dr.IsDBNull(5))
                    {
                        u.setSupervisor((string)dr["supervisor"]);
                    }
                    else
                    {
                        u.setSupervisor("NA");
                    }
                    u.setRole((string)dr["role"]);
                    u.setDepartment((string)dr["dept_name"]);
                    u.setEmail((string)dr["email"]);
                    u.setStartDate(dr.GetDateTime(3));

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