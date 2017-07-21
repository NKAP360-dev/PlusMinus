using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Data;


namespace LearnHub
{
    public partial class uploadDownloadTest : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
            //get course from previous page in GET request - call Elearn_courseDAO retrieve by id
            //once get Course_elearn obj, then get the category of course
            //in the server dir, create if else to map to which dir to save the course materials 
            //in based on course cat
            //Then create new folder for particular course
            //save doc in the new folder created. 
            //call course_elearnDAO new method and save the folder path in the db based on which week

            //for download - call gridview control and display the file as per normal
            //then download via commandArgument in gridview control

            //db need the server mapPath for eah course folder dir

        }
        protected void Button1_Click(object sender, EventArgs e)
        {
            if (FileUpload1.HasFile)
            {
                string fileName = FileUpload1.FileName;
                FileUpload1.PostedFile
                    .SaveAs(Server.MapPath("~/Data/") + fileName);
            }

            DataTable dt = new DataTable();
            dt.Columns.Add("File");
            dt.Columns.Add("Size");
            dt.Columns.Add("Type");

            foreach (string strfile in Directory.GetFiles(Server.MapPath("~/Data"))) // this dir can retrieve from db
            {
                FileInfo fi = new FileInfo(strfile);
                dt.Rows.Add(fi.Name, fi.Length.ToString(),
                    GetFileTypeByExtension(fi.Extension));
            }

            GridView1.DataSource = dt;
            GridView1.DataBind();
        }

        private string GetFileTypeByExtension(string fileExtension)
        {
            switch (fileExtension.ToLower())
            {
                case ".docx":
                case ".doc":
                    return "Microsoft Word Document";
                case ".xlsx":
                case ".xls":
                    return "Microsoft Excel Document";
                case ".txt":
                    return "Text Document";
                case ".jpg":
                case ".png":
                    return "Image";
                case ".pdf":
                    return "PDF";
                default:
                    return "Unknown";
            }
        }

        protected void GridView1_RowCommand(object sender,
            GridViewCommandEventArgs e)
        {
            Response.Clear();
            Response.ContentType = "application/octet-stream";
            Response.AppendHeader("Content-Disposition", "filename="
                + e.CommandArgument);
            Response.TransmitFile(Server.MapPath("~/Data/")
                + e.CommandArgument);
            Response.End();
        }
    }
}