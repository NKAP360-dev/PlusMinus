<%@ Page Title="" Language="C#" MasterPageFile="~/Masterpage.Master" AutoEventWireup="true" CodeBehind="viewAllModule.aspx.cs" Inherits="LearnHub.viewAllModule" %>
<%@ Import Namespace="LearnHub.AppCode.entity"%>
<%@ Import Namespace="LearnHub.AppCode.dao"%>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
     <style>
        .list-group-item {
            border-left: 1px solid white;
            border-right: 1px solid white;
        }

        #myInput {
            background-image: url('/img/search.png'); /* Add a search icon to input */
            background-position: 10px 12px; /* Position the search icon */
            background-repeat: no-repeat; /* Do not repeat the icon image */
            width: 100%; /* Full-width */
            font-size: 16px; /* Increase font-size */
            padding: 12px 20px 12px 40px; /* Add some padding */
            border: 1px solid #ddd; /* Add a grey border */
            margin-bottom: 12px; /* Add some space below the input */
        }
    </style>
    <script>
        $(document).ready(function () {
            $('#menu').hide();
        });

        function configuration() {
            var x = document.getElementById('menu');
            if (x.style.display === 'none') {
                x.style.display = 'block';
            } else {
                x.style.display = 'none';
            }
        }

        function myFunction() {
            // Declare variables 
            var input, filter, table, tr, td, i;
            input = document.getElementById("myInput");
            filter = input.value.toUpperCase();
            table = document.getElementById("myTable");
            tr = table.getElementsByTagName("tr");

            // Loop through all table rows, and hide those who don't match the search query
            for (i = 0; i < tr.length; i++) {
                td = tr[i].getElementsByTagName("td")[0];
                if (td) {
                    if (td.innerHTML.toUpperCase().indexOf(filter) > -1) {
                        tr[i].style.display = "";
                    } else {
                        tr[i].style.display = "none";
                    }
                }
            }
        }

        function sortTable(n) {
            var table, rows, switching, i, x, y, shouldSwitch, dir, switchcount = 0;
            table = document.getElementById("myTable");
            switching = true;
            //Set the sorting direction to ascending:
            dir = "asc";
            /*Make a loop that will continue until
            no switching has been done:*/
            while (switching) {
                //start by saying: no switching is done:
                switching = false;
                rows = table.getElementsByTagName("TR");
                /*Loop through all table rows (except the
                first, which contains table headers):*/
                for (i = 1; i < (rows.length - 1); i++) {
                    //start by saying there should be no switching:
                    shouldSwitch = false;
                    /*Get the two elements you want to compare,
                    one from current row and one from the next:*/
                    x = rows[i].getElementsByTagName("TD")[n];
                    y = rows[i + 1].getElementsByTagName("TD")[n];
                    /*check if the two rows should switch place,
                    based on the direction, asc or desc:*/
                    if (dir == "asc") {
                        if (x.innerHTML.toLowerCase() > y.innerHTML.toLowerCase()) {
                            //if so, mark as a switch and break the loop:
                            shouldSwitch = true;
                            break;
                        }
                    } else if (dir == "desc") {
                        if (x.innerHTML.toLowerCase() < y.innerHTML.toLowerCase()) {
                            //if so, mark as a switch and break the loop:
                            shouldSwitch = true;
                            break;
                        }
                    }
                }
                if (shouldSwitch) {
                    /*If a switch has been marked, make the switch
                    and mark that a switch has been done:*/
                    rows[i].parentNode.insertBefore(rows[i + 1], rows[i]);
                    switching = true;
                    //Each time a switch is done, increase this count by 1:
                    switchcount++;
                } else {
                    /*If no switching has been done AND the direction is "asc",
                    set the direction to "desc" and run the while loop again.*/
                    if (switchcount == 0 && dir == "asc") {
                        dir = "desc";
                        switching = true;
                    }
                }
            }
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

     <div class="configure">
        <a href="#" id="config" onclick="configuration()"><span class="label label-primary"><span class="glyphicon glyphicon-cog"></span>Configuration Menu</span></a>
    </div>
    <br />
    <div class="configure">
        <ul class="list-group" id="menu">
            <a href="createModules.aspx">
                <li class="list-group-item">Create New Modules
                </li>
            </a>
            <a href="#">
                <li class="list-group-item">Edit and Delete Modules
                </li>
            </a>
        </ul>
    </div>
   
    <div class="container">
        <h1>View Modules</h1>

        <div class="verticalLine"></div>
    </div>
    <asp:Panel ID="viewCompulsory" runat="server" Visible="false">
    <div class="container">
    <div class="row">
        <div class="col-md-3">
            <div class="list-group">
                 <div class="wrapper"><h4><strong><span class="glyphicon glyphicon-menu-hamburger">&emsp;</span>View Training Types</strong></h4></div>
                <a href="viewAllModule.aspx?module=compulsory" class="list-group-item active">
                    <span class="glyphicon glyphicon-menu-right"></span> &emsp;Compulsory Training
                </a>
                <a href="viewAllModule.aspx?module=leadership" class="list-group-item">
                    Leadership Skills Training
                </a>
                <a href="viewAllModule.aspx?module=professional" class="list-group-item">
                    Professional Training
                </a>

            </div>
        </div>
        <div class="col-md-9">
            <h2>Compulsory Modules</h2>
            <input type="text" id="myInput" onkeyup="myFunction()" placeholder="Search for Courses">
            <h6>Click on column name to sort</h6>
            <table class="table table-striped table-hover" id="myTable">
                <thead>
                    <tr>
                    <th onclick="sortTable(0)">Course Name&emsp;<span class="glyphicon glyphicon-sort"></span></th>
                    <th onclick="sortTable(1)">Course Provider&emsp;<span class="glyphicon glyphicon-sort"></span></th>
                        <th>Start Date</th>
                        <th>End Date</th>
                        <th></th>
                    </tr>
                </thead>
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
                             htmlStr += "<td><a href=\"viewModuleInfo.aspx?id="+ ce.getCourseID() + "\"><span class=\"glyphicon glyphicon-menu-right\"></span> View More</a></td>";
                             htmlStr += "</tr>";
                         }
                        Response.Write(htmlStr);
                     }
                     
                    %>
            </table>

        </div>
    </div>
        </div>
        </asp:Panel>

     <asp:Panel ID="viewLeadership" runat="server" Visible="false">
    <div class="container">
    <div class="row">
        <div class="col-md-3">
            <div class="list-group">
                    <div class="wrapper">
                        <h4><strong><span class="glyphicon glyphicon-menu-hamburger">&emsp;</span>View Training Types</strong></h4>
                    </div>
                    <a href="viewAllModule.aspx?module=compulsory" class="list-group-item">Compulsory Training
                    </a>
                    <a href="viewAllModule.aspx?module=leadership" class="list-group-item active">
                        <span class="glyphicon glyphicon-menu-right"></span>&emsp;Leadership Skills Training
                    </a>
                    <a href="viewAllModule.aspx?module=professional" class="list-group-item">Professional Training
                    </a>

                </div>
        </div>
        <div class="col-md-9">
            <h2>Leadership Modules</h2>
            <input type="text" id="myInput" onkeyup="myFunction()" placeholder="Search for Courses">
            <h6>Click on column name to sort</h6>
            <table class="table table-striped table-hover" id="myTable">
                <thead>
                    <tr>
                    <th onclick="sortTable(0)">Course Name&emsp;<span class="glyphicon glyphicon-sort"></span></th>
                    <th onclick="sortTable(1)">Course Provider&emsp;<span class="glyphicon glyphicon-sort"></span></th>
                        <th>Start Date</th>
                        <th>End Date</th>
                        <th></th>
                    </tr>
                </thead>
                 <%
                     Course_elearnDAO allListing = new Course_elearnDAO();
                     ArrayList list = allListing.view_courses("Leadership");
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
                             htmlStr += "<td><a href=\"viewModuleInfo.aspx?id="+ ce.getCourseID() + "\"><span class=\"glyphicon glyphicon-menu-right\"></span> View More</a></td>";
                             htmlStr += "</tr>";
                         }
                        Response.Write(htmlStr);
                     }
                     
                    %>
            </table>

        </div>
    </div>
        </div>
        </asp:Panel>

    <asp:Panel ID="viewProfessional" runat="server" Visible="false">
    <div class="container">
    <div class="row">
        <div class="col-md-3">
            <div class="list-group">
                    <div class="wrapper">
                        <h4><strong><span class="glyphicon glyphicon-menu-hamburger">&emsp;</span>View Training Types</strong></h4>
                    </div>
                    <a href="viewAllModule.aspx?module=compulsory" class="list-group-item">Compulsory Training
                    </a>
                    <a href="viewAllModule.aspx?module=leadership" class="list-group-item"> Leadership Skills Training
                    </a>
                    <a href="viewAllModule.aspx?module=professional" class="list-group-item active"><span class="glyphicon glyphicon-menu-right"></span>&emsp;Professional Training
                    </a>

                </div>
        </div>
        <div class="col-md-9">
            <h2>Professional Modules</h2>
            <input type="text" id="myInput" onkeyup="myFunction()" placeholder="Search for Courses">
            <h6>Click on column name to sort</h6>
            <table class="table table-striped table-hover" id="myTable">
                <thead>
                    <tr>
                    <th onclick="sortTable(0)">Course Name&emsp;<span class="glyphicon glyphicon-sort"></span></th>
                    <th onclick="sortTable(1)">Course Provider&emsp;<span class="glyphicon glyphicon-sort"></span></th>
                        <th>Start Date</th>
                        <th>End Date</th>
                        <th></th>
                    </tr>
                </thead>
                 <%
                     Course_elearnDAO allListing = new Course_elearnDAO();
                     ArrayList list = allListing.view_courses("Professional");
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
                             htmlStr += "<td><a href=\"viewModuleInfo.aspx?id="+ ce.getCourseID() + "\"><span class=\"glyphicon glyphicon-menu-right\"></span> View More</a></td>";
                             htmlStr += "</tr>";
                         }
                        Response.Write(htmlStr);
                     }
                     
                    %>
            </table>

        </div>
    </div>
        </div>
        </asp:Panel>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
