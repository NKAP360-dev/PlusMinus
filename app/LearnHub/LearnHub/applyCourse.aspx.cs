using LearnHub.AppCode.entity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LearnHub
{
    public partial class applyCourse : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["currentUser"] == null)
            {
                Response.Redirect("/Login.aspx");
            } else
            {
                User currentUser = (User)Session["currentUser"];
                nameOfStaffInput.Text = currentUser.getName();
                employeeNoInput.Text = currentUser.getUserID();
                emailInput.Text = currentUser.getEmail();
                designationInput.Text = currentUser.getJobTitle();
                departmentInput.Text = currentUser.getDepartment();
            }
        }

        protected void submitBtn_Click(object sender, EventArgs e)
        {

        }
    }
}