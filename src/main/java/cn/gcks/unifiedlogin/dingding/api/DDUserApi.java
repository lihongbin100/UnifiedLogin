package cn.gcks.unifiedlogin.dingding.api;

import cn.gcks.unifiedlogin.dingding.model.DDUser;
import cn.gcks.unifiedlogin.dingding.utils.DDApiUrl;
import com.alibaba.fastjson.JSON;
import com.foxinmy.weixin4j.exception.WeixinException;
import com.foxinmy.weixin4j.http.weixin.WeixinResponse;
import com.foxinmy.weixin4j.model.Token;
import com.foxinmy.weixin4j.token.TokenManager;

import java.util.List;


/**
 * 通讯录api
 * Created by lihb on 10/18/16.
 */
public class DDUserApi extends BaseApi {

    private TokenManager tokenManager;

    public DDUserApi(TokenManager tokenManager) {
        this.tokenManager = tokenManager;
    }

    public List<DDUser> departmentUsers(int departmentId) throws WeixinException {
        Token token = tokenManager.getCache();
        WeixinResponse response = ddRequestExecutor.get(String.format(DDApiUrl.DEPARTMENT_USER_URL, token.getAccessToken(), departmentId));
        return JSON.parseArray(response.getAsJson().getString("userlist"),
                DDUser.class);
    }

    public DDUser userInfoByCode(String code) throws WeixinException {
        Token token = tokenManager.getCache();
        WeixinResponse response = ddRequestExecutor.get(String.format(DDApiUrl.USER_INFO_CODE_URL, token.getAccessToken(), code));
        return JSON.parseObject(response.getAsJson().getString("user_info"),DDUser.class);
    }

    public DDUser userInfoById(String userid) throws WeixinException {
        Token token = tokenManager.getCache();
        WeixinResponse response = ddRequestExecutor.get(String.format(DDApiUrl.USER_INFO_ID_URL, token.getAccessToken(), userid));
        return JSON.parseObject(response.getAsJson().toString(),DDUser.class);
    }


}
