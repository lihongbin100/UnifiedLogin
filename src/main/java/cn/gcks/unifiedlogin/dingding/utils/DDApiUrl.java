package cn.gcks.unifiedlogin.dingding.utils;

/**
 * Created by lihb on 10/18/16.
 */
public class DDApiUrl {
    public static String ACCESS_TOKEN_URL = "https://oapi.dingtalk.com/gettoken?corpid=%s&corpsecret=%s";
    public static String DEPARTMENT_LIST_URL = "https://oapi.dingtalk.com/department/list?access_token=%s";
    public static String DEPARTMENT_USER_URL = "https://oapi.dingtalk.com/user/list?access_token=%s&department_id=%d";
    public static String JSAPI_TICKET_URL = "https://oapi.dingtalk.com/get_jsapi_ticket?access_token=%s";
    public static String USER_INFO_CODE_URL ="https://oapi.dingtalk.com/user/getuserinfo?access_token=%s&code=%s";
    public static String USER_INFO_ID_URL ="https://oapi.dingtalk.com/user/get?access_token=%s&userid=%s";

}
