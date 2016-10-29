package cn.gcks.unifiedlogin.dingding.model;

import lombok.Data;

/**
 * Created by lihb on 10/17/16.
 * 钉钉部门实体
 *
 *
 *
 * errcode	返回码
 * errmsg	对返回码的文本描述内容
 * id	部门id
 * name	部门名称
 * parentid	父部门id，根部门为1
 * order	在父部门中的次序值
 * createDeptGroup	是否同步创建一个关联此部门的企业群, true表示是, false表示不是
 * autoAddUser	当群已经创建后，是否有新人加入部门会自动加入该群, true表示是, false表示不是
 * deptHiding	是否隐藏部门, true表示隐藏, false表示显示
 * deptPerimits	可以查看指定隐藏部门的其他部门列表，如果部门隐藏，则此值生效，取值为其他的部门id组成的的字符串，使用|符号进行分割
 * userPerimits	可以查看指定隐藏部门的其他人员列表，如果部门隐藏，则此值生效，取值为其他的人员userid组成的的字符串，使用|符号进行分割
 * outerDept	是否本部门的员工仅可见员工自己, 为true时，本部门员工默认只能看到员工自己
 * outerPermitDepts	本部门的员工仅可见员工自己为true时，可以配置额外可见部门，值为部门id组成的的字符串，使用|符号进行分割
 * outerPermitUsers	本部门的员工仅可见员工自己为true时，可以配置额外可见人员，值为userid组成的的字符串，使用| 符号进行分割
 * orgDeptOwner	企业群群主
 * deptManagerUseridList	部门的主管列表,取值为由主管的userid组成的字符串，不同的userid使用|符号进行分割
 */
@Data
public class DDDepartment {
    private Integer id;// 2,
    private String name;// "钉钉事业部",
    private Integer order;// 10,
    private Integer parentid;// 1,
    private boolean createDeptGroup;// true,
    private boolean autoAddUser;// true,
    private boolean deptHiding;// true,
    private String deptPerimits;// "3|4",
    private String userPerimits;// "userid1|userid2",
    private boolean outerDept;// true,
    private String outerPermitDepts;// "1|2",
    private String outerPermitUsers;// "userid3|userid4",
    private String orgDeptOwner;// "manager1122",
    private String deptManagerUseridList;// "manager1122|manager3211"
}
