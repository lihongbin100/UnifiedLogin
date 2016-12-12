package cn.gcks.unifiedlogin.repository;

import cn.gcks.unifiedlogin.entity.TAgentInfo;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by lihb on 8/27/16.
 */
@Repository
public interface AgentInfoRepository extends JpaRepository<TAgentInfo, Integer> {
    //    获取超级管理员的应用
    List<TAgentInfo> findBySuperManager(String superManager);
}
