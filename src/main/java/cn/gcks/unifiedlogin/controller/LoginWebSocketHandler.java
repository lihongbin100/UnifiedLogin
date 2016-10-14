package cn.gcks.unifiedlogin.controller;

import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.*;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;

/**
 * Created by lihb on 9/23/16.
 */
@Slf4j
@Component
public class LoginWebSocketHandler implements WebSocketHandler {

    private static final ArrayList<WebSocketSession> users = new ArrayList<WebSocketSession>();


    public void afterConnectionEstablished(WebSocketSession session) throws Exception {
        users.add(session);
        session.sendMessage(new TextMessage(session.getId()));
    }

    public void handleMessage(WebSocketSession session, WebSocketMessage<?> message) throws Exception {
    }

    public void handleTransportError(WebSocketSession session, Throwable exception) throws Exception {
        if (session.isOpen()) {
            session.close();
        }
        users.remove(session);
    }

    public void afterConnectionClosed(WebSocketSession session, CloseStatus closeStatus) throws Exception {
        users.remove(session);
        log.debug("afterConnectionClosed" + closeStatus.getReason());
    }

    public boolean supportsPartialMessages() {
        return false;
    }

    /**
     * 给所有在线用户发送消息
     *
     * @param message
     */
    public void sendMessageToUsers(TextMessage message) {
        for (WebSocketSession user : users) {
            try {
                if (user.isOpen()) {
                    user.sendMessage(message);
                }
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }

    /**
     * 给单个用户发送消息
     *
     * @param message
     */
    public void sendMessageToUser(TextMessage message, String sessionId) {
        for (WebSocketSession user : users) {
            try {
                if (user.isOpen() && sessionId.equals(user.getId())) {
                    user.sendMessage(message);
                    return;
                }
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }

}
