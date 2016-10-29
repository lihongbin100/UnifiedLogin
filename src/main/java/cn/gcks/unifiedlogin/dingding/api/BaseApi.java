package cn.gcks.unifiedlogin.dingding.api;

import com.foxinmy.weixin4j.http.weixin.WeixinRequestExecutor;

/**
 * Created by lihb on 10/18/16.
 */

public abstract class BaseApi {

    protected final WeixinRequestExecutor ddRequestExecutor;

    public BaseApi() {
        this.ddRequestExecutor = new WeixinRequestExecutor();
    }
}
