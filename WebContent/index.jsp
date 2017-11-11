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
<title>Programowanie sieciowe 2</title>
</head>
<body> 
       <div>
           Message: <input type="text" id="messageinput"/> <br><br>
       </div>
       <br>
       <div>
           <button type="button" onclick="openSocket();" >Open</button>
           <button type="button" onclick="send();" >Send</button>
           <button type="button" onclick="closeSocket();" >Close</button>
       </div>
       <!-- Server responses get written here -->
       <div id="messages"></div>
      
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
       
    <center>
    	<h1> Drop down box or select element</h1>
        <select id="dropdown">
        <%  result = ps2.DatabaseHandler.fetchTables();
        for (String temp : result) {
        %>
            <option><%= temp%></option>
        <% } %>
        </select>
        <input type="button" id="button" value="Show table content" onclick="myFunction()"/>
	</center>
        <script>
        function myFunction() {
       	 	var e = document.getElementById("dropdown");
        	var strUser = e.options[e.selectedIndex].value;
        	messages.innerHTML += "<br/>" + strUser;
        }
        </script>
        <br></br>
        <br></br>
        <center>
        <table style="width:80%%" border="1">
		  <tr>
		    <th>LastName</th>
		    <th>FirstName</th> 
		    <th>KnownAs</th> 
		    <th>Genres</th> 
		    <th>Age</th>
		  </tr>
		  <tr>
		  <%  resultTables = ps2.DatabaseHandler.fetchDataFromTable("MusicArtists");
		  int i=0;
        for (String temp : resultTables) {
        	i++;
        %>
            <th><%= temp%></th>
        <% if(i%5==0) { %>
        	</tr>
        	<tr>
        <%
        }
        } %>
          </tr>
		</table>
		</center>
   </body>
</html>