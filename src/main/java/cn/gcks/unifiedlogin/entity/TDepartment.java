package cn.gcks.unifiedlogin.entity;


import lombok.Data;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * Created by lihb on 8/25/16.
 */

@Entity
@Table(name = "qy_department")
@Data
public class TDepartment implements java.io.Serializable{
    @Id
    @GeneratedValue
    private Integer departmentid;//int(128) NOT NULL AUTO_INCREMENT
    private String corpid;// varchar(256) NOT NULL,
    private String departmentname;// varchar(256) NOT NULL,
    private Integer parentid;// varchar(128) NOT NULL,
    private String writable;// varchar(64) DEFAULT 'true',
    private Integer orderby;// int(20) NOT NULL,
    private String suiteid;//varchar(128) NOT NULL,
    private String id;// varchar(128) NOT NULL,

}
