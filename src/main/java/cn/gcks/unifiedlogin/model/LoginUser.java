package cn.gcks.unifiedlogin.model;

import cn.gcks.unifiedlogin.entity.TRole;
import cn.gcks.unifiedlogin.entity.TUser;
import lombok.Data;

/**
 * Created by lihb on 10/10/16.
 */
@Data
public class LoginUser {
    private TUser user;
    private String[] menus;
    private TRole role;
}
