using Emma.DAO;
using Emma.Entity;
using LearnHub.AppCode.entity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LearnHub
{
    public partial class askEmmEditHelp : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["currentUser"] == null)
            {
                Response.Redirect("/Login.aspx");
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
                        ChatBotHelpQuestionDAO cbhqDAO = new ChatBotHelpQuestionDAO();
                        ChatBotHelpQuestion currentQuestion = cbhqDAO.getChatBotHelpQuestionByID(Convert.ToInt32(Request.QueryString["id"]));
                        if (currentQuestion.question != null)
                        {
                            txtHelpInput.Text = currentQuestion.question;
                        }
                        else
                        {
                            Response.Redirect("errorPage.aspx");
                        }
                    }
                }
            }
        }

        protected void btnConfirmSubmit_Click(object sender, EventArgs e)
        {
            //To do validations
            ChatBotHelpQuestionDAO cbhqDAO = new ChatBotHelpQuestionDAO();
            ChatBotHelpQuestion currentQuestion = cbhqDAO.getChatBotHelpQuestionByID(Convert.ToInt32(Request.QueryString["id"]));
            cbhqDAO.updateChatBotHelpQuestion(txtHelpInput.Text, currentQuestion.questionID);
            Response.Redirect("askEmmaHelpQn.aspx");
        }

        protected void btnCfmDelete_Click(object sender, EventArgs e)
        {
            //To do validations
            ChatBotHelpQuestionDAO cbhqDAO = new ChatBotHelpQuestionDAO();
            ChatBotHelpQuestion currentQuestion = cbhqDAO.getChatBotHelpQuestionByID(Convert.ToInt32(Request.QueryString["id"]));
            cbhqDAO.deleteQuestionByID(currentQuestion.questionID);
            Response.Redirect("askEmmaHelpQn.aspx");
        }
    }
}