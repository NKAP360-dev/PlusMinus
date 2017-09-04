using System;
using LearnHub.AppCode.entity;
using LearnHub.AppCode.dao;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LearnHub
{
    public partial class viewMyResult : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            QuizResultDAO qrDAO = new QuizResultDAO();
            QuizQuestionDAO qqDAO = new QuizQuestionDAO();
            int quizResultID = Convert.ToInt32(Request.QueryString["id"]);
            QuizResult currentQuizResult = qrDAO.getQuizResultByID(quizResultID);
            Quiz currentQuiz = currentQuizResult.getQuiz();
            User currentUser = (User)Session["currentUser"];
            List<QuizQuestion> allQuestions = qqDAO.getAllQuizQuestionByQuizID(currentQuiz.getQuizID());
            Boolean superuser = false;
            foreach (string s in currentUser.getRoles())
            {
                if (s.Equals("superuser"))
                {
                    superuser = true;
                }
            }
            if (currentUser == null)
            {
                Response.Redirect("Login.aspx");
            }
            else if (currentQuizResult.getUser().getUserID() != currentUser.getUserID() && !superuser)
            {
                Response.Redirect("errorPage.aspx");
            }
            else
            {
                lblBreadcrumbCourseName.Text = currentQuiz.getMainCourse().getCourseName();
                lblScore.Text = currentQuizResult.getScore() + "/" + allQuestions.Count;
                lblAttemptNo.Text = currentQuizResult.getAttempt().ToString();
                lblQuizDate.Text = currentQuizResult.getDateSubmitted().ToString("dd/MM/yyyy");
                string grade = currentQuizResult.getGrade();
                if (grade.Equals("pass"))
                {
                    lblStatusPass.Visible = true;
                    lblStatusFail.Visible = false;
                }
                else
                {
                    lblStatusPass.Visible = false;
                    lblStatusFail.Visible = true;
                }
            }
        }
    }
}