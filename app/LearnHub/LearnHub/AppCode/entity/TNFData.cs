using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace LearnHub.AppCode.entity
{
    public class TNFData
    {
        private int tnfid;
        private string prepareForNewJobRole;
        private string prepareForNewJobRoleText;
        private DateTime? prepareForNewJobRoleCompletionDate;
        private string shareKnowledge;
        private string shareKnowledgeText;
        private DateTime? shareKnowledgeCompletionDate;
        private string otherObjectives;
        private string otherObjectivesText;
        private DateTime? otherObjectivesCompletionDate;

        public int getTNFID()
        {
            return tnfid;
        }
        public void setTNFID(int tnfid)
        {
            this.tnfid = tnfid;
        }
        public string getPrepareForNewJobRole()
        {
            return prepareForNewJobRole;
        }
        public void setPrepareForNewJobRole(string prepareForNewJobRole)
        {
            this.prepareForNewJobRole = prepareForNewJobRole;
        }
        public string getPrepareForNewJobRoleText()
        {
            return prepareForNewJobRole;
        }
        public void setPrepareForNewJobRoleText(string prepareForNewJobRoleText)
        {
            this.prepareForNewJobRoleText = prepareForNewJobRoleText;
        }
        public DateTime? getPrepareForNewJobRoleCompletionDate()
        {
            return prepareForNewJobRoleCompletionDate;
        }
        public void setPrepareForNewJobRoleCompletionDate(DateTime? prepareForNewJobRoleCompletionDate)
        {
            this.prepareForNewJobRoleCompletionDate = prepareForNewJobRoleCompletionDate;
        }
        public string getShareKnowledge()
        {
            return shareKnowledge;
        }
        public void setShareKnowledge(string shareKnowledge)
        {
            this.shareKnowledge = shareKnowledge;
        }
        public string getShareKnowledgeText()
        {
            return shareKnowledgeText;
        }
        public void setShareKnowledgeText(string shareKnowledgeText)
        {
            this.shareKnowledgeText = shareKnowledgeText;
        }
        public DateTime? getShareKnowledgeCompletionDate()
        {
            return shareKnowledgeCompletionDate;
        }
        public void setShareKnowledgeCompletionDate(DateTime? shareKnowledgeCompletionDate)
        {
            this.shareKnowledgeCompletionDate = shareKnowledgeCompletionDate;
        }
        public string getOtherObjectives()
        {
            return otherObjectives;
        }
        public void setOtherObjectives(string otherObjectives)
        {
            this.otherObjectives = otherObjectives;
        }
        public string getOtherObjectivesText()
        {
            return otherObjectivesText;
        }
        public void setOtherObjectivesText(string otherObjectivesText)
        {
            this.otherObjectivesText = otherObjectivesText;
        }
        public DateTime? getOtherObjectivesCompletionDate()
        {
            return otherObjectivesCompletionDate;
        }
        public void setOtherObjectivesCompletionDate(DateTime? otherObjectivesCompletionDate)
        {
            this.otherObjectivesCompletionDate = otherObjectivesCompletionDate;
        }
    }
}