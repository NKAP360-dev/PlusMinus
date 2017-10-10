using LearnHub.AppCode.dao;
using LearnHub.AppCode.entity;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LearnHub
{
    public partial class progressReport : System.Web.UI.Page
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
                QuizResultDAO qrDAO = new QuizResultDAO();
                lblUsername.Text = currentUser.getName();
                int numOfCourseComplete = checkNumberOfCourseUserComplete(currentUser.getUserID());
                lblCourseNumber.Text = numOfCourseComplete.ToString();
                lblQuizNumber.Text = qrDAO.getNumberOfPassQuiz(currentUser.getUserID()).ToString();
                double learningHours = (Double)Session["totalLearningHours"];
                lblHours.Text = learningHours.ToString() + " hours";
            }
        }

        protected int checkNumberOfCourseUserComplete(string userID)
        {
            Course_elearnDAO ceDAO = new Course_elearnDAO();
            ArrayList allCourses = ceDAO.getAllCourses();
            QuizDAO quizDAO = new QuizDAO();
            QuizResultDAO qrDAO = new QuizResultDAO();
            ArrayList allResults = qrDAO.getAllQuizResultByUserID(userID);
            List<int> allCompletedCourseID = new List<int>();
            double totalLearningHours = 0;
            int counter = 0;
            foreach(Course_elearn ce in allCourses)
            {
                List<Quiz> allQuizForCourse = quizDAO.getAllQuizByCourseID(ce.getCourseID());
                Boolean checkIfCompleteAllQuiz = true;
                Boolean checkIfCourseGotQuiz = false;
                foreach(Quiz currentQuiz in allQuizForCourse)
                {
                    checkIfCourseGotQuiz = true;
                    if (!qrDAO.checkIfUserPassQuiz(userID,currentQuiz.getQuizID()))
                    {
                        checkIfCompleteAllQuiz = false;
                    }
                }
                if (checkIfCompleteAllQuiz && checkIfCourseGotQuiz)
                {
                    counter++;
                    allCompletedCourseID.Add(ce.getCourseID());
                    totalLearningHours = totalLearningHours + ce.getHoursAwarded();
                }
            }
            Session["allCompletedCourseID"] = allCompletedCourseID;
            Session["totalLearningHours"] = totalLearningHours;
            return counter;
        }
    }
}