package cn.gcks.unifiedlogin.service;

import cn.gcks.unifiedlogin.dingding.api.DDConfigApi;
import cn.gcks.unifiedlogin.dingding.api.DDDepartmentApi;
import cn.gcks.unifiedlogin.dingding.api.DDUserApi;
import cn.gcks.unifiedlogin.dingding.model.DDDepartment;
import cn.gcks.unifiedlogin.dingding.model.DDUser;
import cn.gcks.unifiedlogin.dingding.model.JsApiConfig;
import cn.gcks.unifiedlogin.dingding.token.DDJsapiTicketCreator;
import cn.gcks.unifiedlogin.dingding.token.DDTokenCreator;
import cn.gcks.unifiedlogin.dingding.utils.DDApiUrl;
import com.alibaba.fastjson.JSON;
import com.foxinmy.weixin4j.cache.RedisCacheStorager;
import com.foxinmy.weixin4j.exception.WeixinException;
import com.foxinmy.weixin4j.http.weixin.WeixinResponse;
import com.foxinmy.weixin4j.model.Token;
import com.foxinmy.weixin4j.token.TokenManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.messaging.core.CachingDestinationResolverProxy;
import org.springframework.stereotype.Service;

import javax.annotation.PostConstruct;
import java.util.List;

/**
 * Created by lihb on 10/18/16.
 */
@Service
public class DDAPI {

    private DDDepartmentApi ddDepartmentApi;

    private DDUserApi ddUserApi;

    private DDConfigApi ddConfigApi;

    @Value("${dd.corpid}")
    private String CORP_ID;
    @Value("${dd.corpsecret}")
    private String CORP_SECRET;
    @Value("${unifiedlogin.appid}")
    private String agentId;

    /**
     * token存储
     */
    @Autowired
    private RedisCacheStorager<Token> redisCacheStorager;

    @PostConstruct
    private void init() {
        DDTokenCreator ddTokenCreator = new DDTokenCreator(CORP_ID, CORP_SECRET);
        TokenManager tokenManager = new TokenManager(ddTokenCreator, redisCacheStorager);
        this.ddDepartmentApi = new DDDepartmentApi(tokenManager);
        this.ddUserApi = new DDUserApi(tokenManager);
        DDJsapiTicketCreator ddJsapiTicketCreator = new DDJsapiTicketCreator(tokenManager, CORP_ID);
        TokenManager ticketManger = new TokenManager(ddJsapiTicketCreator, redisCacheStorager);
        this.ddConfigApi = new DDConfigApi(ticketManger);
    }

    public List<DDUser> departmentUsers(int departmentId) throws WeixinException {
        return ddUserApi.departmentUsers(departmentId);
    }

    public List<DDDepartment> departmentList() throws WeixinException {
        return ddDepartmentApi.listDepartment();
    }

    public JsApiConfig jsApiConfig(String url) throws WeixinException {
        return ddConfigApi.jsApiConfig(CORP_ID, agentId, url);
    }

    public DDUser userInfoCode(String code) throws WeixinException {
        return ddUserApi.userInfoByCode(code);
    }
    public DDUser userInfoId(String userid) throws WeixinException {
        return ddUserApi.userInfoById(userid);
    }

}
