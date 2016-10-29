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
@Table(name = "app_logo")
public class TAppLogo implements java.io.Serializable {
    @Id
    private Integer id;
    private String content;
    private String userId;
    private int appId;//超级管理ID
    private String loginUrl;
}
