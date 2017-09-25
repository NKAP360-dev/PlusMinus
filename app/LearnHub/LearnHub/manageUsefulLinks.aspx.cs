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
    public partial class manageUsefulLinks : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            User currentUser = (User)Session["currentUser"];
            if(currentUser == null)
            {
                Response.Redirect("login.aspx");
            }
            Boolean super = false;
            foreach (string role in currentUser.getRoles())
            {
                if (role.Equals("superuser"))
                {
                    super = true;
                }
            }
            if (!super)
            {
                Response.Redirect("errorPage.aspx");
            }
        }
        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            User currentUser = (User)Session["currentUser"];
            string link = txtLink.Text;
            string desc = txtDesc.Text;
            Link createThis = new Link(link, desc, currentUser, DateTime.Now, "Active");
            LinkDAO linkdao = new LinkDAO();
            int succ = linkdao.createLink(createThis);
            if (succ > 0)
            {
                Response.Redirect("manageUsefulLinks.aspx");
            }
            else
            {
                Response.Redirect("errorPage.aspx");
            }

        }
    }
}