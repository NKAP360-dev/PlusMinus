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
            Link createThis = new Link("http://"+link, desc, currentUser, DateTime.Now, "Active");
            LinkDAO linkdao = new LinkDAO();
            int linkID = linkdao.createLink(createThis);
            //set audit
            setAudit(currentUser, "useful links", "create", linkID.ToString(), "link: " + link);

            Response.Redirect("manageUsefulLinks.aspx");

        }
        protected void setAudit(User u, string functionModified, string operation, string id_of_function, string remarks)
        {
            //set audit
            Audit a = new Audit();
            AuditDAO aDAO = new AuditDAO();
            a.userID = u.getUserID();
            a.functionModified = functionModified;
            a.operation = operation;
            a.id_of_function = id_of_function;
            a.dateModified = DateTime.Now;
            a.remarks = remarks;
            aDAO.createAudit(a);
        }
    }
}