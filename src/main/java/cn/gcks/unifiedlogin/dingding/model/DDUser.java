package cn.gcks.unifiedlogin.dingding.model;

import lombok.Data;

/**
 * <p>
 * 钉钉用户
 * </p>
 *
 * @author lihb
 * @date 10/17/16.
 * @see <a href="https://open-doc.dingtalk.com/docs/doc.htm?spm=a219a.7629140.0.0.OCtc6y&treeId=172&articleId=104979&docType=1"></a>
 * { "errcode": 0, "errmsg": "ok", "userid": "zhangsan", "name": "张三", "tel" : "010-123333", "workPlace" :"", "remark" : "", "mobile" : "13800000000", "email" : "dingding@aliyun.com", "active" : true, "orderInDepts" : "{1:10, 2:20}", "isAdmin" : false, "isBoss" : false, "dingId" : "WsUDaq7DCVIHc6z1GAsYDSA", "isLeaderInDepts" : "{1:true, 2:false}", "isHide" : false, "department": [1, 2], "position": "工程师", "avatar": "dingtalk.com/abc.jpg", "jobnumber": "111111", "extattr": { "爱好":"旅游", "年龄":"24" } }
 */
@Data
public class DDUser {
    private String userid;//"zhangsan",
    private String name;//"张三",
    private String tel;//"010-123333",
    private String workPlace;
    private String remark;//"",
    private String mobile;//"13800000000",
    private String email;//"dingding@aliyun.com",
    private String active;//true,
    private String orderInDepts;//"{1:10, 2:20}",
    private String isAdmin;//false,
    private String isBoss;//false,
    private String dingId;//"WsUDaq7DCVIHc6z1GAsYDSA",
    private String isLeaderInDepts;//"{1:true, 2:false}",
    private String isHide;//false,
    private String department;//[1, 2],
    private String position;//"工程师",
    private String avatar;//"dingtalk.com/abc.jpg",
    private String jobnumber;//"111111",
    private String extattr;//
}
