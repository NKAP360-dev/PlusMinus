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

            if (!IsPostBack)
            {
                DeptDAO depdao = new DeptDAO();
                List<Department> deps = depdao.getAllDepartment();
                foreach (Department d in deps)
                {
                    ddlDept.Items.Add(new ListItem(System.Globalization.CultureInfo.CurrentCulture.TextInfo.ToTitleCase(d.getDeptName().ToLower()), d.getDeptName()));
                }
            }
        }
        protected void btnCreate_Click(object sender, EventArgs e)
        {
            User currentUser = (User)Session["currentUser"];
            string dept = ddlDept.SelectedValue;
            string name = txtName.Text;
            string email = txtEmail.Text;
            string remarks = txtRemarks.Text;
            Contact c = new Contact(name, dept, currentUser, DateTime.Now, "Active", email, remarks);
            ContactDAO cdao = new ContactDAO();
            int contactID = cdao.createContact(c);

            //set audit
            setAudit(currentUser, "contact us", "create", contactID.ToString(), "contact personnel name: " + name);

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