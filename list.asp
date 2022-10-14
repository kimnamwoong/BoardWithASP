<%
	Session.CodePage  = 949
	Response.CharSet  = "euc-kr"
	Response.AddHeader "Pragma","no-cache"
	Response.AddHeader "cache-control", "no-staff"
	Response.Expires  = -1
%>
<!-- #include file  = "dbopen.asp" -->
<!-- #include file  = "function_REP.asp" -->
<%
	DIM rs
	DIM sql
	DIM Gotopage,pgcount,recordCount,pagesize
	Dim startpage,setsize
	pagesize = 10			'한 페이지에 보여줄 게시판의 글의 개수
	setsize = 10

	if request("Gotopage") = "" then
		Gotopage = 1
		startpage = 1
	else
		Gotopage = cint(request("Gotopage"))
		startpage = int(Gotopage/setsize)

		if startpage = (Gotopage/setsize) then
			startpage = Gotopage - setsize + 1
		else
			startpage = int(Gotopage/setsize) * setsize + 1

		end if
	end if
	
	Set rs = Server.CreateObject("ADODB.RecordSet") 
	sql = "SELECT COUNT(BoardIdx) FROM MyBoard"
	Set rs = dbcon.execute(sql)
	recordCount = rs(0)	' 전체 데이터 갯수 가져오기 (모든 게시글 가져오기)
	
	pgcount = int(recordCount/pagesize)
	if pgcount*pagesize <> recordCount then
		pgcount = pgcount + 1
	end if 
	' paging 구성을 위한 query문 
	sql = "SELECT * FROM MyBoard "
	sql = sql & "WITH(NOLOCK) ORDER BY BoardIdx ASC OFFSET "
	sql = sql & (Gotopage-1)*pagesize & " ROWS FETCH NEXT "
	sql = sql & pagesize & " ROWS ONLY"
	
	Set rs = dbcon.execute(sql)

%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
    <title>List</title>
    <script language="javascript">
			function checkForm(e){
				if(searchFrm.searchName.value==""){
					e.preventDefault();
					searchFrm.searchName.focus()
					alert("empty search keyword");
					return false;
				}	
			}
	</script>
  </head>
  <body>
		<nav class="navbar navbar-expand-lg navbar-light">
		  <div class="collapse navbar-collapse" id="navbarSupportedContent">
		    <ul class="navbar-nav mr-auto">
		      <li class="nav-item active">
		        <a class="nav-link" href="list.asp">Home</a>
		      </li>
		      <li class="nav-item">
		        <a class="nav-link" href="write.asp">Write</a>
		      </li>
		    </ul>
		  </div>
		</nav>
		<form name="searchFrm" method="POST" action="board_search.asp" onSubmit="javascript:checkForm()">
			<div class="row">
		    <div class="col-auto">
		    	<label>Choose your option</label>
		      <select name="search">
						<option value="UserName">이름</option>
						<option value="BoardTitle">제목</option>
						<option value="BoardContent">내용</option>
					</select>
		    </div>
		    <div class="col-auto">
					<input type=text name="searchName" class="custom-control-input">	
		    </div>
		    <div class="col-auto">
					<button class="btn btn-primary">search</button>
		    </div>
	  	</div>
  	</form>
  	<section class="main">
			<table class="table table-sm">
			  <tr>
			    <td>
			      총 게시글 : <%= recordCount %>
			      &nbsp;
			    </td>
			    <td>
			      page ( <%= Gotopage %> / <%= pgcount %> )
			    </td>
			  </tr>
			</table>
			<table class="table board-table">
				<thead>
					<tr>
						<th scope="col">#</th>
				    <th scope="col">제목</th>
				    <th scope="col">작성자</th>
				    <th scope="col">등록일</th>
	  			</tr>
				</thead>
				
	  	<% if rs.eof or rs.bof then %>
	  		<tr>게시글이 없습니다.</tr>
	  	<% else 
	  			Do Until rs.eof
	  				boardId = rs("BoardIdx")
	  				title = rs("BoardTitle")
	  				userName = rs("UserName")
	  				boardDate = LEFT(rs("BoardDate"),10)
	  				
	  				title = ReplaceTag2Text(title)
	  				userName = ReplaceTag2Text(userName)
	  	%>
	  		<tbody>
		  		<tr>
		  			<th scope="row"><%= boardId %></th>
		  			<td>
		  				<a href="List2Content.asp?b_id=<%=boardId%>&Gotopage=<%=Gotopage%> ">
		  				<%= title %>
		  				</a>
		  			</td>
		  			<td><%= userName %></td>
		  			<td><%= boardDate %></td>
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
		</section>
		<nav class="paging">
			<ul class="pagination justify-content-center">
				<% if startpage=1 then %>
					<li class="page-item disabled">
						<a class="page-link" href="#">Previous</a>
		    	</li>
				<% elseif startpage > setsize then %>
					<li class="page-item">
						<a class="page-link" href="list.asp?Gotopage=<%=startpage-setsize %>">Previous</a>	
					</li>
				<% end if %>
				
				<% ' paging ............................... 
				for i=startpage To setsize+startpage -1
					if i > pgcount then
						exit for
					end if
					if cint(Gotopage)=i then
				%>
					<li class="page-item active">
						<a class="page-link" href="list.asp?Gotopage=<%=i%>"><%= i %></a>
					</li>
				<%	else %>
					<li class="page-item">
						<a class="page-link" href="list.asp?Gotopage=<%=i%>"><%=i%></a>
					</li>
				<%	end if 
				next 
				%>		
				<% if pgcount < setsize or i > pgcount then %>
					<li class="page-item disabled">
						<a class="page-link" href="#">Next</a>
					</li>
				<% else %>
					<li class="page-item">
						<a class="page-link" href="list.asp?Gotopage=<%=startpage+setsize%>">next</a>	
					</li>
				<% end if %>
			</ul>
				
		</nav>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
  </body>
</html>
