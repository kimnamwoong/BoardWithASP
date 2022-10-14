<!-- #include file  = "dbopen.asp" -->
<%
Dim sql,boardId,Gotopage,name,content
boardId = request.form("b_id")
Gotopage = request.form("Gotopage")
name = request.form("name")
content =request.form("content")
response.write boardId & "<br>" & Gotopage & "<br>" & name & "<br>" & content 


SQL = "INSERT INTO Comment VALUES (" & boardId & ", '" & name & "', GETDATE(), '" & content & "')" 

'response.write SQL 
dbcon.execute SQL

dbcon.Close
Set dbcon = nothing
Response.Redirect "content.asp?GotoPage=" & GotoPage & "&b_id=" & boardId
%>