<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%ResultSet resultset =null;%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Programowanie sieciowe 2</title>
</head>
<body>
<p>You are editing <%= request.getParameter("tablename")%> table</p>
<div id="artists" style="display: none;">
 <form action="/194954_projekt_ps2/insertdata.jsp" method="POST">
  Last name:<br>
  <input type="text" name="lastname"><br>
  First name:<br>
  <input type="text" name="firstname"><br>
  Known As:<br>
  <input type="text" name="knownas"><br>
  Genres:<br>
  <input type="text" name="genres"><br>
  Age:<br>
  <input type="number" name="age"><br>
  <br>
  <input type="hidden" name="dropdown" value="MusicArtists">
  <input type="submit" value="Submit">
  <input type="reset" value="Reset">
</form> 
</div>

<div id="albums" style="display: none;">
 <form action="/194954_projekt_ps2/insertdata.jsp" method="POST">
  Album name:<br>
  <input type="text" name="albumname"><br>
  Label:<br>
  <input type="text" name="label"><br>
  Released:<br>
  <input type="text" name="released"><br>
  TrackNo:<br>
  <input type="number" name="trackno"><br>
  ArtistID:<br>
  <input type="number" name="artistid"><br>
  <br>
  <input type="hidden" name="dropdown" value="Albums">
  <input type="submit" value="Submit">
  <input type="reset" value="Reset">
</form> 
</div>
<script type="text/javascript">
	if("<%=request.getParameter("tablename")%>" == "Albums")
		document.getElementById('albums').setAttribute("style", "display:block");
	else
		document.getElementById('artists').setAttribute("style", "display:block");
</script>
<a href="index.jsp">Back to home page</a>
</body>
</html>