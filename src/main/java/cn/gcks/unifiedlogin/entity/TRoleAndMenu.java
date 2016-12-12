package cn.gcks.unifiedlogin.entity;


import lombok.Data;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.IdClass;
import javax.persistence.Table;

/**
 * Created by lihb on 8/25/16.
 */

@Entity
@Table(name = "role_menu")
@Data
@IdClass(TRoleAndMenu.class)
public class TRoleAndMenu implements java.io.Serializable {
    @Id
    private Integer roleid;
    @Id
    private Integer menuid;
    @Id
    private Integer agentid;
}
