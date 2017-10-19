using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace LearnHub.AppCode.entity
{
    public class News
    {
        public string banner_name { get; set; }
        public string banner_link { get; set; }
        public DateTime entry_time { get; set; }
        public User user { get; set; }
        public string news_text { get; set; }
        public string status { get; set; }
        public string img_path { get; set; }
        public int banner_id { get; set; }
        public int level { get; set; }
    }
}