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
    public partial class askLearnyEditIntent : System.Web.UI.Page
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

            //set audit
            User currentUser = (User)Session["currentUser"];
            setAudit(currentUser, "learny intent", "update", currentCBI.intentID.ToString(), "updated intent name: " + txtIntentInput.Text);

            Response.Redirect("askLearnyAddIntent.aspx");
        }

        protected void btnCfmDelete_Click(object sender, EventArgs e)
        {
            //To do validations

            ChatBotIntentDAO cbiDAO = new ChatBotIntentDAO();
            ChatBotIntent currentCBI = cbiDAO.getChatBotIntentByID(Convert.ToInt32(Request.QueryString["id"]));
            cbiDAO.deleteAnswersByIntent(currentCBI.intentID);
            cbiDAO.deleteIntentByID(currentCBI.intentID);

            //set audit
            User currentUser = (User)Session["currentUser"];
            setAudit(currentUser, "learny intent", "delete", currentCBI.intentID.ToString(), "deleted intent name: " + currentCBI.intent);

            Response.Redirect("askLearnyAddIntent.aspx");
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