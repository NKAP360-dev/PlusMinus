<%@ Page Title="" Language="C#" MasterPageFile="~/Masterpage.Master" AutoEventWireup="true" CodeBehind="datatable.aspx.cs" Inherits="LearnHub.datatable" %>
<%@ Import Namespace="LearnHub.AppCode.entity"%>
<%@ Import Namespace="LearnHub.AppCode.dao"%>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <link href="https://cdn.datatables.net/1.10.11/css/jquery.dataTables.min.css" rel="stylesheet" type="text/css" />
    <script src="https://cdn.datatables.net/1.10.11/js/jquery.dataTables.min.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            $('#escalation1').DataTable();
            $('#escalation2').DataTable();
        });
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">

        <div class="page-header">
            <label class="heading">Working datatable with static data</label>
            <div class="form-group">
                <fieldset>
                    <form class="form-group" method="post">
                        <div class="table-responsive">
                            <div class="table-responsive">

                                <table id="escalation1" class="table table-striped table-hover">
                                    <thead>
                                        <tr>
                                            <th>Application</th>
                                            <th>EMOPOP</th>
                                            <th>Stats</th>
                                            <th>Statement</th>
                                            <th>Time</th>
                                            <th>Updated</th>
                                            <th>Details</th>
                                            <th>Price</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td>Tiger Nixon</td>
                                            <td>System Architect</td>
                                            <td>Edinburgh</td>
                                            <td>61</td>
                                            <td>2011/04/25</td>
                                            <td>$320,800</td>
                                            <td>2011/04/25</td>
                                            <td>$320,800</td>
                                        </tr>
                                        <tr>
                                            <td>Dog Nixon</td>
                                            <td>System Developer</td>
                                            <td>Edinburgh</td>
                                            <td>612</td>
                                            <td>2001/04/25</td>
                                            <td>$320,800</td>
                                            <td>2011/04/25</td>
                                            <td>$320,800</td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </form>
                    <!--END OF FORM ^^-->
                </fieldset>
            </div>
        </div>



        <div class="page-header">
            <label class="heading">Table with the same code but does not work with scriptlet</label>
            <div class="form-group">
                <fieldset>
                    <form class="form-group" method="post">
                        <div class="table-responsive">
                            <div class="table-responsive">

                                <table id="escalation2" class="table table-striped table-hover">
                                    <thead>
                                        <tr>
                                            <th>course Name</th>
                                            <th>Course Provider</th>
                                            <th>Start Date</th>
                                            <th>End Date</th>

                                        </tr>
                                    </thead>
                                    <tbody>
                                        <%
                                            Course_elearnDAO allListing = new Course_elearnDAO();
                                            ArrayList list = allListing.view_courses("Compulsory");
                                            String htmlStr = null;
                                            if (list.Count > 0)
                                            {
                                                foreach (Course_elearn ce in list)
                                                {
                                                    htmlStr += "<tr><td>";
                                                    htmlStr += ce.getCourseName();
                                                    htmlStr += "</td>";
                                                    htmlStr += "<td>";
                                                    htmlStr += ce.getCourseProvider();
                                                    htmlStr += "</td>";
                                                    htmlStr += "<td>";
                                                    htmlStr += ce.getStartDate();
                                                    htmlStr += "</td>";
                                                    if (ce.getExpiryDate() != null)
                                                    {
                                                        htmlStr += "<td>";
                                                        htmlStr += ce.getExpiryDate();
                                                        htmlStr += "</td>";
                                                    }
                                                    else
                                                    {
                                                        htmlStr += "<td>";
                                                        htmlStr += "N.A";
                                                        htmlStr += "</td>";
                                                    }
                                                    htmlStr += "<td><a href=\"viewModuleInfo.aspx?id=" + ce.getCourseID() + "\"><span class=\"glyphicon glyphicon-menu-right\"></span> View More</a></td>";
                                                    htmlStr += "</tr>";
                                                }
                                                Response.Write(htmlStr);
                                            }

                                        %>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </form>
                    <!--END OF FORM ^^-->
                </fieldset>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
