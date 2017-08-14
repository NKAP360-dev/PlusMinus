using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace LearnHub.AppCode.entity
{
    public class Testimonial
    {
        private string staff_name;
        private string quote;
        private User user;
        private Course_elearn course;
        private string title;
        private int id;

        public Testimonial()
        {

        }
        public Testimonial(string staff_name, string quote, User user, Course_elearn course, string title)
        {
            this.staff_name = staff_name;
            this.quote = quote;
            this.user = user;
            this.course = course;
            this.title = title;
        }
        public Testimonial(string staff_name, string quote, User user, Course_elearn course, string title, int id)
        {
            this.staff_name = staff_name;
            this.quote = quote;
            this.user = user;
            this.course = course;
            this.title = title;
            this.id = id;
        }
        public string getStaffName()
        {
            return staff_name;
        }
        public void setStaffName(string staff_name)
        {
            this.staff_name = staff_name;
        }
        public int getID()
        {
            return id;
        }
        public void setID(int id)
        {
            this.id = id;
        }
        public string getTitle()
        {
            return title;
        }
        public void setTitle(string title)
        {
            this.title = title;
        }
        public Course_elearn getCourse_elearn()
        {
            return course;
        }
        public void set_course_elearn(Course_elearn course)
        {
            this.course = course;
        }
        public string getQuote()
        {
            return quote;
        }
        public void setQuote(string quote)
        {
            this.quote = quote;
        }

        public User getUser()
        {
            return user;
        }
        public void setUser(User user)
        {
            this.user = user;
        }
    }
}