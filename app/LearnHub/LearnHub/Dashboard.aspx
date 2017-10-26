<%@ Page Title="" Language="C#" MasterPageFile="~/Masterpage.Master" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="LearnHub.Dashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="http://code.jquery.com/jquery-1.9.1.min.js" type="text/javascript"></script>
    <script src="http://code.highcharts.com/highcharts.js" type="text/javascript"></script>

    <style>
        .box {
            background-color: #efefef;
            height: 100px;
            width: 250px;
            padding-top: 5px;
            padding-bottom: 5px;
            padding-left: 25px;
            padding-right: 25px;
            font-size: 40px;
        }

        .highcharts-background {
            fill: #efefef;
        }

        .highcharts-title {
            font-family: 'Helvetica', monospace;
            fill: #434348;
            font-weight: bold;
            font-size: 3em;
            letter-spacing: 0.1em;
        }
    </style>
    <script type="text/javascript">  
        $(function () {
            Highcharts.chart('userPieChart', {
                chart: {
                    plotBackgroundColor: null,
                    plotBorderWidth: null,
                    plotShadow: false,
                    type: 'pie'
                },
                title: {
                    text: 'No. of LearnHub Users by Department'
                },
                tooltip: {
                    pointFormat: '{series.name}: <b>{point.y}</b>'
                },
                plotOptions: {
                    pie: {
                        allowPointSelect: true,
                        cursor: 'pointer',
                        dataLabels: {
                            enabled: true,
                            format: '<b>{point.name}</b>: {point.y}',
                            style: {
                                color: (Highcharts.theme && Highcharts.theme.contrastTextColor) || 'black'
                            }
                        },
                        showInLegend: true
                    }
                },
                series: [{
                    name: 'No. Of Users',
                    colorByPoint: true,
                    data: <%= userPieChartData%>  
                }]
            });
        });


        $(function () {
            Highcharts.chart('coursePieChart', {
                chart: {
                    plotBackgroundColor: null,
                    plotBorderWidth: null,
                    plotShadow: false,
                    type: 'pie'
                },
                title: {
                    text: 'No. of Courses by Course Category'
                },
                tooltip: {
                    pointFormat: '{series.name}: <b>{point.y}</b>'
                },
                plotOptions: {
                    pie: {
                        allowPointSelect: true,
                        cursor: 'pointer',
                        dataLabels: {
                            enabled: true,
                            format: '<b>{point.name}</b>: {point.y}',
                            style: {
                                color: (Highcharts.theme && Highcharts.theme.contrastTextColor) || 'black'
                            }
                        },
                        showInLegend: true
                    }
                },
                series: [{
                    name: 'No. Of Courses',
                    colorByPoint: true,
                    data: <%= coursePieChartData%>  
                }]
            });
        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">
        <br />
        <div class="row">
            <div class="col-md-3">
                <div class="box">
                    <div class="wrapper">
                        <span style="font-size: 35px;" class="glyphicon glyphicon-user"></span>
                        &nbsp;
                        <asp:Label ID="lblUsers" runat="server" Text=""></asp:Label>
                    </div>
                    <div class="wrapper">
                        <h5><strong>Users</strong></h5>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="box">
                    <div class="wrapper">
                        <span style="font-size: 35px;" class="glyphicon glyphicon-book"></span>
                        &nbsp;
                    <asp:Label ID="lblCourses" runat="server" Text=""></asp:Label>
                    </div>
                    <div class="wrapper">
                        <h5><strong>Courses</strong></h5>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="box">
                    <div class="wrapper">
                        <span style="font-size: 35px;" class="glyphicon glyphicon-check"></span>
                        &nbsp;
                 <asp:Label ID="lblQuizAttempts" runat="server" Text=""></asp:Label>
                    </div>
                    <div class="wrapper">
                        <h5><strong>Attempted Quizzes</strong></h5>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="box">
                    <div class="wrapper">
                        <span style="font-size: 35px;" class="glyphicon glyphicon-time"></span>
                        &nbsp;
                 <asp:Label ID="lblHours" runat="server" Text=""></asp:Label>
                    </div>
                    <div class="wrapper">
                        <h5><strong>Learning Hours Awarded</strong></h5>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <br />
    <form id="form1" runat="server">
        <div class=" container">
            <div class="row">
                <div class="col-md-6">
                    <div id="userPieChart" class="pull-left" style="min-width: 300px; width: 500px; height: 400px; margin: 0 auto"></div>
                </div>
                <div class="col-md-6">
                    <div id="coursePieChart" class="pull-left" style="min-width: 300px; width: 500px; height: 400px; margin: 0 auto"></div>
                </div>
            </div>
        </div>
    </form>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
