using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace LearnHub.AppCode.entity
{
    public class Upload
    {
        private Course_elearn course;
        private DateTime date;
        private string title;
        private string desc;
        private string server_path;

        public Upload()
        {

        }
        public Upload(Course_elearn course, DateTime date, string title, string desc, string server_path)
        {
            this.course = course;
            this.date = date;
            this.title = title;
            this.desc = desc;
            this.server_path = server_path;
        }

        public DateTime getDate()
        {
            return date;
        }
        public void setDate(DateTime date)
        {
            this.date = date;
        }

        public string getTitle()
        {
            return title;
        }
        public void setTitle(string title)
        {
            this.title = title;
        }

        public string getDesc()
        {
            return desc;
        }
        public void setDesc(string desc)
        {
            this.desc = desc;
        }

        public string getServerPath()
        {
            return server_path;
        }
        public void setServerPath(string serverPath)
        {
            this.server_path = serverPath;
        }
        public Course_elearn getCourse_elearn()
        {
            return course;
        }
        public void setCourse_elearn(Course_elearn c)
        {
            this.course = c;
        }
    }
}