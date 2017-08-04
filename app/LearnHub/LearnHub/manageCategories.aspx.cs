using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using LearnHub.AppCode.dao;
using LearnHub.AppCode.entity;

namespace LearnHub
{
    public partial class manageCategories : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnConfirmSubmit_Click(object sender, EventArgs e)
        {
            //to do validation

            Course_elearnCategoryDAO cecDAO = new Course_elearnCategoryDAO();
            CourseCategory cc = new CourseCategory();
            cc.category = txtCategory.Text;
            cc.status = "active";
            cecDAO.createCategory(cc);
        }
    }
}