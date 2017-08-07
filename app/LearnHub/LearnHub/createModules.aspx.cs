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
        public const string SELECTED_PREREQUISITE_INDEX = "SelectedPrerequisiteIndex";
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
                    Convert.ToDateTime(fromDateInput.Text), Convert.ToDateTime(toDateInput.Text), "Open", descriptionModuleInput.Text, Convert.ToInt32(moduleType.SelectedValue), user, Convert.ToInt32(hoursInput.Text), txtTargetAudience.Text);
            }

            //check pre req here 
            //pull pre req from model, check the course object here before creating the entry in the database
            List<int> allSelectedID = new List<int>();
            int counter = 0;
            foreach (GridViewRow row in gvPrereq.Rows)
            {
                CheckBox chkRow = (row.Cells[0].FindControl("chkboxPrereq") as CheckBox);
                if (chkRow.Checked)
                {
                    int prereqID = Convert.ToInt32(gvPrereq.DataKeys[counter].Value.ToString());
                    allSelectedID.Add(prereqID);
                }
                counter++;
            }

            //create the course object 
            //now insert into database by calling DAO

            Course_elearnDAO cDao = new Course_elearnDAO();
            Course_elearn res = cDao.create_elearnCourse(c);
            Course_elearn course_with_id = cDao.get_course_by_name(res);
            int id = course_with_id.getCourseID();

            foreach (int prereqID in allSelectedID)
            {
                cDao.insertPrerequisite(id, prereqID);
            }

            //create dir
            string file = "~/Data/";
            string add = Server.MapPath(file) + id;
            Directory.CreateDirectory(add);
            Response.Redirect("viewModuleInfo.aspx?id=" + id);
        }
        
    }
}
