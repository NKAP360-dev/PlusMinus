using LearnHub.AppCode.entity;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using LearnHub.AppCode.dao;
using System.Collections;


namespace LearnHub.AppCode.dao
{
    public class ContactDAO
    {
        public void updateContact(Contact a) // Update.
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
                    "Update [Contact] SET name=@name, department=@dept, email=@email, remarks=@remarks WHERE contact_id = @id";
                comm.Parameters.AddWithValue("@name", a.name);
                comm.Parameters.AddWithValue("@dept", a.department);
                comm.Parameters.AddWithValue("@email", a.email);
                comm.Parameters.AddWithValue("@remarks", a.remarks);
                comm.Parameters.AddWithValue("@id", a.contact_id);
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
        public Contact getContactById(int id)
        {
            SqlConnection conn = new SqlConnection();
            Contact a = new Contact();
            UserDAO udao = new UserDAO();
            try
            {
                conn = new SqlConnection();
                string connstr = ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString();
                conn.ConnectionString = connstr;
                conn.Open();
                SqlCommand comm = new SqlCommand();
                comm.Connection = conn;
                comm.CommandText = "select * from [Contact] where contact_id = @aid";
                comm.Parameters.AddWithValue("@aid", id);
                SqlDataReader dr = comm.ExecuteReader();
                while (dr.Read())
                {
                    a.contact_id = ((int) dr["contact_id"]);
                    a.name = ((string) dr["name"]);
                    a.department = ((string) dr["department"]);
                    a.email = ((string) dr["email"]);
                    a.remarks = ((string) dr["remarks"]);
                    a.upload_datetime = ((DateTime) dr["upload_datetime"]);
                    string userid = (string)dr["user_upload"];
                    User user_now = udao.getUserByID(userid);
                    a.user = user_now;
                    a.status = ((string) dr["status"]);
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
            return a;
        }
        public void deactivateContact(int articleID) // Update.
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
                    "Update [Contact] SET status='Inactive' WHERE contact_id=@contactID";
                comm.Parameters.AddWithValue("@contactID", articleID);
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
        public ArrayList getContacts()
        {
            SqlConnection conn = new SqlConnection();
            ArrayList toReturn = new ArrayList();
            UserDAO udao = new UserDAO();
            try
            { 
                conn = new SqlConnection();
                string connstr = ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString();
                conn.ConnectionString = connstr;
                conn.Open();
                SqlCommand comm = new SqlCommand();
                comm.Connection = conn;
                comm.CommandText = "select * from [Contact] where status = 'Active'";
                SqlDataReader dr = comm.ExecuteReader();
                while (dr.Read())
                {
                    Contact a = new Contact();
                    a.contact_id = ((int) dr["contact_id"]);
                    a.name = ((string) dr["name"]);
                    a.department = ((string) dr["department"]);
                    a.email = ((string) dr["email"]);
                    a.remarks = ((string) dr["remarks"]);
                    a.upload_datetime = ((DateTime) dr["upload_datetime"]);
                    string userid = (string)dr["user_upload"];
                    User user_now = udao.getUserByID(userid);
                    a.user = user_now;
                    a.status = ((string) dr["status"]);
                    toReturn.Add(a);
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
        public int createContact(Contact a) // Insert.
        {
            SqlConnection conn = null;
            int toReturn = 0;
            try
            {
                conn = new SqlConnection();
                conn.ConnectionString = ConfigurationManager.ConnectionStrings["DBConnectionString"].ConnectionString;
                conn.Open();
                SqlCommand comm = new SqlCommand();
                comm.Connection = conn;
                comm.CommandText = "insert into [Contact] (name, department, email, remarks, upload_datetime, status, user_upload)" 
                                        +"values(@name, @dept, @email, @remarks, @date, 'Active', @uid)";
                comm.Parameters.AddWithValue("@name", a.name);
                comm.Parameters.AddWithValue("@dept", a.department);
                comm.Parameters.AddWithValue("@email", a.email);
                comm.Parameters.AddWithValue("@remarks", a.remarks);
                comm.Parameters.AddWithValue("@date", a.upload_datetime);
                comm.Parameters.AddWithValue("@uid", a.user.getUserID());
                toReturn = comm.ExecuteNonQuery();
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