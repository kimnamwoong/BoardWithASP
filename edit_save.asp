<%
	Session.CodePage  = 949
	Response.CharSet  = "euc-kr"
	Response.AddHeader "Pragma","no-cache"
	Response.AddHeader "cache-control", "no-staff"
	Response.Expires  = -1
%>
<!-- #include file  = "dbopen.asp" -->
<%
	'DIM sql
	'sql = "UPDATE MyBoard SET BoardContent='edit content' WHERE BoardIdx = 1"
	'UPDATE MyBoard SET UserName = 'James',BoardDate=GETDATE(),UserEmail='james@email.com',BoardTitle='James title',BoardContent='edit content' WHERE BoardIdx = 1
      
	Set rs = Server.CreateObject("ADODB.RecordSet") 
	DIM sql,boardId
	DIM userName,title,content,userEmail
	userName = request.Form("userName")
	userEmail = request.Form("userEmail")
	title = request.Form("title")
	content = request.Form("content")
	boardId = request.querystring("b_id")
	
	sql = "UPDATE MyBoard SET"
	sql = sql & " UserName = '" & userName & "',"
	sql = sql & " UserEmail = '" & userEmail & "',"
	sql = sql & " BoardTitle = '" & title &"',"
	sql = sql & "BoardContent = '" & content & "'"
	sql = sql & " WHERE BoardIdx = " & boardId
	
	dbcon.execute sql
	
	dbcon.close
	Set dbcon = nothing
	
%>
<script language = "javascript">
	alert ("수정이 완료되었습니다.")
	location.href="list.asp";
</script>