using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace LearnHub.AppCode.entity
{
    public class Audit
    {
        public string userID { get; set; }
        public string functionModified { get; set; }
        public string operation { get; set; }
        public string id_of_function { get; set; }
        public DateTime dateModified { get; set; }
        public string remarks { get; set; }

    }
}