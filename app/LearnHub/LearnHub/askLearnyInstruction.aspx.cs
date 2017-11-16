using System;
using LearnHub.AppCode.entity;
using Emma.DAO;
using Emma.Entity;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using LearnHub.AppCode.dao;

namespace LearnHub
{
    public partial class askLearnyInstruction : System.Web.UI.Page
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
                if (!superuser)
                {
                    Response.Redirect("errorPage.aspx");
                }
                else
                {
                    if (!IsPostBack)
                    {
                        ChatBotInstructionDAO cbiDAO = new ChatBotInstructionDAO();
                        ChatBotInstruction currentInstruction = cbiDAO.getInstruction();
                        txtTitle.Text = currentInstruction.title;
                        CKEditor1.Text = currentInstruction.instruction;
                    }
                }
            }
            else
            {
                Response.Redirect("Login.aspx");
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            //to do validations
            ChatBotInstructionDAO cbiDAO = new ChatBotInstructionDAO();
            cbiDAO.updateChatBotInstruction(txtTitle.Text, CKEditor1.Text);

            //set audit
            User currentUser = (User)Session["currentUser"];
            setAudit(currentUser, "learny instructions", "update", null, "updated instruction title: " + txtTitle.Text);

            Response.Redirect("learnyConfiguration.aspx");
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