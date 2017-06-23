using LearnHub.AppCode.dao;
using LearnHub.AppCode.entity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Helpers;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LearnHub
{
    public partial class LoginDefault : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["currentUser"] != null)
            {
                Session["currentUser"] = null;
            }
        }
        protected void btnLogin_Click(object sender, EventArgs e)
        {
            
           
            if (txtUsername.Text != "" && txtPassword.Text != "")
            {
                LoginDAO loginDAO = new LoginDAO();
                var userSalt = loginDAO.getSalt(txtUsername.Text);
                var hashedPasword = Crypto.SHA256(userSalt + txtPassword.Text);
                User currentUser = loginDAO.login(txtUsername.Text, hashedPasword);
                if (currentUser.getUserID() == null)
                {
                    //Response.Redirect("Login.aspx");
                    lblErrorMsgUse.Visible = true;
                    lblErrorMsgUse.Text = "Invalid username/password.";
                } else
                {
                    Session["currentUser"] = currentUser;
                    //to redirect
                    Response.Redirect("Home.aspx");
                }
            }
            else if(txtUsername.Text != "" || txtPassword.Text != "")
            {
                //Response.Redirect("google.com");
                lblErrorMsgUse.Visible = true;
                lblErrorMsgUse.Text = "Invalid username/password.";
            }
            else
            {
                ///Response.Redirect("yahoo.com");
                lblErrorMsgUse.Visible = true;
                lblErrorMsgUse.Text = "Invalid username/password.";
            }
        }
    }
}