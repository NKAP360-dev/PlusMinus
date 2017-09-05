using System;
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
        protected User toChange;
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
                    UserDAO udao = new UserDAO();
                    string userID = Request.QueryString["userID"];
                    if(userID == null || userID.Equals(""))
                    {
                        Response.Redirect("errorPage.aspx");
                    }
                    toChange = udao.getUserByID(userID);
                    ArrayList roles = udao.getRolesByID(userID);
                    txtUsername.Text = toChange.getUserID();
                    txtName.Text = toChange.getName();
                    txtAddress.Text = toChange.getAddress();
                    txtContactNo.Text = toChange.getContact();
                    txtDept.Text = toChange.getDepartment();
                    txtJobTitle.Text = toChange.getJobTitle();
                    txtEmail.Text = toChange.getEmail();
                    foreach (ListItem item in cblRoles.Items)
                    {
                        foreach(string s in roles)
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
                string pass = txtPassword.Text;
                string name = txtName.Text;
                string contact = txtContactNo.Text;
                string address = txtAddress.Text;
                string email = txtEmail.Text;
                string dept = txtDept.Text;
                string jobtitle = txtJobTitle.Text;
                ArrayList roles = new ArrayList();
                foreach (ListItem item in cblRoles.Items)
                {
                    if (item.Selected)
                        roles.Add(item.Value);
                }
                string salt = Crypto.GenerateSalt();// generate salt of user
                string password_hashed = Crypto.SHA256(salt + pass);
                User create = new User(user, name, jobtitle, "Staff", "S1234567C", roles, dept, email, DateTime.Now, address, contact, getThis.getStatus());
                Boolean done = udao.update_user(create, password_hashed, salt, roles);
                if (done)
                {
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
                Response.Redirect("editUsers.aspx?userID=" + userID);
            }
        }
    }   
}