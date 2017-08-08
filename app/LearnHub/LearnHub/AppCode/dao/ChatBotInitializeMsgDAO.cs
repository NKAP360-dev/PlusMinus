using Emma.Entity;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace Emma.DAO
{
    public class ChatBotInitializeMsgDAO
    {
        public ChatBotInitializeMsg getChatBotInitializeMsgByID(int messageID)
        {
            SqlConnection conn = new SqlConnection();
            ChatBotInitializeMsg toReturn = new ChatBotInitializeMsg();
            try
            {
                conn = new SqlConnection();
                string connstr = ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString();
                conn.ConnectionString = connstr;
                conn.Open();
                SqlCommand comm = new SqlCommand();
                comm.Connection = conn;
                comm.CommandText = "select * from [ChatBotInitialization] where messageID=@messageID";
                comm.Parameters.AddWithValue("@messageID", messageID);
                SqlDataReader dr = comm.ExecuteReader();
                while (dr.Read())
                {
                    toReturn.messageID = (int)dr["messageID"];
                    toReturn.message = (string)dr["message"];
                    toReturn.levels = (int)dr["levels"];
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
        public void updateInitializationLevel(int messageID, int levels) // Update.
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
                    "Update [ChatBotInitialization] SET levels=@levels WHERE messageID=@messageID";
                comm.Parameters.AddWithValue("@messageID", messageID);
                comm.Parameters.AddWithValue("@levels", levels);
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
        public void updateInitializationMessage(int messageID, string message) // Update.
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
                    "Update [ChatBotInitialization] SET message=@message WHERE messageID=@messageID";
                comm.Parameters.AddWithValue("@messageID", messageID);
                comm.Parameters.AddWithValue("@message", message);
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
        public Boolean insertMessage(string message) // Insert.
        {
            SqlConnection conn = null;
            Boolean success = false;
            try
            {
                conn = new SqlConnection();
                conn.ConnectionString = ConfigurationManager.ConnectionStrings["DBConnectionString"].ConnectionString;
                conn.Open();
                SqlCommand comm = new SqlCommand();
                comm.Connection = conn;
                comm.CommandText = "Insert into [ChatBotInitialization] (message, levels) VALUES (@message, @levels)";
                comm.Parameters.AddWithValue("@message", message);
                comm.Parameters.AddWithValue("@levels", getNextOrderNumber() + 1);
                comm.ExecuteNonQuery();
                success = true;
            }
            catch (SqlException ex)
            {
                throw ex;
            }
            finally
            {
                conn.Close();
            }
            return success;
        }
        public int getNextOrderNumber()
        {
            SqlConnection conn = new SqlConnection();
            int toReturn = -1;
            try
            {
                conn = new SqlConnection();
                string connstr = ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString();
                conn.ConnectionString = connstr;
                conn.Open();
                SqlCommand comm = new SqlCommand();
                comm.Connection = conn;
                comm.CommandText = "select max(levels) as preference from [ChatBotInitialization]";
                SqlDataReader dr = comm.ExecuteReader();
                while (dr.Read())
                {
                    toReturn = (int)dr["preference"];
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
        public void deleteMessageByID(int messageID)
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
                comm.CommandText = "DELETE FROM [ChatBotInitialization] WHERE messageID=@messageID";
                comm.Parameters.AddWithValue("@messageID", messageID);
                comm.ExecuteNonQuery();
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