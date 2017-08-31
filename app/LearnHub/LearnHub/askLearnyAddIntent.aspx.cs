using System;
using LearnHub.AppCode.entity;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Emma.DAO;
using Emma.Entity;

namespace LearnHub
{
    public partial class askLearnyAddIntent : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["currentUser"] != null)
            {
                User currentUser = (User)Session["currentUser"];

                if (!currentUser.getDepartment().Equals("hr"))
                {
                    Response.Redirect("errorPage.aspx");
                }
            }
            else
            {
                Response.Redirect("Login.aspx");
            }
        }

        protected void btnSubmitIntent_Click(object sender, EventArgs e)
        {
            //to do validation
            ChatBotIntentDAO cbiDAO = new ChatBotIntentDAO();
            cbiDAO.addIntent(txtIntentInput.Text);
            Response.Redirect("askLearnyAddIntent.aspx");
        }
    }
}