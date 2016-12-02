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
@Table(name = "user_role")
@Data
@IdClass(TUserAndRole.class)
public class TUserAndRole implements java.io.Serializable {
    @Id
    private String userid;
    @Id
    private Integer roleid;
    @Id
    private Integer agentid;
}
