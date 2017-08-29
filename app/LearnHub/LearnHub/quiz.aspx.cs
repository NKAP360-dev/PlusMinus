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
    public partial class quiz : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            QuizDAO quizDAO = new QuizDAO();
            String id_str = Request.QueryString["id"];
            int id_num = int.Parse(id_str);
            Quiz currentQuiz = quizDAO.getQuizByID(id_num);
            User currentUser = (User)Session["currentUser"];
            if (currentUser == null)
            {
                Response.Redirect("Login.aspx");
            }
            else
            {
                //check if user completed all prerequisites of the quiz
                Boolean checkCompleted = checkIfCompletedAllPrerequisite(currentUser.getUserID(), currentQuiz.getQuizID());

                if (!checkCompleted)
                {
                    //redirect user to complete all prerequisite quiz first
                    Response.Redirect("Home.aspx");
                }
                else
                {
                    if (!IsPostBack)
                    {
                        int questionCounter = 1;
                        Session["questionCounter"] = questionCounter;
                        lblBreadcrumbCourseName.Text = currentQuiz.getMainCourse().getCourseName();
                        lblQuizDesc.Text = currentQuiz.getDescription();
                        QuizQuestionDAO qqDAO = new QuizQuestionDAO();
                        List<QuizQuestion> allQuestions = qqDAO.getAllQuizQuestionByQuizID(currentQuiz.getQuizID());
                        lblQnNum.Text = "1";
                        lblTotalQn.Text = allQuestions.Count.ToString();
                        lblTotalNumQn.Text = allQuestions.Count.ToString();
                        if (currentQuiz.getRandomOrder().Equals("y"))
                        {
                            //Random rand = new Random();
                            //var result = allQuestions.OrderBy(item => rand.Next());
                            Session["remainingQuestions"] = randomize(allQuestions);
                        }
                        else
                        {
                            Session["remainingQuestions"] = allQuestions;
                        }
                    }
                    else
                    {
                        lblQnNum.Text = Session["questionCounter"].ToString();
                    }
                }
            }
        }

        protected void btnStartQuiz_Click(object sender, EventArgs e)
        {
            List<QuizResultHistory> userAnswers = new List<QuizResultHistory>();
            Session["userAnswers"] = userAnswers;

            List<QuizQuestion> remainingQuestions = (List<QuizQuestion>)Session["remainingQuestions"];
            QuizQuestion currentQuestion = remainingQuestions[0];
            Session["previousQuestion"] = currentQuestion;
            QuizAnswerDAO qaDAO = new QuizAnswerDAO();
            List<QuizAnswer> currentPossibleAnswers = qaDAO.getAllQuizAnswersByQuizQuestionID(currentQuestion.getQuizQuestionID());
            
            lblQuestion.Text = currentQuestion.getQuestion();
            foreach(QuizAnswer qa in currentPossibleAnswers)
            {
                rblAnswers.Items.Add(new ListItem(qa.getAnswer(), qa.getQuizAnswerID().ToString()));
            }
            
            //to start timer

            panelQuiz.Visible = true;
            panelStartQuiz.Visible = false;
            btnFinish.Visible = false;

        }
        protected Boolean checkIfCompletedAllPrerequisite(string userID, int quizID)
        {
            QuizDAO quizDAO = new QuizDAO();
            QuizResultDAO qrDAO = new QuizResultDAO();
            ArrayList allPrerequisites = quizDAO.getPrereqOfQuiz(quizID);
            foreach (Quiz prereq in allPrerequisites)
            {
                if (!qrDAO.getQuizResultByUserIDandQuizID(userID, prereq.getQuizID()))
                {
                    return false;
                }
            }
            return true;
        }
        protected List<QuizQuestion> randomize(List<QuizQuestion> list)
        {
            Random rnd = new Random();
            for (int i = list.Count; i > 1; i--)
            {
                int pos = rnd.Next(i);
                var x = list[i - 1];
                list[i - 1] = list[pos];
                list[pos] = x;
            }
            return list;
        }

        protected void btnNext_Click(object sender, EventArgs e)
        {
            //handle question counter
            int counter = (int)Session["questionCounter"];
            counter++;
            lblQnNum.Text = counter.ToString();
            Session["questionCounter"] = counter;

            //handle remaining questions
            List<QuizQuestion> remainingQuestions = (List<QuizQuestion>)Session["remainingQuestions"];
            remainingQuestions.RemoveAt(0);
            Session["remainingQuestions"] = remainingQuestions;

            //handle current question and answer
            QuizResultHistory currentAnswer = new QuizResultHistory();
            QuizQuestionDAO qqDAO = new QuizQuestionDAO();
            QuizQuestion currentQuestion = (QuizQuestion)Session["previousQuestion"];
            QuizAnswer currentSelectedAnswer = new QuizAnswer(Convert.ToInt32(rblAnswers.SelectedValue), currentQuestion, rblAnswers.SelectedItem.Text);
            currentAnswer.setQuestion(currentQuestion);
            currentAnswer.setAnswer(currentSelectedAnswer);
            List<QuizResultHistory> userAnswers = (List<QuizResultHistory>)Session["userAnswers"];
            userAnswers.Add(currentAnswer);
            Session["userAnswers"] = userAnswers;

            if (remainingQuestions.Count > 0)
            {
                //handle displaying next qn
                QuizQuestion nextQuestion = remainingQuestions[0];
                Session["previousQuestion"] = nextQuestion;
                QuizAnswerDAO qaDAO = new QuizAnswerDAO();
                List<QuizAnswer> nextPossibleAnswers = qaDAO.getAllQuizAnswersByQuizQuestionID(nextQuestion.getQuizQuestionID());

                lblQuestion.Text = nextQuestion.getQuestion();
                rblAnswers.Items.Clear();
                foreach (QuizAnswer qa in nextPossibleAnswers)
                {
                    rblAnswers.Items.Add(new ListItem(qa.getAnswer(), qa.getQuizAnswerID().ToString()));
                }
            }
            if (remainingQuestions.Count == 1)
            {
                btnFinish.Visible = true;
                btnNext.Visible = false;
            }
        }

        protected void btnFinish_Click(object sender, EventArgs e)
        {
            //handle current question and answer
            QuizResultHistory currentAnswer = new QuizResultHistory();
            QuizQuestionDAO qqDAO = new QuizQuestionDAO();
            QuizQuestion currentQuestion = (QuizQuestion)Session["previousQuestion"];
            QuizAnswer currentSelectedAnswer = new QuizAnswer(Convert.ToInt32(rblAnswers.SelectedValue), currentQuestion, rblAnswers.SelectedItem.Text);
            currentAnswer.setQuestion(currentQuestion);
            currentAnswer.setAnswer(currentSelectedAnswer);
            List<QuizResultHistory> userAnswers = (List<QuizResultHistory>)Session["userAnswers"];
            userAnswers.Add(currentAnswer);
        }
    }
}