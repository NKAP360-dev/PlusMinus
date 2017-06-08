using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace LearnHub.AppCode.entity
{
    public class QuizContent
    {
        private Quiz mainQuiz;
        private int questionNumber;
        private string question;
        private string answerA;
        private string answerB;
        private string answerC;
        private string answerD;
        private string correctAnswer;

        public QuizContent() { }
        public QuizContent(Quiz mainQuiz, int questionNumber, string question, string answerA, string answerB, string answerC, string answerD, string correctAnswer)
        {
            this.mainQuiz = mainQuiz;
            this.questionNumber = questionNumber;
            this.question = question;
            this.answerA = answerA;
            this.answerB = answerB;
            this.answerC = answerC;
            this.answerD = answerD;
            this.correctAnswer = correctAnswer;
        }
        public Quiz getMainQuiz()
        {
            return mainQuiz;
        }
        public void setMainQuiz(Quiz mainQuiz)
        {
            this.mainQuiz = mainQuiz;
        }
        public int getQuestionNumber()
        {
            return questionNumber;
        }
        public void setQuestionNumber(int questionNumber)
        {
            this.questionNumber = questionNumber;
        }
        public string getQuestion()
        {
            return question;
        }
        public void setQuestion(string question)
        {
            this.question = question;
        }
        public string getAnswerA()
        {
            return answerA;
        }
        public void setAnswerA(string answerA)
        {
            this.answerA = answerA;
        }
        public string getAnswerB()
        {
            return answerB;
        }
        public void setAnswerB(string answerB)
        {
            this.answerB = answerB;
        }
        public string getAnswerC()
        {
            return answerC;
        }
        public void setAnswerC(string answerC)
        {
            this.answerC = answerC;
        }
        public string getAnswerD()
        {
            return answerD;
        }
        public void setAnswerD(string answerD)
        {
            this.answerD = answerD;
        }
        public string getCorrectAnswer()
        {
            return correctAnswer;
        }
        public void setCorrectAnswer(string correctAnswer)
        {
            this.correctAnswer = correctAnswer;
        }
    }
}