using LearnHub.AppCode.entity;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace LearnHub.AppCode.dao
{
    public class SupervisorFeedbackDAO
    {
        public int createFeedback(SupervisorFeedback sf) // Insert.
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
                comm.CommandText = "insert into [SupervisorFeedback] "
                                    + "(title, feedback, userTo, userFrom, dateSubmitted)"
                                    + "values(@title, @feedback, @userTo, @userFrom, @dateSubmitted)";
                comm.Parameters.AddWithValue("@title", sf.title);
                comm.Parameters.AddWithValue("@feedback", sf.feedback);
                comm.Parameters.AddWithValue("@userTo", sf.userTo.getUserID());
                comm.Parameters.AddWithValue("@userFrom", sf.userFrom.getUserID());
                comm.Parameters.AddWithValue("@dateSubmitted", sf.dateSubmitted);
                toReturn = comm.ExecuteNonQuery();
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
        public List<SupervisorFeedback> getAllUserFeedback(string userID)
        {
            SqlConnection conn = new SqlConnection();
            List<SupervisorFeedback> toReturn = new List<SupervisorFeedback>();
            UserDAO userDAO = new UserDAO();
            try
            {
                conn = new SqlConnection();
                string connstr = ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString();
                conn.ConnectionString = connstr;
                conn.Open();
                SqlCommand comm = new SqlCommand();
                comm.Connection = conn;
                comm.CommandText = "select * from [SupervisorFeedback] where userTo=@userTo order by dateSubmitted desc";
                comm.Parameters.AddWithValue("@userTo", userID);
                SqlDataReader dr = comm.ExecuteReader();
                while (dr.Read())
                {
                    SupervisorFeedback sf = new SupervisorFeedback();
                    sf.feedbackID = (int)dr["feedbackID"];
                    sf.title = (string)dr["title"];
                    sf.feedback = (string)dr["feedback"];
                    sf.userTo = userDAO.getUserByID((string)dr["userTo"]);
                    sf.userFrom = userDAO.getUserByID((string)dr["userFrom"]);
                    sf.dateSubmitted = (DateTime)dr["dateSubmitted"];

                    toReturn.Add(sf);
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
        public void deleteFeedbackByID(int feedbackID)
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
                comm.CommandText = "DELETE FROM [SupervisorFeedback] WHERE feedbackID=@feedbackID";
                comm.Parameters.AddWithValue("@feedbackID", feedbackID);
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