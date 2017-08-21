using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace LearnHub.AppCode.entity
{
    public class QuizResult
    {
        private int quizResultID;
        private User user;
        private Quiz quiz;
        private int score;
        private string grade;
        private QuizResultHistory quizResultHistory;
        private DateTime dateSubmitted;

        public QuizResult() { }
        public QuizResult(int quizResultID, User user, Quiz quiz, int score, string grade, QuizResultHistory quizResultHistory, DateTime dateSubmitted)
        {
            this.quizResultID = quizResultID;
            this.user = user;
            this.quiz = quiz;
            this.score = score;
            this.grade = grade;
            this.quizResultHistory = quizResultHistory;
            this.dateSubmitted = dateSubmitted;
        }
        public int getQuizResultID()
        {
            return quizResultID;
        }
        public void setQuizResultID(int quizResultID)
        {
            this.quizResultID = quizResultID;
        }
        public User getUser()
        {
            return user;
        }
        public void setUser(User user)
        {
            this.user = user;
        }
        public Quiz getQuiz()
        {
            return quiz;
        }
        public void setQuiz(Quiz quiz)
        {
            this.quiz = quiz;
        }
        public int getScore()
        {
            return score;
        }
        public void setScore(int score)
        {
            this.score = score;
        }
        public string getGrade()
        {
            return grade;
        }
        public void setGrade(string grade)
        {
            this.grade = grade;
        }
        public QuizResultHistory getQuizResultHistory()
        {
            return quizResultHistory;
        }
        public void setQuizResultHistory(QuizResultHistory quizResultHistory)
        {
            this.quizResultHistory = quizResultHistory;
        }
        public DateTime getDateSubmitted()
        {
            return dateSubmitted;
        }
        public void setDateSubmitted(DateTime dateSubmitted)
        {
            this.dateSubmitted = dateSubmitted;
        }
    }
}