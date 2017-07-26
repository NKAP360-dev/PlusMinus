using System;
using LearnHub.AppCode.entity;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LearnHub
{
    public partial class askEmmaAddIntent : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["currentUser"] != null)
            {
                User currentUser = (User)Session["currentUser"];

                if (!currentUser.getDepartment().Equals("hr"))
                {
                    Response.Redirect("errorPage.aspx");
                }
            }
            else
            {
                Response.Redirect("Login.aspx");
            }
        }
    
    }
}