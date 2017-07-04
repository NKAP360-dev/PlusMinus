<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="LearnHub.LoginDefault" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <style>
        .wrapper {
            margin-top: 80px;
            margin-bottom: 80px;
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
                                    <asp:Button ID="btnLogin" runat="server" Text="Submit" CssClass="btn btn-primary" OnClick="btnLogin_Click" />
                                    
                                    <p>
                                        <br/><a href="#">Forgot your password?</a>
                                    </p>
                                    <p>
                                        <br/>
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
                        </fieldset>
                    </form>
                </div>
            </div>
        </div>
    </div>

    
</body>

<script src='https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js'></script>
<script type="text/javascript" src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>

</html>
