using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace LearnHub.AppCode.entity
{
    public class QuizQuestion
    {
        private int quizQuestionID;
        private Quiz quiz;
        private string question;
        private QuizAnswer correctAnswer;
        
        public QuizQuestion() { }

        public QuizQuestion(int quizQuestionID, Quiz quiz, string question, QuizAnswer correctAnswer)
        {
            this.quizQuestionID = quizQuestionID;
            this.quiz = quiz;
            this.question = question;
            this.correctAnswer = correctAnswer;
        }
        public int getQuizQuestionID()
        {
            return quizQuestionID;
        }
        public void setQuizQuestionID(int quizQuestionID)
        {
            this.quizQuestionID = quizQuestionID;
        }
        public Quiz getQuiz()
        {
            return quiz;
        }
        public void setQuiz(Quiz quiz)
        {
            this.quiz = quiz;
        }
        public string getQuestion()
        {
            return question;
        }
        public void setQuestion(string question)
        {
            this.question = question;
        }
        public QuizAnswer getQuizAnswer()
        {
            return correctAnswer;
        }
        public void setQuizAnswer(QuizAnswer correctAnswer)
        {
            this.correctAnswer = correctAnswer;
        }
    }
}