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
                    Boolean superuser = false;
                    foreach (String s in currentUser.getRoles())
                    {
                        if (s.Equals("superuser"))
                        {
                            superuser = true;
                        }
                    }
                    if (!superuser)
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
            int answerID = cbaDAO.insertAnswer(cbAnswer);

            //set audit
            User currentUser = (User)Session["currentUser"];
            setAudit(currentUser, "learny answers", "create", answerID.ToString(), "answer: " + txtAnswers.Text);

            Response.Redirect("askLearnyAddAns.aspx");
        }

        protected void cfmDelete_Click(object sender, EventArgs e)
        {

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