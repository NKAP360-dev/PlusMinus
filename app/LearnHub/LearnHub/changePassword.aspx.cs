using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using LearnHub.AppCode.dao;
using LearnHub.AppCode.entity;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.Helpers;

namespace LearnHub
{
    public partial class changePassword : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void submit_new_password(object sender, EventArgs e)
        {
            UserDAO udao = new UserDAO();
            User currentUser = (User)Session["currentUser"];
            LoginDAO loginDAO = new LoginDAO();
            string userSalt = loginDAO.getSalt(currentUser.getUserID());
            string db_password_hashed = udao.getPassword(currentUser.getUserID());
            string hashedPassword = Crypto.SHA256(userSalt + txtPassword_now.Text);
            if (hashedPassword.Equals(db_password_hashed))
            {
                string pw = txtPassword_new.Text;
                string compare = txtPassword_newConfirm.Text;
                if (pw.Equals(compare))
                {
                    string new_hashedPassword = Crypto.SHA256(userSalt + compare);
                    Boolean isit = udao.updatePassword(new_hashedPassword, currentUser);
                    if (isit)
                    {
                        Response.Redirect("accountSetting.aspx");
                    }
                    else
                    {
                        Response.Redirect("Home.aspx");
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
    }
}