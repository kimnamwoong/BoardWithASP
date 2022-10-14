<%
  Set dbcon = Server.CreateObject("ADODB.Connection")
  dbcon.ConnectionString = "provider=SQLOLEDB;driver={SQL Server};Data Source=172.28.54.29;uid=namwoong.kim_sqler;pwd=carrier2022!;database=nwtestdb"    
  dbcon.Open 
  dbcon.CommandTimeout=600
	
%>