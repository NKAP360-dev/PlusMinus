using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Emma.Entity
{
    public class ChatBotFeedback
    {
        public int feedbackID { get; set; }
        public string name { get; set; }
        public string feedback { get; set; }
        public string department { get; set; }
        public DateTime feedbackDate { get; set; }
    }
}