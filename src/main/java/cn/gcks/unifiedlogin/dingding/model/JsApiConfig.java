package cn.gcks.unifiedlogin.dingding.model;

import lombok.Data;

/**
 * 钉钉jsapi配置对象
 * Created by lihb on 10/21/16.
 */
@Data
public class JsApiConfig {
    private String agentId;
    private String corpId;
    private long timeStamp;
    private String nonceStr; // 必填，生成签名的随机串
    private String signature; // 必填，签名
    private int type;   //选填。0表示微应用的jsapi,1表示服务窗的jsapi。不填默认为0。该参数从dingtalk.js的0.8.3版本开始支持
}