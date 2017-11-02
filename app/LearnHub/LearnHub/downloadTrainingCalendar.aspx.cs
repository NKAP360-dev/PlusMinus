using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Data;
using System.Collections;

namespace LearnHub
{
    public partial class WebForm11 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string path = "Training_Calendar/";
            string[] fileNames = Directory.GetFiles(Server.MapPath(path));
            if (fileNames == null || fileNames.Length == 0)
            {
                Response.Redirect("Home.aspx");
            }
            else
            {
                string file_i_want = fileNames[0];
                FileInfo fileInfo = new FileInfo(file_i_want);
                Response.Clear();
                Response.ContentType = "application/octet-stream";
                Response.AddHeader("Content-Disposition", "attachment;filename=" + fileInfo.Name);
                Response.AddHeader("Content-Length", fileInfo.Length.ToString());
                Response.TransmitFile(Server.MapPath(path + Path.GetFileName(file_i_want)));
                Response.End();
            }
        }
    }
}