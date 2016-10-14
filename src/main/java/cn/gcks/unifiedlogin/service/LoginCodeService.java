package cn.gcks.unifiedlogin.service;

import cn.gcks.unifiedlogin.model.LoginCode;
import cn.gcks.unifiedlogin.model.LoginCodeCreator;
import cn.gcks.unifiedlogin.model.LoginCodeManager;
import com.foxinmy.weixin4j.cache.RedisCacheStorager;
import com.foxinmy.weixin4j.exception.WeixinException;
import com.foxinmy.weixin4j.qy.model.User;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * Created by lihb on 9/26/16.
 */
@Service
@Slf4j
public class LoginCodeService {
    @Autowired
    private RedisCacheStorager<LoginCode> redisCacheStorager;
    public void cacheUser(String key,User user){
        LoginCodeCreator loginCodeCreator = new LoginCodeCreator(key, user);
        LoginCodeManager loginCodeManager = new LoginCodeManager(loginCodeCreator, redisCacheStorager);
        try {
            loginCodeManager.refreshCache();
        } catch (WeixinException e) {
            log.error(e.getMessage());
        }
    }

    public User getUser(String key){
        LoginCodeCreator loginCodeCreator = new LoginCodeCreator(key, null);
        LoginCodeManager loginCodeManager = new LoginCodeManager(loginCodeCreator, redisCacheStorager);
        try {
            return loginCodeManager.getUser();
        } catch (WeixinException e) {
            log.error(e.getMessage());
            return null;
        }
    }

}
