using LearnHub.AppCode.entity;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Collections;
using System.Globalization;

namespace LearnHub.AppCode.dao
{
    public class AuditDAO
    {
        public ArrayList getAllAudit_operation(string operation, DateTime dateFrom, DateTime dateTo)
        {
            SqlConnection conn = new SqlConnection();
            ArrayList toReturn = new ArrayList();
            try
            {
                conn = new SqlConnection();
                string connstr = ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString();
                conn.ConnectionString = connstr;
                conn.Open();
                SqlCommand comm = new SqlCommand();
                comm.Connection = conn;
                comm.CommandText = "select * from Audit where operation = @operation and dateModified >= convert(datetime, @dateFrom, 103) and " +
                    "dateModified <= convert(datetime, @dateTo, 103)"; // all operations are lowercase 
                comm.Parameters.AddWithValue("@operation", operation);
                comm.Parameters.AddWithValue("@dateFrom", dateFrom);
                comm.Parameters.AddWithValue("@dateTo", dateTo);
                SqlDataReader dr = comm.ExecuteReader();
                while (dr.Read())
                {
                    Audit a = new Audit();
                    a.userID = ((string)dr["userID"]);
                    a.functionModified = ((string)dr["functionModified"]);
                    a.operation = ((string)dr["operation"]);
                    a.id_of_function = (string)dr["id_of_function"];
                    a.dateModified = ((DateTime)dr["dateModified"]);
                    a.remarks = ((string)dr["remarks"]);
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
        public ArrayList getAllAudit_function(string function, DateTime dateFrom, DateTime dateTo)
        {
            SqlConnection conn = new SqlConnection();
            ArrayList toReturn = new ArrayList();
            try
            {
                conn = new SqlConnection();
                string connstr = ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString();
                conn.ConnectionString = connstr;
                conn.Open();
                SqlCommand comm = new SqlCommand();
                comm.Connection = conn;
                comm.CommandText = "select * from Audit where functionModified = @function and dateModified >= convert(datetime, @dateFrom, 103) and " +
                    "dateModified <= convert(datetime, @dateTo, 103)"; // all operations are lowercase 
                comm.Parameters.AddWithValue("@function", function);
                comm.Parameters.AddWithValue("@dateFrom", dateFrom);
                comm.Parameters.AddWithValue("@dateTo", dateTo);
                SqlDataReader dr = comm.ExecuteReader();
                while (dr.Read())
                {
                    Audit a = new Audit();
                    a.userID = ((string)dr["userID"]);
                    a.functionModified = ((string)dr["functionModified"]);
                    a.operation = ((string)dr["operation"]);
                    a.id_of_function = (string)dr["id_of_function"];
                    a.dateModified = ((DateTime)dr["dateModified"]);
                    a.remarks = ((string)dr["remarks"]);
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
        public ArrayList getAllAudit_All(DateTime dateFrom, DateTime dateTo)
        {
            SqlConnection conn = new SqlConnection();
            ArrayList toReturn = new ArrayList();
            try
            {
                conn = new SqlConnection();
                string connstr = ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString();
                conn.ConnectionString = connstr;
                conn.Open();
                SqlCommand comm = new SqlCommand();
                comm.Connection = conn;
                comm.CommandText = "select * from Audit where dateModified >= convert(datetime, @dateFrom, 103) and " +
                    "dateModified <= convert(datetime, @dateTo, 103)"; // all operations are lowercase 
                comm.Parameters.AddWithValue("@dateFrom", dateFrom);
                comm.Parameters.AddWithValue("@dateTo", dateTo);
                SqlDataReader dr = comm.ExecuteReader();
                while (dr.Read())
                {
                    Audit a = new Audit();
                    a.userID = ((string)dr["userID"]);
                    a.functionModified = ((string)dr["functionModified"]);
                    a.operation = ((string)dr["operation"]);
                    a.id_of_function = (string)dr["id_of_function"];
                    a.dateModified = ((DateTime)dr["dateModified"]);
                    a.remarks = ((string)dr["remarks"]);
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
        public int createAudit(Audit a) // Insert.
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
                comm.CommandText = "Insert into [Audit] (userID, functionModified, operation, id_of_function, dateModified, remarks) OUTPUT INSERTED.auditID VALUES (@userID, @functionModified, @operation, @id_of_function, @dateModified, @remarks)";
                comm.Parameters.AddWithValue("@userID", a.userID);
                comm.Parameters.AddWithValue("@functionModified", a.functionModified);
                comm.Parameters.AddWithValue("@operation", a.operation);
                if (a.id_of_function != null)
                {
                    comm.Parameters.AddWithValue("@id_of_function", a.id_of_function);
                }
                else
                {
                    comm.Parameters.AddWithValue("@id_of_function", DBNull.Value);
                }
                comm.Parameters.AddWithValue("@dateModified", a.dateModified);
                comm.Parameters.AddWithValue("@remarks", a.remarks);
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
        public ArrayList getAllAudit(string operation, string function, DateTime dateFrom, DateTime dateTo)
        {
            SqlConnection conn = new SqlConnection();
            ArrayList toReturn = new ArrayList();
            try
            {
                conn = new SqlConnection();
                string connstr = ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString();
                conn.ConnectionString = connstr;
                conn.Open();
                SqlCommand comm = new SqlCommand();
                comm.Connection = conn;
                comm.CommandText = "select * from Audit where operation = @operation and functionModified = @function and dateModified >= convert(datetime, @dateFrom, 103) and " +
                    "dateModified <= convert(datetime, @dateTo, 103)"; // all operations are lowercase 
                comm.Parameters.AddWithValue("@operation", operation);
                comm.Parameters.AddWithValue("@function", function);
                comm.Parameters.AddWithValue("@dateFrom", dateFrom);
                comm.Parameters.AddWithValue("@dateTo", dateTo);
                SqlDataReader dr = comm.ExecuteReader();
                while (dr.Read())
                {
                    Audit a = new Audit();
                    a.userID= ((string)dr["userID"]);
                    a.functionModified = ((string)dr["functionModified"]);
                    a.operation = ((string)dr["operation"]);
                    a.id_of_function = (string)dr["id_of_function"];
                    a.dateModified = ((DateTime)dr["dateModified"]);
                    a.remarks = ((string)dr["remarks"]);
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
    }
}