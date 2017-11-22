<%@page import="javax.websocket.Session"%>
<%@page import="ps2.SessionHandler"%>
<%@page import="ps2.DatabaseHandler"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%ArrayList<String> resultHeaders = null;%>
<%ArrayList<String> resultTables = null;%>
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
<body onload="openSocket()"> 
<div class="container-fluid">
       <div style="display: none;">
           Message: <input type="text" id="messageinput" value="update"/> <br><br>
       </div>
       <br>
       <div style="display: none;">
           <button type="button" class="btn-primary" onclick="openSocket();" >Open</button>
           <button type="button" class="btn-primary" onclick="send();" >Send</button>
           <button type="button" class="btn-primary" onclick="closeSocket();" >Close</button>
       </div>
       <!-- Server responses get written here -->
       <div id="messages">
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
                	   window.location.href = '/194954_projekt_ps2/tableview.jsp?dropdown=<%=request.getParameter("dropdown") %>';
                	   //location.reload();
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
 <div id="table">
        <center>
        <p><%= request.getParameter("dropdown")%></p>
        <p style="display: none;">Require update? <%=request.getParameter("update") %></p>
        <table style="width:80%%;" border="1" class="sortable table-striped">
		  <tr>
		  <% resultHeaders = DatabaseHandler.fetchTableHeaders(request.getParameter("dropdown"));
		  	for (String temp : resultHeaders) {%>
			<th style="padding: 5px;"><%= temp%></th>
		    <% } %>
		  </tr>
		  <tr>
		  <%  resultTables = ps2.DatabaseHandler.fetchDataFromTable(request.getParameter("dropdown"));
		  int i=0;
		  int idsend = 0;
        for (String temp : resultTables) {
        	i++;
        	if(i%6 == 1) {
        		idsend = Integer.parseInt(temp);
        		System.out.println(idsend);
        	}
        %>
            <td style="padding: 5px;"><%= temp%></td>
        <% if(i%6==0) { %>
        	<td style="padding: 5px;"><input type="button" name="edit" value="Edit" class="btn-primary" onclick= ></td>
        	<td style="padding: 5px;"><input type="button" name="delete" value="Delete" onclick="if (confirm('Are you sure you want to delete this thing from the database?')) {
        		window.location.href='/194954_projekt_ps2/removedata.jsp?id=<%=idsend %>&table=<%=request.getParameter("dropdown") %>'
			} else {
    			// Do nothing!
			}" class="btn-primary"></td>
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
  			<input type="submit" class="btn-primary" value="Add row">
		</form>
		<br><br>
			<a href="index.jsp">Back to home page</a>
		</center>
		<br></br>
		</div>

	<% try {
		if (request.getParameter("update").equals("yes"))
			SessionHandler.sendToAllConnectedSessions("update");
		} catch (Exception e) {
			e.printStackTrace();
		}%>
</div>
</body>
</html>