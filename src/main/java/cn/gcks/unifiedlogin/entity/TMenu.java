package cn.gcks.unifiedlogin.entity;


import lombok.Data;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * Created by lihb on 8/25/16.
 */

@Entity
@Table(name = "auth_menu")
@Data
public class TMenu implements java.io.Serializable{
    @Id
    private Integer id;
    private String name;
    private Integer agentid;
    private String sign;
}
