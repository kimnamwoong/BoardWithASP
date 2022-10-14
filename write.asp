<%
	Session.CodePage  = 949
	Response.CharSet  = "euc-kr"
	Response.AddHeader "Pragma","no-cache"
	Response.AddHeader "cache-control", "no-staff"
	Response.Expires  = -1
%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link rel="stylesheet" type="text/css" href="style.css">
    <title>Write Form</title>
  </head>
  <body>
  	<h1>�� �� �ۼ�</h1>
  		<form class="write-container container" method="POST" action="write_save.asp">
  			<div class="row">
  				<div class="col-25">
  					<label for="BoardTitle">����</label>
  				</div>
  				<div class="col-75">
  					<input type=text id="BoardTitle" name="BoardTitle">
  				</div>
  			</div>
  			<div class="row">
  				<div class="col-25">
  					<label for="UserName">�̸�</label>
  				</div>
  				<div class="col-75">
  					<input type=text id="UserName" name="UserName">
  				</div>
  			</div>
  			<div class="row">
  				<div class="col-25">
  					<label for="UserEmail">email</label>
  				</div>
  				<div class="col-75">
  					<input type=email id="UserEmail" name="UserEmail">
  				</div>	
  			</div>
  			<div class="row">
  				<div class="col-25">
  					<label for="UserID">ID</label>
  				</div>
  				<div class="col-75">
  					<input type=text id="UserID" name="UserID">	
  				</div>				
  			</div>
  			<div class="row">
  				<div class="col-25">
  					<label for="BoardContent">����</label>
  				</div>
  				<div class="col-75">
  					<textarea id="BoardContent" name="BoardContent"></textarea>
  				</div>				
  			</div>
  			<div class="row">
  				<div class="col-25">
  					<label for="UserPWD">��й�ȣ</label>
  				</div>
  				<div class="col-75">
  					<input type=password id="UserPWD" name="UserPWD">
  				</div>	
  			</div>
  			<div class="row btn-box">
  				<button>submit</button>
  				<a href="list.asp" class="link-btn">Back</a>
  			</div>
  		</form>

  </body>
</html>