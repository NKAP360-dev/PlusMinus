using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Collections;
using LearnHub.AppCode.entity;
using LearnHub.AppCode.dao;
using System.Web.Helpers;

namespace LearnHub
{
    public partial class createAccess : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                DeptDAO depdao = new DeptDAO();
                List<Department> deps = depdao.getAllDepartment();
                foreach (Department d in deps)
                {
                    lblDept.Items.Add(new ListItem(System.Globalization.CultureInfo.CurrentCulture.TextInfo.ToTitleCase(d.getDeptName().ToLower()), d.getDeptName()));
                }
                UserDAO udao = new UserDAO();

                ArrayList sups = udao.get_supervisors();
                foreach (User supervisor in sups)
                {
                    ddlSup.Items.Add(supervisor.getName());
                }
            }
        }
        protected void submit_Click(object sender, EventArgs e)
        {
            UserDAO udao = new UserDAO();
            string user = txtUsername.Text;
            string pass = txtPassword.Text;
            string name = txtName.Text;
            string contact = txtContactNo.Text;
            string address = txtAddress.Text;
            string email = txtEmail.Text;
            string dept = lblDept.SelectedValue;
            string jobtitle = txtJobTitle.Text;
            string supervisor = ddlSup.SelectedValue;
            string supid = udao.getUserByName(supervisor).getUserID();
            ArrayList roles = new ArrayList();
            foreach (ListItem item in cblRoles.Items)
            {
                if (item.Selected)
                    roles.Add(item.Value);
            }
            //need some fields like job category, who is the supervisor, job startdate
            //hash password here first 
            LoginDAO ldao = new LoginDAO();
            string salt = Crypto.GenerateSalt();// generate salt of user
            string password_hashed = Crypto.SHA256(salt + pass);
            //password hashed now create user 
            User u = new User(user, name, jobtitle, "Staff", supid, roles, dept.ToLower(), email, DateTime.Now, address, contact, "Active");
            Boolean res = udao.create_user_elearn(u, password_hashed, salt);
            Boolean res_role = udao.add_role(u, roles);
            //Boolean res = true;
            if (res)
            {
                Response.Redirect("manageUsers.aspx");
            }
            else
            {
                Response.Redirect("home.aspx");
            }
        }

        protected void lblDept_SelectedIndexChanged(object sender, EventArgs e)
        {
            string departmentName = lblDept.SelectedValue;
            UserDAO userDAO = new UserDAO();
            List<User> allSupervisorForDept = userDAO.getAllUsersByDept(departmentName);
            ddlSup.Items.Clear();
            foreach (User u in allSupervisorForDept)
            {
                ddlSup.Items.Add(new ListItem(u.getName(), u.getName()));
            }
        }

        /*
        protected void checkCheckBoxes(object sender, EventArgs e)
        {
            string Password = txtPassword.Text;
            txtPassword.Attributes.Add("value", Password);
            string Password2 = txtPassword2.Text;
            txtPassword2.Attributes.Add("value", Password2);
        }
        */
    }
}