package cn.gcks.unifiedlogin.repository;

import cn.gcks.unifiedlogin.entity.TUser;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.stereotype.Repository;

/**
 * Created by lihb on 8/27/16.
 */
@Repository
public interface UserRepository extends PagingAndSortingRepository<TUser,String>,JpaRepository<TUser,String> {


}
