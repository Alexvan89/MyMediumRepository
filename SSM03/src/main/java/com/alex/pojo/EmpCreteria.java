package com.alex.pojo;

import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

public class EmpCreteria {
    private String name;
    private Double startSalary;
    private Double endSalary;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date startBirth;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date endBirth;
    private Integer deptId;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name == null ? null : name.trim();
    }

    public Double getStartSalary() {
        return startSalary;
    }

    public void setStartSalary(Double startSalary) {
        this.startSalary = startSalary;
    }

    public Double getEndSalary() {
        return endSalary;
    }

    public void setEndSalary(Double endSalary) {
        this.endSalary = endSalary;
    }

    public Date getStartBirth() {
        return startBirth;
    }

    public void setStartBirth(Date startBirth) {
        this.startBirth = startBirth;
    }

    public Date getEndBirth() {
        return endBirth;
    }

    public void setEndBirth(Date endBirth) {
        this.endBirth = endBirth;
    }

    public Integer getDeptId() {
        return deptId;
    }

    public void setDeptId(Integer deptId) {
        this.deptId = deptId;
    }
}
