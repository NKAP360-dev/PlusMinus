using Emma.Entity;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace Emma.DAO
{
    public class ChatBotInstructionDAO
    {
        public ChatBotInstruction getInstruction()
        {
            SqlConnection conn = new SqlConnection();
            ChatBotInstruction toReturn = new ChatBotInstruction();
            try
            {
                conn = new SqlConnection();
                string connstr = ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString();
                conn.ConnectionString = connstr;
                conn.Open();
                SqlCommand comm = new SqlCommand();
                comm.Connection = conn;
                comm.CommandText = "select * from [ChatBotInstruction]";
                SqlDataReader dr = comm.ExecuteReader();
                while (dr.Read())
                {
                    toReturn.title = (string)dr["title"];
                    toReturn.instruction = (string)dr["instruction"];
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
        public void updateChatBotInstruction(string title, string instruction) // Update.
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
                    "Update [ChatBotInstruction] SET title=@title, instruction=@instruction";
                comm.Parameters.AddWithValue("@title", title);
                comm.Parameters.AddWithValue("@instruction", instruction);
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