package cn.gcks.unifiedlogin.dingding.api;

import cn.gcks.unifiedlogin.dingding.model.DDDepartment;
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
public class DDDepartmentApi extends BaseApi {

    private TokenManager tokenManager;

    public DDDepartmentApi(TokenManager tokenManager) {
        this.tokenManager = tokenManager;
    }

    public List<DDDepartment> listDepartment() throws WeixinException {
        Token token = tokenManager.getCache();
        WeixinResponse response = ddRequestExecutor.get(String.format(DDApiUrl.DEPARTMENT_LIST_URL, token.getAccessToken()));
        return JSON.parseArray(response.getAsJson().getString("department"),
                DDDepartment.class);
    }
}
