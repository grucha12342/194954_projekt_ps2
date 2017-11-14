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
<body onload="openSocket()"> 
       <div>
           Message: <input type="text" id="messageinput" value="update"/> <br><br>
       </div>
       <br>
       <div>
           <button type="button" onclick="openSocket();" >Open</button>
           <button type="button" onclick="send();" >Send</button>
           <button type="button" onclick="closeSocket();" >Close</button>
       </div>
       <!-- Server responses get written here -->
       <div id="messages">
       	<p><%=request.getParameter("update") %></p>
       </div>
      
       <!-- Script to utilise the WebSocket -->
       
       <script type="text/javascript">
                      
           var webSocket;
           var messages = document.getElementById("messages");
                     
           function openSocket(){
               // Ensures only one connection is open at a time
               if(webSocket !== undefined && webSocket.readyState !== WebSocket.CLOSED){
                  writeResponse("WebSocket is already opened.");
                   return;
               }
               // Create a new instance of the websocket
               webSocket = new WebSocket("ws://localhost:8080/194954_projekt_ps2/echo");
                
               /**
                * Binds functions to the listeners for the websocket.
                */
               webSocket.onopen = function(event){
                   // For reasons I can't determine, onopen gets called twice
                   // and the first time event.data is undefined.
                   // Leave a comment if you know the answer.
                   if(event.data === undefined)
                       return;
                	   

                   writeResponse(event.data);

               };

               webSocket.onmessage = function(event){
                   writeResponse(event.data);
                   if(event.data == "update")
                	   location.reload();
                   //i++;
               };

               webSocket.onclose = function(event){
                   writeResponse("Connection closed");
               };
           }
          
           /**
            * Sends the value of the text input to the server
            */
           function send(){
               var text = document.getElementById("messageinput").value;
               webSocket.send(text);
           }
          
           function closeSocket(){
               webSocket.close();
           }

           function writeResponse(text){
               messages.innerHTML += "<br/>" + text;
           }     
       </script>
<p><%= request.getParameter("dropdown")%></p>
 <div id="table">
        <center>
        <table style="width:80%%" border="1" class="sortable">
		  <tr>
		  <% if(request.getParameter("dropdown").equals("MusicArtists")) {%>
		  	<th>Id</th>
		    <th>LastName</th>
		    <th>FirstName</th> 
		    <th>KnownAs</th> 
		    <th>Genres</th> 
		    <th>Age</th>
		    <%} else { %>
		    <th>Id</th>
		    <th>AlbumName</th>
		    <th>Label</th> 
		    <th>Released</th> 
		    <th>TrackNo</th> 
		    <th>ArtistID</th>
		    <% }; %>
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
		<br>
		<form action="/194954_projekt_ps2/addrowview.jsp" method="POST">
			<input type="hidden" name="tablename" value="<%=request.getParameter("dropdown")%>">
  			<input type="submit" value="Add row">
		</form>
		</center>
		<br></br>
		</div>
<a href="index.jsp">Back to home page</a>
<script>
if( webSocket.readyState == WebSocket.OPEN && <%=request.getParameter("update")%> == "yes")
	send();
</script>
</body>
</html>