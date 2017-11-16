using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Emma.DAO;
using Emma.Entity;
using LearnHub.AppCode.entity;
using LearnHub.AppCode.dao;

namespace LearnHub
{
    public partial class askLearnyEditInitializeMsg : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["currentUser"] == null)
            {
                Response.Redirect("Login.aspx");
            }
            else
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
                    if (!IsPostBack)
                    {
                        ChatBotInitializeMsgDAO cbimDAO = new ChatBotInitializeMsgDAO();
                        int messageID = Convert.ToInt32(Request.QueryString["id"]);
                        ChatBotInitializeMsg currentMessage = cbimDAO.getChatBotInitializeMsgByID(messageID);
                        txtMsgInput.Text = currentMessage.message;
                    }
                }
            }
        }

        protected void btnConfirmSubmit_Click(object sender, EventArgs e)
        {
            //To do validations

            ChatBotInitializeMsgDAO cbimDAO = new ChatBotInitializeMsgDAO();
            int messageID = Convert.ToInt32(Request.QueryString["id"]);
            cbimDAO.updateInitializationMessage(messageID, txtMsgInput.Text);

            //set audit
            User currentUser = (User)Session["currentUser"];
            setAudit(currentUser, "learny initialization message", "update", messageID.ToString(), "updated message: " + txtMsgInput.Text);

            Response.Redirect("askLearnyInitializeMsg.aspx");
        }

        protected void cfmDelete_Click(object sender, EventArgs e)
        {
            //To do validations

            ChatBotInitializeMsgDAO cbimDAO = new ChatBotInitializeMsgDAO();
            int messageID = Convert.ToInt32(Request.QueryString["id"]);
            cbimDAO.deleteMessageByID(messageID);

            //set audit
            User currentUser = (User)Session["currentUser"];
            setAudit(currentUser, "learny initialization message", "delete", messageID.ToString(), "deleted message: " + txtMsgInput.Text);

            Response.Redirect("askLearnyInitializeMsg.aspx");
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