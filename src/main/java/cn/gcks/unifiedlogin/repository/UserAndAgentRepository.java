package cn.gcks.unifiedlogin.repository;

import cn.gcks.unifiedlogin.entity.TUserAndAgent;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by lihb on 8/27/16.
 */
@Repository
public interface UserAndAgentRepository extends JpaRepository<TUserAndAgent,Integer> {

       List<TUserAndAgent> findByUseridAndAgentid(String userid,Integer agentid);
       List<TUserAndAgent> findByAgentid(Integer agentid);

}
