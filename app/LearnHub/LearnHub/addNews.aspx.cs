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
    public partial class addNews : System.Web.UI.Page
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
        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            string title = txtTitle.Text;
            string desc = txtDesc.Text;
            string type = ddlType.SelectedValue;
            string total = descriptionModuleInput.Text;
            if (FileUpload1.HasFile)
            {
                string fileName = FileUpload1.FileName;
                string filepath = "img/highlights" + "/";
                string FileExtension = fileName.Substring(fileName.LastIndexOf('.') + 1).ToLower();
                if (FileExtension.Equals("jpeg") || FileExtension.Equals("png") || FileExtension.Equals("jpg"))
                {
                    FileUpload1.PostedFile
                    .SaveAs(Server.MapPath(filepath) + fileName);
                    string totalpath1 = Server.MapPath(filepath) + fileName;
                    News_highlights n = new News_highlights();
                    n.title = title;
                    n.status = "Active";
                    n.entry_time = DateTime.Now;
                    n.type = type;
                    n.body = desc;
                    n.news_text = total;
                    n.img_path = totalpath1;
                    n.user = (User)Session["currentUser"];
                    n.type = type;
                    News_highlightsDAO ndao = new News_highlightsDAO();
                    int id = ndao.createNewsHighlight(n);

                    //set audit
                    User currentUser = (User)Session["currentUser"];
                    setAudit(currentUser, "news", "create", id.ToString(), "created news title: " + title);

                    Response.Redirect("home.aspx");
                }
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
        protected void checkForm(object sender, EventArgs e)
        {
            if (Session["FileUpload1"] == null && FileUpload1.HasFile)
            {
                Session["FileUpload1"] = FileUpload1;
                System.Diagnostics.Debug.WriteLine("scenario 1");
            }
            else if (Session["FileUpload1"] != null && (!FileUpload1.HasFile))
            {
                FileUpload1 = (FileUpload)Session["FileUpload1"];
                System.Diagnostics.Debug.WriteLine("scenario 2");
            }
            else if (FileUpload1.HasFile)
            {
                Session["FileUpload1"] = FileUpload1;
                System.Diagnostics.Debug.WriteLine("scenario 3");

            }
            System.Diagnostics.Debug.WriteLine(((FileUpload)Session["FileUpload1"]).FileName);
            Page.Validate("ValidateForm");
            System.Diagnostics.Debug.WriteLine("checkForm");
            if (!Page.IsValid)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openModal();", true);
                //lblErrorMsgFinal.Text = "You have not filled up all of the required fields";
                cfmSubmit.Enabled = false;
            }
            else
            {
                
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openModal();", true);
                //lblErrorMsgFinal.Text = "";
                cfmSubmit.Enabled = true;
            }
        }
    }
}