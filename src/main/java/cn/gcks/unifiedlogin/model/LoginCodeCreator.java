package cn.gcks.unifiedlogin.model;

import cn.gcks.unifiedlogin.utils.BaseMethod;
import com.foxinmy.weixin4j.cache.CacheCreator;
import com.foxinmy.weixin4j.exception.WeixinException;
import com.foxinmy.weixin4j.http.weixin.WeixinRequestExecutor;
import com.foxinmy.weixin4j.qy.model.User;

/**
 * 统一登录code获取
 *
 * @author jinyu(foxinmy@gmail.com)
 * @className WeixinSuitePreCodeCreator
 * @date 2015年6月17日
 * @see <a href=
 * "http://qydev.weixin.qq.com/wiki/index.php?title=%E7%AC%AC%E4%B8%89%E6%96%B9%E5%BA%94%E7%94%A8%E6%8E%A5%E5%8F%A3%E8%AF%B4%E6%98%8E#.E8.8E.B7.E5.8F.96.E9.A2.84.E6.8E.88.E6.9D.83.E7.A0.81">
 * 获取应用套件预授权码</a>
 * @since JDK 1.6
 */

public class LoginCodeCreator implements CacheCreator<LoginCode> {

    /**
     * 缓存KEY前缀
     */
    public final static String CACHEKEY_PREFIX = "login_code_";

    protected final WeixinRequestExecutor weixinExecutor;

    private String authCode = "----";
    private User user;

    public LoginCodeCreator(String authCode,User user) {
        this.authCode = authCode;
        this.user = user;
        this.weixinExecutor = new WeixinRequestExecutor();
    }

    /**
     * 缓存key:附加key前缀
     *
     * @return
     */
    @Override
    public String key() {
        return String.format("%s%s", CACHEKEY_PREFIX, this.authCode);
    }


    @Override
    public LoginCode create() throws WeixinException {
        LoginCode loginCode= new LoginCode(this.user,240000l, BaseMethod.getCurrentTime());
        return loginCode;
    }
}

