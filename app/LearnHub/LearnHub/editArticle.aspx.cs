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
    public partial class editArticle : System.Web.UI.Page
    {
        private Article a;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["currentUser"] == null)
            {
                Response.Redirect("Login.aspx");
            }
            else
            {
                User currentUser = (User)Session["currentUser"];
                Boolean authenticate = authenticateAccess(currentUser);
                if (!authenticate)
                {
                    Response.Redirect("errorPage.aspx");
                }
                else
                {
                    if (!IsPostBack)
                    {
                        string id = Request.QueryString["id"];
                        int id_num = Convert.ToInt32(id);
                        ArticleDAO adao = new ArticleDAO();
                        a = adao.getArticleById(id_num);
                        txtTitle.Text = a.article_name;
                        CKEditor1.Text = a.article_body;
                    }
                }
            }
        }
        protected void btnEdit_Click(object sender, EventArgs e)
        {
            ArticleDAO adao = new ArticleDAO();
            string article_name = txtTitle.Text;
            string article_body = CKEditor1.Text;
            string id = Request.QueryString["id"];
            int id_num = Convert.ToInt32(id);
            Article article = adao.getArticleById(id_num); 
            int id_edit = article.article_id;
            DateTime start = article.upload_datetime;
            User u = article.user;
            string status = article.status;
            Article toChange = new Article(id_edit, article_name, article_body, u, start, status);
            adao.updateArticle(toChange);

            //set audit
            User currentUser = (User)Session["currentUser"];
            setAudit(currentUser, "articles", "update", id_num.ToString(), "updated article title: " + article_name);

            Response.Redirect("manageArticles.aspx");
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