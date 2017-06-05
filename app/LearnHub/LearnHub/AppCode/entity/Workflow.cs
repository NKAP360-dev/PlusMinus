using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace LearnHub.AppCode.entity
{
    public class Workflow
    {
        public int wid { get; set; }
        public string wf_name { get; set; }
        public int probationPeriod { get; set; }
        public double bondCriteria { get; set; }

        public Workflow (int wid, string wf_name, int probationPeriod, double bondCriteria)
        {
            this.wid = wid;
            this.wf_name = wf_name;
            this.probationPeriod = probationPeriod;
            this.bondCriteria = bondCriteria;
        }
    }
}