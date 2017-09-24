using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LearnHub
{
    public partial class article : System.Web.UI.Page
    {
        protected int id_num;
        protected void Page_Load(object sender, EventArgs e)
        {
            string id = Request.QueryString["id"];
            id_num = Convert.ToInt32(id);
        }
    }
}