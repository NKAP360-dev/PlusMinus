using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using LearnHub.AppCode.dao;
using LearnHub.AppCode.entity;
using System.Collections;

namespace LearnHub
{
    public partial class editNews : System.Web.UI.Page
    {
        //protected int id_num;
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
                else
                {
                    if (!IsPostBack)
                    {
                        string id = Request.QueryString["id"];
                        if (id == null || id.Equals(""))
                        {
                            Response.Redirect("errorPage.aspx");
                        }
                        int id_num = Convert.ToInt32(id);
                        News_highlightsDAO ndao = new News_highlightsDAO();
                        News_highlights news = ndao.getHighlightById(id_num);
                        ddlType.SelectedValue = news.type;
                        txtTitle.Text = news.title;
                        txtDesc.Text = news.body;
                        descriptionModuleInput.Text = news.news_text; 
                    }
                }
            }             
        }
        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            News_highlights edited = new News_highlights();
            string id = Request.QueryString["id"];
            if (id == null || id.Equals(""))
            {
                Response.Redirect("errorPage.aspx");
            }
            int id_num = Convert.ToInt32(id);
            edited.highlight_id = id_num;
            edited.title = txtTitle.Text;
            edited.body = txtDesc.Text;
            edited.news_text = descriptionModuleInput.Text;
            edited.type = ddlType.SelectedValue;
            if (FileUpload1.HasFile)
            {
                string fileName = FileUpload1.FileName;
                string filepath = "img/highlights" + "/";
                string FileExtension = fileName.Substring(fileName.LastIndexOf('.') + 1).ToLower();
                if (FileExtension.Equals("jpeg") || FileExtension.Equals("png") || FileExtension.Equals("jpg"))
                {
                    FileUpload1.PostedFile
                    .SaveAs(Server.MapPath(filepath) + fileName);
                    string totalpath1 = Server.MapPath(filepath) + fileName;
                    edited.img_path = totalpath1;
                    News_highlightsDAO ndao = new News_highlightsDAO();
                    Boolean done = ndao.updateHighlight(edited);
                    if (done)
                    {
                        Response.Redirect("manageNews.aspx");
                    }
                }
            }
        }
    }
}