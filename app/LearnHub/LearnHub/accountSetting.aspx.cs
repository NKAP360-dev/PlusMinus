using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using LearnHub.AppCode.dao;
using LearnHub.AppCode.entity;

namespace LearnHub
{
    public partial class accountSetting : System.Web.UI.Page
    {
        protected User currentUser;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                currentUser = (User)Session["currentUser"];
                txtContactNo.Text = currentUser.getContact();
                txtAddress.Text = currentUser.getAddress();
            }
            

        }
        protected void updateInfo_Click(object sender, EventArgs e)
        {
            Page.Validate("ValidateForm");
            if (!Page.IsValid)
            {

            }
            else
            {
                UserDAO udao = new UserDAO();
                currentUser = (User)Session["currentUser"];
                User user = udao.updateInfo(txtContactNo.Text, txtAddress.Text, currentUser);
                Session["currentUser"] = user;
                Response.Redirect("Home.aspx");
            }
        }
    }
}