<%@ Page Title="" Language="C#" MasterPageFile="~/Masterpage.Master" AutoEventWireup="true" CodeBehind="askEmmaHelpQn.aspx.cs" Inherits="LearnHub.askEmmaHelpQn" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
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

        .pager li > a,
        .pager li > span,
        .pager li > a:focus, .pager .disabled > a,
        .pager .disabled > a:hover,
        .pager .disabled > a:focus,
        .pager .disabled > span {
            background-color: #2c3e50;
        }

            .pager li > a:hover {
                background-color: #576777;
            }
    </style>
    <script src="/Scripts/simple-bootstrap-paginator.js"></script>
    <script>
        $(document).ready(function () {
            $("[data-toggle='tooltip']").tooltip();
        });

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
        <a href="emmaConfiguration.aspx" id="config"><span class="label label-default"><span class="glyphicon glyphicon-cog"></span>Configuration Menu</span></a>
    </div>

    <div class="container">
        <h1>Emma's Help Questions</h1>
        <div class="verticalLine"></div>
    </div>
    <form class="form-horizontal" runat="server">
        <div class="container">
            <br />
            <input type="text" id="myInput" onkeyup="myFunction()" placeholder="Search for Questions">

            <table class="table table-striped table-hover with-pager" id="myTable">
                <thead>
                    <tr>
                        <th onclick="sortTable(0)" width="90%">Help Questions&emsp;<span class="glyphicon glyphicon-sort"></span></th>
                        <th></th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>blahblah</td>
                        <td>
                            <asp:LinkButton ID="LinkButton1" CssClass="btn btn-danger" runat="server" Text=""><span class="glyphicon glyphicon-trash"></span></asp:LinkButton></td>

                    </tr>
                    <tr>
                        <td>ayeee</td>
                        <td>
                            <asp:LinkButton ID="LinkButton2" CssClass="btn btn-danger" runat="server" Text=""><span class="glyphicon glyphicon-trash"></span></asp:LinkButton></td>

                    </tr>
                </tbody>
            </table>
            <nav>
                <ul class="pager">
                    <li class="previous">
                        <a href="#"><span aria-hidden="true"><span class="glyphicon glyphicon-chevron-left"></span></span>Older</a>
                    </li>
                    <li class="next"><a href="#">Newer<span aria-hidden="true"><span class="glyphicon glyphicon-chevron-right"></span></span>
                    </a>
                    </li>
                </ul>
            </nav>
            <div class="verticalLine"></div>
            <fieldset>
                <h2>Create new Help Questions</h2>
                <br />
                <div class="form-group">
                    <strong>
                        <%--Intent--%>
                        <label for="intentInput" class="col-lg-3 control-label"><span class="glyphicon glyphicon-question-sign" data-toggle='tooltip' data-placement="left" title="" data-original-title="What the hell is a help question? Beats me"></span>&nbsp;Help Question *</label>
                    </strong>
                    <div class="col-lg-7">
                        <%--Mandatory text field--%>
                        <asp:TextBox ID="intentInput" runat="server" CssClass="form-control" placeholder="Enter Help Question"></asp:TextBox>
                    </div>
                    <div class="col-lg-1">
                        <asp:Button ID="addBtn" CssClass="btn btn-primary" runat="server" Text="Add" />
                    </div>
                    <br />
                </div>
                <asp:Label ID="Label1" CssClass="col-lg-2 control-label" runat="server" Text="* = Compulsory fields"></asp:Label>
                <br />
                <br />

            </fieldset>
        </div>
    </form>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
