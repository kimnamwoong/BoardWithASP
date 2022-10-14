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
	DIM sql,boardId,Gotopage
	DIM userName,title,content,boardDate,userEmail,readNum
	Gotopage = request("Gotopage")
	boardId = request.querystring("b_id")
'	sql = "UPDATE MyBoard  SET Visited = Visited + 1 WHERE BoardIdx=" & boardId
'	Set rs = dbcon.execute(sql)
	
	sql = "SELECT UserName,BoardTitle,BoardDate,BoardContent,UserEmail,Visited FROM MyBoard WHERE BoardIdx = "&boardId
	
	Set rs = dbcon.execute(sql)
	if rs.eof or rs.bof then
%>
<script language="javascript">
	alert("�Խñ��� �����ϴ�.")
</script>
<%
	else
		userName = rs("UserName")
		title = rs("BoardTitle")
		content = rs("BoardContent")
		boardDate = rs("BoardDate")
		userEmail = rs("UserEmail")
		readNum = rs("Visited")
	end if
	
   '���� ���� board_idx ���� ���ϴ� �κ�
  SQL = "Select Min(BoardIdx) from MyBoard where BoardIdx > " & boardId
  Set rs = dbcon.Execute(SQL)
  if Not Rs.EOF then
      prev_idx = Rs(0)
  end if

  '���� ���� board_idx ���� ���ϴ� �κ�
  SQL = "Select Max(BoardIdx) from MyBoard where BoardIdx < " & boardId
  Set rs = dbcon.Execute(SQL)
  if Not Rs.EOF then
      next_idx = Rs(0)
  end if
	
	SQL = "SELECT Co_name,Co_date,Co_Content,Co_seq FROM Comment WHERE BoardIdx="&boardId
	Set rs = dbcon.Execute(SQL)
	Dim arrComment 
	if not rs.eof then 
		arrComment = rs.Getstring()
	end if
	dbcon.close
	Set dbcon = nothing
	
%> 
<!DOCTYPE html>
<html lang="en">
	<head>
		<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link rel="stylesheet" type="text/css" href="style.css">
	<title>�� ������</title>
	</head>
	<body>
		<form action="POST" name="myForm">
			<input type="hidden" name="boardId" value=<%= boardId %>
			<% response.write boardId %>
			<span>[��ȸ��: <%= readNum %>]</span>
			<% if prev_idx <> "" then %>
			<span><a href="List2Content.asp?b_id=<%= prev_idx%>&Gotopage=<%= Gotopage%>">������</a> |</span>
		<% end if %>
		<% if next_idx <> "" then %>
			<span><a href="List2Content.asp?b_id=<%= next_idx%>&Gotopage=<%= Gotopage%>">������</a></span>
			<% end if %>
			<table class="content-table">
			   <thead>
				   <tr>
				       <td>�̸�</td>
				       <td><%=userName %></td>
				   </tr>
			   </thead>
			   <tbody>
				   <tr>
				   		<td>�����</td>
				      <td><%=LEFT(boardDate,10)%></td>
				   </tr>
				   <tr>
				       <td>Email</td>
				       <td><%=userEmail %></td>    
				   </tr>
				   <tr>
				       <td>����</td>
				        <td><%=title %></td>
				   </tr>
				   <tr>
				   		<td>����</td>
				       <td><%=content %></td>
				   </tr>
				 </tbody>
			</table>
			<div class="link-box">
				<label for="pwd">PWD</label>
				<input type="password" name="UserPWD" id="pwd"><br><br>
				<a href="edit.asp?b_id=<%=boardId %>" class="link-btn">�����ϱ�</a>
				<a href="delete.asp?b_id=<%=boardId %>" class="link-btn">�����ϱ�</a>
				<a href="list.asp?Gotopage=<%= Gotopage %>" class="link-btn">�������</a>
			</div>
			<br>
			
			<hr>
	</form>
	<h3>Leave your comment!!</h3>
	<form name="frmMent" action="Insert_Comment.asp" method="post">
		<input class= "inputa" type="hidden" name= "Gotopage"value="<%=Gotopage%>">
    <input class= "inputa" type="hidden" name= "b_id"value="<%=boardId%>">
    <label for="name">Name</label><br>
    <input class="inputa" name="name" size="20" maxlength="10" id="name"><br>
		<label for="comment">Please enter your comment</label><br>
	  <input class="inputa" name="content" size="50" maxlength="200" id="comment"><br>
	  
	  <button id="co-btn">submit</button>
	</form>
	<hr>
	<%
  if arrComment <> "" then
    Dim arrRecord, arrColumn, inum
    arrRecord = Split(arrComment,chr(13))
	%>
  <br><font size=2><b>Comment</b></font>
  <%
  for inum=0 to Ubound(arrRecord)-1
    arrColumn = Split(arrRecord(inum), Chr(9))
    Dim co_name,co_date,co_content,commentId
    co_name = arrColumn(0)
    co_date = LEFT(arrColumn(1),10)
    co_content = arrColumn(2)
    commentId = arrColumn(3)
	%>
  <div class="comment-box">
  	<span><%= co_name %></span>
  	<span><%= co_date %></span>
  	<p id="content<%= commentId %>">
  		<%= co_content %>
  	</p>
  	<a href="javascript:editComment(<%= commentId %>);" id="edit-link">edit</a>
  	<a href="#">delete</a>
  </div>
  <br>
<% next %>  
<% end if %>
	<script language="javascript">
		const btn = document.getElementById('co-btn');
		function addComment(e){
			if(frmMent.name.value == ""){
				e.preventDefault();
				alert("Please enter your name")
				return;
			}
			if(frmMent.content.value == ""){
				e.preventDefault();
				alert("Please enter your comment")
				return;
			}
		}
		function editComment(commentId){
			var contentEle = document.querySelector(`#content${commentId}`)
			var newElement = document.createElement("input")
			newElement.type = "text";
			newElement.id = commentId
			contentEle.parentNode.replaceChild(newElement, contentEle);
			
		}

		
	</script>
	</body>
</html>