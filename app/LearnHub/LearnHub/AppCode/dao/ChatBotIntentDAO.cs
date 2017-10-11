using Emma.Entity;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace Emma.DAO
{
    [Serializable]
    public class ChatBotIntentDAO
    {
        public List<ChatBotIntent> getAllChatBotIntent()
        {
            SqlConnection conn = new SqlConnection();
            List<ChatBotIntent> toReturn = new List<ChatBotIntent>();
            try
            {
                conn = new SqlConnection();
                string connstr = ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString();
                conn.ConnectionString = connstr;
                conn.Open();
                SqlCommand comm = new SqlCommand();
                comm.Connection = conn;
                comm.CommandText = "select * from [ChatBotIntent]";
                SqlDataReader dr = comm.ExecuteReader();
                while (dr.Read())
                {
                    ChatBotIntent cbi = new ChatBotIntent();
                    cbi.intentID = (int)dr["intentID"];
                    cbi.intent = (string)dr["intent"];

                    toReturn.Add(cbi);
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
        public int addIntent(string intent) // Insert.
        {
            SqlConnection conn = null;
            int toReturn = -1;
            try
            {
                conn = new SqlConnection();
                conn.ConnectionString = ConfigurationManager.ConnectionStrings["DBConnectionString"].ConnectionString;
                conn.Open();
                SqlCommand comm = new SqlCommand();
                comm.Connection = conn;
                comm.CommandText = "Insert into [ChatBotIntent] (intent) OUTPUT INSERTED.intentID VALUES (@intent)";
                comm.Parameters.AddWithValue("@intent", intent);
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
        public ChatBotIntent getChatBotIntentByID(int intentID)
        {
            SqlConnection conn = new SqlConnection();
            ChatBotIntent toReturn = new ChatBotIntent();
            try
            {
                conn = new SqlConnection();
                string connstr = ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString();
                conn.ConnectionString = connstr;
                conn.Open();
                SqlCommand comm = new SqlCommand();
                comm.Connection = conn;
                comm.CommandText = "select * from [ChatBotIntent] where intentID=@intentID";
                comm.Parameters.AddWithValue("@intentID", intentID);
                SqlDataReader dr = comm.ExecuteReader();
                while (dr.Read())
                {
                    toReturn.intentID = (int)dr["intentID"];
                    toReturn.intent = (string)dr["intent"];
                    
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
        public void updateChatBotIntent(string intent, int intentID) // Update.
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
                    "Update [ChatBotIntent] SET intent=@intent WHERE intentID=@intentID";
                comm.Parameters.AddWithValue("@intent", intent);
                comm.Parameters.AddWithValue("@intentID", intentID);
                
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
        public void deleteAnswersByIntent(int intentID)
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
                comm.CommandText = "DELETE FROM [ChatBotAns] WHERE intentID=@intentID";
                comm.Parameters.AddWithValue("@intentID", intentID);
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
        public void deleteIntentByID(int intentID)
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
                comm.CommandText = "DELETE FROM [ChatBotIntent] WHERE intentID=@intentID";
                comm.Parameters.AddWithValue("@intentID", intentID);
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