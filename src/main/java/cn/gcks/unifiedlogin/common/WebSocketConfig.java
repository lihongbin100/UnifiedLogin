package cn.gcks.unifiedlogin.common;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;
import org.springframework.web.socket.config.annotation.EnableWebSocket;
import org.springframework.web.socket.config.annotation.WebSocketConfigurer;
import org.springframework.web.socket.config.annotation.WebSocketHandlerRegistry;
import cn.gcks.unifiedlogin.controller.LoginWebSocketHandler;

/**
 * Created by lihb on 9/23/16.
 */
@Configuration
@EnableWebMvc
@EnableWebSocket
public class WebSocketConfig extends WebMvcConfigurerAdapter implements WebSocketConfigurer {
    @Autowired
    LoginWebSocketHandler loginWebSocketHandler;
    @Override
    public void registerWebSocketHandlers(WebSocketHandlerRegistry registry) {
//        registry.addHandler(systemWebSocketHandler(),"/webSocketServer").addInterceptors(new WebSocketHandshakeInterceptor())
        registry.addHandler(loginWebSocketHandler, "webSocketServer/login").setAllowedOrigins("*").withSockJS();
    }
}
