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
        /*public static void createNotification(Resume r) // Insert.
        {
            SqlConnection conn = null;
            int newResumeID = 0;

            try
            {
                conn = new SqlConnection();
                conn.ConnectionString = ConfigurationManager.ConnectionStrings["DBConnectionString"].ConnectionString;
                conn.Open();
                SqlCommand comm = new SqlCommand();
                comm.Connection = conn;
                comm.CommandText = "Insert into Resume (DateOfCreation, LastUpdated, AdditionalInfo, JobSeekerID) VALUES (@DateOfCreation, @LastUpdated, @AdditionalInfo, @JobSeekerID)";
                comm.Parameters.AddWithValue("@DateOfCreation", r.DateOfCreation);
                comm.Parameters.AddWithValue("@LastUpdated", r.LastUpdated);
                comm.Parameters.AddWithValue("@AdditionalInfo", r.AdditionalInfo);
                comm.Parameters.AddWithValue("@JobSeekerID", r.JobSeekerID);
                int rowsAffected = comm.ExecuteNonQuery();
                comm.CommandText = "select @@IDENTITY as newResumeID";
                SqlDataReader dr = comm.ExecuteReader();
                dr.Read();
                newResumeID = int.Parse(dr["NewResumeID"].ToString());
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
            return newResumeID;
        }*/
    }
}