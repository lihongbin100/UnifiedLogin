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
@Table(name = "qy_user_agent")
@Data
@IdClass(TUserAndAgent.class)
public class TUserAndAgent implements java.io.Serializable{
    @Id
    private String userid;
    @Id
    private Integer agentid;
}
