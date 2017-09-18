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
    public partial class viewCompletedCourses : System.Web.UI.Page
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
                UserDAO userDAO = new UserDAO();
                User user = userDAO.getUserByID((String)Request.QueryString["id"]);
                if (!user.getSupervisor().Equals(currentUser.getUserID()))
                {
                    Response.Redirect("errorPage.aspx");
                }
            }
        }
    }
}