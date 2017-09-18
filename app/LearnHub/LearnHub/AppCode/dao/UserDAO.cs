using LearnHub.AppCode.entity;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Collections;

namespace LearnHub.AppCode.dao
{
    public class UserDAO
    {
        public Boolean update_status_deactivate(string id)
        {
            SqlConnection conn = new SqlConnection();
            Boolean toReturn = false;
            try
            {
                conn = new SqlConnection();
                string connstr = ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString();
                conn.ConnectionString = connstr;
                conn.Open();
                SqlCommand comm = new SqlCommand();
                comm.Connection = conn;
                comm.CommandText = "update [User] set status='Inactive' where userID=@userID";
                comm.Parameters.AddWithValue("@userID", id);
                int rowsAffected = comm.ExecuteNonQuery();
                //need new method to create pre-requisities here to store in seperate table (pre-req table)
                toReturn = true;
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
        public Boolean update_status_activate(string id)
        {
            SqlConnection conn = new SqlConnection();
            Boolean toReturn = false;
            try
            {
                conn = new SqlConnection();
                string connstr = ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString();
                conn.ConnectionString = connstr;
                conn.Open();
                SqlCommand comm = new SqlCommand();
                comm.Connection = conn;
                comm.CommandText = "update [User] set status='Active' where userID=@userID";
                comm.Parameters.AddWithValue("@userID", id);
                int rowsAffected = comm.ExecuteNonQuery();
                //need new method to create pre-requisities here to store in seperate table (pre-req table)
                toReturn = true;
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
        public Boolean update_user_without_password(User u, ArrayList roles)
        {
            SqlConnection conn = new SqlConnection();
            Boolean toReturn = false;
            try
            {
                conn = new SqlConnection();
                string connstr = ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString();
                conn.ConnectionString = connstr;
                conn.Open();
                SqlCommand comm = new SqlCommand();
                comm.Connection = conn;
                comm.CommandText = "update [User] set userID=@userID, name=@name , " +
                    "start_Date=@date, job_category=@category, job_title=@job_title, supervisor=@supervisor, role='user', dept_name=@dept_name, " +
                    "contactNumber=@contact, address=@add, email=@email where userID=@userID1";
                comm.Parameters.AddWithValue("@userID", u.getUserID());
                comm.Parameters.AddWithValue("@name", u.getName());
                //comm.Parameters.AddWithValue("@password", password);
                comm.Parameters.AddWithValue("@date", u.getStartDate());
                comm.Parameters.AddWithValue("@category", u.getJobCategory());
                comm.Parameters.AddWithValue("@job_title", u.getJobTitle());
                comm.Parameters.AddWithValue("@supervisor", u.getSupervisor());
                comm.Parameters.AddWithValue("@dept_name", u.getDepartment());
                comm.Parameters.AddWithValue("@contact", u.getContact());
                comm.Parameters.AddWithValue("@add", u.getAddress());
                //comm.Parameters.AddWithValue("@salt", salt);
                comm.Parameters.AddWithValue("@email", u.getEmail());
                comm.Parameters.AddWithValue("@userID1", u.getUserID());
                int rowsAffected = comm.ExecuteNonQuery();
                //need new method to create pre-requisities here to store in seperate table (pre-req table)
                add_role(u, roles);
                toReturn = true;
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
        public Boolean update_user(User u, string password, string salt, ArrayList roles)
        {
            SqlConnection conn = new SqlConnection();
            Boolean toReturn = false;
            try
            {
                conn = new SqlConnection();
                string connstr = ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString();
                conn.ConnectionString = connstr;
                conn.Open();
                SqlCommand comm = new SqlCommand();
                comm.Connection = conn;
                comm.CommandText = "update [User] set userID=@userID, name=@name , password=@password, " +
                    "start_Date=@date, job_category=@category, job_title=@job_title, supervisor='S1234567C', role='user', dept_name=@dept_name, " +
                    "contactNumber=@contact, address=@add, salt=@salt, email=@email where userID=@userID1";
                comm.Parameters.AddWithValue("@userID", u.getUserID());
                comm.Parameters.AddWithValue("@name", u.getName());
                comm.Parameters.AddWithValue("@password", password);
                comm.Parameters.AddWithValue("@date", u.getStartDate());
                comm.Parameters.AddWithValue("@category", u.getJobCategory());
                comm.Parameters.AddWithValue("@job_title", u.getJobTitle());
                comm.Parameters.AddWithValue("@supervisor", u.getSupervisor());
                comm.Parameters.AddWithValue("@dept_name", u.getDepartment());
                comm.Parameters.AddWithValue("@contact", u.getContact());
                comm.Parameters.AddWithValue("@add", u.getAddress());
                comm.Parameters.AddWithValue("@salt", salt);
                comm.Parameters.AddWithValue("@email", u.getEmail());
                comm.Parameters.AddWithValue("@userID1", u.getUserID());
                int rowsAffected = comm.ExecuteNonQuery();
                //need new method to create pre-requisities here to store in seperate table (pre-req table)
                add_role(u, roles);
                toReturn = true;
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
        public Boolean delete_user(User u)
        {
            SqlConnection conn = new SqlConnection();
            Boolean toReturn = false;
            try
            {
                conn = new SqlConnection();
                string connstr = ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString();
                conn.ConnectionString = connstr;
                conn.Open();
                SqlCommand comm = new SqlCommand();
                comm.Connection = conn;
                comm.CommandText = "delete from [User] where userID=@userID";
                comm.Parameters.AddWithValue("@userID", u.getUserID());
                int rowsAffected = comm.ExecuteNonQuery();
                //need new method to create pre-requisities here to store in seperate table (pre-req table)
                toReturn = true;
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
        public Boolean delete_roles_of_user(User u)
        {
            SqlConnection conn = new SqlConnection();
            Boolean toReturn = false;
            try
            {
                conn = new SqlConnection();
                string connstr = ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString();
                conn.ConnectionString = connstr;
                conn.Open();
                SqlCommand comm = new SqlCommand();
                comm.Connection = conn;
                comm.CommandText = "delete from [User_roles] where userID=@userID";
                comm.Parameters.AddWithValue("@userID", u.getUserID());
                int rowsAffected = comm.ExecuteNonQuery();
                //need new method to create pre-requisities here to store in seperate table (pre-req table)
                toReturn = true;
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
        public Boolean add_role(User u, ArrayList arr)
        {
            SqlConnection conn = new SqlConnection();
            Boolean toReturn = false;
            foreach (string s in arr)
            {
                try
                {
                    conn = new SqlConnection();
                    string connstr = ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString();
                    conn.ConnectionString = connstr;
                    conn.Open();
                    SqlCommand comm = new SqlCommand();
                    comm.Connection = conn;
                    comm.CommandText = "INSERT INTO [User_roles] (userID, role) VALUES(@userID, @role)";
                    comm.Parameters.AddWithValue("@userID", u.getUserID());
                    comm.Parameters.AddWithValue("@role", s);
                    int rowsAffected = comm.ExecuteNonQuery();
                    //need new method to create pre-requisities here to store in seperate table (pre-req table)
                    toReturn = true;
                }
                catch (SqlException ex)
                {
                    throw ex;
                }
                finally
                {
                    conn.Close();
                }
            }
            return toReturn;
        }
        public Boolean create_user_elearn(User u, string password, string salt)
        {
            SqlConnection conn = new SqlConnection();
            Boolean toReturn = false;
            try
            {
                conn = new SqlConnection();
                string connstr = ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString();
                conn.ConnectionString = connstr;
                conn.Open();
                SqlCommand comm = new SqlCommand();
                comm.Connection = conn;
                comm.CommandText = "INSERT INTO [User] (userID, name , password, start_Date, job_category, job_title," +
                                    "supervisor, role, dept_name, contactNumber, address, salt, email, status)" +
                                    "VALUES(@userID, @name, @password, @start_date, @job_category, @job_title, @supervisor, 'user', @dept, @contact, @address, @salt, @email, @status)";
                comm.Parameters.AddWithValue("@userID", u.getUserID());
                comm.Parameters.AddWithValue("@name", u.getName());
                comm.Parameters.AddWithValue("@password", password);
                comm.Parameters.AddWithValue("@start_date", u.getStartDate());
                comm.Parameters.AddWithValue("@job_category", u.getJobCategory());
                comm.Parameters.AddWithValue("@job_title", u.getJobTitle());
                comm.Parameters.AddWithValue("@supervisor", u.getSupervisor());
                comm.Parameters.AddWithValue("@dept", u.getDepartment());
                comm.Parameters.AddWithValue("@contact", u.getContact());
                comm.Parameters.AddWithValue("@address", u.getAddress());
                comm.Parameters.AddWithValue("@salt", salt);
                comm.Parameters.AddWithValue("@email", u.getEmail());
                comm.Parameters.AddWithValue("@status", u.getStatus());
                int rowsAffected = comm.ExecuteNonQuery();
                //need new method to create pre-requisities here to store in seperate table (pre-req table)
                toReturn = true;
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

        public Boolean updatePassword(string password, User user)
        {
            SqlConnection conn = new SqlConnection();
            Boolean done = false;
            try
            {
                conn = new SqlConnection();
                string connstr = ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString();
                conn.ConnectionString = connstr;
                conn.Open();
                SqlCommand comm = new SqlCommand();
                comm.Connection = conn;
                comm.CommandText =
                    "update [User] set password=@pw where userID = @userid";
                comm.Parameters.AddWithValue("@pw", password);
                comm.Parameters.AddWithValue("@userid", user.getUserID());
                int rowsAffected = comm.ExecuteNonQuery();
                done = true;
            }
            catch (SqlException ex)
            {
                throw ex;
            }
            finally
            {
                conn.Close();
            }
            return done;
        }
        public string getPassword(string userID)
        {
            SqlConnection conn = new SqlConnection();
            string toReturn = null;
            try
            {
                conn = new SqlConnection();
                string connstr = ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString();
                conn.ConnectionString = connstr;
                conn.Open();
                SqlCommand comm = new SqlCommand();
                comm.Connection = conn;
                comm.CommandText = "select password from [User] where userID=@userID";
                comm.Parameters.AddWithValue("@userID", userID);
                SqlDataReader dr = comm.ExecuteReader();
                while (dr.Read())
                {
                    toReturn = (string)dr["password"];
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
        public User getUserByID(string userID)
        {
            SqlConnection conn = new SqlConnection();
            User toReturn = null;
            try
            {
                conn = new SqlConnection();
                string connstr = ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString();
                conn.ConnectionString = connstr;
                conn.Open();
                SqlCommand comm = new SqlCommand();
                comm.Connection = conn;
                comm.CommandText = "select * from [User] where userID=@userID";
                comm.Parameters.AddWithValue("@userID", userID);
                SqlDataReader dr = comm.ExecuteReader();
                while (dr.Read())
                {
                    toReturn = new User();
                    toReturn.setUserID((string)dr["userID"]);
                    toReturn.setName((string)dr["name"]);
                    toReturn.setJobTitle((string)dr["job_title"]);
                    toReturn.setJobCategory((string)dr["job_category"]);
                    if (!dr.IsDBNull(6))
                    {
                        toReturn.setSupervisor((string)dr["supervisor"]);
                    }
                    else
                    {
                        toReturn.setSupervisor("NA");
                    }
                    ArrayList roles = getRolesByID(userID);
                    toReturn.setRoles(roles); // need new method here to call roles table and populate this entity's arraylist variable
                    if (!dr.IsDBNull(8))
                    {
                        toReturn.setDepartment((string)dr["dept_name"]);
                    }
                    else
                    {
                        toReturn.setDepartment("NA");
                    }
                    toReturn.setEmail((string)dr["email"]);
                    toReturn.setContact((string)dr["contactNumber"]);
                    toReturn.setAddress((string)dr["address"]);
                    toReturn.setStartDate(dr.GetDateTime(3));
                    toReturn.setStatus((string)dr["status"]);

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
        public User getUserByName(string name)
        {
            SqlConnection conn = new SqlConnection();
            User toReturn = null;
            try
            {
                conn = new SqlConnection();
                string connstr = ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString();
                conn.ConnectionString = connstr;
                conn.Open();
                SqlCommand comm = new SqlCommand();
                comm.Connection = conn;
                comm.CommandText = "select * from [User] where name = @name";
                comm.Parameters.AddWithValue("@name", name);
                SqlDataReader dr = comm.ExecuteReader();
                while (dr.Read())
                {
                    toReturn = new User();
                    string userid = (string)dr["userID"];
                    toReturn.setUserID(userid);
                    toReturn.setName((string)dr["name"]);
                    toReturn.setJobTitle((string)dr["job_title"]);
                    toReturn.setJobCategory((string)dr["job_category"]);
                    if (!dr.IsDBNull(6))
                    {
                        toReturn.setSupervisor((string)dr["supervisor"]);
                    }
                    else
                    {
                        toReturn.setSupervisor("NA");
                    }
                    ArrayList roles = getRolesByID(userid);
                    toReturn.setRoles(roles); // need new method here to call roles table and populate this entity's arraylist variable
                    if (!dr.IsDBNull(8))
                    {
                        toReturn.setDepartment((string)dr["dept_name"]);
                    }
                    else
                    {
                        toReturn.setDepartment("NA");
                    }
                    toReturn.setEmail((string)dr["email"]);
                    toReturn.setContact((string)dr["contactNumber"]);
                    toReturn.setAddress((string)dr["address"]);
                    toReturn.setStartDate(dr.GetDateTime(3));
                    toReturn.setStatus((string)dr["status"]);

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
        public ArrayList get_supervisors()
        {
            SqlConnection conn = new SqlConnection();
            ArrayList arr = new ArrayList();
            try
            {
                User toReturn = null;
                conn = new SqlConnection();
                string connstr = ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString();
                conn.ConnectionString = connstr;
                conn.Open();
                SqlCommand comm = new SqlCommand();
                comm.Connection = conn;
                comm.CommandText = "select * from [User] where job_category <> 'staff'";
                SqlDataReader dr = comm.ExecuteReader();
                while (dr.Read())
                {
                    toReturn = new User();
                    toReturn.setUserID((string)dr["userID"]);
                    toReturn.setName((string)dr["name"]);
                    toReturn.setJobTitle((string)dr["job_title"]);
                    toReturn.setJobCategory((string)dr["job_category"]);
                    if (!dr.IsDBNull(6))
                    {
                        toReturn.setSupervisor((string)dr["supervisor"]);
                    }
                    else
                    {
                        toReturn.setSupervisor("NA");
                    }
                    //ArrayList roles = getRolesByID(userID);
                    //toReturn.setRoles(roles); // need new method here to call roles table and populate this entity's arraylist variable
                    if (!dr.IsDBNull(8))
                    {
                        toReturn.setDepartment((string)dr["dept_name"]);
                    }
                    else
                    {
                        toReturn.setDepartment("NA");
                    }
                    toReturn.setEmail((string)dr["email"]);
                    toReturn.setContact((string)dr["contactNumber"]);
                    toReturn.setAddress((string)dr["address"]);
                    toReturn.setStartDate(dr.GetDateTime(3));
                    toReturn.setStatus((string)dr["status"]);
                    arr.Add(toReturn);
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
            return arr;
        }
        public User getUserByEmail(string email)
        {
            SqlConnection conn = new SqlConnection();
            User toReturn = null;
            try
            {
                conn = new SqlConnection();
                string connstr = ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString();
                conn.ConnectionString = connstr;
                conn.Open();
                SqlCommand comm = new SqlCommand();
                comm.Connection = conn;
                comm.CommandText = "select * from [User] where email=@email";
                comm.Parameters.AddWithValue("@email", email);
                SqlDataReader dr = comm.ExecuteReader();
                while (dr.Read())
                {
                    toReturn = new User();
                    string userID = ((string)dr["userID"]);
                    toReturn.setUserID(userID);
                    toReturn.setName((string)dr["name"]);
                    toReturn.setJobTitle((string)dr["job_title"]);
                    toReturn.setJobCategory((string)dr["job_category"]);
                    if (!dr.IsDBNull(6))
                    {
                        toReturn.setSupervisor((string)dr["supervisor"]);
                    }
                    else
                    {
                        toReturn.setSupervisor("NA");
                    }
                    ArrayList roles = getRolesByID(userID);
                    toReturn.setRoles(roles); // need new method here to call roles table and populate this entity's arraylist variable
                    if (!dr.IsDBNull(8))
                    {
                        toReturn.setDepartment((string)dr["dept_name"]);
                    }
                    else
                    {
                        toReturn.setDepartment("NA");
                    }
                    toReturn.setEmail((string)dr["email"]);
                    toReturn.setContact((string)dr["contactNumber"]);
                    toReturn.setAddress((string)dr["address"]);
                    toReturn.setStartDate(dr.GetDateTime(3));
                    toReturn.setStatus((string)dr["status"]);

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
        public ArrayList getRolesByID(string userID)
        {
            SqlConnection conn = new SqlConnection();
            ArrayList toReturn = new ArrayList();
            try
            {
                conn = new SqlConnection();
                string connstr = ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString();
                conn.ConnectionString = connstr;
                conn.Open();
                SqlCommand comm = new SqlCommand();
                comm.Connection = conn;
                comm.CommandText = "select role from User_roles where userID=@userID";
                comm.Parameters.AddWithValue("@userID", userID);
                SqlDataReader dr = comm.ExecuteReader();
                while (dr.Read())
                {
                    toReturn.Add((string)dr["role"]);
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

        public User updateInfo(string contact, string add, User user)
        {
            SqlConnection conn = new SqlConnection();
            try
            {
                conn = new SqlConnection();
                string connstr = ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString();
                conn.ConnectionString = connstr;
                conn.Open();
                SqlCommand comm = new SqlCommand();
                comm.Connection = conn;
                comm.CommandText =
                    "update [User] set contactNumber=@contact, address=@add where userID = @userID";
                comm.Parameters.AddWithValue("@contact", contact);
                comm.Parameters.AddWithValue("@add", add);
                comm.Parameters.AddWithValue("@userID", user.getUserID());
                user.setAddress(add);
                user.setContact(contact);
                int rowsAffected = comm.ExecuteNonQuery();
                return user;
            }
            catch (SqlException ex)
            {
                throw ex;
            }
            finally
            {
                conn.Close();
            }
        }

        public List<User> getAllUsers()
        {
            List<User> toReturn = new List<User>();
            SqlConnection conn = new SqlConnection();
            User u = null;
            try
            {
                conn = new SqlConnection();
                string connstr = ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString();
                conn.ConnectionString = connstr;
                conn.Open();
                SqlCommand comm = new SqlCommand();
                comm.Connection = conn;
                comm.CommandText = "select * from [User]";
                SqlDataReader dr = comm.ExecuteReader();
                while (dr.Read())
                {
                    u = new User();
                    u = new User();
                    string userID = ((string)dr["userID"]);
                    u.setUserID(userID);
                    u.setName((string)dr["name"]);
                    u.setJobTitle((string)dr["job_title"]);
                    u.setJobCategory((string)dr["job_category"]);
                    if (!DBNull.Value.Equals(dr["supervisor"]))
                    {
                        u.setSupervisor((string)dr["supervisor"]);
                    }
                    else
                    {
                        u.setSupervisor("NA");
                    }
                    ArrayList roles = getRolesByID(userID);
                    u.setRoles(roles);
                    u.setContact((string)dr["contactNumber"]);
                    u.setAddress((string)dr["address"]);
                    u.setDepartment((string)dr["dept_name"]);
                    u.setEmail((string)dr["email"]);
                    u.setStartDate(dr.GetDateTime(3));
                    u.setStatus((string)dr["status"]);
                    toReturn.Add(u);
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
        public User getSupervisorbyDepartment(string dept_name)
        {
            SqlConnection conn = new SqlConnection();
            User toReturn = null;
            try
            {
                conn = new SqlConnection();
                string connstr = ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString();
                conn.ConnectionString = connstr;
                conn.Open();
                SqlCommand comm = new SqlCommand();
                comm.Connection = conn;
                comm.CommandText = "select * from [User] where dept_name=@dept_name and job_category=@job_category";
                comm.Parameters.AddWithValue("@dept_name", dept_name);
                comm.Parameters.AddWithValue("@job_category", "supervisor");
                SqlDataReader dr = comm.ExecuteReader();
                while (dr.Read())
                {
                    toReturn = new User();
                    string userID = ((string)dr["userID"]);
                    toReturn.setUserID(userID);
                    toReturn.setName((string)dr["name"]);
                    toReturn.setJobTitle((string)dr["job_title"]);
                    toReturn.setJobCategory((string)dr["job_category"]);
                    if (!dr.IsDBNull(5))
                    {
                        toReturn.setSupervisor((string)dr["supervisor"]);
                    }
                    else
                    {
                        toReturn.setSupervisor("NA");
                    }
                    ArrayList roles = getRolesByID(userID);
                    toReturn.setRoles(roles);
                    toReturn.setDepartment((string)dr["dept_name"]);
                    toReturn.setEmail((string)dr["email"]);
                    toReturn.setStartDate(dr.GetDateTime(3));
                    toReturn.setStatus((string)dr["status"]);
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
        public User getHODbyDepartment(string dept_name)
        {
            SqlConnection conn = new SqlConnection();
            User hod = getSupervisorbyDepartment(dept_name);
            string supervisorID = getSupervisorIDOfUser(hod.getUserID());
            return getUserByID(supervisorID);
        }
        public string getSupervisorIDOfUser(string userID)
        {
            SqlConnection conn = new SqlConnection();
            string toReturn = "";
            try
            {
                conn = new SqlConnection();
                string connstr = ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString();
                conn.ConnectionString = connstr;
                conn.Open();
                SqlCommand comm = new SqlCommand();
                comm.Connection = conn;
                comm.CommandText = "select supervisor from [User] where userID=@userID";
                comm.Parameters.AddWithValue("@userID", userID);
                SqlDataReader dr = comm.ExecuteReader();
                while (dr.Read())
                {
                    toReturn = (string)dr["supervisor"];
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
        public User getCEO()
        {
            SqlConnection conn = new SqlConnection();
            User toReturn = null;
            try
            {
                conn = new SqlConnection();
                string connstr = ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString();
                conn.ConnectionString = connstr;
                conn.Open();
                SqlCommand comm = new SqlCommand();
                comm.Connection = conn;
                comm.CommandText = "select * from [User] where job_category=@job_category";
                comm.Parameters.AddWithValue("@job_category", "ceo");
                SqlDataReader dr = comm.ExecuteReader();
                while (dr.Read())
                {
                    toReturn = new User();
                    string userID = ((string)dr["userID"]);
                    toReturn.setUserID(userID);
                    toReturn.setName((string)dr["name"]);
                    toReturn.setJobTitle((string)dr["job_title"]);
                    toReturn.setJobCategory((string)dr["job_category"]);
                    if (!dr.IsDBNull(6))
                    {
                        toReturn.setSupervisor((string)dr["supervisor"]);
                    }
                    else
                    {
                        toReturn.setSupervisor("NA");
                    }
                    ArrayList roles = getRolesByID(userID);
                    toReturn.setRoles(roles);
                    toReturn.setDepartment((string)dr["dept_name"]);
                    toReturn.setEmail((string)dr["email"]);
                    toReturn.setStartDate(dr.GetDateTime(3));
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
        public User getHRHOD()
        {
            SqlConnection conn = new SqlConnection();
            User toReturn = null;
            try
            {
                conn = new SqlConnection();
                string connstr = ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString();
                conn.ConnectionString = connstr;
                conn.Open();
                SqlCommand comm = new SqlCommand();
                comm.Connection = conn;
                comm.CommandText = "select * from [User] where job_category=@job_category";
                comm.Parameters.AddWithValue("@job_category", "hr hod");
                SqlDataReader dr = comm.ExecuteReader();
                while (dr.Read())
                {
                    toReturn = new User();
                    string userID = ((string)dr["userID"]);
                    toReturn.setUserID(userID);
                    toReturn.setName((string)dr["name"]);
                    toReturn.setJobTitle((string)dr["job_title"]);
                    toReturn.setJobCategory((string)dr["job_category"]);
                    if (!dr.IsDBNull(5))
                    {
                        toReturn.setSupervisor((string)dr["supervisor"]);
                    }
                    else
                    {
                        toReturn.setSupervisor("NA");
                    }
                    ArrayList roles = getRolesByID(userID);
                    toReturn.setRoles(roles);
                    toReturn.setDepartment((string)dr["dept_name"]);
                    toReturn.setEmail((string)dr["email"]);
                    toReturn.setStartDate(dr.GetDateTime(3));
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
        public List<User> getAllHR()
        {
            List<User> toReturn = new List<User>();
            SqlConnection conn = new SqlConnection();
            User u = null;
            try
            {
                conn = new SqlConnection();
                string connstr = ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString();
                conn.ConnectionString = connstr;
                conn.Open();
                SqlCommand comm = new SqlCommand();
                comm.Connection = conn;
                comm.CommandText = "select * from [User] where job_category=@job_category";
                comm.Parameters.AddWithValue("@job_category", "hr");
                SqlDataReader dr = comm.ExecuteReader();
                while (dr.Read())
                {
                    u = new User();
                    u = new User();
                    string userID = ((string)dr["userID"]);
                    u.setUserID(userID);
                    //u.setUserID((string)dr["userID"]);
                    u.setName((string)dr["name"]);
                    u.setJobTitle((string)dr["job_title"]);
                    u.setJobCategory((string)dr["job_category"]);
                    if (!dr.IsDBNull(5))
                    {
                        u.setSupervisor((string)dr["supervisor"]);
                    }
                    else
                    {
                        u.setSupervisor("NA");
                    }
                    ArrayList roles = getRolesByID(userID);
                    u.setRoles(roles);
                    u.setDepartment((string)dr["dept_name"]);
                    u.setEmail((string)dr["email"]);
                    u.setStartDate(dr.GetDateTime(3));

                    toReturn.Add(u);
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
        public List<User> getAllUsersBySubordinate(string supervisorID)
        {
            List<User> toReturn = new List<User>();
            SqlConnection conn = new SqlConnection();
            User u = null;
            try
            {
                conn = new SqlConnection();
                string connstr = ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString();
                conn.ConnectionString = connstr;
                conn.Open();
                SqlCommand comm = new SqlCommand();
                comm.Connection = conn;
                comm.CommandText = "select * from [User] where supervisor=@supervisorID";
                comm.Parameters.AddWithValue("@supervisorID", supervisorID);
                SqlDataReader dr = comm.ExecuteReader();
                while (dr.Read())
                {
                    u = new User();
                    u = new User();
                    string userID = ((string)dr["userID"]);
                    u.setUserID(userID);
                    u.setName((string)dr["name"]);
                    u.setJobTitle((string)dr["job_title"]);
                    u.setJobCategory((string)dr["job_category"]);
                    if (!DBNull.Value.Equals(dr["supervisor"]))
                    {
                        u.setSupervisor((string)dr["supervisor"]);
                    }
                    else
                    {
                        u.setSupervisor("NA");
                    }
                    ArrayList roles = getRolesByID(userID);
                    u.setRoles(roles);
                    u.setContact((string)dr["contactNumber"]);
                    u.setAddress((string)dr["address"]);
                    u.setDepartment((string)dr["dept_name"]);
                    u.setEmail((string)dr["email"]);
                    u.setStartDate(dr.GetDateTime(3));
                    u.setStatus((string)dr["status"]);
                    toReturn.Add(u);
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