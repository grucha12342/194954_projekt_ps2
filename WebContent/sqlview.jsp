<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%ResultSet resultset =null;%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Programowanie sieciowe 2</title>
</head>
<body>
<p>Druga strona</p>
<p><%= request.getParameter("sqlquery")%></p>
<%
	String sqlquery = request.getParameter("sqlquery");
	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
	String url = "jdbc:sqlserver://194954ps3db.database.windows.net:1433;database=194954_projekt_ps2;user=ps3db@194954ps3db;password=tatib@w5ese;encrypt=true;trustServerCertificate=false;hostNameInCertificate=*.database.windows.net;loginTimeout=30;";
	Connection connection = null;
	try {
		connection = DriverManager.getConnection(url);
		String schema = connection.getSchema();
		if(sqlquery.contains("select")) {
			try (Statement statement = connection.createStatement();
					ResultSet resultSet = statement.executeQuery(sqlquery)) {
				
				while (resultSet.next())
				{
					%><p><%= resultSet.getString(1) %></p><%
                }
				connection.close();
			}  
		} else {
			try (Statement statement = connection.createStatement();) {
				statement.executeUpdate(sqlquery);
				%><p>Query executed</p><%
				connection.close();
			} 
		}
	}
	catch (Exception e) {
		e.printStackTrace();
		%><p><%= e.getMessage() %></p><%
	}
%>
<a href="index.jsp">Back to home page</a>
</body>
</html>