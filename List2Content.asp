<!-- #include file  = "dbopen.asp" -->
<%
	Dim boardId,Gotopage
	boardId = request("b_id")
	Gotopage = request("Gotopage")
	
	Set rs = Server.CreateObject("ADODB.RecordSet") 
	
	sql = "UPDATE MyBoard SET Visited = Visited + 1 WHERE BoardIdx= " & Cint(boardId)
	response.write sql

	Set rs = dbcon.execute(sql)
	
	dbcon.Close
	Set dbcon = nothing 
	response.redirect "content.asp?b_id=" & boardId & "&Gotopage=" & Gotopage
%>