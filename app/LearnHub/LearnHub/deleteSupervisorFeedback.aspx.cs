using LearnHub.AppCode.dao;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LearnHub
{
    public partial class deleteSupervisorFeedback : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            int id = Convert.ToInt32(Request.QueryString["id"]);
            string ud = (String)Request.QueryString["ud"];
            SupervisorFeedbackDAO sfDAO = new SupervisorFeedbackDAO();
            sfDAO.deleteFeedbackByID(id);
            Response.Redirect("progressReports.aspx?id=" + ud);
        }
    }
}