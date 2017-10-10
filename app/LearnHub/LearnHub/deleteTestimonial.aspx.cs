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
    public partial class WebForm4 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.QueryString["id"] != null && Request.QueryString["cid"] != null)
            {
                TestimonialDAO tdao = new TestimonialDAO();
                string id = Request.QueryString["id"];
                string cid = Request.QueryString["cid"];
                int tid = Convert.ToInt32(id);
                int course_id = Convert.ToInt32(cid);
                Boolean check = tdao.delete_testimonial(tid, course_id);

                //set audit
                User currentUser = (User)Session["currentUser"];
                string title = tdao.getTestimonialTitleByID(tid);
                setAudit(currentUser, "course", "update", cid, "deleted testimonial title: " + title);

                Response.Redirect("viewModuleInfo.aspx?id=" + course_id);
            }
            else
            {
                return;
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