using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;

namespace LearnHub
{
    public partial class WebForm5 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.QueryString["id"] != null && Request.QueryString["path"] != null)
            {
                //TestimonialDAO tdao = new TestimonialDAO();
                string id = Request.QueryString["id"];
                string fullPath = Request.QueryString["path"];
                int id_num = Convert.ToInt32(id);
                if (!System.IO.File.Exists(fullPath))
                {
                    Response.Redirect("Home.aspx");
                }
                else
                {
                    System.IO.File.Delete(fullPath);
                }
               
                Response.Redirect("viewModuleInfo.aspx?id=" + id_num);
            }
        }
    }
}