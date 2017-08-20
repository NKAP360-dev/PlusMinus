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
    public partial class editCategories : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                User currentUser = (User)Session["currentUser"];
                int categoryID = Convert.ToInt32(Request.QueryString["id"]);
                Course_elearnCategoryDAO cecDAO = new Course_elearnCategoryDAO();
                CourseCategory currentCategory = cecDAO.getCategoryByID(categoryID);
                if (currentCategory.status.Equals("active"))
                {
                    btnDeactivate.Visible = true;
                    btnActivate.Visible = false;
                } else
                {
                    btnDeactivate.Visible = false;
                    btnActivate.Visible = true;
                }
                txtCategory.Text = currentCategory.category;
                lblHiddenID.Text = currentCategory.categoryID.ToString();
            }
        }
        protected void btnConfirmSubmit_Click(object sender, EventArgs e)
        {
            //to do validation
            int categoryID = Convert.ToInt32(lblHiddenID.Text);
            Course_elearnCategoryDAO cecDAO = new Course_elearnCategoryDAO();
            cecDAO.updateCategory(txtCategory.Text, categoryID);
            Response.Redirect("manageCategories.aspx");
        }

        protected void btnCfmDeactivate_Click(object sender, EventArgs e)
        {
            //to do validation
            int categoryID = Convert.ToInt32(lblHiddenID.Text);
            Course_elearnCategoryDAO cecDAO = new Course_elearnCategoryDAO();
            cecDAO.deactivateCategory(categoryID);
            Response.Redirect("manageCategories.aspx");
        }

        protected void btnCfmActivate_Click(object sender, EventArgs e)
        {
            //to do validation
            int categoryID = Convert.ToInt32(lblHiddenID.Text);
            Course_elearnCategoryDAO cecDAO = new Course_elearnCategoryDAO();
            cecDAO.activateCategory(categoryID);
            Response.Redirect("manageCategories.aspx");
        }
    }
}