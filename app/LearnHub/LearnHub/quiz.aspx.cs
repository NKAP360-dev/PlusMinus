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
                        lblQuizTitle.Text = currentQuiz.getTitle();
                        QuizQuestionDAO qqDAO = new QuizQuestionDAO();
                        List<QuizQuestion> allQuestions = qqDAO.getAllQuizQuestionByQuizID(currentQuiz.getQuizID());
                        lblQnNum.Text = "1";
                        lblTotalQn.Text = allQuestions.Count.ToString();
                        lblTotalNumQn.Text = allQuestions.Count.ToString();
                        lblPassingReq.Text = currentQuiz.getPassingGrade().ToString() + "/" + allQuestions.Count.ToString();
                        TimeSpan timeLeft = TimeSpan.FromSeconds(currentQuiz.getTimeLimit());
                        lblTimer.Text = timeLeft.ToString(@"hh\:mm\:ss");
                        lblTimerDisplay.Text = timeLeft.ToString(@"hh\:mm\:ss");
                        //lblTimer.Text = currentQuiz.getTimeLimit().ToString();
                        //lblTimerDisplay.Text = currentQuiz.getTimeLimit().ToString();
                        string multipleAttempt = currentQuiz.getMultipleAttempts();
                        if (multipleAttempt.Equals("n"))
                        {
                            int attempts = currentQuiz.getNumberOfAttempts();
                            lblMaxAttempt.Text = attempts + " times";
                        }
                        else
                        {
                            lblMaxAttempt.Text = "No limit";
                        }
                        
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
            QuizDAO quizDAO = new QuizDAO();
            String id_str = Request.QueryString["id"];
            int id_num = int.Parse(id_str);
            Quiz currentQuiz = quizDAO.getQuizByID(id_num);

            List<QuizResultHistory> userAnswers = new List<QuizResultHistory>();
            Session["userAnswers"] = userAnswers;

            List<QuizQuestion> remainingQuestions = (List<QuizQuestion>)Session["remainingQuestions"];
            QuizQuestion currentQuestion = remainingQuestions[0];
            Session["previousQuestion"] = currentQuestion;
            QuizAnswerDAO qaDAO = new QuizAnswerDAO();
            List<QuizAnswer> currentPossibleAnswers = qaDAO.getAllQuizAnswersByQuizQuestionID(currentQuestion.getQuizQuestionID());
            Session["timeLeft"] = DateTime.Now.AddSeconds(currentQuiz.getTimeLimit());
            lblQuestion.Text = currentQuestion.getQuestion();
            foreach(QuizAnswer qa in currentPossibleAnswers)
            {
                rblAnswers.Items.Add(new ListItem(qa.getAnswer(), qa.getQuizAnswerID().ToString()));
            }
            
            panelQuiz.Visible = true;
            panelStartQuiz.Visible = false;

            if (remainingQuestions.Count == 1)
            {
                btnFinish.Visible = true;
                btnNext.Visible = false;
            }
            else
            {
                btnFinish.Visible = false;
                btnNext.Visible = true;
            }

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
            int quizID = Convert.ToInt32(Request.QueryString["id"]);
            User currentUser = (User)Session["currentUser"];
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
            QuizResultHistoryDAO qrhDAO = new QuizResultHistoryDAO();
            QuizQuestionDAO qqDAO = new QuizQuestionDAO();
            QuizQuestion currentQuestion = (QuizQuestion)Session["previousQuestion"];
            QuizAnswer currentSelectedAnswer = new QuizAnswer(Convert.ToInt32(rblAnswers.SelectedValue), currentQuestion, rblAnswers.SelectedItem.Text);
            int attempt = qrhDAO.getAttemptForQuiz(currentQuestion.getQuizQuestionID());
            attempt++;
            currentAnswer.setAttempt(attempt);
            currentAnswer.setUserID(currentUser.getUserID());
            currentAnswer.setQuestion(currentQuestion);
            currentAnswer.setAnswer(currentSelectedAnswer);
            currentAnswer.setQuizID(quizID);
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
            int quizID = Convert.ToInt32(Request.QueryString["id"]);
            User currentUser = (User)Session["currentUser"];
            //handle current question and answer
            QuizDAO quizDAO = new QuizDAO();
            QuizResultDAO qrDAO = new QuizResultDAO();
            QuizResultHistory currentAnswer = new QuizResultHistory();
            QuizResultHistoryDAO qrhDAO = new QuizResultHistoryDAO();
            QuizQuestionDAO qqDAO = new QuizQuestionDAO();
            QuizQuestion currentQuestion = (QuizQuestion)Session["previousQuestion"];
            Quiz currentQuiz = quizDAO.getQuizByID(quizID);
            QuizAnswer currentSelectedAnswer = new QuizAnswer(Convert.ToInt32(rblAnswers.SelectedValue), currentQuestion, rblAnswers.SelectedItem.Text);
            //int attempt = qrhDAO.getAttemptForQuiz(currentQuestion.getQuizQuestionID());
            int attempt = qrDAO.getAttemptForQuiz(quizID);
            attempt++;
            currentAnswer.setAttempt(attempt);
            currentAnswer.setUserID(currentUser.getUserID());
            currentAnswer.setQuestion(currentQuestion);
            currentAnswer.setAnswer(currentSelectedAnswer);
            currentAnswer.setQuizID(quizID);
            List<QuizResultHistory> userAnswers = (List<QuizResultHistory>)Session["userAnswers"];
            userAnswers.Add(currentAnswer);

            //to calculate score
            int userScore = calculateScore(userAnswers);

            //to get all other details needed to insert to QuizResult
            string grade = "fail";
            if (checkIfUserPass(quizID, userScore))
            {
                grade = "pass";
            }
            DateTime currentDate = DateTime.Now.Date;

            //insert quizResultHistory
            foreach (QuizResultHistory qrh in userAnswers)
            {
                qrhDAO.createQuizResultHistory(qrh);
            }

            //insert QuizResult
            int quizResultID = qrDAO.createQuizResult(currentUser.getUserID(), quizID, userScore, grade, currentDate, attempt);

            string displayAnswer = currentQuiz.getDisplayAnswer();
            if (displayAnswer.Equals("always"))
            {
                Response.Redirect("viewResults.aspx?id=" + quizResultID);
            }
            else if (displayAnswer.Equals("never"))
            {
                //Response.Redirect("viewResults.aspx?id=" + quizResultID);
                Response.Redirect("Home.aspx");
            }
            else
            {
                if (grade.Equals("pass"))
                {
                    Response.Redirect("viewResults.aspx?id=" + quizResultID);
                }
                else
                {
                    Response.Redirect("viewMyResult.aspx?id=" + quizResultID);
                }
            }
        }
        protected int calculateScore(List<QuizResultHistory> userAnswers)
        {
            QuizQuestionDAO qqDAO = new QuizQuestionDAO();
            int totalScore = 0;
            foreach (QuizResultHistory qrh in userAnswers)
            {
                if (qqDAO.checkIfAnswerCorrect(qrh.getQuestion().getQuizQuestionID(), qrh.getAnswer().getQuizAnswerID())) 
                {
                    totalScore++;
                }
            }
            return totalScore;
        }
        protected Boolean checkIfUserPass(int quizID, int userScore)
        {
            QuizDAO quizDAO = new QuizDAO();
            Quiz currentQuiz = quizDAO.getQuizByID(quizID);
            if (userScore >= currentQuiz.getPassingGrade())
            {
                return true;
            }
            return false;
        }

        protected void Timer1_Tick(object sender, EventArgs e)
        {
            TimeSpan timeLeft = new TimeSpan();
            if (Session["timeLeft"] != null)
            {
                timeLeft = (DateTime)Session["timeLeft"] - DateTime.Now;
                if (timeLeft.Hours <= 0 && timeLeft.Minutes <= 0 && timeLeft.Seconds <= 0)
                {
                    lblTimer.Text = "Times up!";
                    lblTimerDisplay.Text = "Times up!";
                    panelQuiz.Visible = false;
                    panelStartQuiz.Visible = true;

                    //insert attempt
                    int quizID = Convert.ToInt32(Request.QueryString["id"]);
                    User currentUser = (User)Session["currentUser"];
                    QuizResultDAO qrDAO = new QuizResultDAO();
                    QuizResultHistoryDAO qrhDAO = new QuizResultHistoryDAO();
                    List<QuizResultHistory> userAnswers = (List<QuizResultHistory>)Session["userAnswers"];
                    QuizQuestion currentQuestion = (QuizQuestion)Session["previousQuestion"];
                    int attempt = qrDAO.getAttemptForQuiz(quizID);
                    attempt++;

                    //to calculate score
                    int userScore = calculateScore(userAnswers);

                    //to get all other details needed to insert to QuizResult
                    string grade = "fail";
                    if (checkIfUserPass(quizID, userScore))
                    {
                        grade = "pass";
                    }
                    DateTime currentDate = DateTime.Now.Date;

                    //insert quizResultHistory
                    foreach (QuizResultHistory qrh in userAnswers)
                    {
                        qrhDAO.createQuizResultHistory(qrh);
                    }

                    //insert QuizResult
                    int quizResultID = qrDAO.createQuizResult(currentUser.getUserID(), quizID, userScore, grade, currentDate, attempt);

                }
                else
                {
                    //lblTimer.Text = timeLeft.Seconds.ToString();
                    lblTimer.Text = timeLeft.ToString(@"hh\:mm\:ss");
                }
            }
        }
    }
}