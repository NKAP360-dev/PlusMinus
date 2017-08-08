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
    public partial class askEmmaEditInitializeMsg : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["currentUser"] == null)
            {
                Response.Redirect("/Login.aspx");
            }
            else
            {
                User currentUser = (User)Session["currentUser"];

                if (!currentUser.getDepartment().Equals("hr"))
                {
                    Response.Redirect("/errorPage.aspx");
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
            Response.Redirect("/askEmmaInitializeMsg.aspx");
        }

        protected void cfmDelete_Click(object sender, EventArgs e)
        {
            //To do validations

            ChatBotInitializeMsgDAO cbimDAO = new ChatBotInitializeMsgDAO();
            int messageID = Convert.ToInt32(Request.QueryString["id"]);
            cbimDAO.deleteMessageByID(messageID);
            Response.Redirect("/askEmmaInitializeMsg.aspx");
        }
    }
}