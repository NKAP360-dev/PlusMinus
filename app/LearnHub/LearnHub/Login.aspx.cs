﻿using LearnHub.AppCode.dao;
using LearnHub.AppCode.entity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LearnHub
{
    public partial class LoginDefault : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void btnLogin_Click(object sender, EventArgs e)
        {
            if (txtUsername.Text == "")
            {
                lblErrorMsgUse.Visible = true;
                lblErrorMsgUse.Text = "Please enter your username";
            }
            if (txtPassword.Text == "")
            {
                lblErrorMsgPass.Visible = true;
                lblErrorMsgPass.Text = "Please enter your password";
            }

            if (txtUsername.Text != "" && txtPassword.Text != "")
            {
                LoginDAO loginDAO = new LoginDAO();
                User currentUser = loginDAO.login(txtUsername.Text, txtPassword.Text);
                if (currentUser.getUserID() == null)
                {
                    lblErrorMsgUse.Visible = true;
                    lblErrorMsgUse.Text = "Invalid username/password.";
                } else
                {
                    Session["currentUser"] = currentUser;
                    //to redirect
                    Response.Redirect("Home.aspx");
                }
            }
        }
    }
}