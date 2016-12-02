package cn.gcks.unifiedlogin.repository;

import cn.gcks.unifiedlogin.entity.TUser;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * The interface User repository.
 */
@Repository
public interface UserRepository extends PagingAndSortingRepository<TUser, String>, JpaRepository<TUser, String> {

    List<TUser> findByNameLike(String name);

    @Query("select new TUser(u.userid,u.name,u.avatar,r.name) from TUser u,TUserAndRole ur,TRole r where u.userid = ur.userid and ur.roleid = r.id and ur.agentid=?1")
//     @Query("select ur from TUserAndRole ur where ur.agentid=?1 and ur.userid=?2")
    List<TUser> usersHaveRole(Integer agentId);

    TUser findByMobile(String mobile);
}
