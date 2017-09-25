using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace LearnHub.AppCode.entity
{
    public class Link
    {
        public int link_id { get; set; }
        public string link_path { get; set; }
        public string description { get; set; }
        public User user { get; set; }
        public DateTime upload_datetime { get; set; }
        public string status { get; set; }

        public Link() { }
        public Link (int link_id, string link_path, string description, User user, DateTime upload, string status)
        {
            this.link_id = link_id;
            this.link_path = link_path;
            this.description = description;
            this.user = user;
            this.upload_datetime = upload;
            this.status = status;
        }
        public Link(string link_path, string description, User user, DateTime upload, string status)
        {
            //this.article_id = article_id;
            //this.link_id = link_id;
            this.link_path = link_path;
            this.description = description;
            this.user = user;
            this.upload_datetime = upload;
            this.status = status;
        }
    }
}