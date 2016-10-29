package cn.gcks.unifiedlogin.dingding.api;

import cn.gcks.unifiedlogin.dingding.model.JsApiConfig;
import cn.gcks.unifiedlogin.dingding.utils.SignMethod;
import com.foxinmy.weixin4j.exception.WeixinException;
import com.foxinmy.weixin4j.token.TokenManager;

import java.util.UUID;


/**
 * 通讯录api
 * Created by lihb on 10/18/16.
 */
public class DDConfigApi extends BaseApi {

    private TokenManager ticketManger;

    public DDConfigApi(TokenManager ticketManger) {
        this.ticketManger = ticketManger;
    }


    public JsApiConfig jsApiConfig(String corpId, String agentId, String url) throws WeixinException {
        JsApiConfig jsApiConfig = new JsApiConfig();
        String nonceStr = String.valueOf(UUID.randomUUID()).substring(0,7);
        long time = System.currentTimeMillis()/1000;
        String ticket=ticketManger.getAccessToken();
        jsApiConfig.setType(0);
        jsApiConfig.setAgentId(agentId);
        jsApiConfig.setCorpId(corpId);
        jsApiConfig.setNonceStr(nonceStr);
        jsApiConfig.setTimeStamp(time);
        String sign = SignMethod.sign(ticket, nonceStr, time, url);
        jsApiConfig.setSignature(sign);
        return jsApiConfig;
    }


}
