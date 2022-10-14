<%
	Session.CodePage  = 949
	Response.CharSet  = "euc-kr"
	Response.AddHeader "Pragma","no-cache"
	Response.AddHeader "cache-control", "no-staff"
	Response.Expires  = -1
%>
<!-- #include file  = "dbopen.asp" -->

<%
	Set rs = Server.CreateObject("ADODB.RecordSet") 
	DIM sql,boardId
	DIM userName,title,content,boardDate,userEmail
	
	boardId = request.querystring("b_id")
	sql = "SELECT UserName,BoardTitle,BoardDate,BoardContent,UserEmail FROM MyBoard WHERE BoardIdx = "&boardId
	
	Set rs = dbcon.execute(sql)
	if rs.eof or rs.bof then
%>
<script language = "javascript">
	alert ("No data")
</script>

<%
	else
		userName = rs("UserName")
		title = rs("BoardTitle")
		content = rs("BoardContent")
		boardDate = rs("BoardDate")
		userEmail = rs("UserEmail")
	end if
	dbcon.close
	Set dbcon = nothing
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link rel="stylesheet" type="text/css" href="style.css">
		<title>수정 페이지</title>
	</head>

	<body>
		<h1>Edit Form</h1>
		<form method="POST" action = "edit_save.asp?b_id=<%= boardId %>" class="edit-container editForm-container" name="myForm">
			<div>
				<div>
					<label for="userName">이름</label>
				</div>
				<div>
					<input type=text id="userName" name="userName" value="<%=userName %>">	
				</div>
			</div>	
			<div>
				<div>
					<label for="userEmail">Email</label>
				</div>
				<div>
					<input type=email id="userEmail" name="userEmail" value="<%=userEmail %>">
				</div>
			</div>
			<div>
				<div>
					<label for="title">제목</label>
				</div>
				<div>
					<input type=text id="title" name="title" value="<%=title %>">
				</div>
			</div>
			<div>
				<div>
					<label for="content">내용</label>
				</div>
				<div>
					<textarea id="content" name="content" cols="50" rows="10"><%=content %></textarea>
				</div>
			</div>
			<div class="link-box">
				<button id='editBtn'>submit</button>
	      <a href="list.asp" class="link-btn">cancel</a>
			</div>
		</form>	
		
		<script language="javascript">
		const btn = document.getElementById('editBtn');
		console.log(btn)
		function sendit(e){
			if(document.myForm.userName.value=="" || document.myForm.title.value=="" || document.myForm.content.value==""){
				e.preventDefault()	// form 제출 막기
				alert("Please check your form")
				return;
			}
			 document.myform.submit();
		}
		
		btn.addEventListener('click',sendit);
	</script>
	</body>
</html>