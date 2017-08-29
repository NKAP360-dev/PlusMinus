﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="LearnHub.LoginDefault" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <style>
        body {
            background-color: #18bc9c !important;
        }

        h1 {
            color: white !important;
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
            width: 100px;
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
            padding: 40px 30px 10px 30px;
        }

        .header {
            background-color: #2c3e50;
            color: white;
            height: 50px;
            padding: 10px;
            font-size: 18px;
        }
    </style>
    <title>Login - LearnHub</title>
    <link href="bootstrap/css/bootstrap.css" rel="stylesheet" />
</head>
<body>
    

     <div class="container">
        <div class="row">
            <div class="col-lg-4"></div>
            <div class="col-lg-4">
                <div class="wrapper">
                    <form id="form1" runat="server">

                        <h1 class="text-center login-title"><a href="Home.aspx">
                            <img src="img/LearnHub2.png" alt="LHLogo" style="width: 65px; height: 65px;" /></a>&nbsp;LearnHub&nbsp;&nbsp;&nbsp;</h1>
                        <br />
                        <div class="card">

                            <fieldset>
                                <div class="header"><strong>L O G I N</strong></div>
                                <br />
                                <div class="inner">
                                    <div class="form-group">
                                        <%if (lblErrorMsgUse.Text == "")
                                            {%>
                                        <div class="input-group">
                                            <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control" placeholder="Username"></asp:TextBox>
                                            <span class="input-group-addon"><span class="glyphicon glyphicon-user"></span></span>
                                        </div>
                                        <br />
                                        <%}
                                            else
                                            {%>
                                        <div class="form-group has-error">
                                            <div class="input-group">
                                                <asp:TextBox ID="txtUsernameVal" runat="server" CssClass="form-control" placeholder="Username"></asp:TextBox>
                                                <span class="input-group-addon"><span class="glyphicon glyphicon-user"></span></span>
                                            </div>

                                        </div>
                                        <%}%>
                                        <%if (lblErrorMsgUse.Text == "")
                                            {%>
                                        <div class="input-group">
                                            <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" placeholder="Password" TextMode="Password"></asp:TextBox>
                                            <span class="input-group-addon"><span class="glyphicon glyphicon-lock"></span></span>
                                        </div>
                                        <br />
                                        <%}
                                            else
                                            {%>

                                        <div class="form-group has-error">
                                            <div class="input-group">
                                                <asp:TextBox ID="txtPasswordVal" runat="server" CssClass="form-control" placeholder="Password" TextMode="Password"></asp:TextBox>
                                                <span class="input-group-addon"><span class="glyphicon glyphicon-lock"></span></span>
                                            </div>

                                        </div>
                                        <%}%>
                                        <br />
                                        <div class="form-group text-center">
                                            <asp:LinkButton ID="btnLogin" runat="server" CssClass="btn btn-primary" OnClick="btnLogin_Click"><span><strong>Login</strong></span></asp:LinkButton>


                                            <p>
                                                <br />
                                                <a href="#">Forgot your password?</a>
                                            </p>
                                            <p>
                                                <br />
                                            </p>
                                            <%--
                                    <asp:RequiredFieldValidator ID="rfv_NoUseError" runat="server" ErrorMessage="Invalid username/password." ControlToValidate="txtUsername" CssClass="text-danger"></asp:RequiredFieldValidator>
                                    <br />
                                    <asp:RequiredFieldValidator ID="rfv_NoPassError" runat="server" ErrorMessage="Please Enter Your Password" ControlToValidate="txtPassword" CssClass="text-danger"></asp:RequiredFieldValidator>
                                    <br />
                                            --%>
                                            <asp:Label ID="lblErrorMsgUse" runat="server" CssClass="text-danger" Visible="false"></asp:Label>
                                        </div>
                                    </div>
                                </div>
                            </fieldset>
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
