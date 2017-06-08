using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace LearnHub.AppCode.entity
{
    public class Bonds
    {
        private string bondName;
        private string category;
        private double criteria;

        public Bonds() { }
        public Bonds (string bondName, string category, double criteria)
        {
            this.bondName = bondName;
            this.category = category;
            this.criteria = criteria;
        }
        public string getBondName()
        {
            return bondName;
        }
        public void setBondName(string bondName)
        {
            this.bondName = bondName;
        }
        public string getCategory()
        {
            return category;
        }
        public void setCategory(string category)
        {
            this.category = category;
        }
        public double getCriteria()
        {
            return criteria;
        }
        public void setCriteria(double criteria)
        {
            this.criteria = criteria;
        }
    }
}