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
    public partial class manageNewsBanners : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            User currentUser = (User)Session["currentUser"];
        }
        protected void btnSave_Click(object sender, EventArgs e)
        {
            NewsDAO ndao = new NewsDAO();
            int counter = 0;
            int[] messageIDs = (from p in Request.Form["banner_id"].Split(',')
                                select int.Parse(p)).ToArray();
            foreach (int messageID in messageIDs)
            {
                ndao.updateNewsLevel(messageID, counter);
                counter++;
            }

            //set audit
            User currentUser = (User)Session["currentUser"];
            setAudit(currentUser, "Manage News Banners", "update", null, "Reorder message order");
            Response.Redirect("manageNewsBanners.aspx");
        }
        protected void btnUpload_Click(object sender, EventArgs e)
        {
            string name = txtName.Text;
            string link = txtLink.Text;
            if (FileUpload1.HasFile)
            {
                string fileName = FileUpload1.FileName;
                string filepath = "img/banner" + "/";
                string FileExtension = fileName.Substring(fileName.LastIndexOf('.') + 1).ToLower();
                if (FileExtension.Equals("jpeg") || FileExtension.Equals("png") || FileExtension.Equals("jpg"))
                {
                    FileUpload1.PostedFile
                    .SaveAs(Server.MapPath(filepath) + fileName);
                    string totalpath1 = Server.MapPath(filepath) + fileName;
                    News news = new News();
                    news.banner_link = link;
                    news.banner_name = name;
                    news.entry_time = DateTime.Now;
                    news.status = "Active";
                    news.user = (User)Session["currentUser"];
                    news.img_path = totalpath1;
                    NewsDAO ndao = new NewsDAO();
                    int done = ndao.createNewsBanner(news);
                    if (done > 0)
                    {
                        Response.Redirect("home.aspx");
                    }
                    else
                    {
                        Response.Redirect("manageNewsBanners.aspx");
                    }
                }
            }
            else
            {
                Response.Redirect("manageNewsBanners.aspx");
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