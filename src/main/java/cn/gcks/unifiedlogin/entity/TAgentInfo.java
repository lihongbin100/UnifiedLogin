package cn.gcks.unifiedlogin.entity;

import lombok.Data;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * Created by lihb on 9/2/16.
 */
@Data
@Entity
@Table(name = "agent")
public class TAgentInfo implements java.io.Serializable {
    @Id
    @GeneratedValue
    private Integer id;
    private String name;
    private String description;
    private String superManager;//超级管理ID
    private String loginUrl;
    private String managers;
}
