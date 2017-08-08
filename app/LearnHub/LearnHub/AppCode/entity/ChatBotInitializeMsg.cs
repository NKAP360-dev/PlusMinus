using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Emma.Entity
{
    public class ChatBotInitializeMsg
    {
        public int messageID { get; set; }
        public string message { get; set; }
        public int levels { get; set; }

    }
}