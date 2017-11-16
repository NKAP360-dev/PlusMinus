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
    public partial class askLearnyAddIntent : System.Web.UI.Page
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
            }
            else
            {
                Response.Redirect("Login.aspx");
            }
        }

        protected void btnSubmitIntent_Click(object sender, EventArgs e)
        {
            //to do validation
            ChatBotIntentDAO cbiDAO = new ChatBotIntentDAO();
            int intentID = cbiDAO.addIntent(txtIntentInput.Text);

            //set audit
            User currentUser = (User)Session["currentUser"];
            setAudit(currentUser, "learny intent", "create", intentID.ToString(), "created intent name: " + txtIntentInput.Text);

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