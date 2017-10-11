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
    public class ChatBotAnswerDAO
    {
        public List<ChatBotAnswer> getChatBotAnswerByIntent(string intent)
        {
            SqlConnection conn = new SqlConnection();
            List<ChatBotAnswer> toReturn = new List<ChatBotAnswer>();
            try
            {
                conn = new SqlConnection();
                string connstr = ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString();
                conn.ConnectionString = connstr;
                conn.Open();
                SqlCommand comm = new SqlCommand();
                comm.Connection = conn;
                comm.CommandText = "select cba.answerID, cba.answer, cbi.intent, cba.entityName from [ChatBotAns] cba inner join [ChatBotIntent] cbi on cba.intentID = cbi.intentID where cbi.intent=@intent";
                comm.Parameters.AddWithValue("@intent", intent);
                SqlDataReader dr = comm.ExecuteReader();
                while (dr.Read())
                {
                    ChatBotAnswer cba = new ChatBotAnswer();
                    cba.answerID = (int)dr["answerID"];
                    cba.answer = (string)dr["answer"];
                    cba.intent = (string)dr["intent"];
                    if (!dr.IsDBNull(3))
                    {
                        cba.entityName = (string)dr["entityName"];
                    }

                    toReturn.Add(cba);
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

        public List<string> getChatBotHelpQuestions()
        {
            SqlConnection conn = new SqlConnection();
            List<string> toReturn = new List<string>();
            try
            {
                conn = new SqlConnection();
                string connstr = ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString();
                conn.ConnectionString = connstr;
                conn.Open();
                SqlCommand comm = new SqlCommand();
                comm.Connection = conn;
                comm.CommandText = "select question from [ChatBotHelpQuestion]";
                SqlDataReader dr = comm.ExecuteReader();
                while (dr.Read())
                {
                    toReturn.Add((string)dr["question"]);
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

        public List<string> getChatBotInitializationMessage()
        {
            SqlConnection conn = new SqlConnection();
            List<string> toReturn = new List<string>();
            try
            {
                conn = new SqlConnection();
                string connstr = ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString();
                conn.ConnectionString = connstr;
                conn.Open();
                SqlCommand comm = new SqlCommand();
                comm.Connection = conn;
                comm.CommandText = "select message from [ChatBotInitialization] order by levels asc";
                SqlDataReader dr = comm.ExecuteReader();
                while (dr.Read())
                {
                    toReturn.Add((string)dr["message"]);
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

        public Boolean insertFeedback(string name, string feedback) // Insert.
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
                comm.CommandText = "Insert into [ChatBotFeedback] (name, feedback) VALUES (@name, @feedback)";
                comm.Parameters.AddWithValue("@name", name);
                comm.Parameters.AddWithValue("@feedback", feedback);
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

        public List<ChatBotAnswer> getAllChatBotAnswers()
        {
            SqlConnection conn = new SqlConnection();
            List<ChatBotAnswer> toReturn = new List<ChatBotAnswer>();
            try
            {
                conn = new SqlConnection();
                string connstr = ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString();
                conn.ConnectionString = connstr;
                conn.Open();
                SqlCommand comm = new SqlCommand();
                comm.Connection = conn;
                comm.CommandText = "select cba.answerID, cba.answer, cbi.intent, cba.entityName from [ChatBotAns] cba inner join [ChatBotIntent] cbi on cba.intentID = cbi.intentID";
                SqlDataReader dr = comm.ExecuteReader();
                while (dr.Read())
                {
                    ChatBotAnswer cba = new ChatBotAnswer();
                    cba.answerID = (int)dr["answerID"];
                    cba.answer = (string)dr["answer"];
                    cba.intent = (string)dr["intent"];
                    if (!dr.IsDBNull(3))
                    {
                        cba.entityName = (string)dr["entityName"];
                    }

                    toReturn.Add(cba);
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

        public int insertAnswer(ChatBotAnswer cbAnswer) // Insert.
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
                comm.CommandText = "Insert into [ChatBotAns] (answer, intentID, entityName) OUTPUT INSERTED.answerID VALUES (@answer, @intentID, @entityName)";
                comm.Parameters.AddWithValue("@answer", cbAnswer.answer);
                comm.Parameters.AddWithValue("@intentID", cbAnswer.intent);
                if (cbAnswer.entityName != null)
                {
                    comm.Parameters.AddWithValue("@entityName", cbAnswer.entityName);
                }
                else
                {
                    comm.Parameters.AddWithValue("@entityName", DBNull.Value);
                }
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
        public ChatBotAnswer getChatBotAnswerByID(int answerID)
        {
            SqlConnection conn = new SqlConnection();
            ChatBotAnswer toReturn = new ChatBotAnswer();
            try
            {
                conn = new SqlConnection();
                string connstr = ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString();
                conn.ConnectionString = connstr;
                conn.Open();
                SqlCommand comm = new SqlCommand();
                comm.Connection = conn;
                comm.CommandText = "select cba.answerID, cba.answer, cbi.intent, cba.entityName from [ChatBotAns] cba inner join [ChatBotIntent] cbi on cba.intentID = cbi.intentID where cba.answerID=@answerID";
                comm.Parameters.AddWithValue("@answerID", answerID);
                SqlDataReader dr = comm.ExecuteReader();
                while (dr.Read())
                {
                    toReturn.answerID = (int)dr["answerID"];
                    toReturn.answer = (string)dr["answer"];
                    if (!dr.IsDBNull(3))
                    {
                        toReturn.entityName = (string)dr["entityName"];
                    }
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

        public void updateChatBotAnswer(string answer, string entity, string intent, int answerID) // Update.
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
                    "Update [ChatBotAns] SET answer=@answer, entityName=@entity, intentID=@intent WHERE answerID=@answerID";
                comm.Parameters.AddWithValue("@answer", answer);
                if (entity != null)
                {
                    comm.Parameters.AddWithValue("@entity", entity);
                }
                else
                {
                    comm.Parameters.AddWithValue("@entity", DBNull.Value);
                }
                comm.Parameters.AddWithValue("@intent", intent);
                comm.Parameters.AddWithValue("@answerID", answerID);
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
        public string getIntentNameByID(int intentID)
        {
            SqlConnection conn = new SqlConnection();
            string toReturn = "";
            try
            {
                conn = new SqlConnection();
                string connstr = ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString();
                conn.ConnectionString = connstr;
                conn.Open();
                SqlCommand comm = new SqlCommand();
                comm.Connection = conn;
                comm.CommandText = "select intent from [ChatBotIntent] where intentID=@intentID";
                comm.Parameters.AddWithValue("@intentID", intentID);
                SqlDataReader dr = comm.ExecuteReader();
                while (dr.Read())
                {
                    toReturn = (string)dr["intent"];
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
        public void deleteAnswerByID(int answerID)
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
                comm.CommandText = "DELETE FROM [ChatBotAns] WHERE answerID=@answerID";
                comm.Parameters.AddWithValue("@answerID", answerID);
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