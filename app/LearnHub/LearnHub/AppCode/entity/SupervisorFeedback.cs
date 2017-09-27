using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace LearnHub.AppCode.entity
{
    public class SupervisorFeedback
    {
        public int feedbackID { get; set; }
        public string title { get; set; }
        public string feedback { get; set; }
        public User userTo { get; set; }
        public User userFrom { get; set; }
        public DateTime dateSubmitted { get; set; }

    }
}