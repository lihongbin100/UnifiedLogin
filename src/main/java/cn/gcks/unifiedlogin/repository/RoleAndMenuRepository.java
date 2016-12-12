package cn.gcks.unifiedlogin.repository;

import cn.gcks.unifiedlogin.entity.TMenu;
import cn.gcks.unifiedlogin.entity.TRoleAndMenu;
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
public interface RoleAndMenuRepository extends JpaRepository<TRoleAndMenu, String> {

    List<TRoleAndMenu> findByRoleidAndAgentid(Integer roleid, Integer agentid);

    @Query("select new TMenu(m.id,m.name,m.agentId,m.sign,m.parent) from TMenu m,TRoleAndMenu rm where rm.menuid=m.id and rm.roleid=?1 and rm.agentid=?2")
    List<TMenu> findMenusByRoleidAndAgentid(Integer roleid, Integer agentid);
}
