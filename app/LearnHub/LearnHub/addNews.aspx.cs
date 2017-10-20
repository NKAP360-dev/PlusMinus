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
                    int done = ndao.createNewsHighlight(n);
                    if (done > 0)
                    {
                        Response.Redirect("home.aspx");
                    }
                    else
                    {
                        Response.Redirect("manageNews.aspx");
                    }
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
    }
}