using LearnHub.AppCode.dao;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LearnHub
{
    public partial class TestCipher : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            String encryptedText = StringCipher.Encrypt(txtString.Text, txtPass.Text);
            lblDisplay.Text = encryptedText;
        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            String plainText = StringCipher.Decrypt(txtCipher.Text, txtCipherPass.Text);
            lblDisplay2.Text = plainText;
        }
    }
}