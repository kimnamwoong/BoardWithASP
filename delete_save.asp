<!-- #include file  = "dbopen.asp" -->
<%
	DIM sql,userPWD,boardId,savedPWD
	Set rs = Server.CreateObject("ADODB.RecordSet") 
	boardId = request.querystring("b_id")
	userPWD = request.form("userPWD")
	
	sql = "SELECT UserPWD FROM MyBoard WHERE BoardIdx = " & boardId

	Set rs = dbcon.execute(sql)
	savedPWD = rs("UserPWD")

	if savedPWD <> userPWD Then
%>
<script language="javascript">
	alert("비밀번호가 일치하지 않습니다");
	location.href="list.asp"
</script>

<%
	else
		response.write "일치"
		sql = "DELETE FROM MyBoard WHERE BoardIdx = " & boardId
		dbcon.execute sql
%>
<script language="javascript">
	alert("삭제되었습니다");
	location.href="list.asp";
</script>
<%
end if
	dbcon.close
	Set dbcon = nothing
%>