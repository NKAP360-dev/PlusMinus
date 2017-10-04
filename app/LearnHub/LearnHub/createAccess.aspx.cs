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

        protected void cv_checkEmailExist_ServerValidate(object source, ServerValidateEventArgs args)
        {
            UserDAO userDAO = new UserDAO();
            User checkUser = userDAO.getUserByEmail(txtEmail.Text);
            System.Diagnostics.Debug.WriteLine("cv 1");
            if (checkUser != null)
            {
                System.Diagnostics.Debug.WriteLine("cv false");
                args.IsValid = false;
            }
            else
            {
                System.Diagnostics.Debug.WriteLine("cv true");
                args.IsValid = true;
            }
        }
        protected void cv_checkPasswordFormat_ServerValidate(object source, ServerValidateEventArgs args)
        {
            System.Diagnostics.Debug.WriteLine("val pass");
            string userQuery = txtPassword.Text;
            bool containsAtLeastOneUppercase = userQuery.Any(char.IsUpper);
            bool containsAtLeastOneLowercase = userQuery.Any(char.IsLower);
            bool containsAtLeastOneNumerical = userQuery.Any(char.IsNumber);
            int containsSpecialCharacters = userQuery.Count(p => !char.IsLetterOrDigit(p));

            if (userQuery.Length >= 8 && containsAtLeastOneLowercase && containsAtLeastOneNumerical && containsAtLeastOneUppercase && containsSpecialCharacters > 0)
            {
                args.IsValid = true;
            }
            else
            {
                args.IsValid = false;
            }
        }

        
        protected void checkForm(object sender, EventArgs e)
        {
            Page.Validate("ValidateForm");
            System.Diagnostics.Debug.WriteLine("checkForm");
            if (!Page.IsValid)
            {
                System.Diagnostics.Debug.WriteLine("not valid");
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openModal();", true);
                lblErrorMsgFinal.Text = "You have not filled up all of the required fields";
                btnCfmSubmit.Enabled = false;
            }
            else
            {
                System.Diagnostics.Debug.WriteLine("valid");
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openModal();", true);
                lblErrorMsgFinal.Text = "";
                btnCfmSubmit.Enabled = true;
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