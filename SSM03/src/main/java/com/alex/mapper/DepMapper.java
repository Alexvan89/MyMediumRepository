package com.alex.mapper;

import com.alex.pojo.Dep;
import com.alex.pojo.DepExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface DepMapper {
    long countByExample(DepExample example);

    int deleteByExample(DepExample example);

    int deleteByPrimaryKey(Integer depid);

    int insert(Dep record);

    int insertSelective(Dep record);

    List<Dep> selectByExample(DepExample example);

    Dep selectByPrimaryKey(Integer depid);

    int updateByExampleSelective(@Param("record") Dep record, @Param("example") DepExample example);

    int updateByExample(@Param("record") Dep record, @Param("example") DepExample example);

    int updateByPrimaryKeySelective(Dep record);

    int updateByPrimaryKey(Dep record);
}