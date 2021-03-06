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
@Table(name = "task")
@Data
public class TTask {
    @Id
    @GeneratedValue
    private Integer id;//int(128) NOT NULL AUTO_INCREMENT,
    private String state;//varchar(128) NOT NULL,
    private String type;//varchar(128) NOT NULL,
    private String userid;//varchar(128) NOT NULL,
    private Date createtime;//bigint(30) NOT NULL,
}
