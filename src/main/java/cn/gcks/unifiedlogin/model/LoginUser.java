package cn.gcks.unifiedlogin.model;

import com.foxinmy.weixin4j.qy.model.User;
import lombok.Data;

/**
 * Created by lihb on 10/10/16.
 */
@Data
public class LoginUser {
      private User user;
      private String[] menus;
}
