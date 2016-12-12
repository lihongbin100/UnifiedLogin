package cn.gcks.unifiedlogin.entity;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * Created by lihb on 8/25/16.
 */

@Entity
@Table(name = "menu")
@Data
@AllArgsConstructor
@NoArgsConstructor
public class TMenu implements java.io.Serializable{
    @Id
    @GeneratedValue
    private Integer id;
    private String name;
    private Integer agentId;
    private String sign;
    private Integer parent;
}
