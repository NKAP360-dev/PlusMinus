using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Emma.DAO;
using Emma.Entity;
using LearnHub.AppCode.entity;

namespace LearnHub
{
    public partial class askEmmaEditIntent : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["currentUser"] == null)
            {
                Response.Redirect("Login.aspx");
            }
            else
            {
                if (!IsPostBack)
                {
                    User currentUser = (User)Session["currentUser"];

                    if (!currentUser.getDepartment().Equals("hr"))
                    {
                        Response.Redirect("errorPage.aspx");
                    }
                    else
                    {
                        ChatBotIntentDAO cbiDAO = new ChatBotIntentDAO();
                        ChatBotIntent currentCBI = cbiDAO.getChatBotIntentByID(Convert.ToInt32(Request.QueryString["id"]));
                        txtIntentInput.Text = currentCBI.intent;
                    }
                }
            }
        }

        protected void cfmSubmit_Click(object sender, EventArgs e)
        {
            //To do validations

            ChatBotIntentDAO cbiDAO = new ChatBotIntentDAO();
            ChatBotIntent currentCBI = cbiDAO.getChatBotIntentByID(Convert.ToInt32(Request.QueryString["id"]));
            cbiDAO.updateChatBotIntent(txtIntentInput.Text, currentCBI.intentID);
            Response.Redirect("askEmmaAddIntent.aspx");
        }

        protected void btnCfmDelete_Click(object sender, EventArgs e)
        {
            //To do validations

            ChatBotIntentDAO cbiDAO = new ChatBotIntentDAO();
            ChatBotIntent currentCBI = cbiDAO.getChatBotIntentByID(Convert.ToInt32(Request.QueryString["id"]));
            cbiDAO.deleteAnswersByIntent(currentCBI.intentID);
            cbiDAO.deleteIntentByID(currentCBI.intentID);
            Response.Redirect("askEmmaAddIntent.aspx");
        }
    }
}