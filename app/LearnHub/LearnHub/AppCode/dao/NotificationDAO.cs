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
        public void updateNotificationStatus(int notif_ID, string status) // Update.
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
                    "Update [Notifications] SET status=@status WHERE notif_ID=@notif_ID";
                comm.Parameters.AddWithValue("@status", status);
                comm.Parameters.AddWithValue("@notif_ID", notif_ID);
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
        public void updateNotificationApprovedDate(int notif_ID) // Update.
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
                    "Update [Notifications] SET dateApproved=@dateApproved WHERE notif_ID=@notif_ID";
                comm.Parameters.AddWithValue("@dateApproved", DateTime.Now);
                comm.Parameters.AddWithValue("@notif_ID", notif_ID);
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
            public Notification getNotificationByID(int notif_ID)
        {
            SqlConnection conn = new SqlConnection();
            Notification toReturn = null;
            try
            {
                conn = new SqlConnection();
                string connstr = ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString();
                conn.ConnectionString = connstr;
                conn.Open();
                SqlCommand comm = new SqlCommand();
                comm.Connection = conn;
                comm.CommandText = "select * from [Notifications] where notif_ID=@notif_ID";
                comm.Parameters.AddWithValue("@notif_ID", notif_ID);
                SqlDataReader dr = comm.ExecuteReader();
                while (dr.Read())
                {
                    toReturn = new Notification();
                    toReturn.setUserIDFrom((string)dr["userID_from"]);
                    toReturn.setUserIDTo((string)dr["userID_to"]);
                    toReturn.setTNFID((int)dr["tnfid"]);
                    toReturn.setStatus((string)dr["status"]);
                    toReturn.setNotificationID((int)dr["notif_ID"]);
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
        public Notification getPendingNotificationByTnfIDandUserID(int tnfid, string userID)
        {
            SqlConnection conn = new SqlConnection();
            Notification toReturn = null;
            try
            {
                conn = new SqlConnection();
                string connstr = ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString();
                conn.ConnectionString = connstr;
                conn.Open();
                SqlCommand comm = new SqlCommand();
                comm.Connection = conn;
                comm.CommandText = "select * from [Notifications] where tnfid=@tnfid and userID_To=@userID_To and status=@status";
                comm.Parameters.AddWithValue("@tnfid", tnfid);
                comm.Parameters.AddWithValue("@userID_To", userID);
                comm.Parameters.AddWithValue("@status", "pending");
                SqlDataReader dr = comm.ExecuteReader();
                while (dr.Read())
                {
                    toReturn = new Notification();
                    toReturn.setUserIDFrom((string)dr["userID_from"]);
                    toReturn.setUserIDTo((string)dr["userID_to"]);
                    toReturn.setTNFID((int)dr["tnfid"]);
                    toReturn.setStatus((string)dr["status"]);
                    toReturn.setNotificationID((int)dr["notif_ID"]);
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
        public void updateNotificationRemarks(int notif_ID, string remarks) // Update.
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
                    "Update [Notifications] SET remarks=@remarks WHERE notif_ID=@notif_ID";
                comm.Parameters.AddWithValue("@remarks", remarks);
                comm.Parameters.AddWithValue("@notif_ID", notif_ID);
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
        public List<Notification> getPendingNotificationByUserID(string userID)
        {
            SqlConnection conn = new SqlConnection();
            List<Notification> toReturn = new List<Notification>();
            try
            {
                conn = new SqlConnection();
                string connstr = ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString();
                conn.ConnectionString = connstr;
                conn.Open();
                SqlCommand comm = new SqlCommand();
                comm.Connection = conn;
                comm.CommandText = "select * from [Notifications] where userID_To=@userID_To and status=@status";
                comm.Parameters.AddWithValue("@userID_To", userID);
                comm.Parameters.AddWithValue("@status", "pending");
                SqlDataReader dr = comm.ExecuteReader();
                while (dr.Read())
                {
                    Notification n = new Notification();
                    n.setUserIDFrom((string)dr["userID_from"]);
                    n.setUserIDTo((string)dr["userID_to"]);
                    n.setTNFID((int)dr["tnfid"]);
                    n.setStatus((string)dr["status"]);
                    n.setNotificationID((int)dr["notif_ID"]);

                    toReturn.Add(n);
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

        public List<Notification> getApprovedNotificationByTnfID(int tnfID)
        {
            SqlConnection conn = new SqlConnection();
            List<Notification> toReturn = new List<Notification>();
            try
            {
                conn = new SqlConnection();
                string connstr = ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString();
                conn.ConnectionString = connstr;
                conn.Open();
                SqlCommand comm = new SqlCommand();
                comm.Connection = conn;
                comm.CommandText = "select * from [Notifications] where tnfID=@tnfID and status=@status";
                comm.Parameters.AddWithValue("@tnfID", tnfID);
                comm.Parameters.AddWithValue("@status", "approved");
                SqlDataReader dr = comm.ExecuteReader();
                while (dr.Read())
                {
                    Notification n = new Notification();
                    n.setUserIDFrom((string)dr["userID_from"]);
                    n.setUserIDTo((string)dr["userID_to"]);
                    n.setTNFID((int)dr["tnfid"]);
                    n.setStatus((string)dr["status"]);
                    n.setDateApproved((DateTime)dr["dateApproved"]);
                    if (!dr.IsDBNull(5))
                    {
                        n.setRemarks((string)dr["remarks"]);
                    }
                    n.setNotificationID((int)dr["notif_ID"]);

                    toReturn.Add(n);
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