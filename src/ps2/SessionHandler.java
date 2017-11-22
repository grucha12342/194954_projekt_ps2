package ps2;
import java.util.HashSet;
import javax.websocket.Session;
import java.util.Set;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author Grucha
 */
public class SessionHandler {
    private static final Set<Session> sessions = new HashSet<>();
    
    public static void addSession(Session session) {
        sessions.add(session);
    }
    
    public static void removeSession(Session session) {
        sessions.remove(session);
    }
    
    public static void sendToSession(Session session, String message) {
        session.getAsyncRemote().sendText(message);
    }
    
    public static void sendToAllConnectedSessions(String message) {
        for(Session sessions : sessions) {
        	sessions.getAsyncRemote().sendText(message);
        }
    }
}