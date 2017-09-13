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
    public partial class createQuizQnA : System.Web.UI.Page
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
                if (!superuser || !course_creator)
                {
                    Response.Redirect("errorPage.aspx");
                }
                if (!IsPostBack)
                {
                    Course_elearnDAO cdao = new Course_elearnDAO();
                    String id_str = Request.QueryString["id"];
                    int id_num = int.Parse(id_str);
                    lblBreadcrumbCourseName.Text = cdao.get_course_by_id(id_num).getCourseName();

                    List<QuizQuestion> allQuestions = new List<QuizQuestion>();
                    Session["allQuestions"] = allQuestions;
                    Session["questionNumber"] = 1;
                    lblQuestionNumber.Text = "Question " + 1;
                    lblAddedMsg.Visible = false;
                }
                else
                {
                    int counter = (int)Session["questionNumber"];
                    lblQuestionNumber.Text = "Question " + counter;
                    lblAddedMsg.Visible = false;
                }
            }
        }

        protected void btnNewQn_Click(object sender, EventArgs e)
        {

            //to do validation
            Page.Validate("ValidateForm");
            if (!Page.IsValid)
            {

            }
            else
            {
                List<QuizQuestion> allQuestions = (List<QuizQuestion>)Session["allQuestions"];
                QuizQuestion newQuestion = new QuizQuestion();
                newQuestion.setQuestion(txtQuizQuestion.Text);

                QuizAnswer answer1 = new QuizAnswer();
                answer1.setAnswer(txtOptionOne.Text);

                QuizAnswer answer2 = new QuizAnswer();
                answer2.setAnswer(txtOptionTwo.Text);

                QuizAnswer answer3 = new QuizAnswer();
                answer3.setAnswer(txtOptionThree.Text);

                QuizAnswer answer4 = new QuizAnswer();
                answer4.setAnswer(txtOptionFour.Text);

                List<QuizAnswer> allAnswers = new List<QuizAnswer>();
                allAnswers.Add(answer1);
                allAnswers.Add(answer2);
                allAnswers.Add(answer3);
                allAnswers.Add(answer4);

                newQuestion.setAllAnswers(allAnswers);

                if (ddlCorrectAns.SelectedValue.Equals("1"))
                {
                    newQuestion.setQuizAnswer(answer1);
                }
                else if (ddlCorrectAns.SelectedValue.Equals("2"))
                {
                    newQuestion.setQuizAnswer(answer2);
                }
                else if (ddlCorrectAns.SelectedValue.Equals("3"))
                {
                    newQuestion.setQuizAnswer(answer3);
                }
                else
                {
                    newQuestion.setQuizAnswer(answer4);
                }

                allQuestions.Add(newQuestion);
                Session["allQuestions"] = allQuestions;
                int counter = (int)Session["questionNumber"];
                lblAddedMsg.Text = $"Question {counter++} has been added successfully.";
                lblAddedMsg.Visible = true;
                Session["questionNumber"] = counter;
                txtQuizQuestion.Text = "";
                txtNumCorrectAns.Text = "";
                txtOptionOne.Text = "";
                txtOptionTwo.Text = "";
                txtOptionThree.Text = "";
                txtOptionFour.Text = "";
                lblQuestionNumber.Text = "Question " + counter;
            }
        }

        protected void btnConfirmSubmit_Click(object sender, EventArgs e)
        {
            //to do validation

            //add the last question
            List<QuizQuestion> allQuestions = (List<QuizQuestion>)Session["allQuestions"];
            QuizQuestion newQuestion = new QuizQuestion();
            newQuestion.setQuestion(txtQuizQuestion.Text);

            QuizAnswer answer1 = new QuizAnswer();
            answer1.setAnswer(txtOptionOne.Text);

            QuizAnswer answer2 = new QuizAnswer();
            answer2.setAnswer(txtOptionTwo.Text);

            QuizAnswer answer3 = new QuizAnswer();
            answer3.setAnswer(txtOptionThree.Text);

            QuizAnswer answer4 = new QuizAnswer();
            answer4.setAnswer(txtOptionFour.Text);

            List<QuizAnswer> allAnswersForLastQn = new List<QuizAnswer>();
            allAnswersForLastQn.Add(answer1);
            allAnswersForLastQn.Add(answer2);
            allAnswersForLastQn.Add(answer3);
            allAnswersForLastQn.Add(answer4);

            newQuestion.setAllAnswers(allAnswersForLastQn);

            if (ddlCorrectAns.SelectedValue.Equals("1"))
            {
                newQuestion.setQuizAnswer(answer1);
            }
            else if (ddlCorrectAns.SelectedValue.Equals("2"))
            {
                newQuestion.setQuizAnswer(answer2);
            }
            else if (ddlCorrectAns.SelectedValue.Equals("3"))
            {
                newQuestion.setQuizAnswer(answer3);
            }
            else
            {
                newQuestion.setQuizAnswer(answer4);
            }

            allQuestions.Add(newQuestion);

            QuizDAO quizDAO = new QuizDAO();
            QuizAnswerDAO qaDAO = new QuizAnswerDAO();
            QuizQuestionDAO qqDAO = new QuizQuestionDAO();
            Course_elearnDAO ceDAO = new Course_elearnDAO();

            Course_elearn currentCourse = ceDAO.get_course_by_id(Convert.ToInt32(Request.QueryString["id"]));

            //create quiz
            List<string> part1 = (List<string>)Session["createQuiz1"];
            Quiz newQuiz = new Quiz();
            newQuiz.setTitle(part1[0]);
            newQuiz.setDescription(part1[1]);
            newQuiz.setMainCourse(currentCourse);
            newQuiz.setPassingGrade(Convert.ToInt32(txtNumCorrectAns.Text));
            newQuiz.setStatus("active");
            if (ddlRandomize.SelectedValue.Equals("y"))
            {
                newQuiz.setRandomOrder("y");
            }
            else
            {
                newQuiz.setRandomOrder("n");
            }
            newQuiz.setTimeLimit(Convert.ToInt32(txtTimeLimit.Text));
            if (rdlAttempt.SelectedValue.Equals("y"))
            {
                newQuiz.setMultipleAttempts("y");
            }
            else
            {
                newQuiz.setMultipleAttempts("n");
            }
            newQuiz.setNumberOfAttempts(Convert.ToInt32(txtNoOfAttempt.Text));
            newQuiz.setDisplayAnswer(ddlDisplayAnswer.SelectedValue);

            int quizID = quizDAO.createQuiz(newQuiz);

            //add prerequisites
            List<int> prereqIDlist = (List<int>)Session["selectedPrereq"];
            foreach (int prereqID in prereqIDlist)
            {
                quizDAO.insertPrerequisite(quizID, prereqID);
            }

            //create question and answer
            foreach (QuizQuestion question in allQuestions) {
                question.setQuiz(quizDAO.getQuizByID(quizID));
                int questionID = qqDAO.createQuizQuestion(question);
                QuizQuestion currentQuestion = qqDAO.getQuizQuestionByID(questionID);
                List<QuizAnswer> allAnswers = question.getAllAnswers();
                foreach (QuizAnswer answer in allAnswers)
                {
                    answer.setQuizQuestion(currentQuestion);
                    int answerID = qaDAO.createQuizAnswer(answer);
                    if (question.getQuizAnswer().getAnswer().Equals(answer.getAnswer()))
                    {
                        qqDAO.updateCorrectAnswerID(questionID, answerID);
                    }
                }
             }

            Response.Redirect($"quizSummary.aspx?id={currentCourse.getCourseID()}");
        }
    }
}