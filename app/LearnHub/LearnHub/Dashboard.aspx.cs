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

            //QuizResultHistoryDAO qrhDAO = new QuizResultHistoryDAO();
            //List<QuizResultHistory> allQuiz = qrhDAO.getAll();
            //lblQuizAttempts.Text = allQuiz.Count().ToString();

            renderUserPieChart();
            renderCoursePieChart();
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
                }
            }

            return dt;
        }
    }
}