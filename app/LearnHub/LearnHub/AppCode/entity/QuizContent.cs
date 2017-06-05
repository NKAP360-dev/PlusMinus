using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace LearnHub.AppCode.entity
{
    public class QuizContent
    {
        public Quiz mainQuiz { get; set; }
        public int questionNumber { get; set; }
        public string question { get; set; }
        public string answerA { get; set; }
        public string answerB { get; set; }
        public string answerC { get; set; }
        public string answerD { get; set; }
        public string correctAnswer { get; set; }

        public QuizContent (Quiz mainQuiz, int questionNumber, string question, string answerA, string answerB, string answerC, string answerD, string correctAnswer)
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
    }
}