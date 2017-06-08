using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace LearnHub.AppCode.entity
{
    public class Quiz
    {
        private string quizID;
        private Course mainCourse;
        private int quizDuration;
        private string quiz_expiry_date;

        public Quiz() { }
        public Quiz (string quizID, Course mainCourse, int quizDuration, string quiz_expiry_date)
        {
            this.quizID = quizID;
            this.quizDuration = quizDuration;
            this.quiz_expiry_date = quiz_expiry_date;
            this.mainCourse = mainCourse;
        }
        public string getQuizID()
        {
            return quizID;
        }
        public void setQuizID(string quizID)
        {
            this.quizID = quizID;
        }
        public Course getMainCourse()
        {
            return mainCourse;
        }
        public void setMainCourse(Course mainCourse)
        {
            this.mainCourse = mainCourse;
        }
        public int getQuizDuration()
        {
            return quizDuration;
        }
        public void setQuizDuration(int quizDuration)
        {
            this.quizDuration = quizDuration;
        }
        public string getQuizExpiryDate()
        {
            return quiz_expiry_date;
        }
        public void setQuizExpiryDate(string quiz_expiry_date)
        {
            this.quiz_expiry_date = quiz_expiry_date;
        }
    }
}