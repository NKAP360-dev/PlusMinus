﻿using LearnHub.AppCode.entity;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Web;
using System.Collections;

namespace LearnHub.AppCode.dao
{
    public class LoginDAO
    {
        public User login(string userID, string password)
        {
            SqlConnection conn = new SqlConnection();
            User toReturn = new User();
            UserDAO uDao = new UserDAO();
            try
            {
                conn = new SqlConnection();
                string connstr = ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString();
                conn.ConnectionString = connstr;
                conn.Open();
                SqlCommand comm = new SqlCommand();
                comm.Connection = conn;
                comm.CommandText = "select * from [User] where userID=@userID and password=@password";
                comm.Parameters.AddWithValue("@userID", userID);
                comm.Parameters.AddWithValue("@password", password);
                SqlDataReader dr = comm.ExecuteReader();
                while (dr.Read())
                {
                    toReturn = new User();
                    string validation = (string)dr["status"];
                    if (validation.Equals("Active"))
                    {
                        toReturn.setUserID((string)dr["userID"]);
                        toReturn.setName((string)dr["name"]);
                        toReturn.setJobTitle((string)dr["job_title"]);
                        toReturn.setJobCategory((string)dr["job_category"]);
                        toReturn.setEmail((string)dr["email"]);
                        toReturn.setStartDate(dr.GetDateTime(3));
                        toReturn.setContact((string)dr["contactNumber"]);
                        toReturn.setAddress((string)dr["address"]);
                        //toReturn.setPasswordHashed((string)dr["password"]);
                        if (!dr.IsDBNull(6))
                        {
                            toReturn.setSupervisor((string)dr["supervisor"]);
                        }
                        else
                        {
                            toReturn.setSupervisor("NA");
                        }
                        ArrayList roles = uDao.getRolesByID(userID);
                        toReturn.setRoles(roles);
                        if (!dr.IsDBNull(8))
                        {
                            toReturn.setDepartment((string)dr["dept_name"]);
                        }
                        else
                        {
                            toReturn.setDepartment("NA");
                        }
                        //toReturn.setStatus((string)dr["status"]);
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
        public string getSalt(string userID)
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
                comm.CommandText = "select salt from [User] where userID=@userID";
                comm.Parameters.AddWithValue("@userID", userID);
                SqlDataReader dr = comm.ExecuteReader();
                while (dr.Read())
                {
                    toReturn = (string)dr["salt"];
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