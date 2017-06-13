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

        }

        protected void btnTNF_Click(object sender, EventArgs e)
        {
            TNFDAO tnfDAO = new TNFDAO();
            TNF tnf = tnfDAO.getIndividualTNFByID(txtTNFUser.Text, int.Parse(txtTNF.Text));
            Workflow_Route.routeForApproval(tnf);
            Response.Redirect("testIndividualRouting.aspx");
        }

        protected void btnApprover_Click(object sender, EventArgs e)
        {
            TNFDAO tnfDAO = new TNFDAO();
            UserDAO userDAO = new UserDAO();
            NotificationDAO notificationDAO = new NotificationDAO();

            TNF tnf = tnfDAO.getIndividualTNFByID(txtTNFUser.Text, int.Parse(txtTNF.Text));
            User currentUser = userDAO.getUserByID(txtApprover.Text);
            Notification selectedNotification = notificationDAO.getNotificationByID(int.Parse(GridView1.SelectedRow.Cells[5].Text));

            Workflow_Approve.makeApproval(tnf, currentUser, selectedNotification);
            Response.Redirect("testIndividualRouting.aspx");
        }
    }
}