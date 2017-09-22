﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using LearnHub.AppCode.dao;
using LearnHub.AppCode.entity;

namespace LearnHub
{
    public partial class createArticle : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["currentUser"] == null)
            {
                Response.Redirect("login.aspx");
            }
        }
        protected void cfmSubmit_Click(object sender, EventArgs e)
        {
            ArticleDAO adao = new ArticleDAO();
            string title = txtTitle.Text;
            string body = CKEditor1.Text;
            User upload = (User)Session["currentUser"];
            DateTime time = DateTime.Now;
            Article a = new Article(title, body, upload, time, "Active");
            int done = adao.createArticle(a);
            if (done > 0)
            {
                Response.Redirect("manageArticles.aspx");
            }
            else
            {
                Response.Redirect("errorPage.aspx");
            }
        }
    }
}