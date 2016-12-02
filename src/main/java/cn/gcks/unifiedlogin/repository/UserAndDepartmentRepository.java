package cn.gcks.unifiedlogin.repository;

import cn.gcks.unifiedlogin.entity.TUserAndDepartment;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by lihb on 8/27/16.
 */
@Repository
public interface UserAndDepartmentRepository extends PagingAndSortingRepository<TUserAndDepartment,String>,JpaRepository<TUserAndDepartment,String> {


    List<TUserAndDepartment> findByDepartmentid(int departmentid);
    Page<TUserAndDepartment> findByDepartmentid(Pageable pageable,int departmentid);
}
