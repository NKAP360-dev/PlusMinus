using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace LearnHub.AppCode.entity
{
    public class QuizAnswer
    {
        private int quizAnswerID;
        private QuizQuestion quizQuestion;
        private string answer;

        public QuizAnswer() { }
        public QuizAnswer(int quizAnswerID, QuizQuestion quizQuestion, string answer)
        {
            this.quizAnswerID = quizAnswerID;
            this.quizQuestion = quizQuestion;
            this.answer = answer;
        }

        public int getQuizAnswerID()
        {
            return quizAnswerID;
        }
        public void setQuizAnswerID(int quizAnswerID)
        {
            this.quizAnswerID = quizAnswerID;
        }
        public QuizQuestion getQuizQuestion()
        {
            return quizQuestion;
        }
        public void setQuizQuestion(QuizQuestion quizQuestion)
        {
            this.quizQuestion = quizQuestion;
        }
        public string getAnswer()
        {
            return answer;
        }
        public void setAnswer(string answer)
        {
            this.answer = answer;
        }
    }
}