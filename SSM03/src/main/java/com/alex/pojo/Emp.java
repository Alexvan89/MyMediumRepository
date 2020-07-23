package com.alex.pojo;

import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

public class Emp {
    private Integer id;

    private String name;

    private Integer age;

    private String sex;

    private Double salary;

    private Double bonus;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date birth;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date hiredate;

    private String leader;

    private Integer depid;

    private String url;

    private Dep dep;

    public Dep getDep() {
        return dep;
    }

    public void setDep(Dep dep) {
        this.dep = dep;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name == null ? null : name.trim();
    }

    public Integer getAge() {
        return age;
    }

    public void setAge(Integer age) {
        this.age = age;
    }

    public String getSex() {
        return sex;
    }

    public void setSex(String sex) {
        this.sex = sex == null ? null : sex.trim();
    }

    public Double getSalary() {
        return salary;
    }

    public void setSalary(Double salary) {
        this.salary = salary;
    }

    public Double getBonus() {
        return bonus;
    }

    public void setBonus(Double bonus) {
        this.bonus = bonus;
    }

    public Date getBirth() {
        return birth;
    }

    public void setBirth(Date birth) {
        this.birth = birth;
    }

    public Date getHiredate() {
        return hiredate;
    }

    public void setHiredate(Date hiredate) {
        this.hiredate = hiredate;
    }

    public String getLeader() {
        return leader;
    }

    public void setLeader(String leader) {
        this.leader = leader == null ? null : leader.trim();
    }

    public Integer getDepid() {
        return depid;
    }

    public void setDepid(Integer depid) {
        this.depid = depid;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url == null ? null : url.trim();
    }
}