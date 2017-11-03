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
            CompareEndTodayValidator.ValueToCompare = DateTime.Now.ToShortDateString();
        }
        protected void btnDownload_Click(object sender, EventArgs e)
        {
            Page.Validate("ValidateForm");
            if (!Page.IsValid)
            {

            }
            else
            {
                string function = ddlFunction.SelectedValue.ToLower();
                string operation = ddlOperation.SelectedValue.ToLower();
                string date_from1 = fromDateInput.Text;
                string date_to1 = toDateInput.Text;
                string fromDate = fromDateInput.Text.Substring(3, 2) + "/" + fromDateInput.Text.Substring(0, 2) + "/" + fromDateInput.Text.Substring(6, 4);
                string toDate = toDateInput.Text.Substring(3, 2) + "/" + toDateInput.Text.Substring(0, 2) + "/" + toDateInput.Text.Substring(6, 4);

                string date_from = fromDate + " 00:00:00";
                string date_to = toDate + " 23:59:59";

                AuditDAO adao = new AuditDAO();
                ArrayList arr = new ArrayList();
                if (function.Equals("all") && operation.Equals("all"))
                {
                    arr = adao.getAllAudit_All(DateTime.ParseExact(fromDate, "MM/dd/yyyy", CultureInfo.InvariantCulture),
                    DateTime.ParseExact(toDate, "MM/dd/yyyy", CultureInfo.InvariantCulture));
                }
                else
                {
                    if (operation.Equals("all"))
                    {
                        arr = adao.getAllAudit_function(function, DateTime.ParseExact(fromDate, "MM/dd/yyyy", CultureInfo.InvariantCulture),
                        DateTime.ParseExact(toDate, "MM/dd/yyyy", CultureInfo.InvariantCulture));
                    }
                    else if (function.Equals("all"))
                    {
                        arr = adao.getAllAudit_operation(operation, DateTime.ParseExact(fromDate, "MM/dd/yyyy", CultureInfo.InvariantCulture),
                        DateTime.ParseExact(toDate, "MM/dd/yyyy", CultureInfo.InvariantCulture));
                    }
                    else
                    {
                        arr = adao.getAllAudit(operation, function, DateTime.ParseExact(fromDate, "MM/dd/yyyy", CultureInfo.InvariantCulture),
                        DateTime.ParseExact(toDate, "MM/dd/yyyy", CultureInfo.InvariantCulture));
                    }
                }

                var myExport = new CsvExport();
                foreach (Audit a in arr)
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
                string filename = "[" + date_from1 + "]" + date + "_" + time + "_" + function + "_" + operation;
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
        protected void compareDate(object sender, ServerValidateEventArgs args)
        {
            String fromDate = fromDateInput.Text;
            String toDate = toDateInput.Text;
            DateTime fDate = DateTime.ParseExact(fromDate,"dd/MM/yyyy", CultureInfo.InvariantCulture);
            DateTime tDate = DateTime.ParseExact(toDate,"dd/MM/yyyy", CultureInfo.InvariantCulture);
            String curr = DateTime.Now.ToString("dd/MM/yyyy");
            DateTime currDate = DateTime.ParseExact(curr, "dd/MM/yyyy", CultureInfo.InvariantCulture);
            if (fDate > tDate)
            {
                cv_dateInput.ErrorMessage = "Please enter a From Date that is Before the To Date.";
                args.IsValid = false;
            }
            else if(fDate <= tDate)
            {
                if (tDate > currDate)
                {
                    cv_dateInput.ErrorMessage = "Please enter a To Date that is not later than today's date";
                    args.IsValid = false;
                }
                else
                {
                    args.IsValid = true;
                }
            }
            
        }
    }
}