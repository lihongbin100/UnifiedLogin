package cn.gcks.unifiedlogin.entity;

import lombok.Data;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import java.util.Date;

/**
 * Created by lihb on 10/28/16.
 */
@Entity
@Table(name = "log")
@Data
public class TLog {
    @Id
    @GeneratedValue
    private Integer id;
    private String description;
    private String operator;
    private String userId;
    private Integer agentId;
    private String agentName;
    private Date createTime;
}
