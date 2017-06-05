using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace LearnHub.AppCode.entity
{
    public class Lesson
    {
        public string lessonID { get; set; }
        public string courseID { get; set; }
        public string start_time { get; set; }
        public string end_time { get; set; }
        public string start_date { get; set; }
        public string end_date { get; set; }
        public int timing { get; set; }
        public string instructor { get; set; }

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
    }
}