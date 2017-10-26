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
            Highcharts.chart('pie', {
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
                    data: <%= pieChartData%>  
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
                 31
                    </div>
                    <div class="wrapper">
                        <h5><strong>No. of Users</strong></h5>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="box">
                    <div class="wrapper">
                        <span style="font-size: 35px;" class="glyphicon glyphicon-book"></span>
                        &nbsp;
                 31
                    </div>
                    <div class="wrapper">
                        <h5><strong>No. of Courses</strong></h5>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="box">
                    <div class="wrapper">
                        <span style="font-size: 35px;" class="glyphicon glyphicon-book"></span>
                        &nbsp;
                 31
                    </div>
                    <div class="wrapper">
                        <h5><strong>No. of Courses</strong></h5>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="box">
                    <div class="wrapper">
                        <span style="font-size: 35px;" class="glyphicon glyphicon-book"></span>
                        &nbsp;
                 31
                    </div>
                    <div class="wrapper">
                        <h5><strong>No. of Courses</strong></h5>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class=" container">
        <br />
        <form id="form1" runat="server">
            <div id="pie" class="pull-left" style="width: 500px; height: 400px; margin: 0 auto"></div>
        </form>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
