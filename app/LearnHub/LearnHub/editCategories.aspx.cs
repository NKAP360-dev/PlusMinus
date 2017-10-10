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

            //set audit
            User currentUser = (User)Session["currentUser"];
            setAudit(currentUser, "course category", "update", categoryID.ToString(), "update category name to: " + txtCategory.Text);

            Response.Redirect("manageCategories.aspx");
        }

        protected void btnCfmDeactivate_Click(object sender, EventArgs e)
        {
            //to do validation
            int categoryID = Convert.ToInt32(lblHiddenID.Text);
            Course_elearnCategoryDAO cecDAO = new Course_elearnCategoryDAO();
            cecDAO.deactivateCategory(categoryID);

            //set audit
            User currentUser = (User)Session["currentUser"];
            setAudit(currentUser, "course category", "deactivate", categoryID.ToString(), "category name: " + txtCategory.Text);

            Response.Redirect("manageCategories.aspx");
        }

        protected void btnCfmActivate_Click(object sender, EventArgs e)
        {
            //to do validation
            int categoryID = Convert.ToInt32(lblHiddenID.Text);
            Course_elearnCategoryDAO cecDAO = new Course_elearnCategoryDAO();
            cecDAO.activateCategory(categoryID);

            //set audit
            User currentUser = (User)Session["currentUser"];
            setAudit(currentUser, "course category", "activate", categoryID.ToString(), "category name: " + txtCategory.Text);

            Response.Redirect("manageCategories.aspx");
        }
        protected void checkForm(object sender, EventArgs e)
        {
            Page.Validate("ValidateForm");
            System.Diagnostics.Debug.WriteLine("checkForm");
            if (!Page.IsValid)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openModal();", true);
                lblErrorMsgFinal.Text = "You have not filled up all of the required fields";
                btnConfirmSubmit.Enabled = false;
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openModal();", true);
                lblErrorMsgFinal.Text = "";
                btnConfirmSubmit.Enabled = true;
            }
        }
        protected void setAudit(User u, string functionModified, string operation, string id_of_function, string remarks)
        {
            //set audit
            Audit a = new Audit();
            AuditDAO aDAO = new AuditDAO();
            a.userID = u.getUserID();
            a.functionModified = functionModified;
            a.operation = operation;
            a.id_of_function = id_of_function;
            a.dateModified = DateTime.Now;
            a.remarks = remarks;
            aDAO.createAudit(a);
        }
    }
}