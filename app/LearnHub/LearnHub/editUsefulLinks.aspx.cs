using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Collections;
using LearnHub.AppCode.dao;
using LearnHub.AppCode.entity;

namespace LearnHub
{
    public partial class editUsefulLinks : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            User currentUser = (User)Session["currentUser"];
            if (currentUser == null)
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
            if (!IsPostBack)
            {
                string id = Request.QueryString["id"];
                int id_num = Convert.ToInt32(id);
                LinkDAO adao = new LinkDAO();
                Link a = adao.getLinksById(id_num);
                txtLink.Text = a.link_path;
                txtDesc.Text = a.description;
            }
        }
        protected void btnSave_Click(object sender, EventArgs e)
        {
            LinkDAO ldao = new LinkDAO();
            string link = txtLink.Text;
            string desc = txtDesc.Text;
            string id = Request.QueryString["id"];
            int id_num = Convert.ToInt32(id);
            Link article = ldao.getLinksById(id_num);
            int id_edit = article.link_id;
            DateTime start = article.upload_datetime;
            User u = article.user;
            string status = article.status;
            Link toChange = new Link(id_edit, link, desc, u, start, status);
            ldao.updateLink(toChange);
            Response.Redirect("manageUsefulLinks.aspx");
        }
    }
}