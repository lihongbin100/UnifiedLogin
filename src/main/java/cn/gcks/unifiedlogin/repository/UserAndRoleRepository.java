package cn.gcks.unifiedlogin.repository;

import cn.gcks.unifiedlogin.entity.TRole;
import cn.gcks.unifiedlogin.entity.TUserAndRole;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Created by lihb on 8/27/16.
 */
@Repository
public interface UserAndRoleRepository extends JpaRepository<TUserAndRole, String> {

    TUserAndRole findByUseridAndAgentid(String userid, Integer agentid);

    @Query("select r from TRole r,TUserAndRole tr where tr.roleid=r.id and tr.userid=?1 and tr.agentid=?2")
    TRole findRoleByByUseridAndAgentid(String userid, Integer agentid);


    @Transactional
    @Modifying
    @Query("delete from TUserAndRole tr where tr.userid=?1 and tr.agentid=?2")
    int deleteByUseridAndAgentid(String userid, Integer agentid);
}
