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
            lblErrorMsg.Visible = false;
            lblPasswordSaved.Visible = false;
        }
        protected void submit_new_password(object sender, EventArgs e)
        {
            Page.Validate("ValidateForm");
            if (!Page.IsValid)
            {

            }
            else
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
                            lblErrorMsg.Visible = false;
                            lblPasswordSaved.Visible = true;
                        }
                        else
                        {
                            lblErrorMsg.Visible = true;
                            lblErrorMsg.Text = "An error occurred while saving";
                        }
                    }
                    else
                    {
                        lblErrorMsg.Visible = true;
                        lblErrorMsg.Text = "Passwords do not match";
                    }
                }
                else
                {
                    Response.Redirect("login.aspx");
                }
            }
        }

        protected void ValidateCurrPass(object sender, ServerValidateEventArgs args)
        {
            String input = txtPassword_now.Text;
            UserDAO userdao = new UserDAO();
            User user = (User)Session["currentUser"];
            String currentPass = userdao.getPassword(user.getUserID());
            LoginDAO loginDAO = new LoginDAO();
            var userSalt = loginDAO.getSalt(user.getUserID());
            var hashedPasword = Crypto.SHA256(userSalt + input);
            User currentUser = loginDAO.login(user.getUserID(), hashedPasword);
            if (currentUser.getUserID() == null)
            {
                System.Diagnostics.Debug.WriteLine("args false");
                args.IsValid = false;
            }
            else
            {
                System.Diagnostics.Debug.WriteLine("args true");
                args.IsValid = true;
            }
        }
        protected void ValidateSamePass(object sender, ServerValidateEventArgs args)
        {
            String input = txtPassword_new.Text;
            UserDAO userdao = new UserDAO();
            User user = (User)Session["currentUser"];
            String currentPass = userdao.getPassword(user.getUserID());
            LoginDAO loginDAO = new LoginDAO();
            var userSalt = loginDAO.getSalt(user.getUserID());
            var hashedPasword = Crypto.SHA256(userSalt + input);
            User currentUser = loginDAO.login(user.getUserID(), hashedPasword);
            if (currentUser.getUserID() != null)
            {
                System.Diagnostics.Debug.WriteLine("args false");
                args.IsValid = false;
            }
            else
            {
                System.Diagnostics.Debug.WriteLine("args true");
                args.IsValid = true;
            }
        }

        protected void ValidateMatchPass(object sender, ServerValidateEventArgs args)
        {
            String first = txtPassword_new.Text;
            String second = txtPassword_newConfirm.Text;
            if (first.Equals(second))
            {
                System.Diagnostics.Debug.WriteLine("args true");
                args.IsValid = true;
            }
            else
            {
                
                System.Diagnostics.Debug.WriteLine("args false");
                args.IsValid = false;

            }
        }
    }
}