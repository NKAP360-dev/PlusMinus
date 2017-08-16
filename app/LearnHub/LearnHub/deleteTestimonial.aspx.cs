using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using LearnHub.AppCode.dao;
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
                Response.Redirect("viewModuleInfo.aspx?id=" + course_id);
            }
            else
            {
                return;
            }
        }
    }
}