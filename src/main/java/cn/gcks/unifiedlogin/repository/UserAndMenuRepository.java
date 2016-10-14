package cn.gcks.unifiedlogin.repository;

import cn.gcks.unifiedlogin.entity.TUserAndMenu;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;

/**
 * Created by lihb on 8/27/16.
 */
@Repository
public interface UserAndMenuRepository extends JpaRepository<TUserAndMenu,String> {
       public List<TUserAndMenu> findByUseridAndAgentid(String userid, Integer agentid);
}
