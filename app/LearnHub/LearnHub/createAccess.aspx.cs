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
            
        }
        protected void submit_Click(object sender, EventArgs e)
        {
            string user = txtUsername.Text;
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
            //need some fields like job category, who is the supervisor, job startdate
            //hash password here first 
            LoginDAO ldao = new LoginDAO();
            string salt = Crypto.GenerateSalt();// generate salt of user
            string password_hashed = Crypto.SHA256(salt + pass);
            //password hashed now create user 
            User u = new User(user, name, jobtitle, "Staff", "S1234567C", roles, dept, email, DateTime.Now, address, contact);
            UserDAO udao = new UserDAO();
            Boolean res = udao.create_user_elearn(u, password_hashed, salt);
            Boolean res_role = udao.add_role(u, roles);
            if (res)
            {
                Response.Redirect("Home.aspx");
            }
            else
            {
                Response.Redirect("Login.aspx");
            }
        }

    }
}