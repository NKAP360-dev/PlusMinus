using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using LearnHub.AppCode.dao;
using LearnHub.AppCode.entity;
using System.Collections;

namespace LearnHub
{
    public partial class WebForm10 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            User currentUser = (User)Session["currentUser"];
            Boolean authenticate = authenticateAccess(currentUser);
            if (Request.QueryString["id"] != null)
            {
                if (!authenticate)
                {
                    Response.Redirect("errorPage.aspx");
                }
                else
                {
                    //TestimonialDAO tdao = new TestimonialDAO();
                    string id = Request.QueryString["id"];
                    int id_num = Convert.ToInt32(id);
                    News_highlightsDAO adao = new News_highlightsDAO();
                    adao.deactivateNewsHighlight(id_num); 
                    News_highlights obj = adao.getHighlightById(id_num);
                    if (File.Exists(obj.img_path))
                    {
                        File.Delete(obj.img_path);
                    }               
                    //set audit
                    setAudit(currentUser, "news", "delete", id, "deleted news title: " + obj.title);

                    Response.Redirect("manageNews.aspx");
                }
            }
            else
            {
                Response.Redirect("errorPage.aspx");
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
        protected Boolean authenticateAccess(User currentUser)
        {
            Boolean toReturn = false;
            ArrayList roles = currentUser.getRoles();
            if (roles.Contains("superuser") || roles.Contains("content creator"))
            {
                toReturn = true;
            }
            return toReturn;
        }
    }
}