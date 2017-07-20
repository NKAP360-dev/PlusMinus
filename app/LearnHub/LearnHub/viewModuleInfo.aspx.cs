using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using LearnHub.AppCode.entity;
using LearnHub.AppCode.dao;

namespace LearnHub
{

    public partial class viewModuleInfo : System.Web.UI.Page
    {
        protected Course_elearn course;
        protected void Page_Load(object sender, EventArgs e)
        {
            Course_elearnDAO cdao = new Course_elearnDAO();
            string id_str = null;
            if (Request.QueryString["id"] != null)
            {
                id_str = Request.QueryString["id"];
            }
            else
            {
                return;
            }

            int id_num = int.Parse(id_str);
            Course_elearn current = cdao.get_course_by_id(id_num);
            lblCourseNameHeader.Text = current.getCourseName();
            lblCourseName.Text = current.getCourseName();
            lblCourseDescription.Text = current.getDescription();
        }
    }
}