using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace LearnHub.AppCode.entity
{
    public class News_highlights
    {
        public string title { get; set; }
        public string body { get; set; }
        public DateTime entry_time { get; set; }
        public User user { get; set; }
        public string news_text { get; set; }
        public string status { get; set; }
        public string img_path { get; set; }
        public int highlight_id { get; set; }
        public string type { get; set; }
    }
}