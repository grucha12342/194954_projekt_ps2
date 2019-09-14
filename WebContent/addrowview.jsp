<%@page import="ps2.JSONHandler"%>
<%@page import="ps2.DatabaseHandler"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%ArrayList<String> resultHeaders = null;%>
<%String json = new String();%>
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
	<title>Programowanie sieciowe 2</title>
</head>
<body>
	<div style="float: right; padding: 5px; margin-right: 5px;">
		<h5><%=json=JSONHandler.getUserData(request) %>
		<a href="/.auth/logout">Logout</a></h5>
	</div>   
	<div class="container-fluid">
		<h1>You are adding row to <%= request.getParameter("tablename")%> table</h1>
		<div>
			<form action="/insertdata.jsp" method="POST">
				<% resultHeaders = DatabaseHandler.fetchTableHeaders(request.getParameter("tablename"));
				int i = 1;
		  		for (String temp : resultHeaders) {
		  		if (i % 6 != 1 ) {%>
		  		<%=temp %> :<br>
		  		<%if (temp.equals("Age") || temp.equals("Released") || temp.equals("TrackNo") || temp.equals("ArtistID")) {%>
		  			<input type="number" name=<%=temp %>><br>
		  		<%} else {%>
					<input type="text" name=<%=temp %>><br>
		    	<%	  } 
		    	}
		    	i++; 
		    	} %>
		    	<input type="hidden" name="dropdown" value=<%=request.getParameter("tablename") %>> <br>
	  			<input type="submit" class="btn-primary" value="Submit">
				<input type="reset" class="btn-primary" value="Reset">
			</form> 
		</div>
		<br>
		<a href="index.jsp">Back to home page</a>
	</div>
</body>
</html>