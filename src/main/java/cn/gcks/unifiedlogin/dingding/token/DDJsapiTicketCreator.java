package cn.gcks.unifiedlogin.dingding.token;

import cn.gcks.unifiedlogin.dingding.utils.DDApiUrl;
import com.alibaba.fastjson.JSONObject;
import com.foxinmy.weixin4j.exception.WeixinException;
import com.foxinmy.weixin4j.http.weixin.WeixinResponse;
import com.foxinmy.weixin4j.model.Token;
import com.foxinmy.weixin4j.token.TokenCreator;
import com.foxinmy.weixin4j.token.TokenManager;

/**
 * 钉钉获取JsapiTicket
 * Created by lihb on 10/18/16.
 */
public class DDJsapiTicketCreator extends TokenCreator {

    private final TokenManager tokenManager;
    private String corpId;

    /**
     *
     * @param tokenManager
     */
    public DDJsapiTicketCreator(TokenManager tokenManager,String corpId) {
        this.tokenManager = tokenManager;
        this.corpId=corpId;
    }

    @Override
    public String key0() {
        return String.format("dd_jsapi_ticket_%s", corpId);
    }

    @Override
    public Token create() throws WeixinException {
        String tokenUrl = String.format(DDApiUrl.JSAPI_TICKET_URL,tokenManager.getAccessToken());
        WeixinResponse response = weixinExecutor.get(tokenUrl);
        JSONObject result = response.getAsJson();
        return new Token(result.getString("ticket"),7000*1000l);
    }
}
