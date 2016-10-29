package cn.gcks.unifiedlogin.entity;

import lombok.Data;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import java.util.Date;

/**
 * Created by lihb on 8/28/16.
 */
@Entity
@Table(name = "role")
@Data
public class TRole {
    @Id
    @GeneratedValue
    private Integer id;//int(128) NOT NULL AUTO_INCREMENT,
    private String name;//varchar(128) NOT NULL,
    private String description;//varchar(128) NOT NULL,
    private String createUser;//varchar(128) NOT NULL,
    private Date createTime;//bigint(30) NOT NULL,
}
