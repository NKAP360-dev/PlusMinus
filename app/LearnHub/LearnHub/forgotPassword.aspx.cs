using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using LearnHub.AppCode.dao;
using LearnHub.AppCode.entity;
using System.Web.Helpers;
using System.Collections;
using System.Net;
using System.Net.Mail;
using System.Threading.Tasks;
using System.Windows;

namespace LearnHub
{
    public partial class forgotPassword : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            panelErrorMsg.Visible = false;
            panelSuccessMsg.Visible = false;
        }

        protected void btnRequest_Click(object sender, EventArgs e)
        {
            string email = txtEmail.Text;
            UserDAO udao = new UserDAO();
            User toChange = udao.getUserByEmail(email); //find email in database.
                                                        //change password in db for this email to auto generated password
            if (toChange != null)
            {
                string randompassword = System.Web.Security.Membership.GeneratePassword(8, 1);
                string salt = Crypto.GenerateSalt();// generate salt of user
                string password_hashed = Crypto.SHA256(salt + randompassword); // generate hashed random password
                Boolean success = udao.updateUserPassword(toChange, password_hashed, salt); // update db with new salt and password
                //send email based on chatbot configs for smtp mail server 
                try
                {
                    ChatBotFeedbackSettingsDAO cbfsDAO = new ChatBotFeedbackSettingsDAO();
                    ChatBotFeedbackSettings currentSettings = cbfsDAO.getCurrentSettings();
                    SmtpClient client = new SmtpClient("Host");
                    client.Host = "smtp.gmail.com";
                    client.Port = 587;
                    client.EnableSsl = true;
                    client.Credentials = new NetworkCredential(currentSettings.smtpUsername, currentSettings.smtpPassword);
                    MailMessage mailMessage = new MailMessage();
                    mailMessage.IsBodyHtml = true;
                    mailMessage.From = new MailAddress("DO_NOT_REPLY@amkthk.gov.sg");
                    mailMessage.To.Add(toChange.getEmail());
                    mailMessage.Body = $"Hi, {toChange.getName()}<br /><br /> A password change was requested. <br /><br />The new password is: <br /><b>{randompassword}</b><br /><br />Please change your password upon login.<br /><br />You do not have to reply to this email as it's auto-generated";
                    mailMessage.Subject = "Change password";
                    client.Send(mailMessage);
                    panelSuccessMsg.Visible = true;
                }
                catch (Exception)
                {
                    panelErrorMsg.Visible = true;
                }
            }
                else
            {
                panelErrorMsg.Visible = true;
            }
            
        }

    }    
}