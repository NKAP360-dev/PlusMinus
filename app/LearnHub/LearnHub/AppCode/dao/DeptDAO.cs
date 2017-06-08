using LearnHub.AppCode.entity;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace LearnHub.AppCode.dao
{
    public class DeptDAO
    {
        private UserDAO userDAO = new UserDAO();
        public Department getDeptByName(string deptName)
        {
            SqlConnection conn = new SqlConnection();
            Department toReturn = null;
            try
            {
                conn = new SqlConnection();
                string connstr = ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString();
                conn.ConnectionString = connstr;
                conn.Open();
                SqlCommand comm = new SqlCommand();
                comm.Connection = conn;
                comm.CommandText = "select * from [Department] where dept_name=@dept_name";
                comm.Parameters.AddWithValue("@dept_name", deptName);
                SqlDataReader dr = comm.ExecuteReader();
                while (dr.Read())
                {
                    toReturn = new Department();
                    toReturn.setDeptName((string)dr["dept_name"]);
                    toReturn.setProjectedBudget(Convert.ToSingle(dr["projected_budget"]));
                    toReturn.setActualBudget(Convert.ToSingle(dr["actual_budget"]));
                    string dept_headID = (string)dr["dept_headID"];
                    toReturn.setDeptHead(userDAO.getUserByID(dept_headID));
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

        public List<Department> getAllDepartment()
        {
            List<Department> toReturn = new List<Department>();
            SqlConnection conn = new SqlConnection();
            Department d = null;
            try
            {
                conn = new SqlConnection();
                string connstr = ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString();
                conn.ConnectionString = connstr;
                conn.Open();
                SqlCommand comm = new SqlCommand();
                comm.Connection = conn;
                comm.CommandText = "select * from [Department]";
                SqlDataReader dr = comm.ExecuteReader();
                while (dr.Read())
                {
                    d = new Department();
                    d.setDeptName((string)dr["dept_name"]);
                    d.setProjectedBudget(Convert.ToSingle(dr["projected_budget"]));
                    d.setActualBudget(Convert.ToSingle(dr["actual_budget"]));
                    string dept_headID = (string)dr["dept_headID"];
                    d.setDeptHead(userDAO.getUserByID(dept_headID));

                    toReturn.Add(d);
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