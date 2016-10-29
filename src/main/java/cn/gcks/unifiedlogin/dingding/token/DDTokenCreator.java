package cn.gcks.unifiedlogin.dingding.token;

import cn.gcks.unifiedlogin.dingding.utils.DDApiUrl;
import com.alibaba.fastjson.JSONObject;
import com.foxinmy.weixin4j.exception.WeixinException;
import com.foxinmy.weixin4j.http.weixin.WeixinResponse;
import com.foxinmy.weixin4j.model.Token;
import com.foxinmy.weixin4j.token.TokenCreator;

/**
 * 钉钉获取access
 * Created by lihb on 10/18/16.
 */
public class DDTokenCreator extends TokenCreator {

    private final String corpid;
    private final String corpsecret;

    /**
     * @param corpid     ID
     * @param corpsecret secret
     */
    public DDTokenCreator(String corpid, String corpsecret) {
        this.corpid = corpid;
        this.corpsecret = corpsecret;
    }

    @Override
    public String key0() {
        return String.format("dd_token_%s", corpid);
    }

    @Override
    public Token create() throws WeixinException {
        String tokenUrl = String.format(DDApiUrl.ACCESS_TOKEN_URL, corpid,
                corpsecret);
        WeixinResponse response = weixinExecutor.get(tokenUrl);
        JSONObject result = response.getAsJson();
        return new Token(result.getString("access_token"),7000*1000l);
    }
}
