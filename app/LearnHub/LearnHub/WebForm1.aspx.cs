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
    public partial class WebForm1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Panel1.Visible = false;
            lblError.Visible = false;
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            string userInput = TextBox1.Text;
            UserDAO userDAO = new UserDAO();
            User searchUser = userDAO.getUserByID(userInput);
            if (searchUser != null)
            {
                Panel1.Visible = true;
                lblName.Text = searchUser.getName();
                lblJobTitle.Text = searchUser.getJobTitle();
            } else
            {
                lblError.Visible = true;
                lblError.Text = "Unable to find user";
            }
        }

        protected void LinkButton1_Click(object sender, EventArgs e)
        {

        }

        protected void LinkButton1_Click1(object sender, EventArgs e)
        {

        }
    }
}