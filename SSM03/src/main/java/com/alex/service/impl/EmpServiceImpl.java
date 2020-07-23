package com.alex.service.impl;

import com.alex.mapper.DepMapper;
import com.alex.mapper.EmpMapper;
import com.alex.pojo.Dep;
import com.alex.pojo.Emp;
import com.alex.pojo.EmpCreteria;
import com.alex.pojo.EmpExample;
import com.alex.service.IEmpService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Arrays;
import java.util.List;

@Service
@Transactional
public class EmpServiceImpl implements IEmpService {

    @Autowired
    private DepMapper depMapper;

    @Autowired
    private EmpMapper empMapper;

    @Override
    public List<Dep> selectDeps() {
        //没有条件就表示查询所有
        return depMapper.selectByExample(null);
    }

   /* 1.开始执行预备分页
    2.条件的非空判断和拼接
    3.关联员工和部门
    4.结果集 以 有参构造的形式 封装进 pageInfo 对象
    * */

    @Override
    public PageInfo<Emp> selectLikeEmp(EmpCreteria ec, Integer pageNum) {
        PageHelper.startPage(pageNum,5);
        EmpExample e=new EmpExample();
        EmpExample.Criteria c=e.createCriteria();
        if (ec.getName()!=null){
            c.andNameLike("%"+ec.getName()+"%");
        }
        if (ec.getStartSalary()!=null){
            c.andSalaryGreaterThanOrEqualTo(ec.getStartSalary());
        }
        if (ec.getEndSalary()!=null){
            c.andSalaryLessThanOrEqualTo(ec.getEndSalary());
        }
        if (ec.getStartBirth()!=null){
            c.andBirthGreaterThanOrEqualTo(ec.getStartBirth());
        }
        if (ec.getEndBirth()!=null){
            c.andBirthLessThanOrEqualTo(ec.getEndBirth());
        }
        if (ec.getDeptId()!=null&&ec.getDeptId()!=0){
            c.andDepidEqualTo(ec.getDeptId());
        }
        //条件拼接后执行模糊查询
        List<Emp> emps = empMapper.selectByExample(e);
        //关联员工表和部门表
        for (Emp emp:emps){
            Dep dep=depMapper.selectByPrimaryKey(emp.getDepid());
            emp.setDep(dep);
        }
        //封装结果集到 pageInfo对象
        return new PageInfo<Emp>(emps);
    }

    @Override
    public int add(Emp emp) {
        return empMapper.insertSelective(emp);
    }

    @Override
    public Emp selectEmpById(Integer id) {
        return empMapper.selectByPrimaryKey(id);
    }

    @Override
    public int update(Emp emp) {
        return empMapper.updateByPrimaryKeySelective(emp);
    }

    @Override
    public int delete(Integer id) {
        return empMapper.deleteByPrimaryKey(id);
    }

    @Override
    public void batchDelete(Integer[] ids) {
        EmpExample e=new EmpExample();
        EmpExample.Criteria c=e.createCriteria();
        c.andIdIn(Arrays.asList(ids));//数组转换成集合
        empMapper.deleteByExample(e);
    }
}
