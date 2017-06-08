using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace LearnHub.AppCode.entity
{
    public class Lesson
    {
        private string lessonID;
        private string courseID;
        private string start_time;
        private string end_time;
        private string start_date;
        private string end_date;
        private int timing;
        private string instructor;

        public Lesson() { }
        public Lesson (string lessonID, string courseID, string start_time, string end_time, string start_date, string end_date, int timing, string instructor)
        {
            this.lessonID = lessonID;
            this.courseID = courseID;
            this.start_date = start_date;
            this.end_date = end_date;
            this.start_time = start_time;
            this.end_time = end_time;
            this.timing = timing;
            this.instructor = instructor;
        }
        public string getLessonID()
        {
            return lessonID;
        }
        public void setLessonID(string lessonID)
        {
            this.lessonID = lessonID;
        }
        public string getCourseID()
        {
            return courseID;
        }
        public void setCourseID(string courseID)
        {
            this.courseID = courseID;
        }
        public string getStartTime()
        {
            return start_time;
        }
        public void setStartTime(string start_time)
        {
            this.start_time = start_time;
        }
        public string getEndTime()
        {
            return end_time;
        }
        public void setEndTime(string end_time)
        {
            this.end_time = end_time;
        }
        public string getStartDate()
        {
            return start_date;
        }
        public void setStartDate(string start_date)
        {
            this.start_date = start_date;
        }
        public string getEndDate()
        {
            return end_date;
        }
        public void setEndDate(string end_date)
        {
            this.end_date = end_date;
        }
        public int getTiming()
        {
            return timing;
        }
        public void setTiming(int timing)
        {
            this.timing = timing;
        }
        public string getInstructor()
        {
            return instructor;
        }
        public void setInstructor(string instructor)
        {
            this.instructor = instructor;
        }
    }
}