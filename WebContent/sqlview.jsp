<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%ResultSet resultset =null;%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
 <!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<!-- jQuery library -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<!-- Latest compiled JavaScript -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script> 
<script src="sorttable.js"></script>
<title>Programowanie sieciowe 2</title>
</head>
<body>
<div class="container-fluid">
<div>
<center>
	<h1>Your query: <%= request.getParameter("txtarea")%></h1>
<%
	String sqlquery = request.getParameter("txtarea");
	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
	String url = "jdbc:sqlserver://194954ps3db.database.windows.net:1433;database=194954_projekt_ps2;user=ps3db@194954ps3db;password=tatib@w5ese;encrypt=true;trustServerCertificate=false;hostNameInCertificate=*.database.windows.net;loginTimeout=30;";
	Connection connection = null;
	try {
		connection = DriverManager.getConnection(url);
		String schema = connection.getSchema();
		if(sqlquery.contains("select")) {
			try (Statement statement = connection.createStatement();
					ResultSet resultSet = statement.executeQuery(sqlquery)) {
				ResultSetMetaData rsmd = resultSet.getMetaData();
				%><h2>Row size: <%= rsmd.getColumnCount() %></h2>
				<table style="width:80%%;" border="1" class="sortable table-striped">
				<tr>
				<%for(int i = 1; i <= rsmd.getColumnCount(); i++) {%>
				<th style="padding: 5px;"><%=rsmd.getColumnName(i)%> </th>
				<% } %>
				</tr><%
				while (resultSet.next())
				{
					%><tr><%for(int j = 1; j <= rsmd.getColumnCount(); j++) {%>
					<td style="padding: 5px;"><%=resultSet.getString(j)%> </td>
					<% } %>
					</tr><%
                }
				connection.close();
				%></table><%
			}  
		} else {
			try (Statement statement = connection.createStatement();) {
				statement.executeUpdate(sqlquery);
				%><h2>Query executed</h2><%
				connection.close();
			} 
		}
	}
	catch (Exception e) {
		e.printStackTrace();
		%><h2><%= e.getMessage() %></h2><%
	}
%>
	<br>
	<form action="/index.jsp" method=POST id="sqlquery" name="sqlquery">
		<input type="hidden" value="<%=request.getParameter("txtarea") %>" name="txtarea" />
		<input type="submit" class="btn-primary" value="Back to home page">
	</form>
</center>
</div>
</div>
</body>
</html>