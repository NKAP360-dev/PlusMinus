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
        private List<QuizAnswer> allAnswers;
        
        public QuizQuestion() { }

        public QuizQuestion(int quizQuestionID, Quiz quiz, string question, QuizAnswer correctAnswer, List<QuizAnswer> allAnswers)
        {
            this.quizQuestionID = quizQuestionID;
            this.quiz = quiz;
            this.question = question;
            this.correctAnswer = correctAnswer;
            this.allAnswers = allAnswers;
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
        public List<QuizAnswer> getAllAnswers()
        {
            return allAnswers;
        }
        public void setAllAnswers(List<QuizAnswer> allAnswers)
        {
            this.allAnswers = allAnswers;
        }
    }
}