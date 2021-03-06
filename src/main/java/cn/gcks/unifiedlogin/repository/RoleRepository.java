package cn.gcks.unifiedlogin.repository;

import cn.gcks.unifiedlogin.entity.TRole;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by lihb on 8/27/16.
 */
@Repository
public interface RoleRepository extends JpaRepository<TRole, Integer> {

       List<TRole> findByAgentId(Integer agentId);
}
