<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="LearnHub.LoginDefault" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Login</title>
    <link href="/bootstrap/css/bootstrap.css" rel="stylesheet" />
</head>
<body>


  <div class="container">
    <div class="row">
      <div class="col-lg-4 col-lg-offset-4 ">
        <div class="well">
            <form id="form1" runat="server">
            <fieldset>
                <br />
              <h2 class="text-center login-title"> <span class="glyphicon glyphicon-send"></span>&nbsp;&nbsp;LearnHub</h2>
            <br/>
            <div class="form-group">
              <div class="input-group">
                  <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control" placeholder="Username"></asp:TextBox>
                  <span class="input-group-addon"><span class="glyphicon glyphicon-user"></span></span>
              </div>
              
              <br/>

              <div class="input-group">
                <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" placeholder="Password" TextMode="Password"></asp:TextBox>
                <span class="input-group-addon"><span class="glyphicon glyphicon-lock"></span></span>
              </div>
              <br />

              <div class="form-group text-center">
                <asp:Button ID="btnLogin" runat="server" Text="Submit" CssClass="btn btn-primary" OnClick="btnLogin_Click" />
                <p><br></p>
                  <asp:Panel ID="panelAlert" CssClass="alert alert-dismissible alert-danger" runat="server" Visible="False">
                      <asp:Label ID="lblErrorMsg" runat="server"></asp:Label>
                  </asp:Panel>
                  <p>
                      </br><a href="#">Forgot your password?</a></p>
              </div>
            
          
            </div>
                </fieldset>
            </form>
      </div>
    </div>


    
  </div>



</body>
<script src='https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js'></script>
<script src='/bootstrap/js/bootstrap.js'></script>
</html>
