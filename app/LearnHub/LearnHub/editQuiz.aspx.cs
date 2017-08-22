using System;
using LearnHub.AppCode.entity;
using LearnHub.AppCode.dao;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LearnHub
{
    public partial class editQuiz : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Course_elearnDAO cdao = new Course_elearnDAO();
            String id_str = Request.QueryString["id"];
            int id_num = int.Parse(id_str);
            lblBreadcrumbCourseName.Text = cdao.get_course_by_id(id_num).getCourseName();
        }
    }
}