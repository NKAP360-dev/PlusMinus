using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using LearnHub.AppCode.dao;
using LearnHub.AppCode.entity;

namespace LearnHub
{
    public partial class viewAllModule : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
           
           
        }

        protected void btnModuleCategory_Click(object sender, EventArgs e)
        {
            LinkButton btn = (LinkButton)(sender);
            string value = btn.CommandArgument;
            Course_elearnCategoryDAO cecDAO = new Course_elearnCategoryDAO();
            CourseCategory cc = cecDAO.getCategoryByID(Convert.ToInt32(value));
            lblModuleCategory.Text = cc.category + " Module";

            SqlDataSourceCourse.SelectCommand = $"SELECT * FROM [Elearn_course] WHERE categoryID = {value}";
            gvCourse.DataSource = SqlDataSourceCourse;
            gvCourse.DataBind();
            gvCourse.UseAccessibleHeader = true;
            if (gvCourse.Rows.Count > 0)
            {
                gvCourse.HeaderRow.TableSection = TableRowSection.TableHeader;
            }
        }
    }
}