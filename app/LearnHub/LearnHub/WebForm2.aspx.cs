using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using LearnHub.AppCode.dao;
using LearnHub.AppCode.entity;

namespace LearnHub
{
    public partial class WebForm2 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            Course_elearnDAO cdao = new Course_elearnDAO();
            int id_int = Convert.ToInt32(id.Text);
            Boolean check = false;
            DateTime exp = new DateTime();
            if (expiry != null)
            {
                if (expiry.Text != "")
                {
                    exp = Convert.ToDateTime(expiry.Text);
                    check = true;
                }

            }

            Course_elearn c = null;
            if (check) // if no expiry date
            {
                c = new Course_elearn(id_int, name.Text, provider.Text, DateTime.Now, status.Text, desc.Text, "Leadership");
            }
            else // if got expiry date
            {
                c = new Course_elearn(id_int, name.Text, provider.Text, DateTime.Now, exp, status.Text, desc.Text, "Leadership");
            }
            //check pre req here 
            //pull pre req from model, check the course object here before creating the entry in the database


            //create the course object 
            //now insert into database by calling DAO

            Course_elearnDAO cDao = new Course_elearnDAO();
            Course_elearn res = cDao.create_elearnCourse(c);
            Session.Add("res", res);
            Response.Redirect("WebForm1.aspx");
        }
    }
}