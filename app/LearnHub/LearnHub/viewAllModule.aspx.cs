using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LearnHub
{
    public partial class viewAllModule : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string courseType = null;
            if (Request.QueryString["module"] != null)
            {
                courseType = Request.QueryString["module"];

                if (courseType.Equals("compulsory")) {
                    viewCompulsory.Visible = true;
                    viewLeadership.Visible = false;
                    viewProfessional.Visible = false;
                }
                else if (courseType.Equals("leadership"))
                {
                    viewLeadership.Visible = true;
                    viewCompulsory.Visible = false;
                    viewProfessional.Visible = false;
                }
                else if (courseType.Equals("professional"))
                {
                    viewProfessional.Visible = true;
                    viewLeadership.Visible = false;
                    viewCompulsory.Visible = false;
                }
            }
            else
            {
                return;
            }
        }
    }
}