﻿using System;
using LearnHub.AppCode.dao;
using LearnHub.AppCode.entity;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Emma.DAO;
using Emma.Entity;

namespace LearnHub
{
    public partial class askEmmaEditAns : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["currentUser"] == null)
            {
                Response.Redirect("/Login.aspx");
            }
            else
            {
                if (!IsPostBack)
                {
                    User currentUser = (User)Session["currentUser"];

                    if (!currentUser.getDepartment().Equals("hr"))
                    {
                        Response.Redirect("/errorPage.aspx");
                    }
                    else
                    {
                        ChatBotAnswerDAO cbaDAO = new ChatBotAnswerDAO();
                        ChatBotAnswer currrentAnswer = cbaDAO.getChatBotAnswerByID(Convert.ToInt32(Request.QueryString["id"]));
                        if (currrentAnswer.answer != null)
                        {
                            txtAnswers.Text = currrentAnswer.answer;
                            ddlIntent.DataBind();
                            ddlIntent.SelectedIndex = ddlIntent.Items.IndexOf(ddlIntent.Items.FindByText(currrentAnswer.intent));
                        }
                        else
                        {
                            Response.Redirect("/errorPage.aspx");
                        }
                    }
                }
            }
        }

        protected void cfmSubmit_Click(object sender, EventArgs e)
        {
            //to do validation

            ChatBotAnswerDAO cbaDAO = new ChatBotAnswerDAO();
            int answerID = Convert.ToInt32(Request.QueryString["id"]);
            cbaDAO.updateChatBotAnswer(txtAnswers.Text, null, ddlIntent.SelectedValue, answerID);
            Response.Redirect("/askEmmaAddAns.aspx");
        }
    }
}