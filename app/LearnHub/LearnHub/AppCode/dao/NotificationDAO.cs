using LearnHub.AppCode.entity;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace LearnHub.AppCode.dao
{
    public class NotificationDAO
    {
        public void createNotification(Notification n) // Insert.
        {
            SqlConnection conn = null;
            try
            {
                conn = new SqlConnection();
                conn.ConnectionString = ConfigurationManager.ConnectionStrings["DBConnectionString"].ConnectionString;
                conn.Open();
                SqlCommand comm = new SqlCommand();
                comm.Connection = conn;
                comm.CommandText = "Insert into [Notifications] (userID_from, userID_to, tnfid, status) VALUES (@userID_from, @userID_to, @tnfid, @status)";
                comm.Parameters.AddWithValue("@userID_from", n.getUserIDFrom());
                comm.Parameters.AddWithValue("@userID_to", n.getUserIDTo());
                comm.Parameters.AddWithValue("@tnfid", n.getTNFID());
                comm.Parameters.AddWithValue("@status", n.getStatus());
                
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