using System;
using LearnHub.AppCode.dao;
using LearnHub.AppCode.entity;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LearnHub
{
    public partial class TRFapproval : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["currentUser"] == null)
            {
                Response.Redirect("/Login.aspx");
            }
            else
            {
                //string tnfid = Request.QueryString["tnfid"];
                string tnfid = Request["tnfID"];
                nameOfStaffOutput.Text = tnfid;

                User currentUser = (User)Session["currentUser"];

                //all HR will view HR approval section
                if (currentUser.getDepartment().Equals("hr"))
                {
                    hrApprovalView.Visible = true;

                    //if HR and also an approver, both section will be seen
                    if (!currentUser.getJobCategory().Equals("hr")) {
                        normalApprovalView.Visible = true;
                    }             
                }else{
                    normalApprovalView.Visible = true;
                }

            }
        }
    }
}