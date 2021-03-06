<%@page import="ps2.DatabaseHandler"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%ArrayList<String> resultHeaders = null;%>
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
<div class="container-fluid">
<h1>You are editing <%= request.getParameter("table")%> table, row ID <%= request.getParameter("id")%></h1>
<div>
	<form action="/194954_projekt_ps2/updatedata.jsp" method="POST">
		<% resultHeaders = DatabaseHandler.fetchTableHeaders(request.getParameter("table"));
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
	    <input type="hidden" name="id" value=<%=request.getParameter("id") %>>
	    <input type="hidden" name="dropdown" value=<%=request.getParameter("table") %>> <br>
  		<input type="submit" class="btn-primary" value="Submit">
		<input type="reset" class="btn-primary" value="Reset">
	</form> 
</div>
<br>
<a href="index.jsp">Back to home page</a>
</div>
</body>
</html>