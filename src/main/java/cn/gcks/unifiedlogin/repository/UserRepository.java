package cn.gcks.unifiedlogin.repository;

import cn.gcks.unifiedlogin.entity.TUser;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * The interface User repository.
 */
@Repository
public interface UserRepository extends PagingAndSortingRepository<TUser, String>, JpaRepository<TUser, String> {

     List<TUser> findByNameLike(String name);
}
