using LearnHub.AppCode.dao;
using LearnHub.AppCode.entity;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LearnHub
{
    public partial class editAboutUs : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            User currentUser = (User)Session["currentUser"];
            if (currentUser != null)
            {
                Boolean authenticate = authenticateAccess(currentUser);

                if (!authenticate) 
                {
                    Response.Redirect("errorPage.aspx");
                }
                else
                {
                    if (!IsPostBack)
                    {
                        AboutUsDAO aDAO = new AboutUsDAO();
                        string message = aDAO.getAboutUs();
                        CKEditor1.Text = message;
                    }
                }
            }
            else
            {
                Response.Redirect("login.aspx");
            }
        }

        protected void cfmSubmit_Click(object sender, EventArgs e)
        {
            AboutUsDAO aDAO = new AboutUsDAO();
            aDAO.updateAboutUs(CKEditor1.Text);

            //set audit
            User currentUser = (User)Session["currentUser"];
            setAudit(currentUser, "about us", "update", null, "updated about us");

            Response.Redirect("aboutUs.aspx");
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
        protected Boolean authenticateAccess(User currentUser)
        {
            Boolean toReturn = false;
            ArrayList roles = currentUser.getRoles();
            if (roles.Contains("superuser") || roles.Contains("content creator"))
            {
                toReturn = true;
            }
            return toReturn;
        }
    }
}