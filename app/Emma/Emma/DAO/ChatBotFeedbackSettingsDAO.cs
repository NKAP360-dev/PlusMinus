using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using LearnHub.AppCode.entity;
using System.Data.SqlClient;
using System.Configuration;

namespace LearnHub.AppCode.dao
{
    public class ChatBotFeedbackSettingsDAO
    {
        public ChatBotFeedbackSettings getCurrentSettings()
        {
            SqlConnection conn = new SqlConnection();
            ChatBotFeedbackSettings toReturn = new ChatBotFeedbackSettings();
            try
            {
                conn = new SqlConnection();
                string connstr = ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString();
                conn.ConnectionString = connstr;
                conn.Open();
                SqlCommand comm = new SqlCommand();
                comm.Connection = conn;
                comm.CommandText = "select * from [ChatBotFeedbackSettings]";
                SqlDataReader dr = comm.ExecuteReader();
                while (dr.Read())
                {
                    toReturn.enabled = (string)dr["enabled"];
                    toReturn.emailToSendTo = (string)dr["emailToSendTo"];
                    toReturn.smtpUsername = (string)dr["smtpUsername"];
                    toReturn.smtpPassword = (string)dr["smtpPassword"];
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
        public void updateSettings(string enabled, string emailToSendTo, string smtpUsername, string smtpPassword) // Update.
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
                comm.CommandText = "Update [ChatBotFeedbackSettings] SET enabled=@enabled, emailToSendTo=@emailToSendTo, smtpUsername=@smtpUsername, smtpPassword=@smtpPassword";
                comm.Parameters.AddWithValue("@enabled", enabled);
                comm.Parameters.AddWithValue("@emailToSendTo", emailToSendTo);
                comm.Parameters.AddWithValue("@smtpUsername", smtpUsername);
                comm.Parameters.AddWithValue("@smtpPassword", smtpPassword);
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
        
    }
}