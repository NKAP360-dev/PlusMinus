using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using LearnHub.AppCode.dao;
using LearnHub.AppCode.entity;
using Jitbit.Utils;
using System.IO;
using System.Collections;
using System.Globalization;

namespace LearnHub
{
    public partial class audit : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
        }
        protected void btnDownload_Click(object sender, EventArgs e)
        {
            string function = ddlFunction.SelectedValue;
            string operation = ddlOperation.SelectedValue;
            string date_from1 = fromDateInput.Text;
            string date_to1 = toDateInput.Text;
            string fromDate = fromDateInput.Text.Substring(3, 2) + "/" + fromDateInput.Text.Substring(0, 2) + "/" + fromDateInput.Text.Substring(6, 4);
            string toDate = toDateInput.Text.Substring(3, 2) + "/" + toDateInput.Text.Substring(0, 2) + "/" + toDateInput.Text.Substring(6, 4);
            
            string date_from = fromDate + " 00:00:00";
            string date_to = toDate + " 23:59:59";

            AuditDAO adao = new AuditDAO();
            ArrayList arr = adao.getAllAudit(operation, function, DateTime.ParseExact(fromDate, "MM/dd/yyyy", CultureInfo.InvariantCulture), 
                DateTime.ParseExact(toDate, "MM/dd/yyyy", CultureInfo.InvariantCulture));
            var myExport = new CsvExport();
            foreach(Audit a in arr)
            {
                myExport.AddRow();
                myExport["UserID"] = a.userID;
                myExport["Function Modified"] = a.functionModified;
                myExport["Operation"] = a.operation;
                myExport["ID Of Function"] = a.id_of_function;
                myExport["Date Modified"] = a.dateModified;
                myExport["Remarks"] = a.remarks;
            }

            date_from1 = date_from1.Replace("/", "_");
            string date = DateTime.Now.ToShortDateString();
            string time = DateTime.Now.ToShortTimeString();
            date = date.Replace("/", "_");
            time = time.Replace(":", "_");
            string filename = "[" + date_from1 + "]" +  date + "_" + time + "_" + function + "_" + operation;
            string path = Server.MapPath("Audit/" + filename + ".csv");
            FileStream stream = File.Create(path);
            stream.Dispose();
            ///ASP.NET MVC action example
            myExport.ExportToFile(path);

            FileInfo fileInfo = new FileInfo(path);
            Response.Clear();
            Response.AddHeader("Content-Disposition", "attachment;filename=" + fileInfo.Name);
            Response.AddHeader("Content-Length", fileInfo.Length.ToString());
            Response.ContentType = "text/csv";
            Response.Flush();
            Response.WriteFile(fileInfo.FullName);
            Response.End();
        }
    }
}