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
    public partial class manageQuiz : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            User currentUser = (User)Session["currentUser"];
            if (currentUser == null)
            {
                Response.Redirect("Login.aspx");
            }
            else
            {
                Boolean superuser = false;
                Boolean course_creator = false;
                foreach (string s in currentUser.getRoles())
                {
                    if (s.Equals("superuser"))
                    {
                        superuser = true;
                    }
                    else if (s.Equals("course creator"))
                    {
                        course_creator = true;
                    }
                }
                if (!superuser || !course_creator)
                {
                    Response.Redirect("errorPage.aspx");
                }
                if (!IsPostBack)
                {

                    Course_elearnDAO cdao = new Course_elearnDAO();
                    string id_str = Request.QueryString["id"];
                    int id_num = int.Parse(id_str);
                    lblBreadcrumbCourseName.Text = cdao.get_course_by_id(id_num).getCourseName();
                }
            }
        }
    }
}