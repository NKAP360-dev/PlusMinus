using LearnHub.AppCode.entity;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace LearnHub.AppCode.dao
{
    public class AuditDAO
    {
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
                comm.Parameters.AddWithValue("@id_of_function", a.id_of_function);
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
    }
}