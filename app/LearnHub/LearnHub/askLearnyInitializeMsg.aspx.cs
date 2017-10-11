using System;
using LearnHub.AppCode.entity;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Emma.DAO;
using Emma.Entity;
using LearnHub.AppCode.dao;

namespace LearnHub
{
    public partial class askLearnyInitializeMsg : System.Web.UI.Page
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
                else
                {
                    if(!IsPostBack)
                    {
                        gvMessages.DataBind();
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
            //to do validations
            ChatBotInitializeMsgDAO cbimDAO = new ChatBotInitializeMsgDAO();
            int messageID = cbimDAO.insertMessage(txtMsgInput.Text);

            //set audit
            User currentUser = (User)Session["currentUser"];
            setAudit(currentUser, "learny initalization message", "create", messageID.ToString(), "created message: " + txtMsgInput.Text);

            Response.Redirect("askLearnyInitializeMsg.aspx");
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            ChatBotInitializeMsgDAO cbimDAO = new ChatBotInitializeMsgDAO();
            int counter = 0;
            int[] messageIDs = (from p in Request.Form["messageID"].Split(',')
                                 select int.Parse(p)).ToArray();
            foreach (int messageID in messageIDs)
            {
                cbimDAO.updateInitializationLevel(messageID, counter);
                counter++;
            }

            //set audit
            User currentUser = (User)Session["currentUser"];
            setAudit(currentUser, "learny initialization message", "update", null, "Reorder message order");
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