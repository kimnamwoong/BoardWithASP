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
	alert("��й�ȣ�� ��ġ���� �ʽ��ϴ�");
	location.href="list.asp"
</script>

<%
	else
		response.write "��ġ"
		sql = "DELETE FROM MyBoard WHERE BoardIdx = " & boardId
		dbcon.execute sql
%>
<script language="javascript">
	alert("�����Ǿ����ϴ�");
	location.href="list.asp";
</script>
<%
end if
	dbcon.close
	Set dbcon = nothing
%>