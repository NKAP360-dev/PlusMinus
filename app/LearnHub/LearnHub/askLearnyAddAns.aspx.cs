using System;
using LearnHub.AppCode.dao;
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
    public partial class askLearnyAddAns : System.Web.UI.Page
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
                }
            }
        }

        protected void btnConfirmSubmit_Click(object sender, EventArgs e)
        {
            //to do validations

            ChatBotAnswerDAO cbaDAO = new ChatBotAnswerDAO();
            ChatBotAnswer cbAnswer = new ChatBotAnswer();
            cbAnswer.answer = txtAnswers.Text;
            cbAnswer.intent = ddlIntent.SelectedValue;
            if (txtEntity.Text != "")
            {
                cbAnswer.entityName = txtEntity.Text;
            }
            else
            {
                cbAnswer.entityName = null;
            }
            cbaDAO.insertAnswer(cbAnswer);
            Response.Redirect("askLearnyAddAns.aspx");
        }

        protected void cfmDelete_Click(object sender, EventArgs e)
        {

        }
    }
}