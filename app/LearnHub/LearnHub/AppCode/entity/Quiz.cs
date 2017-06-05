using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace LearnHub.AppCode.entity
{
    public class Quiz
    {
        public string quizID { get; set; }
        public Course mainCourse { get; set; }
        public int quizDuration { get; set; }
        public string quiz_expiry_date { get; set; }

        public Quiz (string quizID, Course mainCourse, int quizDuration, string quiz_expiry_date)
        {
            this.quizID = quizID;
            this.quizDuration = quizDuration;
            this.quiz_expiry_date = quiz_expiry_date;
            this.mainCourse = mainCourse;
        }
    }
}