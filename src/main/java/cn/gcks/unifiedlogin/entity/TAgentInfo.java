package cn.gcks.unifiedlogin.entity;

import lombok.Data;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * Created by lihb on 9/2/16.
 */
@Data
@Entity
@Table(name = "qy_agent")
public class TAgentInfo implements java.io.Serializable {
    @Id
    private Integer id;
    private String name;
    private Integer authType;// int(16) NOT NULL,
    private Integer appId;// int(16) NOT NULL COMMENT '服务商套件中的对应应用id',
    private String apiGroup;// varchar(256) NOT NULL,
    private Integer privilegeInfoId;// int(16) NOT NULL,
    private String corpId;// varchar(128) NOT NULL,
    private String loginUrl;
}
