using LearnHub.AppCode.dao;
using LearnHub.AppCode.entity;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LearnHub
{
    public partial class suggestCourses : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            User currentUser = (User)Session["currentUser"];
            if (currentUser == null)
            {
                Response.Redirect("Login.aspx");
            }
            else
            {
                if (!IsPostBack)
                {
                    UserDAO userDAO = new UserDAO();
                    User currentSelectedUser = userDAO.getUserByID((string)Request.QueryString["id"]);
                    Course_elearnDAO ceDAO = new Course_elearnDAO();
                    List<int> suggestedCourseIDList = ceDAO.getAllSuggestedCoursesByUserID((string)Request.QueryString["id"]);
                    Session["suggestedCourseIDList"] = suggestedCourseIDList;
                }
                var itemIDs = string.Join(",", ((IList<int>)Session["suggestedCourseIDList"]).ToArray());

                //to load course list
                var sqlQueryCourseList = "";
                if (itemIDs.Length > 0)
                {
                    sqlQueryCourseList = String.Format("SELECT * FROM [Elearn_course] ec INNER JOIN [Elearn_courseCategory] ecc ON ec.categoryID = ecc.categoryID WHERE ec.status='active' and ec.start_date <= getDate() and ec.expiry_date >= getDate() and ec.elearn_courseID NOT IN ({0})", itemIDs);
                }
                else
                {
                    sqlQueryCourseList = "SELECT * FROM [Elearn_course] ec INNER JOIN [Elearn_courseCategory] ecc ON ec.categoryID = ecc.categoryID WHERE ec.status='active' and ec.start_date <= getDate() and ec.expiry_date >= getDate()";
                }
                SqlDataSource1.SelectCommand = sqlQueryCourseList;
                gvCourses.DataSource = SqlDataSource1;
                gvCourses.DataBind();

                gvCourses.UseAccessibleHeader = true;

                if (gvCourses.Rows.Count > 0)
                {
                    gvCourses.HeaderRow.TableSection = TableRowSection.TableHeader;
                }

                //to load suggested cart

                var sqlQuery = "";
                if (itemIDs.Length > 0)
                {
                    sqlQuery = String.Format("SELECT * FROM [Elearn_course] WHERE [elearn_courseID] IN ({0})", itemIDs);
                }
                else
                {
                    sqlQuery = "SELECT * FROM [Elearn_course] WHERE [elearn_courseID] = -1";
                }

                SqlDataSourceCourseCart.SelectCommand = sqlQuery;
                gvCourseCart.DataSource = SqlDataSourceCourseCart;
                gvCourseCart.DataBind();

                //btnViewReport.OnClientClick = $"window.open('progressReports.aspx?id={ddlSelectUser.SelectedValue}')";
            }
        }

        protected void gvCourses_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (gvCourseCart.Rows.Count < 5)
            {
                List<int> suggestedCourseIDList = (List<int>)Session["suggestedCourseIDList"];
                int id = Convert.ToInt32(e.CommandArgument);

                
                suggestedCourseIDList.Add(id);
                Session["suggestedCourseIDList"] = suggestedCourseIDList;
                var itemIDs = string.Join(",", ((IList<int>)Session["suggestedCourseIDList"]).ToArray());

                var sqlQueryCourseList = "";
                if (itemIDs.Length > 0)
                {
                    sqlQueryCourseList = String.Format("SELECT * FROM [Elearn_course] ec INNER JOIN [Elearn_courseCategory] ecc ON ec.categoryID = ecc.categoryID WHERE ec.status='active' and ec.start_date <= getDate() and ec.expiry_date >= getDate() and ec.elearn_courseID NOT IN ({0})", itemIDs);
                }
                else
                {
                    sqlQueryCourseList = "SELECT * FROM [Elearn_course] ec INNER JOIN [Elearn_courseCategory] ecc ON ec.categoryID = ecc.categoryID WHERE ec.status='active' and ec.start_date <= getDate() and ec.expiry_date >= getDate()";
                }
                SqlDataSource1.SelectCommand = sqlQueryCourseList;
                gvCourses.DataSource = SqlDataSource1;
                gvCourses.DataBind();

                gvCourses.UseAccessibleHeader = true;

                if (gvCourses.Rows.Count > 0)
                {
                    gvCourses.HeaderRow.TableSection = TableRowSection.TableHeader;
                }

                var sqlQuery = String.Format("SELECT * FROM [Elearn_course] WHERE [elearn_courseID] IN ({0})", itemIDs);

                SqlDataSourceCourseCart.SelectCommand = sqlQuery;
                gvCourseCart.DataSource = SqlDataSourceCourseCart;
                gvCourseCart.DataBind();
            }
            else
            {
                panelError.Visible = true;
            }
        }

        protected void gvCourseCart_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            panelError.Visible = false;
            List<int> suggestedCourseIDList = (List<int>)Session["suggestedCourseIDList"];
            int id = Convert.ToInt32(e.CommandArgument);
            suggestedCourseIDList.Remove(id);
            Session["suggestedCourseIDList"] = suggestedCourseIDList;
            var itemIDs = string.Join(",", ((IList<int>)Session["suggestedCourseIDList"]).ToArray());

            var sqlQueryCourseList = "";
            if (itemIDs.Length > 0)
            {
                sqlQueryCourseList = String.Format("SELECT * FROM [Elearn_course] ec INNER JOIN [Elearn_courseCategory] ecc ON ec.categoryID = ecc.categoryID WHERE ec.status='active' and ec.start_date <= getDate() and ec.expiry_date >= getDate() and ec.elearn_courseID NOT IN ({0})", itemIDs);
            }
            else
            {
                sqlQueryCourseList = "SELECT * FROM [Elearn_course] ec INNER JOIN [Elearn_courseCategory] ecc ON ec.categoryID = ecc.categoryID WHERE ec.status='active' and ec.start_date <= getDate() and ec.expiry_date >= getDate()";
            }
            SqlDataSource1.SelectCommand = sqlQueryCourseList;
            gvCourses.DataSource = SqlDataSource1;
            gvCourses.DataBind();

            gvCourses.UseAccessibleHeader = true;

            if (gvCourses.Rows.Count > 0)
            {
                gvCourses.HeaderRow.TableSection = TableRowSection.TableHeader;
            }

            var sqlQuery = "";
            if (itemIDs.Length > 0)
            {
                sqlQuery = String.Format("SELECT * FROM [Elearn_course] WHERE [elearn_courseID] IN ({0})", itemIDs);
            }
            else
            {
                sqlQuery = "SELECT * FROM [Elearn_course] WHERE [elearn_courseID] = -1";
            }

            SqlDataSourceCourseCart.SelectCommand = sqlQuery;
            gvCourseCart.DataSource = SqlDataSourceCourseCart;
            gvCourseCart.DataBind();
        }

        protected void ddlSelectUser_SelectedIndexChanged(object sender, EventArgs e)
        {
            Course_elearnDAO ceDAO = new Course_elearnDAO();
            List<int> suggestedCourseIDList = ceDAO.getAllSuggestedCoursesByUserID((string)Request.QueryString["id"]);
            Session["suggestedCourseIDList"] = suggestedCourseIDList;
            var itemIDs = string.Join(",", ((IList<int>)Session["suggestedCourseIDList"]).ToArray());

            //to load course list
            var sqlQueryCourseList = "";
            if (itemIDs.Length > 0)
            {
                sqlQueryCourseList = String.Format("SELECT * FROM [Elearn_course] ec INNER JOIN [Elearn_courseCategory] ecc ON ec.categoryID = ecc.categoryID WHERE ec.status='active' and ec.start_date <= getDate() and ec.expiry_date >= getDate() and ec.elearn_courseID NOT IN ({0})", itemIDs);
            }
            else
            {
                sqlQueryCourseList = "SELECT * FROM [Elearn_course] ec INNER JOIN [Elearn_courseCategory] ecc ON ec.categoryID = ecc.categoryID WHERE ec.status='active' and ec.start_date <= getDate() and ec.expiry_date >= getDate()";
            }
            SqlDataSource1.SelectCommand = sqlQueryCourseList;
            gvCourses.DataSource = SqlDataSource1;
            gvCourses.DataBind();

            gvCourses.UseAccessibleHeader = true;

            if (gvCourses.Rows.Count > 0)
            {
                gvCourses.HeaderRow.TableSection = TableRowSection.TableHeader;
            }

            //to load suggested cart

            var sqlQuery = "";
            if (itemIDs.Length > 0)
            {
                sqlQuery = String.Format("SELECT * FROM [Elearn_course] WHERE [elearn_courseID] IN ({0})", itemIDs);
            }
            else
            {
                sqlQuery = "SELECT * FROM [Elearn_course] WHERE [elearn_courseID] = -1";
            }

            SqlDataSourceCourseCart.SelectCommand = sqlQuery;
            gvCourseCart.DataSource = SqlDataSourceCourseCart;
            gvCourseCart.DataBind();
        }

        protected void cfmSubmit_Click(object sender, EventArgs e)
        {
            string userID = (string)Request.QueryString["id"];
            List<int> suggestedCourseIDList = (List<int>)Session["suggestedCourseIDList"];
            Course_elearnDAO ceDAO = new Course_elearnDAO();

            //delete all existing suggested courses
            ceDAO.deleteSuggestedCoursesByUserID(userID);

            //insert new suggested courses
            foreach (int id in suggestedCourseIDList)
            {
                ceDAO.insertSuggestedCourses(id, userID);
            }
            //to change redirect path
            Response.Redirect("progressReports.aspx?id=" + userID);
        }
    }
}