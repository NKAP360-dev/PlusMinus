<%@ Page Language="C#" Debug="true" AutoEventWireup="true" CodeBehind="forgotPassword.aspx.cs" Inherits="LearnHub.forgotPassword" %>

<!DOCTYPE html>
<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="LearnHub.AppCode.dao" %>
<%@ Import Namespace="LearnHub.AppCode.entity" %>
<%@ Import Namespace="System.Web.Helpers" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Windows" %>
<%@ Import Namespace="System.Net" %>
<%@ Import Namespace="System.Net.Mail" %>
<%@ Import Namespace="System.Collections" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link href="https://fonts.googleapis.com/css?family=Martel:900" rel="stylesheet" />
    <style>
        body {
            background-color: #18bc9c !important;
        }

        h1 {
            color: white !important;
            font-family: 'Martel', serif !important;
        }

        .wrapper {
            margin-top: 100px;
            margin-bottom: 100px;
        }

        .btn {
            border-radius: 4px;
            border: none;
            text-align: center;
            font-size: 40px;
            padding: 20px;
            width: 230px;
            transition: all 0.5s;
            cursor: pointer;
            margin: 5px;
            box-shadow: 0 8px 16px 0 rgba(0,0,0,0.2), 0 6px 20px 0 rgba(0,0,0,0.19);
        }

            .btn span {
                cursor: pointer;
                display: inline-block;
                position: relative;
                transition: 0.5s;
            }

                .btn span:after {
                    content: '\00bb';
                    position: absolute;
                    opacity: 0;
                    top: 0;
                    right: -20px;
                    transition: 0.5s;
                }

            .btn:hover span {
                padding-right: 25px;
            }

                .btn:hover span:after {
                    opacity: 1;
                    right: 0;
                }

        .card {
            box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2);
            max-width: 500px;
            margin: auto;
            text-align: center;
            background-color: white;
        }

        .inner {
            padding: 20px 30px 10px 30px;
        }

        .header {
            background-color: #2c3e50;
            color: white;
            height: 50px;
            padding: 10px;
            font-size: 18px;
        }

        .logo {
            max-width: 500px;
            margin: auto;
            text-align: center;
        }
    </style>

    <title>Forgot Password - LearnHub</title>
    <link href="bootstrap/css/bootstrap.css" rel="stylesheet" />
</head>
<body>
    <div class="container">
        <div class="row">
            <div class="col-lg-4"></div>
            <div class="col-lg-4">
                <div class="wrapper">
                    <form id="form1" runat="server">
                        <h1 class="text-center login-title">LearnHub</h1>
                        <br />
                                    <div class="card">
                                        <fieldset>
                                            <div class="header">&emsp;<strong>F O R G O T &nbsp; P A S S W O R D </strong></div>
                                            <br />
                                            <div class="inner">
                                                <div class="form-group">
                                                    <p>Enter your email address below and click on the 'Reset' button. You will receive your new password shortly.</p>
                                                    <br />
                                                    <div class="input-group">
                                                        <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" placeholder="Email Address"></asp:TextBox>
                                                        <span class="input-group-addon"><span class="glyphicon glyphicon-globe"></span></span>
                                                    </div>
                                                    <br />
                                                    <br />
                                                    <div class="form-group text-center">
                                                        <asp:LinkButton ID="btnRequest" runat="server" CssClass="btn btn-primary" OnClick="btnRequest_Click"><span><strong>Request New Password</strong></span></asp:LinkButton><br />
                                                    </div>
                                                    <br />
                                                </div>
                                            </div>
                                        </fieldset>
                                    </div>
                        <br />
                        <div class="logo">
                            <img src="img/amkthk.png" alt="LHLogo" style="width: 165px; height: 117px;" />
                        </div>
                    </form>
                </div>
            </div>
            <div class="col-lg-4"></div>
        </div>
    </div>

</body>

<script src='https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js'></script>
<script type="text/javascript" src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>

</html>
