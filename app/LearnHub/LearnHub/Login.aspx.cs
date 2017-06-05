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
                panelAlert.Visible = true;
                lblErrorMsg.Text = "Please enter your username";
            }
            if(txtPassword.Text == "")
            {
                panelAlert.Visible = true;
                lblErrorMsg.Text = "Please enter your password";
            }
        }
    }
}