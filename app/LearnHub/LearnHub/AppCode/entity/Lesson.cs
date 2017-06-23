using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace LearnHub.AppCode.entity
{
    public class Lesson
    {
        private int lessonID;
        private int courseID;
        private TimeSpan start_time;
        private TimeSpan end_time;
        private DateTime start_date;
        private DateTime end_date;
        private string venue;
        private string instructor;

        public Lesson() { }
        public Lesson (int courseID, TimeSpan start_time, TimeSpan end_time, DateTime start_date, DateTime end_date, string venue, string instructor)
        {
            this.courseID = courseID;
            this.start_date = start_date;
            this.end_date = end_date;
            this.start_time = start_time;
            this.end_time = end_time;
            this.venue = venue;
            this.instructor = instructor;
        }
        public int getLessonID()
        {
            return lessonID;
        }
        public void setLessonID(int lessonID)
        {
            this.lessonID = lessonID;
        }
        public int getCourseID()
        {
            return courseID;
        }
        public void setCourseID(int courseID)
        {
            this.courseID = courseID;
        }
        public TimeSpan getStartTime()
        {
            return start_time;
        }
        public void setStartTime(TimeSpan start_time)
        {
            this.start_time = start_time;
        }
        public TimeSpan getEndTime()
        {
            return end_time;
        }
        public void setEndTime(TimeSpan end_time)
        {
            this.end_time = end_time;
        }
        public DateTime getStartDate()
        {
            return start_date;
        }
        public void setStartDate(DateTime start_date)
        {
            this.start_date = start_date;
        }
        public DateTime getEndDate()
        {
            return end_date;
        }
        public void setEndDate(DateTime end_date)
        {
            this.end_date = end_date;
        }
        public string getVenue()
        {
            return venue;
        }
        public void setVenue(string timing)
        {
            this.venue = venue;
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