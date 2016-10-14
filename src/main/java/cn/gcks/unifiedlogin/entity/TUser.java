package cn.gcks.unifiedlogin.entity;


import lombok.Data;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * Created by lihb on 8/25/16.
 */

@Entity
@Table(name = "qy_user")
@Data
public class TUser implements java.io.Serializable{
    @Id
    private String userid;//varchar(128) NOT NULL,
    private String username;//varchar(128) NOT NULL,
    private String position;//varchar(256) DEFAULT NULL COMMENT '职位信息',
    private String mobile;//varchar(128) DEFAULT NULL,
    private Integer gender;//varchar(10) DEFAULT '0' COMMENT '性别。0表示未定义，1表示男性，2表示女性',
    private String email;//varchar(128) DEFAULT NULL,
    private String weixinid;//varchar(128) DEFAULT '',
    private String avatar;//varchar(256) DEFAULT 'http://www.wexue.top:20000/images/default-header.jpg',
    private Integer status;//varchar(10) NOT NULL DEFAULT '4' COMMENT '关注状态: 1=已关注，2=已冻结，4=未关注',
    private String corpid;//varchar(128) NOT NULL,
    private Long createtime;//varchar(128) NOT NULL,
    private Long updatetime;//varchar(128) NOT NULL,
    private Long syntime;//varchar(128) NOT NULL DEFAULT '0',
}
