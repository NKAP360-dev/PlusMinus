using LearnHub.AppCode.entity;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace LearnHub.AppCode.dao
{
    public class QuizDAO
    {
        public Quiz getQuizByID(int quizID)
        {
            SqlConnection conn = new SqlConnection();
            Quiz toReturn = null;
            try
            {
                conn = new SqlConnection();
                string connstr = ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString();
                conn.ConnectionString = connstr;
                conn.Open();
                SqlCommand comm = new SqlCommand();
                comm.Connection = conn;
                comm.CommandText = "select * from [Quiz] q inner join [Elearn_course] ec on q.elearn_courseID = ec.elearn_courseID where q.quizID=@quizID";
                comm.Parameters.AddWithValue("@quizID", quizID);
                SqlDataReader dr = comm.ExecuteReader();
                while (dr.Read())
                {
                    toReturn = new Quiz();
                    toReturn.setQuizID((int)dr["quizID"]);
                    toReturn.setTitle((string)dr["title"]);
                    toReturn.setDescription((string)dr["description"]);
                    toReturn.setPassingGrade((int)dr["passingGrade"]);
                    toReturn.setRandomOrder((string)dr["randomOrder"]);
                    toReturn.setStatus((string)dr["status"]);
                    Course_elearnDAO ceDAO = new Course_elearnDAO();
                    //toReturn.setMainCourse(ceDAO.get_course_by_id((int)dr["elearn_courseID"]));

                    Course_elearn course = new Course_elearn();
                    UserDAO userDAO = new UserDAO();
                    int cid = (int)dr["elearn_courseID"]; //1
                    course.setCourseID(cid);
                    course.setCourseName((string)dr["elearn_courseName"]); //2
                    if (!dr.IsDBNull(4))
                    {
                        course.setCourseProvider((string)dr["elearn_courseProvider"]);
                    };
                    course.setStartDate((DateTime)dr["start_date"]);//3
                    if (!dr.IsDBNull(4))
                    {
                        course.setExpiryDate((DateTime)dr["expiry_date"]);
                    }
                    course.setStatus((string)dr["status"]);//4
                    //get the prereq
                    course.setDescription((string)dr["description"]);//6
                    course.setEntryDate((DateTime)dr["entry_date"]);
                    ArrayList list = ceDAO.getPrereqOfCourse(cid);//5
                    if (list != null)
                    {
                        course.setPrerequisite(list); //retrieve arraylist of all prereq course_elearn objects
                    }
                    course.setCategoryID((int)dr["categoryID"]);//7
                    course.setCourseCreator(userDAO.getUserByID((string)dr["courseCreator"]));
                    course.setHoursAwarded((double)dr["hoursAwarded"]);
                    if (!dr.IsDBNull(11))
                    {
                        course.setTargetAudience((string)dr["targetAudience"]);
                    }

                    toReturn.setMainCourse(course);
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
        public int createQuiz(Quiz q) // Insert.
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
                comm.CommandText = "Insert into [Quiz] (elearn_courseID, title, description, passingGrade, randomOrder, status) OUTPUT INSERTED.quizID VALUES (@elearn_courseID, @title, @description, @passingGrade, @randomOrder, @status)";
                comm.Parameters.AddWithValue("@elearn_courseID", q.getMainCourse().getCourseID());
                comm.Parameters.AddWithValue("@title", q.getTitle());
                comm.Parameters.AddWithValue("@description", q.getDescription());
                comm.Parameters.AddWithValue("@passingGrade", q.getPassingGrade());
                comm.Parameters.AddWithValue("@randomOrder", q.getRandomOrder());
                comm.Parameters.AddWithValue("@status", q.getStatus());
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
        public ArrayList getPrereqOfQuiz(int quizID)
        {
            ArrayList toReturn_list = new ArrayList();
            SqlConnection conn = new SqlConnection();
            Quiz toReturn = null;
            try
            {
                conn = new SqlConnection();
                string connstr = ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString();
                conn.ConnectionString = connstr;
                conn.Open();
                SqlCommand comm = new SqlCommand();
                comm.Connection = conn;
                comm.CommandText = "select * from Quiz q inner join " +
                    "(select prereq_quizID from QuizPrerequisite where quizID = @check) " +
                    "as temp on q.quizID = temp.prereq_quizID;";
                comm.Parameters.AddWithValue("@check", quizID);
                SqlDataReader dr = comm.ExecuteReader();
                while (dr.Read())
                {
                    toReturn = new Quiz();
                    toReturn.setQuizID((int)dr["quizID"]);
                    toReturn.setTitle((string)dr["title"]);
                    toReturn.setDescription((string)dr["description"]);
                    toReturn.setPassingGrade((int)dr["passingGrade"]);
                    toReturn.setRandomOrder((string)dr["randomOrder"]);
                    toReturn.setStatus((string)dr["status"]);
                    Course_elearnDAO ceDAO = new Course_elearnDAO();
                    toReturn.setMainCourse(ceDAO.get_course_by_id((int)dr["elearn_courseID"]));
                    toReturn_list.Add(toReturn);
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
            return toReturn_list;
        }
        public List<int> getAllQuizLinkedToPrerequisite(int prereq_quizID)
        {
            SqlConnection conn = new SqlConnection();
            List<int> toReturn = new List<int>();
            try
            {
                conn = new SqlConnection();
                string connstr = ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString();
                conn.ConnectionString = connstr;
                conn.Open();
                SqlCommand comm = new SqlCommand();
                comm.Connection = conn;
                comm.CommandText = "select quizID from [QuizPrerequisite] where prereq_quizID =@prereq_quizID";
                comm.Parameters.AddWithValue("@prereq_quizID", prereq_quizID);
                SqlDataReader dr = comm.ExecuteReader();
                while (dr.Read())
                {
                    toReturn.Add((int)dr["quizID"]);
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
        public Boolean insertPrerequisite(int quizID, int prereqID)
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
                comm.CommandText = "insert into [QuizPrerequisite] "
                                    + "(quizID, prereq_quizID)"
                                    + "values(@quizID, @prereqID)";
                comm.Parameters.AddWithValue("@quizID", quizID);
                comm.Parameters.AddWithValue("@prereqID", prereqID);
                int rowsAffected = comm.ExecuteNonQuery();
                toReturn = true;
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
        public List<Quiz> getAllQuizByCourseID(int courseID)
        {
            SqlConnection conn = new SqlConnection();
            List<Quiz> toReturn = new List<Quiz>();
            try
            {
                conn = new SqlConnection();
                string connstr = ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString();
                conn.ConnectionString = connstr;
                conn.Open();
                SqlCommand comm = new SqlCommand();
                comm.Connection = conn;
                comm.CommandText = "select * from [Quiz] where elearn_courseID=@elearn_courseID and status='active'";
                comm.Parameters.AddWithValue("@elearn_courseID", courseID);
                SqlDataReader dr = comm.ExecuteReader();
                while (dr.Read())
                {
                    Quiz q = new Quiz();
                    q.setQuizID((int)dr["quizID"]);
                    q.setTitle((string)dr["title"]);
                    q.setDescription((string)dr["description"]);
                    q.setPassingGrade((int)dr["passingGrade"]);
                    q.setRandomOrder((string)dr["randomOrder"]);
                    q.setStatus((string)dr["status"]);
                    Course_elearnDAO ceDAO = new Course_elearnDAO();
                    q.setMainCourse(ceDAO.get_course_by_id((int)dr["elearn_courseID"]));

                    toReturn.Add(q);
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
        public void updateQuiz(int quizID, string title, string description, int passingGrade, string randomOrder) // Update.
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
                    "Update [Quiz] SET title=@title, description=@description, passingGrade=@passingGrade, randomOrder=@randomOrder where quizID=@quizID";
                comm.Parameters.AddWithValue("@title", title);
                comm.Parameters.AddWithValue("@description", description);
                comm.Parameters.AddWithValue("@passingGrade", passingGrade);
                comm.Parameters.AddWithValue("@randomOrder", randomOrder);
                comm.Parameters.AddWithValue("@quizID", quizID);
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
        public void updateQuizStatus(int quizID, string status) // Update.
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
                    "Update [Quiz] SET status=@status where quizID=@quizID";
                comm.Parameters.AddWithValue("@status", status);
                comm.Parameters.AddWithValue("@quizID", quizID);
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
        public void deletePrerequisitesByQuizID(int quizID)
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
                comm.CommandText = "DELETE FROM [QuizPrerequisite] WHERE quizID=@quizID";
                comm.Parameters.AddWithValue("@quizID", quizID);
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