using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Emma.Entity
{
    public class ChatBotAnswer
    {
        public int answerID { get; set; }
        public string answer { get; set; }
        public string intent { get; set; }
        public string entityName { get; set; }
    }
}