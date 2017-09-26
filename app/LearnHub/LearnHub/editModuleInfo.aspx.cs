using LearnHub.AppCode.dao;
using LearnHub.AppCode.entity;
using System;
using System.Collections;
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
                Response.Redirect("Login.aspx");
            }
            else 
            {
                User currentUser = (User)Session["currentUser"];
                Course_elearnDAO ceDAO = new Course_elearnDAO();
                Course_elearn currentCourse = ceDAO.get_course_by_id(Convert.ToInt32(Request.QueryString["id"]));
                Boolean superuser = false;
                Boolean course_creator = false;
                foreach (string s in currentUser.getRoles())
                {
                    if (s.Equals("superuser"))
                    {
                        superuser = true;
                    }
                    else if (s.Equals("course creator"))
                    {
                        course_creator = true;
                    }
                }
                if (currentUser.getUserID() != currentCourse.getCourseCreator().getUserID() && !(superuser || course_creator))
                {
                    Response.Redirect("errorPage.aspx");
                }
                else
                {
                    if (!IsPostBack)
                    {
                        moduleType.SelectedValue = currentCourse.getCategoryID().ToString();
                        ddlCourseType.SelectedValue = currentCourse.getCourseType();
                        nameOfModuleInput.Text = currentCourse.getCourseName();
                        lblBreadcrumbCourseName.Text = currentCourse.getCourseName();
                        descriptionModuleInput.Text = currentCourse.getDescription();
                        hoursInput.Text = currentCourse.getHoursAwarded().ToString();
                        if (currentCourse.getTargetAudience() != null)
                        {
                            txtTargetAudience.Text = currentCourse.getTargetAudience().ToString();
                        }
                        fromDateInput.Text = currentCourse.getStartDate().ToString("dd/MM/yyyy");
                        toDateInput.Text = currentCourse.getExpiryDate().ToString("dd/MM/yyyy");

                        //prerequisites
                        ArrayList allPrerequisites = currentCourse.getPrerequisite();
                        List<int> prereqIDlist = new List<int>();
                        foreach (Course_elearn prereq in allPrerequisites)
                        {
                            prereqIDlist.Add(prereq.getCourseID());
                        }
                        Session["selectedPrereq"] = prereqIDlist;
                        var itemIDs = string.Join(",", ((IList<int>)Session["selectedPrereq"]).ToArray());

                        //postrequisites
                        List<int> postReqIDList = getAllPostRequisiteCourses(currentCourse.getCourseID());
                        List<int> postReqIDListNoDup = new List<int>();
                        foreach (int postreqID in postReqIDList)
                        {
                            if (!postReqIDListNoDup.Contains(postreqID) && postReqIDList.Contains(postreqID))
                            {
                                postReqIDListNoDup.Add(postreqID);
                            }
                        }
                        Session["selectedPostreq"] = postReqIDListNoDup;
                        var itemIDs2 = string.Join(",", ((IList<int>)Session["selectedPostreq"]).ToArray());

                        //to load course list
                        var sqlQueryCourseList = "";
                        if (itemIDs.Length > 0)
                        {
                            sqlQueryCourseList = String.Format("SELECT * FROM [Elearn_course] ec INNER JOIN [Elearn_courseCategory] ecc ON ec.categoryID = ecc.categoryID WHERE ec.status='active' and ec.start_date <= getDate() and ec.elearn_courseID NOT IN ({0}) and ec.elearn_courseID NOT IN ({1}) and ec.courseType='Online Learning' and ec.elearn_courseID != " + currentCourse.getCourseID(), itemIDs, itemIDs2);
                        }
                        else
                        {
                            sqlQueryCourseList = String.Format("SELECT * FROM [Elearn_course] ec INNER JOIN [Elearn_courseCategory] ecc ON ec.categoryID = ecc.categoryID WHERE ec.status='active' and ec.start_date <= getDate() and ec.courseType='Online Learning' and ec.elearn_courseID NOT IN ({0}) and ec.elearn_courseID != " + currentCourse.getCourseID(), itemIDs2);
                        }
                        SqlDataSource1.SelectCommand = sqlQueryCourseList;
                        gvPrereq.DataSource = SqlDataSource1;
                        gvPrereq.DataBind();

                        //to load prereq cart

                        var sqlQuery = "";
                        if (itemIDs.Length > 0)
                        {
                            sqlQuery = String.Format("SELECT * FROM [Elearn_course] WHERE [elearn_courseID] IN ({0}) and elearn_courseID != " + currentCourse.getCourseID(), itemIDs);
                        }
                        else
                        {
                            sqlQuery = "SELECT * FROM [Elearn_course] WHERE [elearn_courseID] = -1";
                        }

                        SqlDataSourcePrereqCart.SelectCommand = sqlQuery;
                        gvPrereqCart.DataSource = SqlDataSourcePrereqCart;
                        gvPrereqCart.DataBind();
                        Session["currentMod"] = nameOfModuleInput.Text;
                    }
                }
            }
        }
        protected void btnCfmDeactivate_Click(object sender, EventArgs e)
        {
            Course_elearnDAO ceDAO = new Course_elearnDAO();
            Course_elearn currentCourse = ceDAO.get_course_by_id(Convert.ToInt32(Request.QueryString["id"]));
            ceDAO.deactivateCourse(Convert.ToInt32(Request.QueryString["id"]));
            int cat = currentCourse.getCategoryID();
            Response.Redirect($"viewAllModule.aspx");

        }

        protected void cfmActivate_Click(object sender, EventArgs e)
        {
            Course_elearnDAO ceDAO = new Course_elearnDAO();
            Course_elearn currentCourse = ceDAO.get_course_by_id(Convert.ToInt32(Request.QueryString["id"]));
            ceDAO.activateCourse(Convert.ToInt32(Request.QueryString["id"]));
            int cat = currentCourse.getCategoryID();
            Response.Redirect($"viewAllModule.aspx");

        }

        protected void cfmSubmit_Click(object sender, EventArgs e)
        {
            //to do validations

            Course_elearnDAO ceDAO = new Course_elearnDAO();
            int courseID = Convert.ToInt32(Request.QueryString["id"]);
            //change to MM-dd-yyyy
            string fromDate = fromDateInput.Text.Substring(3, 2) + "/" + fromDateInput.Text.Substring(0, 2) + "/" + fromDateInput.Text.Substring(6, 4);
            string toDate = toDateInput.Text.Substring(3, 2) + "/" + toDateInput.Text.Substring(0, 2) + "/" + toDateInput.Text.Substring(6, 4);
            ceDAO.updateCourse(courseID, Convert.ToInt32(moduleType.SelectedValue), nameOfModuleInput.Text, descriptionModuleInput.Text, Convert.ToDouble(hoursInput.Text), DateTime.ParseExact(fromDate, "MM/dd/yyyy", CultureInfo.InvariantCulture), DateTime.ParseExact(toDate, "MM/dd/yyyy", CultureInfo.InvariantCulture));
            //update prerequisites
            //delete all prereq first
            ceDAO.deletePrerequisitesByCourseID(courseID);
            //insert all new prereq
            List<int> prereqIDlist = (List<int>)Session["selectedPrereq"];
            foreach (int prereqID in prereqIDlist)
            {
                ceDAO.insertPrerequisite(courseID, prereqID);
            }

            Response.Redirect($"viewModuleInfo.aspx?id={courseID}");
        }

        protected void gvPrereq_PageIndexChanged(object sender, EventArgs e)
        {
            
        }

        protected void gvPrereq_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            List<int> prereqIDlist = (List<int>)Session["selectedPrereq"];
            int id = Convert.ToInt32(e.CommandArgument);

            //to get course and add any prereq related to the course
            Course_elearnDAO ceDAO = new Course_elearnDAO();
            Course_elearn currentCourse = ceDAO.get_course_by_id(Convert.ToInt32(Request.QueryString["id"]));
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
            
            var itemIDs2 = string.Join(",", ((IList<int>)Session["selectedPostreq"]).ToArray());

            var sqlQueryCourseList = "";
            if (itemIDs.Length > 0)
            {
                sqlQueryCourseList = String.Format("SELECT * FROM [Elearn_course] ec INNER JOIN [Elearn_courseCategory] ecc ON ec.categoryID = ecc.categoryID WHERE ec.status='active' and ec.start_date <= getDate() and ec.elearn_courseID NOT IN ({0}) and ec.elearn_courseID NOT IN ({1}) and ec.courseType='Online Learning' and ec.elearn_courseID != " + currentCourse.getCourseID(), itemIDs, itemIDs2);
            }
            else
            {
                sqlQueryCourseList = String.Format("SELECT * FROM [Elearn_course] ec INNER JOIN [Elearn_courseCategory] ecc ON ec.categoryID = ecc.categoryID WHERE ec.status='active' and ec.start_date <= getDate() and ec.courseType='Online Learning' and ec.elearn_courseID NOT IN ({0}) and ec.elearn_courseID != " + currentCourse.getCourseID(), itemIDs2);
            }
            SqlDataSource1.SelectCommand = sqlQueryCourseList;
            gvPrereq.DataSource = SqlDataSource1;
            gvPrereq.DataBind();

            var sqlQuery = String.Format("SELECT * FROM [Elearn_course] WHERE [elearn_courseID] IN ({0}) and elearn_courseID != " + currentCourse.getCourseID(), itemIDs);

            SqlDataSourcePrereqCart.SelectCommand = sqlQuery;
            gvPrereqCart.DataSource = SqlDataSourcePrereqCart;
            gvPrereqCart.DataBind();
        }

        protected void gvPrereqCart_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            List<int> prereqIDlist = (List<int>)Session["selectedPrereq"];
            int id = Convert.ToInt32(e.CommandArgument);
            Course_elearnDAO ceDAO = new Course_elearnDAO();
            Course_elearn currentCourse = ceDAO.get_course_by_id(Convert.ToInt32(Request.QueryString["id"]));
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

            var itemIDs2 = string.Join(",", ((IList<int>)Session["selectedPostreq"]).ToArray());

            var sqlQueryCourseList = "";
            if (itemIDs.Length > 0)
            {
                sqlQueryCourseList = String.Format("SELECT * FROM [Elearn_course] ec INNER JOIN [Elearn_courseCategory] ecc ON ec.categoryID = ecc.categoryID WHERE ec.status='active' and ec.start_date <= getDate() and ec.elearn_courseID NOT IN ({0}) and ec.elearn_courseID NOT IN ({1}) and ec.courseType='Online Learning' and ec.elearn_courseID != " + currentCourse.getCourseID(), itemIDs, itemIDs2);
            }
            else
            {
                sqlQueryCourseList = String.Format("SELECT * FROM [Elearn_course] ec INNER JOIN [Elearn_courseCategory] ecc ON ec.categoryID = ecc.categoryID WHERE ec.status='active' and ec.start_date <= getDate() and ec.courseType='Online Learning' and ec.elearn_courseID NOT IN ({0}) and ec.elearn_courseID != " + currentCourse.getCourseID(), itemIDs2);
            }
            SqlDataSource1.SelectCommand = sqlQueryCourseList;
            gvPrereq.DataSource = SqlDataSource1;
            gvPrereq.DataBind();

            var sqlQuery = "";
            if (itemIDs.Length > 0)
            {
                sqlQuery = String.Format("SELECT * FROM [Elearn_course] WHERE [elearn_courseID] IN ({0}) and elearn_courseID != " + currentCourse.getCourseID(), itemIDs);
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
            foreach (Course_elearn prerequisite in coursePrereqs)
            {
                toReturn.Add(prerequisite.getCourseID());
                ArrayList morePrereq = getAllPrerequisites(prerequisite.getCourseID());
                if (morePrereq.Count > 0)
                {
                    foreach (int prerequisitesID in morePrereq)
                    {
                        toReturn.Add(prerequisitesID);
                    }
                }
            }
            return toReturn;
        }

        protected void validateNameExists(Object source, EventArgs args)
        {
            System.Diagnostics.Debug.WriteLine("VALIDATENAMEEXISTS");
            String input = nameOfModuleInput.Text;
            Course_elearnDAO course_elearnDAO = new Course_elearnDAO();
            if (course_elearnDAO.checkModuleNameExists(input))
            {
                if ((String)Session["currentMod"] == input)
                {
                    System.Diagnostics.Debug.WriteLine("modulenamedoesnotexist");
                    //lbl_nameValidate.Visible = false;
                    lbl_nameValidate.Attributes.Add("style", "display:none");
                    lbl_nameValidate.Text = "";
                }
                else
                {
                    System.Diagnostics.Debug.WriteLine("modulenameexists");
                    //lbl_nameValidate.Visible = true;
                    lbl_nameValidate.Attributes.Add("style", "display:unset");
                    lbl_nameValidate.Text = "This module already exists! Please input another Name.";
                }

            }
            else
            {
                System.Diagnostics.Debug.WriteLine("modulenamedoesnotexist");
                //lbl_nameValidate.Visible = false;
                lbl_nameValidate.Attributes.Add("style", "display:none");
                lbl_nameValidate.Text = "";
            }
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
                    foreach (int innerListCourseID in innerList)
                    {
                        toReturn.Add(innerListCourseID);
                    }
                }
            }
            return toReturn;
        }
    }
}