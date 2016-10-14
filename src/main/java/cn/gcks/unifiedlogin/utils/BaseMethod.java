package cn.gcks.unifiedlogin.utils;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.UUID;

/**
 * Created by lihb on 10/4/15.
 */
public class BaseMethod {

    public static String createUUID(String type) {
        UUID uuid = UUID.randomUUID();
        return type + uuid.toString();
    }

    public static long getCurrentTime() {
        return new Date().getTime();
    }

    public static boolean notEmpty(String o) {
        if (o != null && !"".equals(o)) {
            return true;
        } else {
            return false;
        }
    }

    public static String join(String[] ss) {
        String s = "";
        if (ss != null && ss.length != 0) {
            for(String si:ss){
                s = s + si+",";
            }
        } else {
            s = "";
        }
        return s;
    }

    public static String[] split(String s) {
        String[] ss = {};
        if (notEmpty(s)) {
            ss = s.split(",");
        }
        return ss;
    }


    public static String WDKCAPPID = "2";
    public static String PXKCAPPID = "1";
    public static String QLXZAPPID = "";


    public static String dateFormat(Long time){
        Date date=new Date(time);
        SimpleDateFormat simpleDateFormat=  new SimpleDateFormat("yyyy年MM月dd日 HH:mm");
        return simpleDateFormat.format(date);
    }
}
