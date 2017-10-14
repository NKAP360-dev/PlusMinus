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
                    DeptDAO depdao = new DeptDAO();
                    List<Department> deps = depdao.getAllDepartment();
                    foreach (Department d in deps)
                    {
                        lblDept.Items.Add(new ListItem(System.Globalization.CultureInfo.CurrentCulture.TextInfo.ToTitleCase(d.getDeptName().ToLower()), d.getDeptName()));
                    }
                    string id = Request.QueryString["id"];
                    int id_num = Convert.ToInt32(id);
                    ContactDAO adao = new ContactDAO();
                    a = adao.getContactById(id_num);
                    txtName.Text = a.name;
                    lblDept.SelectedValue = a.department;
                    txtEmail.Text = a.email;
                    txtRemarks.Text = a.remarks;
                }
            }
        }
        protected void btnEdit_Click(object sender, EventArgs e)
        {
            ContactDAO adao = new ContactDAO();
            string name = txtName.Text;
            string dept = lblDept.Text;
            string email = txtEmail.Text;
            string remarks = txtRemarks.Text;
            string id = Request.QueryString["id"];
            int id_num = Convert.ToInt32(id);
            Contact article = adao.getContactById(id_num);
            int id_edit = article.contact_id;
            DateTime start = article.upload_datetime;
            User u = article.user;
            string status = article.status;
            Contact toChange = new Contact(id_edit, name, dept.ToLower(), u, start, status, email, remarks);
            adao.updateContact(toChange);

            //set audit
            User currentUser = (User)Session["currentUser"];
            setAudit(currentUser, "contact us", "update", id, "updated contact personnel name: " + name);

            Response.Redirect("manageContactUs.aspx");
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
    }
}