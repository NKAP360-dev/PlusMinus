using System;
using LearnHub.AppCode.dao;
using LearnHub.AppCode.entity;
using System.Web.Helpers;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Data;


namespace LearnHub
{
    public partial class Masterpage : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            User currentUser = (User)Session["currentUser"];
            if (currentUser == null)
            {
                //Response.Redirect("Login.aspx");
            }
            HyperLink hlRow = new HyperLink();
            hlRow.NavigateUrl = "downloadTrainingCalendar.aspx";
            hlRow.Text = "Training Calendar";
            hlRow.Visible = true;
            this.HyperLink8.Controls.Add(hlRow);
        }
    }
}