using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace LearnHub.AppCode.entity
{
    public class QuizResultHistory
    {
        private int quizResultHistoryID;
        private QuizQuestion question;
        private QuizAnswer answer;

        public QuizResultHistory() { }
        public QuizResultHistory(int quizResultHistoryID, QuizQuestion question, QuizAnswer answer)
        {
            this.quizResultHistoryID = quizResultHistoryID;
            this.question = question;
            this.answer = answer;
        }
        public int getQuizResultHistoryID()
        {
            return quizResultHistoryID;
        }
        public void setQuizResultHistoryID(int quizResultHistoryID)
        {
            this.quizResultHistoryID = quizResultHistoryID;
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
    }
}