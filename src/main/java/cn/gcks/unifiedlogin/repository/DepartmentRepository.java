package cn.gcks.unifiedlogin.repository;

import cn.gcks.unifiedlogin.entity.TDepartment;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

/**
 * The interface User repository.
 */
@Repository
public interface DepartmentRepository extends JpaRepository<TDepartment, Integer> {

}
