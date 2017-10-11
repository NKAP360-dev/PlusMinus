using Emma.DAO;
using Emma.Entity;
using LearnHub.AppCode.dao;
using LearnHub.AppCode.entity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LearnHub
{
    public partial class askLearnyEditHelp : System.Web.UI.Page
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

            //set audit
            User currentUser = (User)Session["currentUser"];
            setAudit(currentUser, "learny help questions", "update", currentQuestion.questionID.ToString(), "updated question: " + txtHelpInput.Text);

            Response.Redirect("askLearnyHelpQn.aspx");
        }

        protected void btnCfmDelete_Click(object sender, EventArgs e)
        {
            //To do validations
            ChatBotHelpQuestionDAO cbhqDAO = new ChatBotHelpQuestionDAO();
            ChatBotHelpQuestion currentQuestion = cbhqDAO.getChatBotHelpQuestionByID(Convert.ToInt32(Request.QueryString["id"]));
            cbhqDAO.deleteQuestionByID(currentQuestion.questionID);

            //set audit
            User currentUser = (User)Session["currentUser"];
            setAudit(currentUser, "learny help questions", "delete", currentQuestion.questionID.ToString(), "deleted question: " + currentQuestion.question);

            Response.Redirect("askLearnyHelpQn.aspx");
        }
        protected void setAudit(User u, string functionModified, string operation, string id_of_function, string remarks)
        {
            //set audit
            Audit a = new Audit();
            AuditDAO aDAO = new AuditDAO();
            a.userID = u.getUserID();
            a.functionModified = functionModified;
            a.operation = operation;
            a.id_of_function = id_of_function;
            a.dateModified = DateTime.Now;
            a.remarks = remarks;
            aDAO.createAudit(a);
        }
    }
}