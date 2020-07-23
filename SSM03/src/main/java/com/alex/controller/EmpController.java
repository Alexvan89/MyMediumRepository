package com.alex.controller;

import com.alex.pojo.Dep;
import com.alex.pojo.Emp;
import com.alex.pojo.EmpCreteria;
import com.alex.service.IEmpService;
import com.alibaba.fastjson.JSONObject;
import com.github.pagehelper.PageInfo;
import org.apache.commons.io.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.*;
import java.util.List;
import java.util.UUID;

@Controller
@RequestMapping("/emp")
public class EmpController {

    @Autowired
    private IEmpService service;

    //批量删除
    @RequestMapping("/batchDelete")
    @ResponseBody//没有该注解,不会执行ajax回调函数
    public void batchDelete(Integer[] ids){
        service.batchDelete(ids);
    }

    //删除
    @RequestMapping("/delete")
    public String delete(Integer id){
        int i=service.delete(id);
        return "redirect:search";
    }

    //修改
    @RequestMapping("/update1")
    public String update1(Integer id,Model m){
        //根据id查询员工信息
        Emp emp=service.selectEmpById(id);

        //查询所有部门 填充下拉框
        List<Dep> deps = service.selectDeps();
        m.addAttribute("deps",deps);
        m.addAttribute("emp",emp);
        return "update";
    }
    @RequestMapping("/update2")
    public String update2(Emp emp){
        //真正修改信息
        int i=service.update(emp);
        System.out.println(emp);
        return "redirect:search";
    }

    //图片下载
    @RequestMapping("/download")
    public void imgDown(String url, int pageNum, HttpSession session, HttpServletResponse response) throws IOException {
        //第一次过滤,数据库中为null的情况,el表达式中没有null,是空字符串
        if (url.length()>0){
            String realPath=session.getServletContext().getRealPath(url);
            File file=new File(realPath);
            //第二次过滤,数据库中不为null,单服务器路径下没有图片,或图片被人为清空
            if (file.exists()){
                //一个头,两个流
                //获取输入流
                FileInputStream fis=new FileInputStream(file);
                //截取url中 /imgs 后面部分,作为文件名
                String fname=url.substring(55);
                //重新编码,解决中文乱码
                fname = new String(fname.getBytes("gbk"),"iso8859-1");
                //添加响应头--让浏览器以附件下载的形式打开响应文件
                response.addHeader("content-disposition","attachment;filename="+fname);
                //获取输出流
                ServletOutputStream sos=response.getOutputStream();
                IOUtils.copy(fis,sos);
                return;//响应流和页面跳转不能同时出现,所以此处用return返回
            }
        }
        //如果不能正常下载,页面会出现空白,此时跳转页面,去数据库重查,并留在当前页
        response.sendRedirect("/emp/search?pageNum="+pageNum);
    }


    //实现文件上传
    @RequestMapping("/upload")
    @ResponseBody
    public String upload(@RequestParam(required = false,value = "bigHeadImg") MultipartFile file, HttpSession session){
        //1.获取图片的存储路径
        String realPath = session.getServletContext().getRealPath("/imgs");
        System.out.println(realPath);
        //2.获取文件名
        String fname = file.getOriginalFilename();
        //3.加唯一前缀
        fname=System.currentTimeMillis()+ UUID.randomUUID().toString()+fname;
        //4.判断文件大小
        if(file.getSize()>1048576){
            System.out.println("文件太大！");
        }else {
            try {
                //f指定的路径和文件名
                File f = new File(realPath, fname);
                if(!f.exists()){
                    f.mkdirs();
                }
                file.transferTo(f); //5.执行上传
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        JSONObject json = new JSONObject();
        json.put("url","/imgs/"+fname);//返回相对路径 名字叫url

        return json.toJSONString();
    }

    //实现新增时的查询: 1.查询所有部门(填充下拉框) 2.跳转add.jsp
    @RequestMapping("/add1")
    public String add1(Model m){
        List<Dep> deps = service.selectDeps();
        //存进request域
        m.addAttribute("deps",deps);
        //跳转
        return "add";
    }
    //真正实现新增
    @RequestMapping("add2")
    public String add2(Emp emp){
        int i=service.add(emp);
        //重定向去重查数据库 show页面展示
        return "redirect:search";
    }


  /*  1.接收所有条件参数 name salary birth depId
    2.查询所有部门--填充条件下拉框
    3.执行模糊查询
    4.存model    --deps  (emps)   ec(4个条件)    pageInfo(结果集 分页四大参数)
    * */

    @RequestMapping("/search")
    public ModelAndView search(EmpCreteria ec, @RequestParam(defaultValue = "1") Integer pageNum, ModelAndView mav){
        //查询所有部门
        List<Dep> deps = service.selectDeps();
        //执行模糊查询
        PageInfo<Emp> pageInfo = service.selectLikeEmp(ec,pageNum);
        //存model
        mav.addObject("deps",deps);
        mav.addObject("pageInfo",pageInfo);
        mav.addObject("ec",ec);
        //页面跳转
        mav.setViewName("show");
        return mav;
    }
}
