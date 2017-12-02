package ps2;
import java.io.IOException;
import javax.websocket.OnClose;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.PathParam;
import javax.websocket.server.ServerEndpoint;


@ServerEndpoint(value = "/echo")
public class Server {
    @OnOpen
    public void onOpen(Session session) throws ClassNotFoundException{ 
        try {
            session.getBasicRemote().sendText("Connection Established");
            SessionHandler.addSession(session);
        } catch (IOException ex) {
            ex.printStackTrace();
        }
    }
 
    @OnMessage
    public void onMessage(String message, Session session){
        SessionHandler.sendToAllConnectedSessions(message);
    }
 
    @OnClose
    public void onClose(Session session){
        SessionHandler.removeSession(session);
    }
}