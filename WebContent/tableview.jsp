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
<title>Programowanie sieciowe 2</title>
</head>
<body>
<p>Druga strona</p>
<p><%= request.getParameter("dropdown")%></p>
 <div id="table">
        <center>
        <table style="width:80%%" border="1" class="sortable">
		  <tr>
		  	<th>Id</th>
		    <th>LastName</th>
		    <th>FirstName</th> 
		    <th>KnownAs</th> 
		    <th>Genres</th> 
		    <th>Age</th>
		  </tr>
		  <tr>
		  <%  resultTables = ps2.DatabaseHandler.fetchDataFromTable(request.getParameter("dropdown"));
		  int i=0;
        for (String temp : resultTables) {
        	i++;
        %>
            <td><%= temp%></td>
        <% if(i%6==0) { %>
        	</tr>
        	<tr>
        <%
        }
        } %>
          </tr>
		</table>
		</center>
		<br></br>
		</div>
<a href="index.jsp">Back to home page</a>
</body>
</html>