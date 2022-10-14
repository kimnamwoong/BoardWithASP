<%
	Session.CodePage  = 949
	Response.CharSet  = "euc-kr"
	Response.AddHeader "Pragma","no-cache"
	Response.AddHeader "cache-control", "no-staff"
	Response.Expires  = -1
	
	DIM boardId
	boardId = request.querystring("b_id")
	response.write "delete page"
	response.write boardId
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link rel="stylesheet" type="text/css" href="style.css">
		<title>삭제 페이지</title>
	</head>
	<body>
		<form method="POST" action="delete_save.asp?b_id=<%= boardId%>" name="myForm">
			<label>비밀번호</label>
			<input type=password name="userPWD">
			<p>
				<button id="delBtn">delete</button>
				<a href="content.asp?b_id=<%= boardId%>" class="link-btn">back</a>
			</p>
		</form>
		<script language="javascript">
			const btn = document.getElementById('delBtn');
			function sendit(e){
				
				if(document.myForm.userPWD.value==""){
					e.preventDefault();
					alert("empty pwd")
					return;
				}
			}
			btn.addEventListener('click',sendit)
		</script>
	</body>
</html>
	