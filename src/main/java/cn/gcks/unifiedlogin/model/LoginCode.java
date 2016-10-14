package cn.gcks.unifiedlogin.model;
import java.util.HashMap;
import java.util.Map;

import com.foxinmy.weixin4j.cache.Cacheable;
import com.foxinmy.weixin4j.qy.model.User;

/**
 * access_token是公众号的全局唯一票据,公众号调用各接口时都需使用access_token,正常情况下access_token有效期为7200秒,
 * 重复获取将导致上次获取的access_token失效
 *
 * @className LoginCode
 * @author jinyu(foxinmy@gmail.com)
 * @date 2014年4月5日
 * @since JDK 1.6
 * @see <a
 *      href="https://mp.weixin.qq.com/wiki?t=resource/res_main&id=mp1421140183&token=&lang=zh_CN">微信公众平台获取token</a>
 * @see <a
 *      href="http://qydev.weixin.qq.com/wiki/index.php?title=%E4%B8%BB%E5%8A%A8%E8%B0%83%E7%94%A8">微信企业号的主动模式</a>
 */
public class LoginCode implements Cacheable {

    private static final long serialVersionUID = -7564855472419104084L;

    /**
     * 自制登陆授权码
     */
    private User user;
    /**
     * 凭证有效时间，单位：毫秒
     */
    private long expires;
    /**
     * token创建的时间,单位：毫秒
     */
    private long createTime;
    /**
     * 扩展信息
     */
    private Map<String, String> extra;

    /**
     * 永不过期、创建时间为当前时间戳的token对象
     *
     * @param user
     *            凭证字符串
     */
    public LoginCode(User user) {
        this(user, -1);
    }

    /**
     * 有过期时间、创建时间为当前时间戳的token对象
     *
     * @param user
     *            凭证字符串
     * @param expires
     *            过期时间 单位毫秒
     */
    public LoginCode(User user, long expires) {
        this(user, expires, System.currentTimeMillis());
    }

    /**
     *
     * @param user
     *            凭证字符串
     * @param expires
     *            过期时间 单位毫秒
     * @param createTime
     *            创建时间戳 单位毫秒
     */
    public LoginCode(User user, long expires, long createTime) {
        this.user = user;
        this.expires = expires;
        this.createTime = createTime;
        this.extra = new HashMap<String, String>();
    }

    public User getUser() {
        return user;
    }

    @Override
    public long getExpires() {
        return expires;
    }

    @Override
    public long getCreateTime() {
        return createTime;
    }

    public Map<String, String> getExtra() {
        return extra;
    }

    public LoginCode pushExtra(String name, String value) {
        this.extra.put(name, value);
        return this;
    }

    @Override
    public String toString() {
        return "LoginCode [user=" + user + ", expires=" + expires
                + ", createTime=" + createTime + ", extra=" + extra + "]";
    }
}
