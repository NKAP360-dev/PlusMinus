using System;
using LearnHub.AppCode.entity;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using LearnHub.AppCode.dao;

namespace LearnHub
{
    public partial class askLearnyFeedback : System.Web.UI.Page
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
                    if (!IsPostBack) {
                        ChatBotFeedbackSettingsDAO cbfsDAO = new ChatBotFeedbackSettingsDAO();
                        ChatBotFeedbackSettings currentSettings = cbfsDAO.getCurrentSettings();
                        if (currentSettings.enabled.Equals("y"))
                        {
                            rdlEmail.SelectedValue = "y";
                        } else
                        {
                            rdlEmail.SelectedValue = "n";
                        }
                        txtEmail.Text = currentSettings.emailToSendTo;
                        txtSMTPUser.Text = currentSettings.smtpUsername;
                        txtSMTPPassword.Text = currentSettings.smtpPassword;
                        txtSMTPPassword.Attributes["type"] = "password";
                    }
                }
            }
            else
            {
                Response.Redirect("Login.aspx");
            }
        
    }

        protected void btnConfirmSave_Click(object sender, EventArgs e)
        {
            Page.Validate("ValidateForm");
            if (!Page.IsValid)
            {

            }
            else
            {
                ChatBotFeedbackSettingsDAO cbfsDAO = new ChatBotFeedbackSettingsDAO();
                cbfsDAO.updateSettings(rdlEmail.SelectedValue, txtEmail.Text, txtSMTPUser.Text, txtSMTPPassword.Text);
                /*
                string message = "Saved.";
                System.Text.StringBuilder sb = new System.Text.StringBuilder();
                sb.Append("<script type = 'text/javascript'>");
                sb.Append("window.onload=function(){");
                sb.Append("alert('");
                sb.Append(message);
                sb.Append("')};");
                sb.Append("</script>");
                ClientScript.RegisterClientScriptBlock(this.GetType(), "alert", sb.ToString());
                */
                lblSaveSuccess.Visible = true;
            }
        }
        protected void changeSelectedIndex(object sender, EventArgs e)
        {
            if (rdlEmail.SelectedItem.Value == ("y"))
            {
                txtEmail.Enabled = true;
                rfv_txtEmail.Enabled = true;
            }
            else
            {
                txtEmail.Enabled = false;
                rfv_txtEmail.Enabled = false;
            }
        }
    }
}