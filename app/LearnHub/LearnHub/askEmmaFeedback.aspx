<%@ Page Title="" Language="C#" MasterPageFile="~/Masterpage.Master" AutoEventWireup="true" CodeBehind="askEmmaFeedback.aspx.cs" Inherits="LearnHub.askEmmaFeedback" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="/Scripts/simple-bootstrap-paginator.js"></script>
    <style>
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
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="configure">
        <a href="emmaConfiguration.aspx" id="config"><span class="label label-default"><span class="glyphicon glyphicon-cog"></span>Configuration Menu</span></a>
    </div>

    <div class="container">
        <h1>View Feedback for Emma</h1>
        <div class="verticalLine"></div>
        <form class="form-horizontal" runat="server">
            <div class="container">
                <br />
                <table class="table table-striped table-hover with-pager" id="myTable">
                    <thead>
                        <tr>
                            <th width="80%">Feedback</th>
                            <th width="10%">Given by</th>
                            <th></th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>blahblah</td>
                            <td>Ber</td>
                            <td>
                                <asp:LinkButton ID="LinkButton1" CssClass="btn btn-danger" runat="server" Text="" data-toggle="modal" href="#deleteModal"><span class="glyphicon glyphicon-trash"></span></asp:LinkButton></td>

                        </tr>
                        <tr>
                            <td>ayeee</td>
                            <td>Rafid</td>
                            <td>
                                <asp:LinkButton ID="LinkButton2" CssClass="btn btn-danger" runat="server" Text="" data-toggle="modal" href="#deleteModal"><span class="glyphicon glyphicon-trash"></span></asp:LinkButton></td>

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
            </div>
        </form>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
