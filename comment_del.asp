<%
boardId = request("b_id")
commentId = request("co_id")
response.write "edit " & boardId & "<br>"
response.write commentId
%>