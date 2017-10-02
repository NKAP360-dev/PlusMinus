using System;
using LearnHub.AppCode.entity;
using LearnHub.AppCode.dao;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Collections;

namespace LearnHub
{
    public partial class createQuiz : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            User currentUser = (User)Session["currentUser"];
            if (currentUser == null)
            {
                Response.Redirect("Login.aspx");
            }
            else
            {
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
                if (superuser || course_creator)
                {
                    if (!IsPostBack)
                    {

                        Course_elearnDAO cdao = new Course_elearnDAO();
                        string id_str = Request.QueryString["id"];
                        int id_num = int.Parse(id_str);
                        lblBreadcrumbCourseName.Text = cdao.get_course_by_id(id_num).getCourseName();

                        List<int> prereqIDlist = new List<int>();
                        List<string> part1 = new List<string>();
                        Session["createQuiz1"] = part1;
                        Session["selectedPrereq"] = prereqIDlist;
                        var itemIDs = string.Join(",", ((IList<int>)Session["selectedPrereq"]).ToArray());

                        //to load course list
                        var sqlQueryCourseList = "";
                        if (itemIDs.Length > 0)
                        {
                            sqlQueryCourseList = String.Format("SELECT * FROM [Quiz] WHERE status='active' and elearn_courseID='{0}' and quizID NOT IN ({1})", id_str, itemIDs);
                        }
                        else
                        {
                            sqlQueryCourseList = "SELECT * FROM [Quiz] WHERE status='active' and elearn_courseID = '" + id_str + "'";
                        }
                        SqlDataSource1.SelectCommand = sqlQueryCourseList;
                        gvPrereq.DataSource = SqlDataSource1;
                        gvPrereq.DataBind();

                        gvPrereq.UseAccessibleHeader = true;

                        if (gvPrereq.Rows.Count > 0)
                        {
                            gvPrereq.HeaderRow.TableSection = TableRowSection.TableHeader;
                        }

                        //to load prereq cart

                        var sqlQuery = "";
                        if (itemIDs.Length > 0)
                        {
                            sqlQuery = String.Format("SELECT * FROM [Quiz] WHERE [quizID] IN ({0})", itemIDs);
                        }
                        else
                        {
                            sqlQuery = "SELECT * FROM [Quiz] WHERE [quizID] = -1";
                        }

                        SqlDataSourcePrereqCart.SelectCommand = sqlQuery;
                        gvPrereqCart.DataSource = SqlDataSourcePrereqCart;
                        gvPrereqCart.DataBind();
                    }
                }
                else
                {
                    Response.Redirect("errorPage.aspx");
                }
            }
        }

        protected void gvPrereq_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            string id_str = Request.QueryString["id"];
            List<int> prereqIDlist = (List<int>)Session["selectedPrereq"];
            int id = Convert.ToInt32(e.CommandArgument);

            //to get quiz and add any prereq related to the quiz
            QuizDAO quizDAO = new QuizDAO();
            Quiz selectedQuiz = quizDAO.getQuizByID(id);
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
                sqlQueryCourseList = String.Format("SELECT * FROM [Quiz] WHERE status='active' and elearn_courseID='{0}' and quizID NOT IN ({1})", id_str, itemIDs);
            }
            else
            {
                sqlQueryCourseList = "SELECT * FROM [Quiz] WHERE status='active' and elearn_courseID = '" + id_str + "'";
            }
            SqlDataSource1.SelectCommand = sqlQueryCourseList;
            gvPrereq.DataSource = SqlDataSource1;
            gvPrereq.DataBind();

            gvPrereq.UseAccessibleHeader = true;

            if (gvPrereq.Rows.Count > 0)
            {
                gvPrereq.HeaderRow.TableSection = TableRowSection.TableHeader;
            }

            var sqlQuery = String.Format("SELECT * FROM [Quiz] WHERE [quizID] IN ({0})", itemIDs);

            SqlDataSourcePrereqCart.SelectCommand = sqlQuery;
            gvPrereqCart.DataSource = SqlDataSourcePrereqCart;
            gvPrereqCart.DataBind();
        }

        protected void gvPrereqCart_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            string id_str = Request.QueryString["id"];
            List<int> prereqIDlist = (List<int>)Session["selectedPrereq"];
            int id = Convert.ToInt32(e.CommandArgument);
            QuizDAO quizDAO = new QuizDAO();
            List<int> allLinkedQuizzes = quizDAO.getAllQuizLinkedToPrerequisite(id);
            foreach (int linkedID in allLinkedQuizzes)
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
                sqlQueryCourseList = String.Format("SELECT * FROM [Quiz] WHERE status='active' and elearn_courseID='{0}' and quizID NOT IN ({1})", id_str, itemIDs);
            }
            else
            {
                sqlQueryCourseList = "SELECT * FROM [Quiz] WHERE status='active' and elearn_courseID = '" + id_str + "'";
            }
            SqlDataSource1.SelectCommand = sqlQueryCourseList;
            gvPrereq.DataSource = SqlDataSource1;
            gvPrereq.DataBind();

            gvPrereq.UseAccessibleHeader = true;

            if (gvPrereq.Rows.Count > 0)
            {
                gvPrereq.HeaderRow.TableSection = TableRowSection.TableHeader;
            }

            var sqlQuery = "";
            if (itemIDs.Length > 0)
            {
                sqlQuery = String.Format("SELECT * FROM [Quiz] WHERE [quizID] IN ({0})", itemIDs);
            }
            else
            {
                sqlQuery = "SELECT * FROM [Quiz] WHERE [quizID] = -1";
            }

            SqlDataSourcePrereqCart.SelectCommand = sqlQuery;
            gvPrereqCart.DataSource = SqlDataSourcePrereqCart;
            gvPrereqCart.DataBind();
        }
        protected ArrayList getAllPrerequisites(int quizID)
        {
            ArrayList toReturn = new ArrayList();
            QuizDAO quizDAO = new QuizDAO();
            ArrayList quizPrereqs = quizDAO.getPrereqOfQuiz(quizID);
            foreach (Quiz prerequisite in quizPrereqs)
            {
                toReturn.Add(prerequisite.getQuizID());
                ArrayList morePrereq = getAllPrerequisites(prerequisite.getQuizID());
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

        protected void btnCreate_Click(object sender, EventArgs e)
        {
            //to do validations
            Page.Validate("ValidateForm");
            if (!Page.IsValid)
            {

            }
            else
            {
                String input = txtQuizTitle.Text;
                QuizDAO quizdao = new QuizDAO();
                List<Quiz> quizList = quizdao.getAllQuiz();
                Boolean checker = false;
                foreach(Quiz curr in quizList)
                {
                    if(curr.getTitle() == input)
                    {
                        checker = true;
                    }
                }
                if (checker == true)
                {
                    lbl_duplicateTitle.Text = "This Quiz title already exists! Please enter another one!";
                }
                else
                {
                    lbl_duplicateTitle.Text = "";
                    int courseID = Convert.ToInt32(Request.QueryString["id"]);
                    List<string> part1 = new List<string>();
                    part1.Add(txtQuizTitle.Text);
                    part1.Add(txtQuizDesc.Text);
                    Session["createQuiz1"] = part1;
                    Response.Redirect("createQuizQnA.aspx?id=" + courseID);
                }
            }
        }
    }
}