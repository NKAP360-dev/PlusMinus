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
    public partial class editQuiz : System.Web.UI.Page
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
                QuizDAO quizDAO = new QuizDAO();
                String id_str = Request.QueryString["id"];
                int id_num = int.Parse(id_str);
                Quiz currentQuiz = quizDAO.getQuizByID(id_num);
                Course_elearn currentCourse = currentQuiz.getMainCourse();
                lblBreadcrumbCourseName.Text = currentQuiz.getMainCourse().getCourseName();
                if (currentUser.getUserID() != currentCourse.getCourseCreator().getUserID() && !(currentUser.getRole().Equals("course creator") || currentUser.getRole().Equals("superuser")))
                {
                    Response.Redirect("errorPage.aspx");
                }
                else
                {
                    if (!IsPostBack)
                    {
                        txtQuizTitle.Text = currentQuiz.getTitle();
                        txtQuizDesc.Text = currentQuiz.getDescription();
                        txtNumCorrectAns.Text = currentQuiz.getPassingGrade().ToString();
                        if (currentQuiz.getRandomOrder().Equals("y"))
                        {
                            ddlRandomize.SelectedIndex = 0;
                        } else
                        {
                            ddlRandomize.SelectedIndex = 1;
                        }

                        if (currentQuiz.getStatus().Equals("active"))
                        {
                            btnActivate.Visible = false;
                            btnDeactivate.Visible = true;
                        }
                        else
                        {
                            btnActivate.Visible = true;
                            btnDeactivate.Visible = false;
                        }

                        //prerequisites
                        ArrayList allPrerequisites = quizDAO.getPrereqOfQuiz(currentQuiz.getQuizID());
                        List<int> prereqIDlist = new List<int>();
                        foreach (Quiz prereq in allPrerequisites)
                        {
                            prereqIDlist.Add(prereq.getQuizID());
                        }
                        Session["selectedPrereq"] = prereqIDlist;
                        var itemIDs = string.Join(",", ((IList<int>)Session["selectedPrereq"]).ToArray());

                        //to load course list
                        var sqlQueryQuizList = "";
                        if (itemIDs.Length > 0)
                        {
                            sqlQueryQuizList = String.Format("SELECT * FROM [Quiz] WHERE status='active' and elearn_courseID='{0}' and quizID NOT IN ({1}) and quizID != " + id_str, currentCourse.getCourseID(), itemIDs);
                        }
                        else
                        {
                            sqlQueryQuizList = "SELECT * FROM [Quiz] WHERE status='active' and elearn_courseID = '" + currentCourse.getCourseID() + "' and quizID != " + currentQuiz.getQuizID();
                        }
                        SqlDataSource1.SelectCommand = sqlQueryQuizList;
                        gvPrereq.DataSource = SqlDataSource1;
                        gvPrereq.DataBind();

                        //to load prereq cart

                        var sqlQuery = "";
                        if (itemIDs.Length > 0)
                        {
                            sqlQuery = String.Format("SELECT * FROM [Quiz] WHERE [quizID] IN ({0}) and quizID != " + currentQuiz.getQuizID(), itemIDs);
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
            }
        }

        protected void gvPrereq_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            string id_str = Request.QueryString["id"];
            int id_num = int.Parse(id_str);
            QuizDAO quizDAO = new QuizDAO();
            Quiz currentQuiz = quizDAO.getQuizByID(id_num);
            Course_elearn currentCourse = currentQuiz.getMainCourse();
            List<int> prereqIDlist = (List<int>)Session["selectedPrereq"];
            int id = Convert.ToInt32(e.CommandArgument);

            //to get quiz and add any prereq related to the quiz
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
                sqlQueryCourseList = String.Format("SELECT * FROM [Quiz] WHERE status='active' and elearn_courseID='{0}' and quizID NOT IN ({1}) and quizID != " + id_str, currentCourse.getCourseID(), itemIDs);
            }
            else
            {
                sqlQueryCourseList = "SELECT * FROM [Quiz] WHERE status='active' and elearn_courseID = '" + currentCourse.getCourseID() + "' and quizID != " + currentQuiz.getQuizID();
            }
            SqlDataSource1.SelectCommand = sqlQueryCourseList;
            gvPrereq.DataSource = SqlDataSource1;
            gvPrereq.DataBind();

            var sqlQuery = String.Format("SELECT * FROM [Quiz] WHERE [quizID] IN ({0}) and quizID != " + currentQuiz.getQuizID(), itemIDs);

            SqlDataSourcePrereqCart.SelectCommand = sqlQuery;
            gvPrereqCart.DataSource = SqlDataSourcePrereqCart;
            gvPrereqCart.DataBind();
        }

        protected void gvPrereqCart_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            string id_str = Request.QueryString["id"];
            int id_num = int.Parse(id_str);
            QuizDAO quizDAO = new QuizDAO();
            Quiz currentQuiz = quizDAO.getQuizByID(id_num);
            Course_elearn currentCourse = currentQuiz.getMainCourse();
            List<int> prereqIDlist = (List<int>)Session["selectedPrereq"];
            int id = Convert.ToInt32(e.CommandArgument);

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
                sqlQueryCourseList = String.Format("SELECT * FROM [Quiz] WHERE status='active' and elearn_courseID='{0}' and quizID NOT IN ({1}) and quizID != " + id_str, currentCourse.getCourseID(), itemIDs);
            }
            else
            {
                sqlQueryCourseList = "SELECT * FROM [Quiz] WHERE status='active' and elearn_courseID = '" + currentCourse.getCourseID() + "' and quizID != " + currentQuiz.getQuizID();
            }
            SqlDataSource1.SelectCommand = sqlQueryCourseList;
            gvPrereq.DataSource = SqlDataSource1;
            gvPrereq.DataBind();

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

        protected void btnConfirmSubmit_Click(object sender, EventArgs e)
        {
            //to do validation

            QuizDAO quizDAO = new QuizDAO();
            int id = Convert.ToInt32(Request.QueryString["id"]);
            Quiz currentQuiz = quizDAO.getQuizByID(id);
            string randomOrder = "";
            if (ddlRandomize.SelectedIndex == 0)
            {
                randomOrder = "y";
            }
            else
            {
                randomOrder = "n";
            }
            quizDAO.updateQuiz(id, txtQuizTitle.Text, txtQuizDesc.Text, Convert.ToInt32(txtNumCorrectAns.Text), randomOrder);

            //update prerequisites

            //delete all prereq first
            quizDAO.deletePrerequisitesByQuizID(id);
            //insert all new prereq
            List<int> prereqIDlist = (List<int>)Session["selectedPrereq"];
            foreach (int prereqID in prereqIDlist)
            {
                quizDAO.insertPrerequisite(currentQuiz.getQuizID(), prereqID);
            }

            Response.Redirect("viewModuleInfo.aspx?id=" + currentQuiz.getMainCourse().getCourseID());
        }

        protected void btnCfmDeactivate_Click(object sender, EventArgs e)
        {
            //to do validation

            QuizDAO quizDAO = new QuizDAO();
            int id = Convert.ToInt32(Request.QueryString["id"]);
            Quiz currentQuiz = quizDAO.getQuizByID(id);
            quizDAO.updateQuizStatus(id, "inactive");
            Response.Redirect("viewModuleInfo.aspx?id=" + currentQuiz.getMainCourse().getCourseID());
        }

        protected void btnCfmActivate_Click(object sender, EventArgs e)
        {
            //to do validation

            QuizDAO quizDAO = new QuizDAO();
            int id = Convert.ToInt32(Request.QueryString["id"]);
            Quiz currentQuiz = quizDAO.getQuizByID(id);
            quizDAO.updateQuizStatus(id, "active");
            Response.Redirect("viewModuleInfo.aspx?id=" + currentQuiz.getMainCourse().getCourseID());
        }
    }
}