using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Collections;
using System.IO;
using LearnHub.AppCode.entity;
using LearnHub.AppCode.dao;

namespace LearnHub
{
    public partial class uploadTrainingCalendar : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            User currentUser = (User)Session["currentUser"];
            if (currentUser == null)
            {
                Response.Redirect("Login.aspx");
            }
            else
            {
                Boolean superuser = false;
                foreach (string s in currentUser.getRoles())
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
        protected void btnUpload_Click(object sender, EventArgs e)
        {
            Array.ForEach(Directory.GetFiles(Server.MapPath("Training_Calendar")), File.Delete);
            if (FileUpload1.HasFile)
            {
                string fileName = FileUpload1.FileName;
                string filepath = "Training_Calendar/";
                string FileExtension = fileName.Substring(fileName.LastIndexOf('.') + 1).ToLower();
                if (FileExtension.Equals("xlsx") || FileExtension.Equals("pdf") || FileExtension.Equals("csv") || FileExtension.Equals("doc") || FileExtension.Equals("docx")
                    || FileExtension.Equals("xlsm"))
                {
                    FileUpload1.PostedFile
                    .SaveAs(Server.MapPath(filepath) + fileName);
                    string totalpath1 = Server.MapPath(filepath) + fileName;

                    //set audit
                    User currentUser = (User)Session["currentUser"];
                    setAudit(currentUser, "training calendar", "create", null, "created training calendar");

                    Response.Redirect("home.aspx");
                }
            }
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