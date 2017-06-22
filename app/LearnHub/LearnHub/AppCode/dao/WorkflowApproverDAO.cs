﻿using LearnHub.AppCode.entity;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace LearnHub.AppCode.dao
{
    public class WorkflowApproverDAO
    {
        private WorkflowDAO wfDAO = new WorkflowDAO();
        private WorkflowSubDAO wfsDAO = new WorkflowSubDAO();

        //TO EDIT
        
        public List<WorkflowApprover> getSortedWorkflowApprovers(int workflowID, int workflow_subID)
        {
            List<WorkflowApprover> toReturn = new List<WorkflowApprover>();
            SqlConnection conn = new SqlConnection();
            WorkflowApprover approver = null;
            UserDAO userDAO = new UserDAO();
            try
            {
                conn = new SqlConnection();
                string connstr = ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString();
                conn.ConnectionString = connstr;
                conn.Open();
                SqlCommand comm = new SqlCommand();
                comm.Connection = conn;
                comm.CommandText = "select * from [Workflow_approvers] where wfid=@wfid and wf_sub_id=@wfsid order by levels asc";
                comm.Parameters.AddWithValue("@wfid", workflowID);
                comm.Parameters.AddWithValue("@wfsid", workflow_subID);
                SqlDataReader dr = comm.ExecuteReader();
                while (dr.Read())
                {
                    approver = new WorkflowApprover();
                    int wfid = (int)dr["wfid"];
                    Workflow wf = wfDAO.getWorkflowByID(wfid);
                    approver.setMainWF(wf);

                    int wfsid = (int)dr["wf_sub_id"];
                    WorkflowSub wfs = wfsDAO.getWorkflowSubByID(wfsid);
                    approver.setMainWFS(wfs);

                    approver.setJobCategory((string)dr["job_category"]);
                    approver.setLevel((int)dr["levels"]);

                    toReturn.Add(approver);
                }
                dr.Close();
            }
            catch (SqlException ex)
            {
                throw ex;
            }
            finally
            {
                conn.Close();
            }
            return toReturn;
        }
        public WorkflowApprover getLastApproverInChain(int workflowID, int workflow_subID)
        {
            WorkflowApprover toReturn = new WorkflowApprover();
            SqlConnection conn = new SqlConnection();
            UserDAO userDAO = new UserDAO();
            try
            {
                conn = new SqlConnection();
                string connstr = ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString();
                conn.ConnectionString = connstr;
                conn.Open();
                SqlCommand comm = new SqlCommand();
                comm.Connection = conn;
                comm.CommandText = "select top 1 * from [Workflow_approvers] where wfid=@wfid and wf_sub_id=@wfsid order by levels desc";
                comm.Parameters.AddWithValue("@wfid", workflowID);
                comm.Parameters.AddWithValue("@wfsid", workflow_subID);
                SqlDataReader dr = comm.ExecuteReader();
                while (dr.Read())
                {
                    int wfid = (int)dr["wfid"];
                    Workflow wf = wfDAO.getWorkflowByID(wfid);
                    toReturn.setMainWF(wf);

                    int wfsid = (int)dr["wf_sub_id"];
                    WorkflowSub wfs = wfsDAO.getWorkflowSubByID(wfsid);
                    toReturn.setMainWFS(wfs);

                    toReturn.setJobCategory((string)dr["job_category"]);
                    toReturn.setLevel((int)dr["levels"]);
                }
                dr.Close();
            }
            catch (SqlException ex)
            {
                throw ex;
            }
            finally
            {
                conn.Close();
            }
            return toReturn;
        }
        public WorkflowApprover getWorkflowApproverByJobCategory(string jobCategory, int wfid, int wf_sub_id)
        {
            WorkflowApprover toReturn = new WorkflowApprover();
            SqlConnection conn = new SqlConnection();
            UserDAO userDAO = new UserDAO();
            try
            {
                conn = new SqlConnection();
                string connstr = ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString();
                conn.ConnectionString = connstr;
                conn.Open();
                SqlCommand comm = new SqlCommand();
                comm.Connection = conn;
                comm.CommandText = "select * from [Workflow_approvers] where job_category=@job_category and wfid=@wfid and wf_sub_id=@wf_sub_id";
                comm.Parameters.AddWithValue("@job_category", jobCategory);
                comm.Parameters.AddWithValue("@wfid", wfid);
                comm.Parameters.AddWithValue("@wf_sub_id", wf_sub_id);
                SqlDataReader dr = comm.ExecuteReader();
                while (dr.Read())
                {
                    int wf_id = (int)dr["wfid"];
                    Workflow wf = wfDAO.getWorkflowByID(wf_id);
                    toReturn.setMainWF(wf);

                    int wfsid = (int)dr["wf_sub_id"];
                    WorkflowSub wfs = wfsDAO.getWorkflowSubByID(wfsid);
                    toReturn.setMainWFS(wfs);

                    toReturn.setJobCategory((string)dr["job_category"]);
                    toReturn.setLevel((int)dr["levels"]);
                }
                dr.Close();
            }
            catch (SqlException ex)
            {
                throw ex;
            }
            finally
            {
                conn.Close();
            }
            return toReturn;
        }
        public int getLevelByJobCategory(string jobCategory, int wfid, int wfsid)
        {
            int toReturn = -1;
            SqlConnection conn = new SqlConnection();
            UserDAO userDAO = new UserDAO();
            try
            {
                conn = new SqlConnection();
                string connstr = ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString();
                conn.ConnectionString = connstr;
                conn.Open();
                SqlCommand comm = new SqlCommand();
                comm.Connection = conn;
                comm.CommandText = "select levels from [Workflow_approvers] where job_category=@job_category and wfid=@wfid and wf_sub_id=@wfsid";
                comm.Parameters.AddWithValue("@job_category", jobCategory);
                comm.Parameters.AddWithValue("@wfid", wfid);
                comm.Parameters.AddWithValue("@wfsid", wfsid);
                SqlDataReader dr = comm.ExecuteReader();
                while (dr.Read())
                {
                    toReturn = (int)dr["levels"];
                }
                dr.Close();
            }
            catch (SqlException ex)
            {
                throw ex;
            }
            finally
            {
                conn.Close();
            }
            return toReturn;
        }
        public string getJobCategory(int workflowID, int workflow_subID, int levels)
        {
            string toReturn = null;
            SqlConnection conn = new SqlConnection();
            try
            {
                conn = new SqlConnection();
                string connstr = ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString();
                conn.ConnectionString = connstr;
                conn.Open();
                SqlCommand comm = new SqlCommand();
                comm.Connection = conn;
                comm.CommandText = "select job_category from [Workflow_approvers] where wfid=@wfid and wf_sub_id=@wfsid and levels=@levels";
                comm.Parameters.AddWithValue("@wfid", workflowID);
                comm.Parameters.AddWithValue("@wfsid", workflow_subID);
                comm.Parameters.AddWithValue("@levels", levels);
                SqlDataReader dr = comm.ExecuteReader();
                while (dr.Read())
                {
                    toReturn = (string)dr["job_category"];
                }
                dr.Close();
            }
            catch (SqlException ex)
            {
                throw ex;
            }
            finally
            {
                conn.Close();
            }
            return toReturn;
        }
    }
}