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
    public partial class manageContactUs : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
             User currentUser = (User)Session["currentUser"];
            if (currentUser == null)
            {
                Response.Redirect("login.aspx");
            }
            Boolean super = false;
            foreach (string role in currentUser.getRoles())
            {
                if (role.Equals("superuser"))
                {
                    super = true;
                }
            }
            if (!super)
            {
                Response.Redirect("errorPage.aspx");
            }
        }
        protected void btnCreate_Click(object sender, EventArgs e)
        {
            User currentUser = (User)Session["currentUser"];
            string dept = txtDepartment.Text;
            string name = txtName.Text;
            string email = txtEmail.Text;
            string remarks = txtRemarks.Text;
            Contact c = new Contact(name, dept, currentUser, DateTime.Now, "Active", email, remarks);
            ContactDAO cdao = new ContactDAO();
            int val = cdao.createContact(c);
            if (val > 0)
            {
                Response.Redirect("manageContactUs.aspx");
            }
            else
            {
                Response.Redirect("errorPage.aspx");
            }
        }
     }
 }