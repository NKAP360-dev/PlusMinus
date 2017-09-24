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
    public partial class editContactUs : System.Web.UI.Page
    {
        private Contact a;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["currentUser"] == null)
            {
                Response.Redirect("Login.aspx");
            }
            else
            {
                User currentUser = (User)Session["currentUser"];
                Boolean superuser = false;
                foreach (string s in currentUser.getRoles())
                {
                    if (s.Equals("superuser"))
                    {
                        superuser = true;
                    }
                }

                if (!superuser)
                {
                    Response.Redirect("errorPage.aspx");
                }
                if (!IsPostBack)
                {
                    string id = Request.QueryString["id"];
                    int id_num = Convert.ToInt32(id);
                    ContactDAO adao = new ContactDAO();
                    a = adao.getContactById(id_num);
                    txtName.Text = a.name;
                    txtDepartment.Text = a.department;
                    txtEmail.Text = a.email;
                    txtRemarks.Text = a.remarks;
                }
            }
        }
        protected void btnEdit_Click(object sender, EventArgs e)
        {
            ContactDAO adao = new ContactDAO();
            string name = txtName.Text;
            string dept = txtDepartment.Text;
            string email = txtEmail.Text;
            string remarks = txtRemarks.Text;
            string id = Request.QueryString["id"];
            int id_num = Convert.ToInt32(id);
            Contact article = adao.getContactById(id_num);
            int id_edit = article.contact_id;
            DateTime start = article.upload_datetime;
            User u = article.user;
            string status = article.status;
            Contact toChange = new Contact(id_edit, name, dept, u, start, status, email, remarks);
            adao.updateContact(toChange);
            Response.Redirect("manageContactUs.aspx");
        }
    }
}