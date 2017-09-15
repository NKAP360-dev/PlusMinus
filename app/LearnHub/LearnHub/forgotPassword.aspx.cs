using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LearnHub
{
    public partial class forgotPassword : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnRequest_Click(object sender, EventArgs e)
        {
            panelUpdate.Visible = false;
            panelMsg.Visible = true;
        }
        protected void btnReceive_Click (object sender, EventArgs e)
        {
            panelReset.Visible = true;
            panelMsg.Visible = false;
        }
    }
}