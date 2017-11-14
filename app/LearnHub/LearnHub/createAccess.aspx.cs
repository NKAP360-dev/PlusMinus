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
            User currentUser = (User)Session["currentUser"];
            if (currentUser != null)
            {
                Boolean superuser = false;
                foreach (string s in currentUser.getRoles())
                {
                    if (s.Equals("superuser"))
                    {
                        superuser = true;
                    }
                }
                if (superuser)
                {
                    if (!IsPostBack)
                    {
                        DeptDAO depdao = new DeptDAO();
                        List<Department> deps = depdao.getAllDepartment();
                        foreach (Department d in deps)
                        {
                            if (d.getDeptName().ToLower().Equals("hr"))
                            {
                                lblDept.Items.Add(new ListItem("Human Resource", d.getDeptName()));
                            }
                            else
                            {
                                lblDept.Items.Add(new ListItem(System.Globalization.CultureInfo.CurrentCulture.TextInfo.ToTitleCase(d.getDeptName().ToLower()), d.getDeptName()));
                            }
                        }
                        UserDAO udao = new UserDAO();

                        ArrayList sups = udao.get_supervisors();
                        foreach (User supervisor in sups)
                        {
                            ddlSup.Items.Add(supervisor.getName());
                        }
                    }
                    else
                    {
                        txtPassword.Attributes["value"] = txtPassword.Text;
                        txtPassword2.Attributes["value"] = txtPassword2.Text;
                    }
                }
                else
                {
                    Response.Redirect("errorPage.aspx");
                }
            }
            else
            {
                Response.Redirect("login.aspx");
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
            string supervisor = null;
            string supid = null;
            if (!(ddlSup.SelectedValue.Equals("none")))
            {
                supervisor = ddlSup.SelectedValue;
                supid = udao.getUserByName(supervisor).getUserID();
            }
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
                //set audit
                User currentUser = (User)Session["currentUser"];
                setAudit(currentUser, "user", "create", user, "created username: " + user);

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
            if(departmentName.Equals("Human Resource"))
            {
                departmentName = "hr";
            }
            UserDAO userDAO = new UserDAO();
            List<User> allSupervisorForDept = userDAO.getAllUsersByDept(departmentName);
            ddlSup.Items.Clear();
            ddlSup.Items.Add(new ListItem("--select--", "none"));
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