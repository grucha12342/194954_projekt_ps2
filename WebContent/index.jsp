<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%ArrayList<String> result = null;%>
<%ArrayList<String> resultTables = null;%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<script src="sorttable.js"></script>
 <!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<!-- jQuery library -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<!-- Latest compiled JavaScript -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script> 
<title>Programowanie sieciowe 2</title>
</head>
<body>  
<div>      
    <center>
    <div>
    	<form action="/194954_projekt_ps2/tableview.jsp" method=POST id="table" name="table">
			<h1> Database Admin WebApp</h1>
        	<select id="dropdown" name="dropdown">
        	<%  result = ps2.DatabaseHandler.fetchTables();
        	for (String temp : result) {
        	%>
            <option><%= temp%></option>
        	<% } %>
        	</select>
  			<input type="submit" class="btn-primary" value="Show table content">
		</form>
	</div>
	</center>
        <br></br>
		<div id="sqlexec">
		<center>
			<form action="/194954_projekt_ps2/sqlview.jsp" method=POST id="sqlquery" name="sqlquery">
				<h1>Insert sql query here: </h1>
				<textarea id="txtarea" name="txtarea" form="sqlquery" rows="6" cols="60" style="resize: none;"><%=request.getParameter("txtarea")%></textarea><br></br>
  				<input type="submit" class="btn-primary" value="Send query">
			</form>
		</center>
		</div>
</div>
</body>
</html>