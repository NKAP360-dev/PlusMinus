using System;
using LearnHub.AppCode.dao;
using LearnHub.AppCode.entity;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LearnHub
{
    public partial class manageUsers : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["currentUser"] == null)
            {
                Response.Redirect("Login.aspx");
            }
            else
            {
                User currentUser = (User)Session["currentUser"];
                if (!currentUser.getRole().Equals("superuser"))
                {
                    Response.Redirect("errorPage.aspx");
                }
            }
        }
    }
}