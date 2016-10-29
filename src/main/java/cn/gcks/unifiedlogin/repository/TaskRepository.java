package cn.gcks.unifiedlogin.repository;

import cn.gcks.unifiedlogin.entity.TTask;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.stereotype.Repository;

/**
 * Created by lihb on 8/27/16.
 */
@Repository
public interface TaskRepository extends PagingAndSortingRepository<TTask, Integer>, JpaRepository<TTask, Integer> {
       Page<TTask> findByUserid(String userid, Pageable pageable);
}
