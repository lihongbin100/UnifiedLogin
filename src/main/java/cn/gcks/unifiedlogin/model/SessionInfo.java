package cn.gcks.unifiedlogin.model;


import cn.gcks.unifiedlogin.service.QyAPI;
import lombok.Data;

/**
 * Created by lihb on 9/4/15.
 */
@Data
public class SessionInfo {
    private String id;
    private LoginUser loginUser;
}
