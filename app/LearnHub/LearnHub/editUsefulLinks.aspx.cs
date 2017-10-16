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
            Boolean cc = false;
            foreach (string role in currentUser.getRoles())
            {
                if (role.Equals("superuser"))
                {
                    super = true;
                }
                if (role.Equals("content creator")) 
                {
                    cc = true;
                }
            }
            if (!cc)
            {
                if (!super)
                {
                    Response.Redirect("errorPage.aspx");
                }
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

            //set audit
            User currentUser = (User)Session["currentUser"];
            setAudit(currentUser, "useful links", "update", id, "updated link: " + link);

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
        protected void checkForm(object sender, EventArgs e)
        {
            Page.Validate("ValidateForm");
            System.Diagnostics.Debug.WriteLine("checkForm");
            if (!Page.IsValid)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openModal();", true);
                lblErrorMsgFinal.Text = "You have not filled up all of the required fields";
                btnConfirmSubmit.Enabled = false;
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openModal();", true);
                lblErrorMsgFinal.Text = "";
                btnConfirmSubmit.Enabled = true;
            }
        }
    }
}