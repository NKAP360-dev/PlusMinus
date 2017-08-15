using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace LearnHub.AppCode.entity
{
    public class ChatBotFeedbackSettings
    {
        public string enabled { get; set; }
        public string emailToSendTo { get; set; }
        public string smtpUsername { get; set; }
        public string smtpPassword { get; set; }
    }
}