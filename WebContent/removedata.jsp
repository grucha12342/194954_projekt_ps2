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
<p>Wait for confirmation...</p>
<p><%=request.getParameter("table")%></p>
<div>
<center>
<p>Wait for query execution...</p>
<%
	String sqlquery = "DELETE FROM "+request.getParameter("table")+" WHERE id='"+request.getParameter("id")+"';";
		
	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
	String url = "jdbc:sqlserver://194954ps3db.database.windows.net:1433;database=194954_projekt_ps2;user=ps3db@194954ps3db;password=tatib@w5ese;encrypt=true;trustServerCertificate=false;hostNameInCertificate=*.database.windows.net;loginTimeout=30;";
	Connection connection = null;
	try {
		connection = DriverManager.getConnection(url);
		String schema = connection.getSchema();
		try (Statement statement = connection.createStatement();) {
			//statement.executeUpdate(sqlquery);
			connection.close();
			%><p>Success</p><%
			String redirectURL = "tableview.jsp?dropdown="+request.getParameter("table")+"&update=yes";
		    response.sendRedirect(redirectURL);
		}
	}
	catch (Exception e) {
		e.printStackTrace();
		%><p><%= e.getMessage() %></p><%
	}
%>
</center>
</div>
</div>
</body>
</html>