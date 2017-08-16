using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using LearnHub.AppCode.dao;
using LearnHub.AppCode.entity;
using System.IO;
using System.Collections;
using System.Web.Services;

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
                Response.Redirect("Login.aspx");
            }
            else if (!currentUser.getRole().Equals("course creator") && !currentUser.getRole().Equals("superuser"))
            {
                Response.Redirect("/errorPage.aspx");
            }
            else
            {
                if (!IsPostBack)
                {
                    List<int> prereqIDlist = new List<int>();
                    Session["selectedPrereq"] = prereqIDlist;
                    var itemIDs = string.Join(",", ((IList<int>)Session["selectedPrereq"]).ToArray());

                    //to load course list
                    var sqlQueryCourseList = "";
                    if (itemIDs.Length > 0)
                    {
                        sqlQueryCourseList = String.Format("SELECT * FROM [Elearn_course] ec INNER JOIN [Elearn_courseCategory] ecc ON ec.categoryID = ecc.categoryID WHERE ec.status='Open' and ec.start_date <= getDate() and ec.elearn_courseID NOT IN ({0})", itemIDs);
                    }
                    else
                    {
                        sqlQueryCourseList = "SELECT * FROM [Elearn_course] ec INNER JOIN [Elearn_courseCategory] ecc ON ec.categoryID = ecc.categoryID WHERE ec.status='Open' and ec.start_date <= getDate()";
                    }
                    SqlDataSource1.SelectCommand = sqlQueryCourseList;
                    gvPrereq.DataSource = SqlDataSource1;
                    gvPrereq.DataBind();

                    //to load prereq cart

                    var sqlQuery = "";
                    if (itemIDs.Length > 0)
                    {
                        sqlQuery = String.Format("SELECT * FROM [Elearn_course] WHERE [elearn_courseID] IN ({0})", itemIDs);
                    }
                    else
                    {
                        sqlQuery = "SELECT * FROM [Elearn_course] WHERE [elearn_courseID] = -1";
                    }

                    SqlDataSourcePrereqCart.SelectCommand = sqlQuery;
                    gvPrereqCart.DataSource = SqlDataSourcePrereqCart;
                    gvPrereqCart.DataBind();
                }
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
            /*List<int> allSelectedID = new List<int>();
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
            }*/

            //create the course object 
            //now insert into database by calling DAO

            Course_elearnDAO cDao = new Course_elearnDAO();
            Course_elearn res = cDao.create_elearnCourse(c);
            Course_elearn course_with_id = cDao.get_course_by_name(res);
            List<int> prereqIDlist = (List<int>)Session["selectedPrereq"];
            int id = course_with_id.getCourseID();

            foreach (int prereqID in prereqIDlist)
            {
                cDao.insertPrerequisite(id, prereqID);
            }

            //create dir
            string file = "~/Data/";
            string add = Server.MapPath(file) + id;
            Directory.CreateDirectory(add);
            Response.Redirect("viewModuleInfo.aspx?id=" + id);
        }

        protected void gvPrereq_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            List<int> prereqIDlist = (List<int>)Session["selectedPrereq"];
            int id = Convert.ToInt32(e.CommandArgument);

            //to get course and add any prereq related to the course
            Course_elearnDAO ceDAO = new Course_elearnDAO();
            Course_elearn selectedCourse = ceDAO.get_course_by_id(id);
            ArrayList allPrereq = getAllPrerequisites(id);
            ArrayList allPrereqNoDup = new ArrayList();
            foreach (int prereqID in allPrereq)
            {
                if (!allPrereqNoDup.Contains(prereqID) && !prereqIDlist.Contains(prereqID))
                {
                    allPrereqNoDup.Add(prereqID);
                }
            }

            foreach (int prereqID in allPrereqNoDup)
            {
                prereqIDlist.Add(prereqID);
            }
            prereqIDlist.Add(id);
            Session["selectedPrereq"] = prereqIDlist;
            var itemIDs = string.Join(",", ((IList<int>)Session["selectedPrereq"]).ToArray());

            var sqlQueryCourseList = "";
            if (itemIDs.Length > 0)
            {
                sqlQueryCourseList = String.Format("SELECT * FROM [Elearn_course] ec INNER JOIN [Elearn_courseCategory] ecc ON ec.categoryID = ecc.categoryID WHERE ec.status='Open' and ec.start_date <= getDate() and ec.elearn_courseID NOT IN ({0})", itemIDs);
            }
            else
            {
                sqlQueryCourseList = "SELECT * FROM [Elearn_course] ec INNER JOIN [Elearn_courseCategory] ecc ON ec.categoryID = ecc.categoryID WHERE ec.status='Open' and ec.start_date <= getDate()";
            }
            SqlDataSource1.SelectCommand = sqlQueryCourseList;
            gvPrereq.DataSource = SqlDataSource1;
            gvPrereq.DataBind();

            var sqlQuery = String.Format("SELECT * FROM [Elearn_course] WHERE [elearn_courseID] IN ({0})", itemIDs);

            SqlDataSourcePrereqCart.SelectCommand = sqlQuery;
            gvPrereqCart.DataSource = SqlDataSourcePrereqCart;
            gvPrereqCart.DataBind();
        }

        protected void gvPrereqCart_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            List<int> prereqIDlist = (List<int>)Session["selectedPrereq"];
            int id = Convert.ToInt32(e.CommandArgument);
            Course_elearnDAO ceDAO = new Course_elearnDAO();
            List<int> allLinkedCourses = ceDAO.getAllCourseLinkedToPrerequisite(id);
            foreach (int linkedID in allLinkedCourses)
            {
                if (prereqIDlist.Contains(linkedID))
                {
                    prereqIDlist.Remove(linkedID);
                }
            }
            prereqIDlist.Remove(id);
            Session["selectedPrereq"] = prereqIDlist;
            var itemIDs = string.Join(",", ((IList<int>)Session["selectedPrereq"]).ToArray());

            var sqlQueryCourseList = "";
            if (itemIDs.Length > 0)
            {
                sqlQueryCourseList = String.Format("SELECT * FROM [Elearn_course] ec INNER JOIN [Elearn_courseCategory] ecc ON ec.categoryID = ecc.categoryID WHERE ec.status='Open' and ec.start_date <= getDate() and ec.elearn_courseID NOT IN ({0})", itemIDs);
            }
            else
            {
                sqlQueryCourseList = "SELECT * FROM [Elearn_course] ec INNER JOIN [Elearn_courseCategory] ecc ON ec.categoryID = ecc.categoryID WHERE ec.status='Open' and ec.start_date <= getDate()";
            }
            SqlDataSource1.SelectCommand = sqlQueryCourseList;
            gvPrereq.DataSource = SqlDataSource1;
            gvPrereq.DataBind();

            var sqlQuery = "";
            if (itemIDs.Length > 0)
            {
                sqlQuery = String.Format("SELECT * FROM [Elearn_course] WHERE [elearn_courseID] IN ({0})", itemIDs);
            }
            else
            {
                sqlQuery = "SELECT * FROM [Elearn_course] WHERE [elearn_courseID] = -1";
            }

            SqlDataSourcePrereqCart.SelectCommand = sqlQuery;
            gvPrereqCart.DataSource = SqlDataSourcePrereqCart;
            gvPrereqCart.DataBind();
        }

        protected ArrayList getAllPrerequisites(int courseID)
        {
            ArrayList toReturn = new ArrayList();
            Course_elearnDAO ceDAO = new Course_elearnDAO();
            ArrayList coursePrereqs = ceDAO.getPrereqOfCourse(courseID);
            foreach(Course_elearn prerequisite in coursePrereqs)
            {
                toReturn.Add(prerequisite.getCourseID());
                ArrayList morePrereq = getAllPrerequisites(prerequisite.getCourseID());
                if (morePrereq.Count > 0)
                {
                    foreach(int prerequisitesID in morePrereq)
                    {
                        toReturn.Add(prerequisitesID);
                    }
                }
            }
            return toReturn;
        }
        [System.Web.Services.WebMethod]
        public static Boolean validateNameExists(String input)
        {
            
            System.Diagnostics.Debug.WriteLine("VALIDATENAMEEXISTS");
            //String input = nameOfModuleInput.Text;
            Course_elearnDAO course_elearnDAO = new Course_elearnDAO();
            if (course_elearnDAO.checkModuleNameExists(input))
            {
                System.Diagnostics.Debug.WriteLine("modulenameexists");
                //args.IsValid = false;
                return false;
            }
            else
            {
                System.Diagnostics.Debug.WriteLine("modulenamedoesnotexist");
                //args.IsValid = true;
                return true;
            }
        }
    }
}
