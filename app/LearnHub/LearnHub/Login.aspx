<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="LearnHub.LoginDefault" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <style>
        .wrapper {
            margin-top: 80px;
            margin-bottom: 80px;
        }

        footer {
            background-color: #F8F8F8;
            border-top: 1px solid #E7E7E7;
            text-align: center;
            padding: 10px;
            position: absolute;
            left: 0;
            bottom: 0;
            height: 150px;
            width: 100%;
            display: inline-block
        }

    </style>
    <title>Login - LearnHub</title>
    <link href="/bootstrap/css/bootstrap.css" rel="stylesheet" />
</head>
<body>

    <div class="container">
        <div class="row">
            <div class="col-lg-4 col-lg-offset-4 ">
                <div class="wrapper">
                    <form id="form1" runat="server">
                        <fieldset>
                            <br />
                            <h2 class="text-center login-title">
                                <img src="img/LearnHub2.png" alt="LHLogo" style="width: 65px; height: 65px;" />&nbsp;&nbsp;LearnHub</h2>
                            <br />
                            <div class="form-group">
                                <div class="input-group">
                                    <asp:RequiredFieldValidator ID="rfv_username" runat="server" ErrorMessage="Please enter a username" ControlToValidate="txtUsername" CssClass="garbage" ></asp:RequiredFieldValidator>
                                    
                                    <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control" placeholder="Username"></asp:TextBox>

                                    <span class="input-group-addon"><span class="glyphicon glyphicon-user"></span></span>
                                </div>
                                <br />
                                <div class="input-group">
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Please enter a password" ControlToValidate="txtPassword" CssClass="garbage" ></asp:RequiredFieldValidator>
                                    <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" placeholder="Password" TextMode="Password"></asp:TextBox>
                                    <span class="input-group-addon"><span class="glyphicon glyphicon-lock"></span></span>
                                </div>
                                <br />
                                <div class="form-group text-center">
                                    <asp:Button ID="btnLogin" runat="server" Text="Submit" CssClass="btn btn-primary" OnClick="btnLogin_Click" />
                                    
                                    <p>
                                        <br/><a href="#">Forgot your password?</a>
                                    </p>
                                    <p>
                                        <br/>
                                    </p>
                                    <asp:RequiredFieldValidator ID="rfv_NoUseError" runat="server" ErrorMessage="Please Enter Your Username" ControlToValidate="txtUsername" CssClass="text-danger"></asp:RequiredFieldValidator>
                                    <br />
                                    <asp:RequiredFieldValidator ID="rfv_NoPassError" runat="server" ErrorMessage="Please Enter Your Password" ControlToValidate="txtPassword" CssClass="text-danger"></asp:RequiredFieldValidator>
                                    <asp:Label ID="lblErrorMsgUse" runat="server" CssClass="text-danger" Visible="false"></asp:Label><br />
                                    <asp:Label ID="lblErrorMsgPass" runat="server" CssClass="text-danger" Visible="false"></asp:Label>
                                </div>
                            </div>
                        </fieldset>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <footer>

        <img src="img/amkthk.png" alt="LHLogo" style="width: 165px; height: 117px;" />
        &nbsp;
         <img src="img/line.png" alt="line" style="width: 1px; height: 77.5px;" />
        &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp;
        <img src="img/smu.png" alt="smuLogo" style="width: 148px; height: 58.5px;" />
        &nbsp;
       <br />
        <a href="#">About Us</a> &nbsp;&nbsp;|&nbsp;&nbsp; 
            <a href="#">Terms and Condition</a> &nbsp;&nbsp;|&nbsp;&nbsp;  
            <a href="#">Sitemap</a>


    </footer>
    
</body>
<script src='https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js'></script>
<script src='/bootstrap/js/bootstrap.js'></script>
</html>
