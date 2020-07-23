package com.alex.service;

import com.alex.pojo.Dep;
import com.alex.pojo.Emp;
import com.alex.pojo.EmpCreteria;
import com.github.pagehelper.PageInfo;

import java.util.List;

public interface IEmpService {
    List<Dep> selectDeps();

    PageInfo<Emp> selectLikeEmp(EmpCreteria ec, Integer pageNum);

    int add(Emp emp);

    Emp selectEmpById(Integer id);

    int update(Emp emp);

    int delete(Integer id);

    void batchDelete(Integer[] ids);
}
