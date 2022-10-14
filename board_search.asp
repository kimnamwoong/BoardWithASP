<%
	Session.CodePage  = 949
	Response.CharSet  = "euc-kr"
	Response.AddHeader "Pragma","no-cache"
	Response.AddHeader "cache-control", "no-staff"
	Response.Expires  = -1
%>
<!-- #include file  = "dbopen.asp" -->

<%
	DIM sql
	DIM searchTarget,searchString
	DIM recCount,GotoPage,pagesize,pagecount
	pagesize=10

	'Gotopage = request.querystring("Gotopage")
	'response.write Gotopage & "<br>"
	'if Gotopage = "" Then 
	'	Gotopage = 1
	'end if
	searchTarget = request("search")
	searchString = request("searchName")
	
	Set rs = Server.CreateObject("ADODB.RecordSet") 
	sql = "SELECT COUNT(*) FROM MyBoard WHERE " & searchTarget
	sql = sql & " LIKE " & " '%" & searchString & "%'"
	Set rs = dbcon.execute(sql)
	recCount = rs(0)
	pagecount = int((recCount-1)/pagesize) + 1 
	'sql = "SELECT * FROM MyBoard WHERE " & searchTarget
	'sql = sql & " LIKE " & " '%" & searchString & "%'"
	
	' PAGING 구성 중 QUERY문 
	'sql = "SELECT * FROM (SELECT ROW_NUMBER() OVER (ORDER BY BoardDate DESC)"
	'sql = sql & " AS ROWNUM,UserName,BoardTitle,BoardDate FROM MyBoard WHERE "
	'sql = sql & searchTarget & " LIKE " & "'%" & searchString & "%') T"
	'sql = sql & " WHERE T.ROWNUM"
	'sql = sql & " WHERE T.ROWNUM BETWEEN " & (Gotopage-1)*pagesize & " AND " & Gotopage*pagesize
	
	sql = "SELECT ROW_NUMBER() OVER(ORDER BY BoardDate DESC) AS ROWNUM,* FROM MyBoard WHERE " & searchTarget & " LIKE "
	sql = sql & "'%" & searchString & "%'"
	Set rs = dbcon.execute(sql)
	if rs.eof or rs.bof then
%>
<script language="javascript">
	alert("없습니다")
	history.back();
</script>
<% 
response.end
	else 
%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Search</title>
  </head>
  <body>
		<h1>검색 결과</h1>
		<table class="page-table" cellpadding="0" cellspacing="0" border="0" width="600">
		  <tr>
		    <td bgcolor="white" height="30" width="400" style="padding-top:5px;">
		      총 게시글 수 : <%= recCount %>
		    </td>
		  </tr>
		</table>
		<table>
			<thead>
				<tr>
					 <td>No</td>
			     <td>제목</td>
			     <td>작성자</td>
			     <td>내용</td>
			     <td>등록일</td>
  			</tr>
			</thead>
		<% Do Until rs.eof %>
  		<tbody>
	  		<tr>
	  			<td><%=rs("ROWNUM")%></td>
	  			<td><%=rs("UserName") %></td>
	  			<td>
	  				<a href="content.asp?b_id=<%=rs("BoardIdx") %>">
	  				<%=rs("BoardTitle") %>
	  				</a>
	  			</td>
	  			<td><%= rs("BoardContent") %></td>
	  			<td><%=LEFT(rs("BoardDate"),10) %></td>
	  		</tr>  			
  		</tbody>
  	<%
	  		rs.MoveNext
	  	LOOP
	  	end if
			dbcon.Close
			Set dbcon=nothing
  	%>
		</table>
		<a href="list.asp">Back</a>
  </body>
</html>