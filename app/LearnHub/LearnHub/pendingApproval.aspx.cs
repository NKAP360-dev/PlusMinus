using LearnHub.AppCode.entity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LearnHub
{
    public partial class pendingApproval : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["currentUser"] == null)
            {
                Response.Redirect("Login.aspx");
                
            } else
            {
                
            }
        }
        protected void lbtnMoreInfo_Click(object sender, EventArgs e)
        {
            //Session["selectedTNFFromNoti"] = tnfID.Value;
            //Session["selectedUserFromNoti"] = userID.Value;
            //Response.Redirect("/TRFApproval.aspx");
        }
    }
}