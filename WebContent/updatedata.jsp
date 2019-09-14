<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%ResultSet resultset =null;%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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
	<center>
		<p>Wait for end of execute query..</p>
		<%
			String sqlquery;
			if(request.getParameter("dropdown").equals("Albums")) {
				sqlquery = "UPDATE Albums SET AlbumName = '"+request.getParameter("AlbumName")+"', Label = '"+request.getParameter("Label")+"', Released = '"+request.getParameter("Released")+"', TrackNo = "+request.getParameter("TrackNo")+", ArtistID = "+request.getParameter("ArtistID")+" WHERE ID = "+request.getParameter("id");
				System.out.println(sqlquery);
			} else {
				sqlquery = "UPDATE MusicArtists SET LastName = '"+request.getParameter("LastName")+"', FirstName = '"+request.getParameter("FirstName")+"', KnownAs = '"+request.getParameter("KnownAs")+"', Genres = '"+request.getParameter("Genres")+"', Age = "+request.getParameter("Age")+" WHERE ID = "+request.getParameter("id");
				System.out.println(sqlquery);
			}
				
			Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
			String url = "jdbc:sqlserver://194954ps3db.database.windows.net:1433;database=194954_projekt_ps2;user=ps3db@194954ps3db;password=tatib@w5ese;encrypt=true;trustServerCertificate=false;hostNameInCertificate=*.database.windows.net;loginTimeout=30;";
			Connection connection = null;
			try {
				connection = DriverManager.getConnection(url);
				String schema = connection.getSchema();
				try (Statement statement = connection.createStatement();) {
					statement.executeUpdate(sqlquery);
					connection.close();
					%><p>Success</p><%
					String redirectURL = "tableview.jsp?dropdown="+request.getParameter("dropdown")+"&update=yes";
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
</body>
</html>