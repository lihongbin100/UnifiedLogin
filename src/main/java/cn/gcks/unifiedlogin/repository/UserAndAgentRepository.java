package cn.gcks.unifiedlogin.repository;

import cn.gcks.unifiedlogin.entity.TUserAndAgent;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by lihb on 8/27/16.
 */
@Repository
public interface UserAndAgentRepository extends JpaRepository<TUserAndAgent,String> {

       public List<TUserAndAgent> findByUseridAndAgentid(String userid,Integer agentid);
}
