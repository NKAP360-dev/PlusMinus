using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using LearnHub.AppCode.entity;
using LearnHub.AppCode.dao;

namespace LearnHub
{
    public partial class WebForm13 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.QueryString["id"] != null && Request.QueryString["path"] != null && Request.QueryString["video_link"] != null)
            {
                //TestimonialDAO tdao = new TestimonialDAO();
                string id = Request.QueryString["id"];
                string fullPath = Request.QueryString["path"];
                string link = Request.QueryString["video_link"];
                int id_num = Convert.ToInt32(id);
                if (!System.IO.File.Exists(fullPath))
                {
                    Response.Redirect("Home.aspx");
                }
                else
                {
                    System.IO.File.Delete(fullPath);
                    Course_elearnDAO cdao = new Course_elearnDAO();
                    cdao.delete_both(id_num, fullPath, link);
                    //cdao.delete_link(id_num, link);
                    //set audit
                    User currentUser = (User)Session["currentUser"];
                    string filename = Path.GetFileName(fullPath);
                    setAudit(currentUser, "course", "update", id, "deleted material link: " + filename);
                }

                Response.Redirect("viewModuleInfo.aspx?id=" + id_num);
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