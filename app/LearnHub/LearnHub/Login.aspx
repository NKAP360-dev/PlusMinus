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
          <form class="form-horizontal">
            <fieldset>
                <br />
              <h2 class="text-center login-title"> <span class="glyphicon glyphicon-send"></span>&nbsp;&nbsp;LearnHub</h2>
            <br/>
            <div class="form-group">
              <div class="input-group">
                <input type="text" class="form-control" id="txtUsername" placeholder="Username"/>
                <span class="input-group-addon"><span class="glyphicon glyphicon-user"></span></span>
              </div>
              
              <br/>

              <div class="input-group">
                <input type="password" class="form-control" id="txtPassword" placeholder="Password"/>
                <span class="input-group-addon"><span class="glyphicon glyphicon-lock"></span></span>
              </div>
              <br />

              <div class="form-group text-center">
                <button type="submit" class="btn btn-primary">Submit</button>
                <p><br></br><a href="#">Forgot your password?</a></p>
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
