using System;
using LearnHub.AppCode.dao;
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
    public partial class askLearnyEditAns : System.Web.UI.Page
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
                    if (!superuser)
                    {
                        Response.Redirect("errorPage.aspx");
                    }
                    else
                    {
                        ChatBotAnswerDAO cbaDAO = new ChatBotAnswerDAO();
                        ChatBotAnswer currrentAnswer = cbaDAO.getChatBotAnswerByID(Convert.ToInt32(Request.QueryString["id"]));
                        if (currrentAnswer.answer != null)
                        {
                            txtAnswers.Text = currrentAnswer.answer;
                            txtEntity.Text = currrentAnswer.entityName;
                            ddlIntent.DataBind();
                            ddlIntent.SelectedIndex = ddlIntent.Items.IndexOf(ddlIntent.Items.FindByText(currrentAnswer.intent));
                        }
                        else
                        {
                            Response.Redirect("errorPage.aspx");
                        }
                    }
                }
            }
        }

        protected void cfmSubmit_Click(object sender, EventArgs e)
        {
            //to do validation

            ChatBotAnswerDAO cbaDAO = new ChatBotAnswerDAO();
            int answerID = Convert.ToInt32(Request.QueryString["id"]);
            if (txtEntity.Text.Equals(""))
            {
                cbaDAO.updateChatBotAnswer(txtAnswers.Text, null, ddlIntent.SelectedValue, answerID);
            }
            else
            {
                cbaDAO.updateChatBotAnswer(txtAnswers.Text, txtEntity.Text, ddlIntent.SelectedValue, answerID);
            }

            //set audit
            User currentUser = (User)Session["currentUser"];
            setAudit(currentUser, "learny answers", "update", answerID.ToString(), "updated answer: " + txtAnswers.Text);

            Response.Redirect("askLearnyAddAns.aspx");
        }

        protected void deleteBtn_Click(object sender, EventArgs e)
        {
            ChatBotAnswerDAO cbaDAO = new ChatBotAnswerDAO();
            int answerID = Convert.ToInt32(Request.QueryString["id"]);
            cbaDAO.deleteAnswerByID(answerID);

            //set audit
            User currentUser = (User)Session["currentUser"];
            setAudit(currentUser, "learny answers", "delete", answerID.ToString(), "deleted answer: " + txtAnswers.Text);

            Response.Redirect("askLearnyAddAns.aspx");
        }

        protected void ddlIntent_SelectedIndexChanged(object sender, EventArgs e)
        {
            gvIntentAnswers.DataBind();
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