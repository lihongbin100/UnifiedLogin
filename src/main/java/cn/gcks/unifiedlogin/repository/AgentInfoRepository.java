package cn.gcks.unifiedlogin.repository;

import cn.gcks.unifiedlogin.entity.TAgentInfo;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

/**
 * Created by lihb on 8/27/16.
 */
@Repository
public interface AgentInfoRepository extends JpaRepository<TAgentInfo,Integer> {



}