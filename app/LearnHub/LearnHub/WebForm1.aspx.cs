using LearnHub.AppCode.dao;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LearnHub
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            List<int> check = getAllPostRequisiteCourses(Convert.ToInt32(TextBox1.Text));
            Label1.Text = check.ToString();
        }
        protected List<int> getAllPostRequisiteCourses(int courseID)
        {
            List<int> toReturn = new List<int>();
            Course_elearnDAO ceDAO = new Course_elearnDAO();
            List<int> currentPostRequisite = ceDAO.getAllCourseLinkedToPrerequisite(courseID);
            foreach (int currentCourseID in currentPostRequisite)
            {
                toReturn.Add(currentCourseID);
                List<int> innerList = getAllPostRequisiteCourses(currentCourseID);
                if (innerList.Count > 0)
                {
                    foreach(int innerListCourseID in innerList)
                    {
                        toReturn.Add(innerListCourseID);
                    }
                }
            }
            return toReturn;
        }
    }
}