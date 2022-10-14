<!-- #include file  = "dbopen.asp" -->
<!-- #include file  = "function_REP.asp" -->
<%

	DIM userName,title,email,id,content,pwd
	id = Request.Form("UserID")
	userName = Request.Form("UserName")
	pwd = Request.Form("UserPWD")
	email = Request.Form("UserEmail")
	title = Request.Form("BoardTitle")
	content = Request.Form("BoardContent")
  
	title = ReplaceTag2Text(title)
  
  
  DIM sql
  sql = "INSERT INTO MyBoard VALUES ("
  sql = sql & "'" & id & "',"
  sql = sql & "'" & pwd & "',"
  sql = sql & "'" & userName & "',"
  sql = sql & "'" & email & "',"
  sql = sql & "'" & title & "',"
  sql = sql & "GETDATE(),"
  sql = sql & "'" & content & "'"
  
	sql = "INSERT INTO MyBoard VALUES ("&_
							"'"&id&"', "&_
							" '"&pwd&"', "&_
							" '"&userName&"', "&_
							" '"&email&"', "&_
							" '"&title&"', "&_
							" GETDATE(), "&_
							" '"&content&"'"&_
							",0)"  
  dbcon.Execute sql
  dbcon.close
  Set dbcon = nothing
  
%>
<script language="javascript">
	alert("등록되었습니다")
	location.href = "list.asp";
</script> 