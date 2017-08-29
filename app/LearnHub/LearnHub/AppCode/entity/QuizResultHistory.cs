using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace LearnHub.AppCode.entity
{
    public class QuizResultHistory
    {
        private string userID;
        private QuizQuestion question;
        private QuizAnswer answer;
        private int attempt;
        private int quizID;

        public QuizResultHistory() { }
        public QuizResultHistory(string userID, QuizQuestion question, QuizAnswer answer)
        {
            this.userID = userID;
            this.question = question;
            this.answer = answer;
        }
        public string getUserID()
        {
            return userID;
        }
        public void setUserID(string userID)
        {
            this.userID = userID;
        }
        public QuizQuestion getQuestion()
        {
            return question;
        }
        public void setQuestion(QuizQuestion question)
        {
            this.question = question;
        }
        public QuizAnswer getAnswer()
        {
            return answer;
        }
        public void setAnswer(QuizAnswer answer)
        {
            this.answer = answer;
        }
        public int getAttempt()
        {
            return attempt;
        }
        public void setAttempt(int attempt)
        {
            this.attempt = attempt;
        }
        public int getQuizID()
        {
            return quizID;
        }
        public void setQuizID(int quizID)
        {
            this.quizID = quizID;
        }
    }
}