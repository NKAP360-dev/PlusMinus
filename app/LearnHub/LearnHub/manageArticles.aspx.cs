using LearnHub.AppCode.entity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LearnHub
{
    public partial class manageArticles : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            User currentUser = (User)Session["currentUser"];
            if (currentUser == null)
            {
                Response.Redirect("Login.aspx");
            }
            else
            {
                Boolean superuser = false;
                Boolean content_creator = false;
                foreach (string s in currentUser.getRoles())
                {
                    if (s.Equals("superuser"))
                    {
                        superuser = true;
                    }
                    else if (s.Equals("content creator"))
                    {
                        content_creator = true;
                    }
                }
                if (superuser || content_creator)
                {

                }
                else
                {
                    Response.Redirect("errorPage.aspx");
                }
            }
        }
        protected void deactivate_Click(object sender, EventArgs e)
        {

        }
    }
}