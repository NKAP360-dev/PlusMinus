using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Script.Serialization;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;


namespace LearnHub
{
    public partial class Dashboard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            renderPieChart();
        }

        public string pieChartData
        {
            get;
            set;
        }

        public void renderPieChart()
        {
            DataTable dt = GetPieData(); //Assuming that GetData already populating with data as datatable   
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
            pieChartData = temp;
        }

        public DataTable GetPieData()
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

    }
}