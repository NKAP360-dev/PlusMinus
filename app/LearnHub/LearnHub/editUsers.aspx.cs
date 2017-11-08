﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using LearnHub.AppCode.dao;
using LearnHub.AppCode.entity;
using System.Collections;
using System.Web.Helpers;

namespace LearnHub
{
    public partial class editUsers : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //hp = new Dictionary<string, string>(); 

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
                    UserDAO udao = new UserDAO();
                    string userID = Request.QueryString["userID"];
                    if (userID == null || userID.Equals(""))
                    {
                        Response.Redirect("errorPage.aspx");
                    }
                    User toChange = udao.getUserByID(userID);
                    ArrayList roles = udao.getRolesByID(userID);
                    txtUsername.Text = toChange.getUserID();
                    txtName.Text = toChange.getName();
                    txtAddress.Text = toChange.getAddress();
                    txtContactNo.Text = toChange.getContact();
                    //txtDept.Text = toChange.getDepartment();

                    DeptDAO depdao = new DeptDAO();
                    List<Department> deps = depdao.getAllDepartment();
                    foreach (Department d in deps)
                    {
                        if (d.getDeptName().ToLower().Equals("hr"))
                        {
                            lblDept.Items.Add(new ListItem("Human Resources", d.getDeptName()));
                        }
                        else
                        {
                            lblDept.Items.Add(new ListItem(System.Globalization.CultureInfo.CurrentCulture.TextInfo.ToTitleCase(d.getDeptName().ToLower()), d.getDeptName()));
                        }
                    }
                    lblDept.SelectedValue = toChange.getDepartment();

                    // find supervisor 
                    List<User> allSupervisorForDept = udao.getAllUsersByDept(toChange.getDepartment());
                    ddlSup.Items.Add(new ListItem("--select--", "none"));
                    foreach (User u in allSupervisorForDept)
                    {
                        ddlSup.Items.Add(new ListItem(u.getName(), u.getName()));
                    }
                    foreach (ListItem li in ddlSup.Items)
                    {
                        string supid = toChange.getSupervisor();
                        User u = udao.getUserByID(supid);
                        if (u == null)
                        {
                            u = udao.getUserByID("admin");
                        }
                        if (li.Text.Equals(u.getName()))
                        {
                            ddlSup.SelectedValue = li.Text;
                        }
                    }
                    txtJobTitle.Text = toChange.getJobTitle();
                    txtEmail.Text = toChange.getEmail();
                    foreach (ListItem item in cblRoles.Items)
                    {
                        foreach (string s in roles)
                        {
                            if (item.Value.Equals(s))
                            {
                                item.Selected = true;
                            }
                        }
                    }
                }
            }
        }
        protected void submit_Click(object sender, EventArgs e)
        {
            if (Session["currentUser"] == null)
            {
                Response.Redirect("Login.aspx");
            }
            else
            {
                User u = (User)Session["currentUser"];
                //delete current entry and re-enter new details. 
                //delete from [User_roles] where userID
                UserDAO udao = new UserDAO();

                //delete from [User] where userID='eugene'

                //now create user again
                string user = txtUsername.Text;

                User getThis = udao.getUserByID(user);
                //need some fields like job category, who is the supervisor, job startdate
                //hash password here first 
                Boolean ans_roles = udao.delete_roles_of_user(getThis);
                if (!ans_roles)
                {
                    Response.Redirect("editUsers.aspx");
                }
                //create user object to parse into new_entry method
                //string pass = txtPassword.Text;
                string name = txtName.Text;
                string contact = txtContactNo.Text;
                string address = txtAddress.Text;
                string email = txtEmail.Text;
                string dept = lblDept.SelectedValue;
                string supervisor = null;
                string supid = null;
                if (ddlSup.SelectedValue != "none")
                {
                    supervisor = ddlSup.SelectedValue;
                    supid = udao.getUserByName(supervisor).getUserID();
                }
                string jobtitle = txtJobTitle.Text;
                ArrayList roles = new ArrayList();
                foreach (ListItem item in cblRoles.Items)
                {
                    if (item.Selected)
                        roles.Add(item.Value);
                }
                string salt = Crypto.GenerateSalt();// generate salt of user
                //string password_hashed = Crypto.SHA256(salt + pass);
                User create = new User(user, name, jobtitle, "Staff", supid, roles, dept.ToLower(), email, DateTime.Now, address, contact, getThis.getStatus());
                //Boolean done = udao.update_user(create, password_hashed, salt, roles);
                Boolean done = udao.update_user_without_password(create, roles);
                
                if (create.getUserID().Equals(u.getUserID()))
                {
                    Session["currentUser"] = create;
                }

                if (done)
                {
                    //set audit
                    User currentUser = (User)Session["currentUser"];
                    setAudit(currentUser, "user", "update", user, "user name: " + user);

                    Response.Redirect("manageUsers.aspx");
                }
                else
                {
                    Response.Redirect("editUsers.aspx");
                }
            }
        }
        protected void deactivate_Click(object sender, EventArgs e)
        {
            UserDAO udao = new UserDAO();
            string userID = Request.QueryString["userID"];
            Boolean suc = udao.update_status_deactivate(userID);
            if (suc)
            {
                //set audit
                User currentUser = (User)Session["currentUser"];
                setAudit(currentUser, "user", "deactivate", userID, "deactivated username: " + userID);

                Response.Redirect("editUsers.aspx?userID=" + userID);
            }
        }
        protected void activate_Click(object sender, EventArgs e)
        {
            UserDAO udao = new UserDAO();
            string userID = Request.QueryString["userID"];
            Boolean suc = udao.update_status_activate(userID);
            if (suc)
            {
                //set audit
                User currentUser = (User)Session["currentUser"];
                setAudit(currentUser, "user", "activate", userID, "activated username: " + userID);

                Response.Redirect("editUsers.aspx?userID=" + userID);
            }
        }
        protected void cv_checkEmailExist_ServerValidate(object source, ServerValidateEventArgs args)
        {
            UserDAO userDAO = new UserDAO();
            User checkUser = userDAO.getUserByEmail(txtEmail.Text);
            User toChange = userDAO.getUserByID((String)Request.QueryString["userID"]);
            System.Diagnostics.Debug.WriteLine("cv 1");
            if (checkUser != null && !txtEmail.Text.Equals(toChange.getEmail()))
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

        protected void lblDept_SelectedIndexChanged(object sender, EventArgs e)
        {
            string departmentName = lblDept.SelectedValue;
            UserDAO userDAO = new UserDAO();
            List<User> allSupervisorForDept = userDAO.getAllUsersByDept(departmentName);
            ddlSup.Items.Clear();
            ddlSup.Items.Add(new ListItem("--select--", "none"));
            foreach (User u in allSupervisorForDept)
            {
                ddlSup.Items.Add(new ListItem(u.getName(), u.getName()));
            }
        }
    }
}