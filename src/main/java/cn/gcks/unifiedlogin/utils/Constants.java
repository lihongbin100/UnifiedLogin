package cn.gcks.unifiedlogin.utils;

/**
 * Created by lihb on 9/4/15.
 */
public class Constants {
    //Message
    public static class Message {
        public static String SYSTEM_ERROR = "系统错误";
        public static String OPERATE_FAILURE = "操作失败";
        public static String LOGIN_SUCCESS = "登陆成功";
        public static String LOGIN_FAILURE = "登陆失败";
        public static String LOGIN_PWD_ERROR = "密码错误";
        public static String LOGIN_NO_USERNAME = "没有该用户";
        public static String REG_FAILURE = "注册失败";
        public static String REG_EXIST_USERNAME = "账户已存在";
        public static String REG_SUCCESS = "注册成功";
    }

    //Config
    public static class Config {
        public static String SESSION_USER_NAME = "userinfo";
    }

    //EntityType
    public static class EntityType {
        public static String AUTH_USER = "AU";
        public static String LOGIN_USER = "LU";
        public static String COURSE = "COURSE";
        public static String PROJECT = "PRO";
        public static String AUTHINFO = "AI";
        public static String AUTHDEPARTMENT = "AD";
        public static String PORTAL = "PORTAL";
        public static String FILE = "FILE";
        public static String AVATOR = "AVATOR";
    }

}
