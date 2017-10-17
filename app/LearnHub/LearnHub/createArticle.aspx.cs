using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using LearnHub.AppCode.dao;
using LearnHub.AppCode.entity;
using System.Collections;

namespace LearnHub
{
    public partial class createArticle : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["currentUser"] == null)
            {
                Response.Redirect("login.aspx");
            }
            else
            {
                User currentUser = (User)Session["currentUser"];
                Boolean authenticate = authenticateAccess(currentUser);
                if (!authenticate)
                {
                    Response.Redirect("errorPage.aspx");
                }
            }
        }
        protected void cfmSubmit_Click(object sender, EventArgs e)
        {
            ArticleDAO adao = new ArticleDAO();
            string title = txtTitle.Text;
            string body = CKEditor1.Text;
            User upload = (User)Session["currentUser"];
            DateTime time = DateTime.Now;
            Article a = new Article(title, body, upload, time, "Active");
            int articleID = adao.createArticle(a);

            //set audit
            setAudit(upload, "articles", "create", articleID.ToString(), "created article title: " + title);

            Response.Redirect("manageArticles.aspx");
            
        }
        protected void checkForm(object sender, EventArgs e)
        {
            Page.Validate("ValidateForm");
            System.Diagnostics.Debug.WriteLine("checkForm");
            if (!Page.IsValid)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openModal();", true);
                lblErrorMsgFinal.Text = "You have not filled up all of the required fields";
                cfmSubmit.Enabled = false;
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openModal();", true);
                lblErrorMsgFinal.Text = "";
                cfmSubmit.Enabled = true;
            }
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