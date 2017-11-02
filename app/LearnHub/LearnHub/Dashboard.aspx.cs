using System;
using System.Collections.Generic;
using System.Linq;
using System.Collections;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Script.Serialization;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using LearnHub.AppCode.entity;
using LearnHub.AppCode.dao;

namespace LearnHub
{
    public partial class Dashboard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            UserDAO userDAO = new UserDAO();
            List<User> allUsers = userDAO.getAllUsers();
            lblUsers.Text = allUsers.Count().ToString();

            Course_elearnDAO courseDAO = new Course_elearnDAO();
            ArrayList allCourses = courseDAO.getAllCourses();
            lblCourses.Text = allCourses.Count.ToString();

            lblQuizAttempts.Text = GetTotalNoOfQuiz().ToString();

            lblHours.Text = GetTotalNoOfLearningHours().ToString();

            renderUserPieChart();
            renderCoursePieChart();
            renderPopularCourse();
            renderPopularCourseCategory();
            renderAuditFunction();
            renderAuditFunctionName();
        }

        public string userPieChartData
        {
            get;
            set;
        }

        public string coursePieChartData
        {
            get;
            set;
        }

        public string popularCourseData
        {
            get;
            set;
        }

        public string popularCourseName
        {
            get;
            set;
        }

        public string auditFunctionData {
            get;
            set;
        }

        public string auditFunctionName {
            get;
            set;
        }

        
        public void renderUserPieChart()
        {
            DataTable dt = GetUserPieData(); //Assuming that GetData already populating with data as datatable   
            List<int> _data = new List<int>();
            //Dictionary<String, string> tHash = new Dictionary<string, string>();
            string temp = "[";
            int counter = 1;
            foreach (DataRow row in dt.Rows)
            {

                int count = (int)row["count"];

                temp = temp + "{" + $"name : '{(string)row["dept_name"]}'," + $"y : {count}" + "}";
                if (counter != dt.Rows.Count)
                {
                    temp = temp + ",";
                }

                counter++;
            }
            temp = temp + "]";
            userPieChartData = temp;
        }

        public void renderCoursePieChart()
        {
            DataTable dt = GetCoursePieData(); //Assuming that GetData already populating with data as datatable   
            List<int> _data = new List<int>();
            //Dictionary<String, string> tHash = new Dictionary<string, string>();
            string temp = "[";
            int counter = 1;
            foreach (DataRow row in dt.Rows)
            {

                int count = (int)row["count"];

                temp = temp + "{" + $"name : '{(string)row["categoryName"]}'," + $"y : {count}" + "}";
                if (counter != dt.Rows.Count)
                {
                    temp = temp + ",";
                }

                counter++;
            }
            temp = temp + "]";
            coursePieChartData = temp;
        }

        public void renderPopularCourse()
        {
            DataTable dt = GetPopularCourseData(); //Assuming that GetData already populating with data as datatable   
            List<int> _data = new List<int>();
            //Dictionary<String, string> tHash = new Dictionary<string, string>();
            string temp = "[";
            int counter = 1;
            foreach (DataRow row in dt.Rows)
            {

                int count = (int)row["count"];

                temp = temp + count;
                if (counter != dt.Rows.Count)
                {
                    temp = temp + "," + " ";
                }

                counter++;
            }
            temp = temp + "]";
            popularCourseData = temp;
        }

        public void renderPopularCourseCategory()
        {
            DataTable dt = GetPopularCourseName();
            string temp = "[";
            int counter = 1;

            foreach (DataRow row in dt.Rows)
            {
                temp = temp + $"'{(string)row["courseName"]}'";
                if (counter != dt.Rows.Count)
                {
                    temp = temp + "," + " ";
                }

                counter++;
            }

            temp = temp + "]";
            popularCourseName = temp;

        }

        public void renderAuditFunction()
        {
            DataTable dt = GetAuditFunctionData(); //Assuming that GetData already populating with data as datatable   
            List<int> _data = new List<int>();
            string temp = "[";
            int counter = 1;
            foreach (DataRow row in dt.Rows)
            {

                int count = (int)row["count"];

                temp = temp + count;
                if (counter != dt.Rows.Count)
                {
                    temp = temp + "," + " ";
                }

                counter++;
            }
            temp = temp + "]";
            auditFunctionData = temp;
        }

        public void renderAuditFunctionName()
        {
            DataTable dt = GetAuditFunctionName();
            string temp = "[";
            int counter = 1;

            foreach (DataRow row in dt.Rows)
            {
                temp = temp + $"'{(string)row["functionmodified"]}'";
                if (counter != dt.Rows.Count)
                {
                    temp = temp + "," + " ";
                }

                counter++;
            }

            temp = temp + "]";
            auditFunctionName = temp;

        }
        public DataTable GetUserPieData()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["DBConnectionString"].ConnectionString;
            DataTable dt = new DataTable();

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand("Select dept_name, count(*) AS count from [User] group by dept_name", connection))
                {
                    connection.Open();
                    using (SqlDataReader dr = command.ExecuteReader())
                    {
                        if (dr.HasRows)
                        {
                            dt.Load(dr);
                        }
                    }
                    connection.Close();
                }
            }

            return dt;
        }

        public DataTable GetCoursePieData()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["DBConnectionString"].ConnectionString;
            DataTable dt = new DataTable();

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(" select cc.category AS categoryName, count(c.elearn_courseName) AS count from [Elearn_courseCategory] cc left outer join [Elearn_course] c ON c.categoryID = cc.categoryID group by cc.category", connection))
                {
                    connection.Open();
                    using (SqlDataReader dr = command.ExecuteReader())
                    {
                        if (dr.HasRows)
                        {
                            dt.Load(dr);
                        }
                    }
                    connection.Close();
                }
            }

            return dt;
        }

        public DataTable GetPopularCourseData()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["DBConnectionString"].ConnectionString;
            DataTable dt = new DataTable();

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand("select top 10 count(*) as count from [QuizResult] qr left outer join [Quiz] q on qr.quizID = q.quizid left outer join [Elearn_course] c on q.elearn_courseID = c.elearn_courseID group by c.elearn_courseName order by count desc", connection))
                {
                    connection.Open();
                    using (SqlDataReader dr = command.ExecuteReader())
                    {
                        if (dr.HasRows)
                        {
                            dt.Load(dr);
                        }
                    }
                    connection.Close();
                }
            }

            return dt;
        }
        public DataTable GetPopularCourseName()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["DBConnectionString"].ConnectionString;
            DataTable dt = new DataTable();

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand("select top 10 c.elearn_courseName AS courseName from [QuizResult] qr left outer join [Quiz] q on qr.quizID = q.quizid left outer join [Elearn_course] c on q.elearn_courseID = c.elearn_courseID group by c.elearn_courseName order by count(*) desc", connection))
                {
                    connection.Open();
                    using (SqlDataReader dr = command.ExecuteReader())
                    {
                        if (dr.HasRows)
                        {
                            dt.Load(dr);
                        }
                    }
                    connection.Close();
                }
            }

            return dt;
        }

        public DataTable GetAuditFunctionData()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["DBConnectionString"].ConnectionString;
            DataTable dt = new DataTable();

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand("select count(*) as count from [Audit] group by functionModified", connection))
                {
                    connection.Open();
                    using (SqlDataReader dr = command.ExecuteReader())
                    {
                        if (dr.HasRows)
                        {
                            dt.Load(dr);
                        }
                    }
                    connection.Close();
                }
            }

            return dt;
        }
        public DataTable GetAuditFunctionName()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["DBConnectionString"].ConnectionString;
            DataTable dt = new DataTable();

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand("select functionmodified from [Audit] group by functionModified", connection))
                {
                    connection.Open();
                    using (SqlDataReader dr = command.ExecuteReader())
                    {
                        if (dr.HasRows)
                        {
                            dt.Load(dr);
                        }
                    }
                    connection.Close();
                }
            }

            return dt;
        }
        public int GetTotalNoOfQuiz() {
            string connectionString = ConfigurationManager.ConnectionStrings["DBConnectionString"].ConnectionString;
            DataTable dt = new DataTable();
            int toReturn = 0;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand("select count(*) from [QuizResultHistory]", connection))
                {
                    connection.Open();
                    using (SqlDataReader dr = command.ExecuteReader())
                    {
                        if (dr.HasRows)
                        {
                            dt.Load(dr);
                        }
                    }
                    connection.Close();
                }
            }
            toReturn = int.Parse(dt.Rows[0][0].ToString());
            return toReturn;
        }

        public double GetTotalNoOfLearningHours()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["DBConnectionString"].ConnectionString;
            DataTable dt = new DataTable();
            double toReturn = 0.0;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand("select sum(c.hoursAwarded) from [QuizResult] qr inner join [Quiz] q on qr.quizID = q.quizID inner join [Elearn_course] c on q.elearn_courseID = c.elearn_courseID where qr.grade = 'pass'", connection))
                {
                    connection.Open();
                    using (SqlDataReader dr = command.ExecuteReader())
                    {
                        if (dr.HasRows)
                        {
                            dt.Load(dr);
                        }
                    }
                    connection.Close();
                }
            }
            toReturn = Double.Parse(dt.Rows[0][0].ToString());
            return toReturn;
        }
    }
}