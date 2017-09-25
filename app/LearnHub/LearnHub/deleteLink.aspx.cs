using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using LearnHub.AppCode.dao;
using LearnHub.AppCode.entity;

namespace LearnHub
{
    public partial class WebForm7 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            User currentUser = (User)Session["currentUser"];
            if (currentUser == null)
            {
                Response.Redirect("Login.aspx");
            }
            Boolean super = false;
            //Boolean hr = false;
            foreach(string role in currentUser.getRoles())
            {
                if (role.Equals("superuser"))
                {
                    super = true;
                }
            }
            if (Request.QueryString["id"] != null && super)
            {
                //TestimonialDAO tdao = new TestimonialDAO();
                string id = Request.QueryString["id"];
                int id_num = Convert.ToInt32(id);
                LinkDAO adao = new LinkDAO();
                adao.deactivateArticle(id_num);
                Response.Redirect("manageUsefulLinks.aspx");
            }
            else
            {
                Response.Redirect("errorPage.aspx");
            }
        }
    }
}