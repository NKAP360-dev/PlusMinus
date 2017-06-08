using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace LearnHub.AppCode.entity
{
    public class TNF
    {
        //to add in when confirmed fields
        private User user;
        private List<User> users;
        private string type;
        private string status;
        private int wf_status;

        public string getType()
        {
            return type;
        }
        public void setType(string type)
        {
            this.type = type;
        }
        public string getStatus()
        {
            return status;
        }
        public void setStatus(string status)
        {
            this.status = status;
        }
        public User getUser()
        {
            return user;
        }
        public void setUser(User user)
        {
            this.user = user;
        }
        public List<User> getUsers()
        {
            return users;
        }
        public void setUsers(List<User> users)
        {
            this.users = users;
        }
        public int getWFStatus()
        {
            return wf_status;
        }
        public void setWFStatus(int wf_status)
        {
            this.wf_status = wf_status;
        }
    }
}