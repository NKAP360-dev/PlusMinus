using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using LearnHub.AppCode.entity;
using LearnHub.AppCode.dao;
using System.IO;
using System.Data;


namespace LearnHub
{

    public partial class viewModuleInfo : System.Web.UI.Page
    {
        protected string title;
        protected string desc;
        protected DateTime date;
        protected Course_elearn current;
        protected void Page_Load(object sender, EventArgs e)
        {
            //Response.Write(DateTime.Now.ToShortDateString());
            Course_elearnDAO cdao = new Course_elearnDAO();
            string id_str = null;
            if (Request.QueryString["id"] != null)
            {
                id_str = Request.QueryString["id"];
                int id_num = int.Parse(id_str);
                current = cdao.get_course_by_id(id_num);
            }
            else
            {
                return;
            }

            if (!IsPostBack)
            {
                int id_num = int.Parse(id_str);
                current = cdao.get_course_by_id(id_num);
                lblCourseNameHeader.Text = current.getCourseName();
                lblCourseName.Text = current.getCourseName();
                lblCourseDescription.Text = current.getDescription();
                hoursOutput.Text = current.getHoursAwarded().ToString();
                txtTargetAudience.Text = current.getTargetAudience();
            }
        }

        protected void moduleInfo_Click(object sender, EventArgs e)
        {
            viewInfo.Visible = true;
            viewLearningMaterial.Visible = false;
        }
        protected void learningMat_Click(object sender, EventArgs e)
        {
            viewInfo.Visible = false;
            viewLearningMaterial.Visible = true;
        }

        protected void quizzes_Click(object sender, EventArgs e)
        {
            viewInfo.Visible = false;
            viewLearningMaterial.Visible = false;
        }

        protected void upload_click(object sender, EventArgs e)
        {
            if (FileUpload1.HasFile)
            {
                int coursedir = current.getCourseID();
                string fileName = FileUpload1.FileName;
                string filepath = "~/Data/" + coursedir + "/";
                FileUpload1.PostedFile
                    .SaveAs(Server.MapPath(filepath) + fileName);
                string totalpath1 = Server.MapPath(filepath) + fileName;
                Course_elearnDAO cdao = new Course_elearnDAO();
                Upload u = new Upload(current, DateTime.Now, uploadTitleInput.Text, uploadDescriptionInput.Text, totalpath1);
                Upload upload_succ = cdao.upload_entry(u);
            }
            
        }
        protected void GridView1_RowCommand(object sender,
           GridViewCommandEventArgs e)
        {
            Response.Clear();
            Response.ContentType = "application/octet-stream";
            Response.AppendHeader("Content-Disposition", "filename="
                + e.CommandArgument);
            string coursedir = "~/Data/"+current.getCourseName();
            Response.TransmitFile(Server.MapPath(coursedir)
                + e.CommandArgument);
            Response.End();
        }

        protected void btnSaveDetails_Click(object sender, EventArgs e)
        {
            int courseID = Convert.ToInt32(Request.QueryString["id"]);
            Course_elearnDAO ceDAO = new Course_elearnDAO();
            ceDAO.updateCourseTargetAudience(courseID, txtTargetAudience.Text);
            Response.Redirect("/viewModuleInfo.aspx?id=" + courseID);
        }
    }
}