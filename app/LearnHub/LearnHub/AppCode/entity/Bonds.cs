using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace LearnHub.AppCode.entity
{
    public class Bonds
    {
        public string bondName { get; set; }
        public string category { get; set; }
        public double criteria { get; set; }

        public Bonds (string bondNamd, string category, double criteria)
        {
            this.bondName = bondName;
            this.category = category;
            this.criteria = criteria;
        }
    }
}