using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using LearnHub.AppCode.dao;
using LearnHub.AppCode.entity;
using System.Collections;
using System.Data;
using System.Data.SqlClient;
using System.Text;

namespace LearnHub
{
    public partial class WebForm3 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Course_elearnDAO d = new Course_elearnDAO();
            ArrayList list = d.view_courses("Leadership");
            foreach(Course_elearn c in list)
            {
                TableRow row = new TableRow();
                TableCell cell1 = new TableCell();
                cell1.Text = c.getCourseID().ToString();
                TableCell cell2 = new TableCell();
                cell2.Text = c.getCourseName().ToString();
                row.Cells.Add(cell1);
                row.Cells.Add(cell2);
                myTable.Rows.Add(row);
            }
        }
    }
}