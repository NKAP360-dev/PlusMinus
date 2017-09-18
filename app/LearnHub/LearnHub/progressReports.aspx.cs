﻿using LearnHub.AppCode.dao;
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
    public partial class progressReports : System.Web.UI.Page
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
                UserDAO userDAO = new UserDAO();
                User user = userDAO.getUserByID((String)Request.QueryString["id"]);
                if (user.getSupervisor().Equals(currentUser.getUserID()))
                {
                    QuizResultDAO qrDAO = new QuizResultDAO();
                    lblUsername.Text = user.getName();
                    int numOfCourseComplete = checkNumberOfCourseUserComplete(user.getUserID());
                    lblCourseNumber.Text = numOfCourseComplete.ToString();
                    lblQuizNumber.Text = qrDAO.getNumberOfPassQuiz(user.getUserID()).ToString();
                }
                else
                {
                    Response.Redirect("errorPage.aspx");
                }
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
                }
            }
            Session["allCompletedCourseID"] = allCompletedCourseID;
            return counter;
        }
    }
}