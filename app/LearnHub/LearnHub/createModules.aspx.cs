using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using LearnHub.AppCode.dao;
using LearnHub.AppCode.entity;
using System.IO;

namespace LearnHub
{
    public partial class createModules : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            User currentUser = (User)Session["currentUser"];
            if (currentUser == null)
            {
                Response.Redirect("/Login.aspx");
            }
            else if (!currentUser.getRole().Equals("course creator") && !currentUser.getRole().Equals("superuser"))
            {
                Response.Redirect("/errorPage.aspx");
            }
            else
            {
                moduleType.Items.Insert(0, "");
                moduleType.Items.Insert(1, "Compulsory");
                moduleType.Items.Insert(2, "Leadership");
                moduleType.Items.Insert(3, "Professional");
            }

        }
        protected void submitBtn_Click(object sender, EventArgs e)
        {
            Course_elearnDAO cdao = new Course_elearnDAO();
            //int id_int = Convert.ToInt32(id.Text);
            Boolean check = true;
            User user = (User)Session["currentUser"];
            Course_elearn c = null;
            string type = Request.QueryString["type"];
            if (check && moduleType.Text != "") // if no expiry date
            {
                c = new Course_elearn(nameOfModuleInput.Text, user.getDepartment(), DateTime.Now,
                    Convert.ToDateTime("01/01/2017"), Convert.ToDateTime("12/31/2017"),  "Open", descriptionModuleInput.Text, moduleType.Text, user, Convert.ToInt32(hoursInput.Text));
            }

            //check pre req here 
            //pull pre req from model, check the course object here before creating the entry in the database


            //create the course object 
            //now insert into database by calling DAO

            Course_elearnDAO cDao = new Course_elearnDAO();
            Course_elearn res = cDao.create_elearnCourse(c);
            Course_elearn course_with_id = cDao.get_course_by_name(res);
            int id = course_with_id.getCourseID();

            //create dir
            string file = "~/Data/";
            string add = Server.MapPath(file) + id;
            Directory.CreateDirectory(add);
            Response.Redirect("viewModuleInfo.aspx?id=" + id);
        }
    }
}
