using System;
using LearnHub.AppCode.entity;
using Emma.DAO;
using Emma.Entity;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LearnHub
{
    public partial class askLearnyHelpQn : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["currentUser"] != null)
            {
                User currentUser = (User)Session["currentUser"];

                Boolean superuser = false;
                foreach (String s in currentUser.getRoles())
                {
                    if (s.Equals("superuser"))
                    {
                        superuser = true;
                    }
                }
                if (!currentUser.getDepartment().Equals("hr"))
                {
                    if (!superuser)
                    {
                        Response.Redirect("errorPage.aspx");
                    }
                }
            }
            else
            {
                Response.Redirect("Login.aspx");
            }
        }

        protected void btnConfirmSubmit_Click(object sender, EventArgs e)
        {
            //To do validations
            ChatBotHelpQuestionDAO cbhqDAO = new ChatBotHelpQuestionDAO();
            cbhqDAO.insertQuestion(txtHelpInput.Text);
            Response.Redirect("askLearnyHelpQn.aspx");
        }
    }
    
}