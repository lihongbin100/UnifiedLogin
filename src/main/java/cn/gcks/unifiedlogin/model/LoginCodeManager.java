package cn.gcks.unifiedlogin.model;

/**
 * Created by lihb on 9/18/16.
 */

import com.foxinmy.weixin4j.cache.CacheManager;
import com.foxinmy.weixin4j.cache.CacheStorager;
import com.foxinmy.weixin4j.exception.WeixinException;
import com.foxinmy.weixin4j.qy.model.User;
import com.foxinmy.weixin4j.token.TokenCreator;

/**
 * 对token的缓存获取
 *
 * @className LoginCodeManager
 * @author jinyu(foxinmy@gmail.com)
 * @date 2015年6月12日
 * @since JDK 1.6
 * @see TokenCreator
 * @see TokenCreator
 * @see CacheStorager
 */
public class LoginCodeManager extends CacheManager<LoginCode> {
    /**
     *
     * @param loginCodeCreator
     *            负责微信各种token的创建
     * @param cacheStorager
     *            负责token的存储
     */
    public LoginCodeManager(LoginCodeCreator loginCodeCreator,
                            CacheStorager<LoginCode> cacheStorager) {
        super(loginCodeCreator, cacheStorager);
    }

    /**
     * 获取token字符串
     *
     * @return token字符串
     * @throws WeixinException
     */
    public User getUser() throws WeixinException {
        return super.getCache().getUser();
    }
}
