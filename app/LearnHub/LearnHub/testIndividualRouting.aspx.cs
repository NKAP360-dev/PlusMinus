using LearnHub.AppCode.dao;
using LearnHub.AppCode.entity;
using LearnHub.AppCode.workflow;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LearnHub
{
    public partial class testIndividualRouting : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            lblNoti.Visible = false;
            GridView1.Visible = false;
            btnApprover.Visible = false;
            lblBond.Visible = false;
            GridView3.Visible = false;

            if (GridView1.Rows.Count > 0)
            {
                lblNoti.Visible = true;
                GridView1.Visible = true;
                btnApprover.Visible = true;
            }
            if (GridView3.Rows.Count > 0)
            {
                lblBond.Visible = true;
                GridView3.Visible = true;
            }
        }

        protected void btnTNF_Click(object sender, EventArgs e)
        {
            TNFDAO tnfDAO = new TNFDAO();
            TNF tnf = tnfDAO.getIndividualTNFByID(GridView2.SelectedRow.Cells[2].Text, int.Parse(GridView2.SelectedRow.Cells[1].Text));
            Workflow_Route.routeForApproval(tnf);
            Response.Redirect("testIndividualRouting.aspx");
        }

        protected void btnApprover_Click(object sender, EventArgs e)
        {
            TNFDAO tnfDAO = new TNFDAO();
            UserDAO userDAO = new UserDAO();
            NotificationDAO notificationDAO = new NotificationDAO();
            
            TNF tnf = tnfDAO.getIndividualTNFByID(GridView1.SelectedRow.Cells[1].Text, int.Parse(GridView1.SelectedRow.Cells[3].Text));
            User currentUser = userDAO.getUserByID(GridView1.SelectedRow.Cells[2].Text);
            Notification selectedNotification = notificationDAO.getNotificationByID(int.Parse(GridView1.SelectedRow.Cells[7].Text));

            Workflow_Approve.makeApproval(tnf, currentUser, selectedNotification);
            Response.Redirect("testIndividualRouting.aspx");
        }
    }
}