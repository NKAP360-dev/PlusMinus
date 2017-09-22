using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace LearnHub.AppCode.entity
{
    public class Article
    {
        public int article_id { get; set; }
        public string article_name { get; set; }
        public string article_body { get; set; }
        public User user { get; set; }
        public DateTime upload_datetime { get; set; }
        public string status { get; set; }

        public Article() { }
        public Article (int article_id, string article_name, string article_body, User user, DateTime upload, string status)
        {
            this.article_id = article_id;
            this.article_name = article_name;
            this.article_body = article_body;
            this.user = user;
            this.upload_datetime = upload;
            this.status = status;
        }
        public Article(string article_name, string article_body, User user, DateTime upload, string status)
        {
            //this.article_id = article_id;
            this.article_name = article_name;
            this.article_body = article_body;
            this.user = user;
            this.upload_datetime = upload;
            this.status = status;
        }
    }
}