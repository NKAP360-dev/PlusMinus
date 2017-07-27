using LearnHub.AppCode.dao;
using LearnHub.AppCode.entity;
using System;
using System.Collections.Generic;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LearnHub
{
    public partial class editModuleInfo : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["currentUser"] == null)
            {
                Response.Redirect("/Login.aspx");
            }
            else 
            {
                User currentUser = (User)Session["currentUser"];
                Course_elearnDAO ceDAO = new Course_elearnDAO();
                Course_elearn currentCourse = ceDAO.get_course_by_id(Convert.ToInt32(Request.QueryString["id"]));
                if (currentUser.getUserID() != currentCourse.getCourseCreator().getUserID() && !(currentUser.getRole().Equals("course creator") || currentUser.getRole().Equals("superuser")))
                {
                    Response.Redirect("/errorPage.aspx");
                }
                else
                {
                    if (!IsPostBack)
                    {
                        //to populate data
                        moduleType.Items.Insert(0, "");
                        moduleType.Items.Insert(1, "Compulsory");
                        moduleType.Items.Insert(2, "Leadership");
                        moduleType.Items.Insert(3, "Professional");

                        moduleType.SelectedValue = currentCourse.getCategory();
                        nameOfModuleInput.Text = currentCourse.getCourseName();
                        descriptionModuleInput.Text = currentCourse.getDescription();
                        hoursInput.Text = currentCourse.getHoursAwarded().ToString();
                        //to add in prerequisite
                        fromDateInput.Text = currentCourse.getStartDate().ToString("MM/dd/yyyy");
                        toDateInput.Text = currentCourse.getExpiryDate().ToString("MM/dd/yyyy");
                    }
                }
            }
        }

        protected void cfmSubmit_Click(object sender, EventArgs e)
        {
            //to do validations

            Course_elearnDAO ceDAO = new Course_elearnDAO();
            int courseID = Convert.ToInt32(Request.QueryString["id"]);
            ceDAO.updateCourse(courseID, moduleType.SelectedValue, nameOfModuleInput.Text, descriptionModuleInput.Text, Convert.ToInt32(hoursInput.Text), DateTime.ParseExact(fromDateInput.Text, "MM/dd/yyyy", CultureInfo.InvariantCulture), DateTime.ParseExact(toDateInput.Text, "MM/dd/yyyy", CultureInfo.InvariantCulture));
            Response.Redirect($"/viewModuleInfo.aspx?id={courseID}");
        }
    }
}