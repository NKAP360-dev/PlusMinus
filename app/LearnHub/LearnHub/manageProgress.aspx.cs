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
    public partial class manageProgress : System.Web.UI.Page
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
                Boolean supervisor = userDAO.checkIfUserIsSupervisor(currentUser.getUserID());
                if (supervisor)
                {

                }
                else
                {
                    Response.Redirect("errorPage.aspx");
                }
            }
        }
    }
}