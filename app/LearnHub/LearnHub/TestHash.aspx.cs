using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Helpers;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LearnHub
{
    public partial class TestHash : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnSalt_Click(object sender, EventArgs e)
        {
            var salt = Crypto.GenerateSalt();
            txtSalt.Text = salt;
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            var hashedPasword = Crypto.SHA256(txtSalt.Text + txtHash.Text);
            lblHash.Text = hashedPasword;
        }
    }
}