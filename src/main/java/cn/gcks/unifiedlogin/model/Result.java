package cn.gcks.unifiedlogin.model;


/**
 * JSON模型
 * <p>
 * 用户后台向前台返回的JSON对象
 *
 * @author lihb
 */

public class Result implements java.io.Serializable {

    private static final long serialVersionUID = -1274608835654709276L;
    public Result(){

    }
    public Result(boolean success, String msg) {
        this.success = success;
        this.msg = msg;
    }

    private boolean success = false;

    private String msg = null;

    private Object obj = null;

    public boolean isSuccess() {
        return success;
    }

    public void setSuccess(boolean success) {
        this.success = success;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    //定制化错误
    public void setSysErrorMsg() {
        this.msg = "系统错误，程序猿小哥走神了";
    }

    public Object getObj() {
        return obj;
    }

    public void setObj(Object obj) {
        this.obj = obj;
    }

}
