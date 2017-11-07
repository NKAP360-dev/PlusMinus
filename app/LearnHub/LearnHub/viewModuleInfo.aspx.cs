using System;
using System.Collections;
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
        protected ArrayList testimonials;
        protected Testimonial deleteThis;
        protected Boolean superuser;
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
                TestimonialDAO t = new TestimonialDAO();
                testimonials = t.get_testimonials_by_course(current);
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
                lblBreadcrumbCourseName.Text = current.getCourseName();
                lblCourseName.Text = current.getCourseName();
                lblCourseDescription.Text = current.getDescription();
                hoursOutput.Text = current.getHoursAwarded().ToString();
                if (!current.getTargetAudience().Equals(""))
                {
                    lblTargetAudience.Text = current.getTargetAudience();
                }
                else
                {
                    lblTargetAudience.Text = "-";
                }
                lblCoursePeriodStart.Text = "Start: " + current.getStartDate().ToLongDateString();
                lblCoursePeriodEnd.Text = "End: " + current.getExpiryDate().ToLongDateString();
                DateTime currentDateTime = DateTime.Now;

                if (current.getStatus().Equals("inactive") || !(DateTime.Compare(current.getStartDate(), currentDateTime) < 0 && DateTime.Compare(current.getExpiryDate(), currentDateTime) > 0))
                {
                    panelInactive.Visible = true;
                }
                Page.Form.Attributes.Add("enctype", "multipart/form-data");
            }
        }
        protected void submitTestimonial_Click(object sender, EventArgs e)
        {
            Page.Validate("ValidateForm");
            if (!Page.IsValid)
            {

            }
            else
            {
                string byWho = txtByWho.Text;
                string quote = CKEditorControl2.Text;
                string title = txtTestimonial.Text;
                TestimonialDAO tdao = new TestimonialDAO();
                Boolean res = tdao.create_testimonial(new Testimonial(byWho, quote, (User)Session["currentUser"], current, title));
                int courseID = Convert.ToInt32(Request.QueryString["id"]);

                //set audit
                User currentUser = (User)Session["currentUser"];
                setAudit(currentUser, "course", "update", courseID.ToString(), "added testimonial title: " + title);

                Response.Redirect("viewModuleInfo.aspx?id=" + courseID);
            }
        }
        protected void moduleInfo_Click(object sender, EventArgs e)
        {
            viewInfo.Visible = true;
            viewLearningMaterial.Visible = false;
            viewQuizzes.Visible = false;
        }
        protected void learningMat_Click(object sender, EventArgs e)
        {
            viewInfo.Visible = false;
            viewLearningMaterial.Visible = true;
            viewQuizzes.Visible = false;
        }

        protected void quizzes_Click(object sender, EventArgs e)
        {
            viewInfo.Visible = false;
            viewLearningMaterial.Visible = false;
            viewQuizzes.Visible = true;
        }

        protected void upload_click(object sender, EventArgs e)
        {
            System.Diagnostics.Debug.WriteLine("upload_click");
            Page.Validate("ValidateForm2");
            if (!Page.IsValid)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "showModal();", true);
            }
            else
            {
                System.Diagnostics.Debug.WriteLine("else");
                //check if is what content
                string val = rblUploadType.SelectedValue.ToLower().Trim();
                if (val.Equals("file"))
                {
                    System.Diagnostics.Debug.WriteLine("val equals file");
                    if (FileUpload1.HasFile)
                    {
                        System.Diagnostics.Debug.WriteLine("has file");
                        int coursedir = current.getCourseID();
                        string fileName = FileUpload1.FileName;
                        string filepath = "~/Data/" + coursedir + "/";
                        string FileExtension = fileName.Substring(fileName.LastIndexOf('.') + 1).ToLower();
                        if (FileExtension.Equals("pdf") || FileExtension.Equals("jpeg") || FileExtension.Equals("png") || FileExtension.Equals("doc")
                            || FileExtension.Equals("docx") || FileExtension.Equals("xlsx") || FileExtension.Equals("csv") || FileExtension.Equals("xlsm")
                            || FileExtension.Equals("mp3") || FileExtension.Equals("mp4") || FileExtension.Equals("avi") || FileExtension.Equals("m4a")
                            || FileExtension.Equals("zip") || FileExtension.Equals("rar") || FileExtension.Equals("ppt") || FileExtension.Equals("jpg") ||
                                FileExtension.Equals("pptx"))
                        {
                            System.Diagnostics.Debug.WriteLine("approved extension");
                            fileName = HttpUtility.UrlDecode(fileName);
                            FileUpload1.PostedFile
                            .SaveAs(Server.MapPath(filepath) + fileName);
                            string totalpath1 = Server.MapPath(filepath) + fileName;
                            Course_elearnDAO cdao = new Course_elearnDAO();
                            Upload u = new Upload(current, DateTime.Now, uploadTitleInput.Text, uploadDescriptionInput.Text, totalpath1);
                            u.upload_type = "file";
                            Upload upload_succ = cdao.upload_entry(u);

                            //set audit
                            User currentUser = (User)Session["currentUser"];
                            setAudit(currentUser, "course", "update", coursedir.ToString(), "uploaded filename: " + fileName);
                        }
                    }
                }
                else if (val.Equals("video"))
                {
                    string title = uploadTitleInput2.Text;
                    string desc = uploadDescriptionInput2.Text;
                    string link = txtVideo.Text;
                    Course_elearnDAO cdao = new Course_elearnDAO();
                    Upload u = new Upload(current, DateTime.Now, uploadTitleInput2.Text, uploadDescriptionInput2.Text);
                    u.upload_type = "video";
                    u.video_link = link;
                    Upload upload_succ = cdao.upload_entry_video(u);

                    //set audit
                    User currentUser = (User)Session["currentUser"];
                }
                else
                {
                    string link = txtVideo2.Text;
                    if (FileUpload2.HasFile)
                    {
                        int coursedir = current.getCourseID();
                        string fileName = FileUpload2.FileName;
                        string filepath = "~/Data/" + coursedir + "/";
                        string FileExtension = fileName.Substring(fileName.LastIndexOf('.') + 1).ToLower();
                        if (FileExtension.Equals("pdf") || FileExtension.Equals("jpeg") || FileExtension.Equals("png") || FileExtension.Equals("doc")
                            || FileExtension.Equals("docx") || FileExtension.Equals("xlsx") || FileExtension.Equals("csv") || FileExtension.Equals("xlsm")
                            || FileExtension.Equals("mp3") || FileExtension.Equals("mp4") || FileExtension.Equals("avi") || FileExtension.Equals("m4a")
                            || FileExtension.Equals("zip") || FileExtension.Equals("rar") || FileExtension.Equals("ppt") || FileExtension.Equals("jpg") ||
                                FileExtension.Equals("pptx"))
                        {
                            fileName = HttpUtility.UrlDecode(fileName);
                            FileUpload2.PostedFile
                            .SaveAs(Server.MapPath(filepath) + fileName);
                            string totalpath1 = Server.MapPath(filepath) + fileName;
                            Course_elearnDAO cdao = new Course_elearnDAO();
                            Upload u = new Upload(current, DateTime.Now, uploadTitleInput3.Text, uploadDescriptionInput3.Text, totalpath1);
                            u.upload_type = "both";
                            u.video_link = link;
                            Upload upload_succ = cdao.upload_entry_both(u);

                            //set audit
                            User currentUser = (User)Session["currentUser"];
                            setAudit(currentUser, "course", "update", coursedir.ToString(), "uploaded filename: " + fileName);
                        }
                    }
                }
                uploadTitleInput.Text = "";
                uploadDescriptionInput.Text = "";
                uploadTitleInput2.Text = "";
                uploadDescriptionInput2.Text = "";
                txtVideo.Text = "";
                uploadTitleInput3.Text = "";
                uploadDescriptionInput3.Text = "";
                txtVideo2.Text = "";
                rblUploadType.ClearSelection();
                fileOnlyPanel.Visible = false;
                videoOnlyPanel.Visible = false;
                bothPanel.Visible = false;
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
            //ceDAO.updateCourseTargetAudience(courseID, txtTargetAudience.Text);
            Response.Redirect("viewModuleInfo.aspx?id=" + courseID);
        }

        protected void checkTitleExists(object sender, ServerValidateEventArgs args)
        {
            String input = "";
            if (rblUploadType.SelectedValue.Equals("file"))
            {
                input = uploadTitleInput.Text;
            }
            else if (rblUploadType.SelectedValue.Equals("video"))
            {
                input = uploadTitleInput2.Text;
            }
            else if (rblUploadType.SelectedValue.Equals("both"))
            {
                input = uploadTitleInput3.Text;
            }
                
            Boolean checker = false;
            Course_elearnDAO cdao = new Course_elearnDAO();
            ArrayList list = cdao.get_uploaded_content_by_id(current);
            string dir = "Data/" + current.getCourseID();
            foreach (string strfile in Directory.GetFiles(Server.MapPath(dir)))
            {
                foreach (Upload u in list)
                {
                    if (u.getTitle().Equals(input))
                    {
                        checker = true;
                    }
                }
            }
            if (checker)
            {
                System.Diagnostics.Debug.WriteLine("args false");
                args.IsValid = false;
            }
            else
            {
                System.Diagnostics.Debug.WriteLine("args true");
                args.IsValid = true;
            }
        }

        protected void setAudit(User u, string functionModified, string operation, string id_of_function, string remarks)
        {
            //set audit
            Audit a = new Audit();
            AuditDAO aDAO = new AuditDAO();
            a.userID = u.getUserID();
            a.functionModified = functionModified;
            a.operation = operation;
            a.id_of_function = id_of_function;
            a.dateModified = DateTime.Now;
            a.remarks = remarks;
            aDAO.createAudit(a);
        }

        protected void rblUploadType_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (rblUploadType.SelectedValue.Equals("file"))
            {
                fileOnlyPanel.Visible = true;
                videoOnlyPanel.Visible = false;
                bothPanel.Visible = false;
                rfv_uploadTitleInput.Enabled = true;
                cv_uploadTitleInput.Enabled = true;
                rfv_uploadDescriptionInput.Enabled = true;
                rfv_uploadTitleInput2.Enabled = false;
                cv_uploadTitleInput2.Enabled = false;
                rfv_uploadDescriptionInput2.Enabled = false;
                rfv_txtVideo.Enabled = false;
                rfv_uploadTitleInput3.Enabled = false;
                cv_uploadTitleInput3.Enabled = false;
                rfv_uploadDescriptionInput3.Enabled = false;
                rfv_txtVideo2.Enabled = false;
                FileUpload1.Visible = true;
                FileUpload2.Visible = false;
                rfv_FileUpload1.Enabled = true;
                rfv_FileUpload2.Enabled = false;
            }
            else if (rblUploadType.SelectedValue.Equals("video")) {
                fileOnlyPanel.Visible = false;
                videoOnlyPanel.Visible = true;
                bothPanel.Visible = false;
                rfv_uploadTitleInput.Enabled = false;
                cv_uploadTitleInput.Enabled = false;
                rfv_uploadDescriptionInput.Enabled = false;
                rfv_uploadTitleInput2.Enabled = true;
                cv_uploadTitleInput2.Enabled = true;
                rfv_uploadDescriptionInput2.Enabled = true;
                rfv_txtVideo.Enabled = true;
                rfv_uploadTitleInput3.Enabled = false;
                cv_uploadTitleInput3.Enabled = false;
                rfv_uploadDescriptionInput3.Enabled = false;
                rfv_txtVideo2.Enabled = false;
                FileUpload1.Visible = false;
                FileUpload2.Visible = false;
                rfv_FileUpload1.Enabled = false;
                rfv_FileUpload2.Enabled = false;

            } else if (rblUploadType.SelectedValue.Equals("both")) {
                fileOnlyPanel.Visible = false;
                videoOnlyPanel.Visible = false;
                bothPanel.Visible = true;
                rfv_uploadTitleInput.Enabled = false;
                cv_uploadTitleInput.Enabled = false;
                rfv_uploadDescriptionInput.Enabled = false;
                rfv_uploadTitleInput2.Enabled = false;
                cv_uploadTitleInput2.Enabled = false;
                rfv_uploadDescriptionInput2.Enabled = false;
                rfv_txtVideo.Enabled = false;
                rfv_uploadTitleInput3.Enabled = true;
                cv_uploadTitleInput3.Enabled = true;
                rfv_uploadDescriptionInput3.Enabled = true;
                rfv_txtVideo2.Enabled = true;
                FileUpload1.Visible = false;
                FileUpload2.Visible = true;
                rfv_FileUpload1.Enabled = false;
                rfv_FileUpload2.Enabled = true;
            }

        }
    }
}