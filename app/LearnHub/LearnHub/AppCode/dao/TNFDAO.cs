using LearnHub.AppCode.entity;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace LearnHub.AppCode.dao
{
    public class TNFDAO
    {
        public TNF getIndividualTNFByID(string userID, int tnfID)
        {
            SqlConnection conn = new SqlConnection();
            TNF toReturn = null;
            try
            {
                conn = new SqlConnection();
                string connstr = ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString();
                conn.ConnectionString = connstr;
                conn.Open();
                SqlCommand comm = new SqlCommand();
                comm.Connection = conn;
                comm.CommandText = "select * from [TNF] where tnfid=@tnfid and userID=@userID and type=@type";
                comm.Parameters.AddWithValue("@tnfid", tnfID);
                comm.Parameters.AddWithValue("@userID", userID);
                comm.Parameters.AddWithValue("@type", "individual");
                SqlDataReader dr = comm.ExecuteReader();
                while (dr.Read())
                {
                    toReturn = new TNF();
                    UserDAO userDAO = new UserDAO();
                    WorkflowDAO wfDAO = new WorkflowDAO();
                    WorkflowSubDAO wfsDAO = new WorkflowSubDAO();
                    User user = userDAO.getUserByID((string)dr["userID"]);
                    toReturn.setUser(user);
                    toReturn.setTNFID((int)dr["tnfid"]);
                    toReturn.setType((string)dr["type"]);
                    toReturn.setStatus((string)(dr["status"]));
                    toReturn.setWFStatus((int)dr["wf_status"]);
                    toReturn.setWorkflow(wfDAO.getWorkflowByID((int)dr["wfid"]));
                    if (!dr.IsDBNull(6))
                    {
                        toReturn.setWorkflowSub(wfsDAO.getWorkflowSubByID((int)dr["wf_sub_id"]));
                    }
                    toReturn.setApplicationDate(dr.GetDateTime(7));
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
        public void updateTNFStatus(int tnfid, string status) // Update.
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
                    "Update [TNF] SET status=@status WHERE tnfid=@tnfid";
                comm.Parameters.AddWithValue("@status", status);
                comm.Parameters.AddWithValue("@tnfid", tnfid);
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
        public Course getCourseFromTNF(int tnfID)
        {
            SqlConnection conn = new SqlConnection();
            Course toReturn = null;
            try
            {
                conn = new SqlConnection();
                string connstr = ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString();
                conn.ConnectionString = connstr;
                conn.Open();
                SqlCommand comm = new SqlCommand();
                comm.Connection = conn;
                comm.CommandText = "select c.courseID, c.courseName, c.price, c.internalOrExternal, c.courseProvider, c.startDate, c.endDate, c.status, c.overseas from [Course] c inner join [TNF_data] td on c.courseID = td.courseID inner join [TNF] t on td.tnfid = t.tnfid where t.tnfid=@tnfid";
                comm.Parameters.AddWithValue("@tnfid", tnfID);
                SqlDataReader dr = comm.ExecuteReader();
                while (dr.Read())
                {
                    toReturn = new Course();
                    toReturn.setCourseID((int)dr["courseID"]);
                    toReturn.setCourseName((string)dr["courseName"]);
                    toReturn.setPrice((double)(dr["price"]));
                    toReturn.setInternalOrExternal((string)dr["internalOrExternal"]);
                    if (!dr.IsDBNull(4))
                    {
                        toReturn.setCourseProvider((string)dr["courseProvider"]);
                    }
                    toReturn.setStartDate(dr.GetDateTime(5));
                    toReturn.setEndDate(dr.GetDateTime(6));
                    toReturn.setStatus((string)dr["status"]);
                    toReturn.setOverseas((string)dr["overseas"]);
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
        public void updateTNFWFStatus(int tnfid, int wf_status) // Update.
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
                    "Update [TNF] SET wf_status=@wf_status WHERE tnfid=@tnfid";
                comm.Parameters.AddWithValue("@wf_status", wf_status);
                comm.Parameters.AddWithValue("@tnfid", tnfid);
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
        public int getWFStatus(int tnfID)
        {
            SqlConnection conn = new SqlConnection();
            int toReturn = 0;
            try
            {
                conn = new SqlConnection();
                string connstr = ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString();
                conn.ConnectionString = connstr;
                conn.Open();
                SqlCommand comm = new SqlCommand();
                comm.Connection = conn;
                comm.CommandText = "select wf_status from [TNF] where tnfid=@tnfid";
                comm.Parameters.AddWithValue("@tnfid", tnfID);
                SqlDataReader dr = comm.ExecuteReader();
                while (dr.Read())
                {
                    toReturn = (int)dr["wf_status"];
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
        public void updateTNFWFSub(int tnfid, int wfsID) // Update.
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
                    "Update [TNF] SET wf_sub_id=@wf_sub_id WHERE tnfid=@tnfid";
                comm.Parameters.AddWithValue("@wf_sub_id", wfsID);
                comm.Parameters.AddWithValue("@tnfid", tnfid);
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
        public void updateTNFDataHRFields(int tnfid, string isProbation, double totalTrainingCost, string isFunding, string sourceOfFunding, DateTime? fundingApplicationDate, string isMSP, string mspMonths) // Update.
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
                    "Update [TNF_data] SET isProbation=@isProbation, totalTrainingCost=@totalTrainingCost, isFunding=@isFunding, sourceOfFunding=@sourceOfFunding, funding_application_date=@fundingApplicationDate WHERE tnfid=@tnfid";
                comm.Parameters.AddWithValue("@isProbation",isProbation);
                comm.Parameters.AddWithValue("@totalTrainingCost", totalTrainingCost);
                comm.Parameters.AddWithValue("@isFunding", isFunding);
                if (!string.IsNullOrEmpty(sourceOfFunding))
                {
                    comm.Parameters.AddWithValue("@sourceOfFunding", sourceOfFunding);
                } else
                {
                    comm.Parameters.AddWithValue("@sourceOfFunding", DBNull.Value);
                }
                if (fundingApplicationDate != null)
                {
                    comm.Parameters.AddWithValue("@fundingApplicationDate", fundingApplicationDate);
                } else
                {
                    comm.Parameters.AddWithValue("@fundingApplicationDate", DBNull.Value);
                }
                comm.Parameters.AddWithValue("@isMSP", isMSP);
                if (!string.IsNullOrEmpty(mspMonths))
                {
                    int duration = Convert.ToInt32(mspMonths);
                    comm.Parameters.AddWithValue("@mspMonths", duration);
                }
                else
                {
                    comm.Parameters.AddWithValue("@mspMonths", DBNull.Value);
                }
                comm.Parameters.AddWithValue("@tnfid", tnfid);
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
        public int createTNF(TNF tnf) // Insert.
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
                comm.CommandText = "Insert into [TNF] (userID, status, wf_status, wfid, type, applicationDate) OUTPUT INSERTED.tnfid VALUES (@userID, @status, @wf_status, @wfid, @type, @applicationDate)";
                comm.Parameters.AddWithValue("@userID", tnf.getUser().getUserID());
                comm.Parameters.AddWithValue("@status", tnf.getStatus());
                comm.Parameters.AddWithValue("@wf_status", 0);
                comm.Parameters.AddWithValue("@wfid", tnf.getWorkflow().getWorkflowID());
                comm.Parameters.AddWithValue("@type", tnf.getType());
                comm.Parameters.AddWithValue("applicationDate", tnf.getApplicationDate());
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
        public void createTNF_Data(int tnfid, int courseID, string prepareForNewJobRole, string prepareForNewJobRoleText, 
            DateTime? prepareForNewJobRoleCompletionDate, string shareKnowledge, string shareKnowledgeText, DateTime? shareKnowledgeCompletionDate, 
            string otherObjectives, string otherObjectivesText, DateTime? otherObjectivesCompletionDate, int lessonID) // Insert.
        {
            SqlConnection conn = null;
            try
            {
                conn = new SqlConnection();
                conn.ConnectionString = ConfigurationManager.ConnectionStrings["DBConnectionString"].ConnectionString;
                conn.Open();
                SqlCommand comm = new SqlCommand();
                comm.Connection = conn;
                comm.CommandText = "Insert into [TNF_data] (tnfid, courseID, prepareForNewJobRole, prepareForNewJobRoleText, " +
                    "prepareForNewJobRoleCompletionDate, shareKnowledge, shareKnowledgeText, shareKnowledgeCompletionDate, otherObjectives, " +
                    "otherObjectivesText, otherObjectivesCompletionDate, lessonID) VALUES (@tnfid, @courseID, @prepareForNewJobRole, @prepareForNewJobRoleText, " +
                    "@prepareForNewJobRoleCompletionDate, @shareKnowledge, @shareKnowledgeText, @shareKnowledgeCompletionDate, @otherObjectives, " +
                    "@otherObjectivesText, @otherObjectivesCompletionDate, @lessonID)";
                comm.Parameters.AddWithValue("@tnfid", tnfid);
                comm.Parameters.AddWithValue("@courseID", courseID);
                comm.Parameters.AddWithValue("@lessonID", lessonID);
                comm.Parameters.AddWithValue("@prepareForNewJobRole", prepareForNewJobRole);
                if (!string.IsNullOrEmpty(prepareForNewJobRoleText))
                {
                    comm.Parameters.AddWithValue("@prepareForNewJobRoleText", prepareForNewJobRoleText);
                }
                else
                {
                    comm.Parameters.AddWithValue("@prepareForNewJobRoleText", DBNull.Value);
                }
                if (prepareForNewJobRoleCompletionDate != null)
                {
                    comm.Parameters.AddWithValue("@prepareForNewJobRoleCompletionDate", prepareForNewJobRoleCompletionDate);
                }
                else
                {
                    comm.Parameters.AddWithValue("prepareForNewJobRoleCompletionDate", DBNull.Value);
                }
                comm.Parameters.AddWithValue("@shareKnowledge", shareKnowledge);
                if (!string.IsNullOrEmpty(shareKnowledgeText))
                {
                    comm.Parameters.AddWithValue("@shareKnowledgeText", shareKnowledgeText);
                }
                else
                {
                    comm.Parameters.AddWithValue("@shareKnowledgeText", DBNull.Value);
                }
                if (shareKnowledgeCompletionDate != null)
                {
                    comm.Parameters.AddWithValue("@shareKnowledgeCompletionDate", shareKnowledgeCompletionDate);
                }
                else
                {
                    comm.Parameters.AddWithValue("@shareKnowledgeCompletionDate", DBNull.Value);
                }
                comm.Parameters.AddWithValue("@otherObjectives", otherObjectives);
                if (!string.IsNullOrEmpty(otherObjectivesText))
                {
                    comm.Parameters.AddWithValue("@otherObjectivesText", otherObjectivesText);
                }
                else
                {
                    comm.Parameters.AddWithValue("@otherObjectivesText", DBNull.Value);
                }
                if (otherObjectivesCompletionDate != null)
                {
                    comm.Parameters.AddWithValue("@otherObjectivesCompletionDate", otherObjectivesCompletionDate);
                } 
                else
                {
                    comm.Parameters.AddWithValue("@otherObjectivesCompletionDate", DBNull.Value);
                }
                /*comm.Parameters.AddWithValue("@sourceOfFunding", sourceOfFunding);
                comm.Parameters.AddWithValue("@isProbation", isProbation);
                comm.Parameters.AddWithValue("@isFunding", isFunding);
                comm.Parameters.AddWithValue("@fundingApplicationDate", fundingApplicationDate);
                comm.Parameters.AddWithValue("@cost_centre", cost_centre);*/
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
        public List<TNF> getAllTNFByUserID(string userID)
        {
            SqlConnection conn = new SqlConnection();
            List<TNF> toReturn = new List<TNF>();
            try
            {
                conn = new SqlConnection();
                string connstr = ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString();
                conn.ConnectionString = connstr;
                conn.Open();
                SqlCommand comm = new SqlCommand();
                comm.Connection = conn;
                comm.CommandText = "select * from [TNF] where userID=@userID";
                comm.Parameters.AddWithValue("@userID", userID);
                SqlDataReader dr = comm.ExecuteReader();
                while (dr.Read())
                {
                    TNF t = new TNF();
                    UserDAO userDAO = new UserDAO();
                    WorkflowDAO wfDAO = new WorkflowDAO();
                    WorkflowSubDAO wfsDAO = new WorkflowSubDAO();
                    User user = userDAO.getUserByID((string)dr["userID"]);
                    t.setUser(user);
                    t.setTNFID((int)dr["tnfid"]);
                    t.setType((string)dr["type"]);
                    t.setStatus((string)(dr["status"]));
                    t.setWFStatus((int)dr["wf_status"]);
                    t.setWorkflow(wfDAO.getWorkflowByID((int)dr["wfid"]));
                    if (!dr.IsDBNull(6))
                    {
                        t.setWorkflowSub(wfsDAO.getWorkflowSubByID((int)dr["wf_sub_id"]));
                    }
                    t.setApplicationDate(dr.GetDateTime(7));

                    toReturn.Add(t);
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
        public Lesson getLessonFromTNF(int tnfID)
        {
            SqlConnection conn = new SqlConnection();
            Lesson toReturn = null;
            try
            {
                conn = new SqlConnection();
                string connstr = ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString();
                conn.ConnectionString = connstr;
                conn.Open();
                SqlCommand comm = new SqlCommand();
                comm.Connection = conn;
                comm.CommandText = "select l.lessonID, l.courseID, l.lesson_start_timing, l.lesson_end_timing, l.lesson_start_date, l.lesson_end_date, l.instructor, l.venue from [Lesson] l inner join [TNF_data] td on l.lessonID = td.lessonID inner join [TNF] t on td.tnfid = t.tnfid where t.tnfid=@tnfid";
                comm.Parameters.AddWithValue("@tnfid", tnfID);
                SqlDataReader dr = comm.ExecuteReader();
                while (dr.Read())
                {
                    toReturn = new Lesson();
                    toReturn.setLessonID((int)dr["lessonID"]);
                    toReturn.setCourseID((int)dr["courseID"]);
                    toReturn.setStartTime((TimeSpan)dr["lesson_start_timing"]);
                    toReturn.setEndTime((TimeSpan)dr["lesson_end_timing"]);
                    toReturn.setStartDate(dr.GetDateTime(4));
                    toReturn.setEndDate(dr.GetDateTime(5));
                    toReturn.setInstructor((string)dr["instructor"]);
                    toReturn.setVenue((string)dr["venue"]);
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
        public TNFData getIndividualTNFDataByID(int tnfID)
        {
            SqlConnection conn = new SqlConnection();
            TNFData toReturn = null;
            try
            {
                conn = new SqlConnection();
                string connstr = ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString();
                conn.ConnectionString = connstr;
                conn.Open();
                SqlCommand comm = new SqlCommand();
                comm.Connection = conn;
                comm.CommandText = "select * from [TNF_data] where tnfid=@tnfid";
                comm.Parameters.AddWithValue("@tnfid", tnfID);
                SqlDataReader dr = comm.ExecuteReader();
                while (dr.Read())
                {
                    toReturn = new TNFData();
                    
                    toReturn.setTNFID((int)dr["tnfid"]);

                    string prepareForNewJobRole = (string)dr["prepareForNewJobRole"];
                    toReturn.setPrepareForNewJobRole(prepareForNewJobRole);
                    if (prepareForNewJobRole.Equals("y"))
                    {
                        toReturn.setPrepareForNewJobRoleText((string)dr["prepareForNewJobRoleText"]);
                        toReturn.setPrepareForNewJobRoleCompletionDate(dr.GetDateTime(4));
                    }

                    string shareKnowledge = (string)dr["shareKnowledge"];
                    toReturn.setShareKnowledge(shareKnowledge);
                    if (shareKnowledge.Equals("y"))
                    {
                        toReturn.setShareKnowledgeText((string)dr["shareKnowledgeText"]);
                        toReturn.setShareKnowledgeCompletionDate(dr.GetDateTime(7));
                    }

                    string otherObjectives = (string)dr["otherObjectives"];
                    toReturn.setOtherObjectives(otherObjectives);
                    if (otherObjectives.Equals("y"))
                    {
                        toReturn.setOtherObjectivesText((string)dr["otherObjectivesText"]);
                        toReturn.setOtherObjectivesCompletionDate(dr.GetDateTime(10));
                    }
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
        public Boolean checkIsCourseAppliedOverseas(int tnfID)
        {
            SqlConnection conn = new SqlConnection();
            string overseas = "";
            Boolean toReturn = false;
            try
            {
                conn = new SqlConnection();
                string connstr = ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString();
                conn.ConnectionString = connstr;
                conn.Open();
                SqlCommand comm = new SqlCommand();
                comm.Connection = conn;
                comm.CommandText = "select c.overseas from [Course] c inner join [TNF_data] td on c.courseID = td.courseID inner join [TNF] t on td.tnfid = t.tnfid where t.tnfid=@tnfid";
                comm.Parameters.AddWithValue("@tnfid", tnfID);
                SqlDataReader dr = comm.ExecuteReader();
                while (dr.Read())
                {
                    overseas = (string)dr["overseas"];
                }
                dr.Close();

                if (overseas.ToLower().Equals("y")) {
                    toReturn = true;
                }
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
        public Boolean checkIsCourseAppliedOver10000(int tnfID)
        {
            SqlConnection conn = new SqlConnection();
            double coursePrice = 0.0;
            Boolean toReturn = false;
            try
            {
                conn = new SqlConnection();
                string connstr = ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString();
                conn.ConnectionString = connstr;
                conn.Open();
                SqlCommand comm = new SqlCommand();
                comm.Connection = conn;
                comm.CommandText = "select c.price from [Course] c inner join [TNF_data] td on c.courseID = td.courseID inner join [TNF] t on td.tnfid = t.tnfid where t.tnfid=@tnfid";
                comm.Parameters.AddWithValue("@tnfid", tnfID);
                SqlDataReader dr = comm.ExecuteReader();
                while (dr.Read())
                {
                    coursePrice = (double)dr["overseas"];
                }
                dr.Close();

                if (coursePrice > 10000)
                {
                    toReturn = true;
                }
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
        public Boolean checkIfUserAppliedCourse(string userID, int courseID)
        {
            SqlConnection conn = new SqlConnection();
            Boolean toReturn = false;
            try
            {
                conn = new SqlConnection();
                string connstr = ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString();
                conn.ConnectionString = connstr;
                conn.Open();
                SqlCommand comm = new SqlCommand();
                comm.Connection = conn;
                comm.CommandText = "select count(*) from [TNF] t inner join [TNF_data] td on t.tnfid = td.tnfid inner join [Course] c on td.courseID = c.courseID where t.userID=@userID and c.courseID=@courseID and t.status<>@status";
                comm.Parameters.AddWithValue("@userID", userID);
                comm.Parameters.AddWithValue("@courseID", courseID);
                comm.Parameters.AddWithValue("@status", "rejected");
                int count = (Int32)comm.ExecuteScalar();
                if (count > 0)
                {
                    toReturn = true;
                }
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