using LearnHub.AppCode.entity;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace LearnHub.AppCode.dao
{
    public class BondDAO
    {
        public Bonds getBondByID(int bondID)
        {
            SqlConnection conn = new SqlConnection();
            Bonds toReturn = null;
            try
            {
                conn = new SqlConnection();
                string connstr = ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString();
                conn.ConnectionString = connstr;
                conn.Open();
                SqlCommand comm = new SqlCommand();
                comm.Connection = conn;
                comm.CommandText = "select * from [Bonds] where bondID=@bondID";
                comm.Parameters.AddWithValue("@bondID", bondID);
                SqlDataReader dr = comm.ExecuteReader();
                while (dr.Read())
                {
                    toReturn = new Bonds();
                    toReturn.setUserID((string)dr["uid"]);
                    toReturn.setBondID((int)dr["bondID"]);
                    toReturn.setTNFID((int)(dr["tnfid"]));
                    if (!dr.IsDBNull(3))
                    {
                        toReturn.setStartDate((DateTime)dr["startDate"]);
                    }
                    if (!dr.IsDBNull(4))
                    {
                        toReturn.setEndDate((DateTime)dr["endDate"]);
                    }
                    toReturn.setStatus((string)dr["status"]);

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
        public Bonds getBondByTNFIDandUserID(int tnfid, string userID)
        {
            SqlConnection conn = new SqlConnection();
            Bonds toReturn = null;
            try
            {
                conn = new SqlConnection();
                string connstr = ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString();
                conn.ConnectionString = connstr;
                conn.Open();
                SqlCommand comm = new SqlCommand();
                comm.Connection = conn;
                comm.CommandText = "select * from [Bonds] where uid=@uid and tnfid=@tnfid";
                comm.Parameters.AddWithValue("@uid", userID);
                comm.Parameters.AddWithValue("@tnfid", tnfid);
                SqlDataReader dr = comm.ExecuteReader();
                while (dr.Read())
                {
                    toReturn = new Bonds();
                    toReturn.setUserID((string)dr["uid"]);
                    toReturn.setBondID((int)dr["bondID"]);
                    toReturn.setTNFID((int)(dr["tnfid"]));
                    if (!dr.IsDBNull(3))
                    {
                        toReturn.setStartDate((DateTime)dr["startDate"]);
                    }
                    if (!dr.IsDBNull(4))
                    {
                        toReturn.setEndDate((DateTime)dr["endDate"]);
                    }
                    toReturn.setStatus((string)dr["status"]);

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
        public void updateBondStartDate(int bondID, DateTime startDate) // Update.
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
                    "Update [Bonds] SET startDate=@startDate WHERE bondID=@bondID";
                comm.Parameters.AddWithValue("@startDate", startDate);
                comm.Parameters.AddWithValue("@bondID", bondID);
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
        public void updateBondEndDate(int bondID, DateTime endDate) // Update.
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
                    "Update [Bonds] SET endDate=@endDate WHERE bondID=@bondID";
                comm.Parameters.AddWithValue("@endDate", endDate);
                comm.Parameters.AddWithValue("@bondID", bondID);
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
        public void updateBondStatus(int bondID, string status) // Update.
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
                    "Update [Bonds] SET status=@status WHERE bondID=@bondID";
                comm.Parameters.AddWithValue("@status", status);
                comm.Parameters.AddWithValue("@bondID", bondID);
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
        public int createBond(Bonds b) // Insert.
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
                comm.CommandText = "Insert into [Bonds] (uid, tnfid, status) OUTPUT INSERTED.bondID VALUES (@uid, @tnfid, @status)";
                comm.Parameters.AddWithValue("@uid", b.getUserID());
                comm.Parameters.AddWithValue("@tnfid", b.getTNFID());
                comm.Parameters.AddWithValue("@status", b.getStatus());
                //comm.CommandText = "select @@IDENTITY as newBondID";
                //SqlDataReader dr = comm.ExecuteReader();
                toReturn = (Int32)comm.ExecuteScalar();
                //dr.Read();
                //newBondID = int.Parse(dr["newBondID"].ToString());
                //dr.Close();
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