using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Emma.Entity;
using System.Data.SqlClient;
using System.Configuration;

namespace Emma.DAO
{
    public class ChatBotFeedbackDAO
    {
        public List<ChatBotFeedback> getAllChatBotFeedback()
        {
            SqlConnection conn = new SqlConnection();
            List<ChatBotFeedback> toReturn = new List<ChatBotFeedback>();
            try
            {
                conn = new SqlConnection();
                string connstr = ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString();
                conn.ConnectionString = connstr;
                conn.Open();
                SqlCommand comm = new SqlCommand();
                comm.Connection = conn;
                comm.CommandText = "select * from [ChatBotFeedback]";
                SqlDataReader dr = comm.ExecuteReader();
                while (dr.Read())
                {
                    ChatBotFeedback cbf = new ChatBotFeedback();
                    cbf.feedbackID = (int)dr["feedbackID"];
                    cbf.name = (string)dr["name"];
                    cbf.department = (string)dr["department"];
                    cbf.feedback = (string)dr["feedback"];
                    cbf.feedbackDate = (DateTime)dr["feedbackDate"];

                    toReturn.Add(cbf);
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