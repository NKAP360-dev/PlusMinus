using LearnHub.AppCode.dao;
using LearnHub.AppCode.entity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LearnHub
{
    public partial class editModuleInfo : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["currentUser"] == null)
            {
                Response.Redirect("/Login.aspx");
            }
            else 
            {
                User currentUser = (User)Session["currentUser"];
                Course_elearnDAO ceDAO = new Course_elearnDAO();
                Course_elearn currentCourse = ceDAO.get_course_by_id(Convert.ToInt32(Request.QueryString["id"]));
                if (currentUser.getUserID() != currentCourse.getCourseCreator().getUserID() && !(currentUser.getRole().Equals("course creator") || currentUser.getRole().Equals("superuser")))
                {
                    Response.Redirect("/errorPage.aspx");
                }
                else
                {
                    //to populate date
                }
            }
        }
    }
}