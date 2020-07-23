<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>新增</title>
    <script src="/js/jquery-3.3.1.min.js"></script>
    <script src="/js/jquery.form.js"></script>
</head>
<body>
<h1 align="center">新增员工信息</h1>
<form action="/emp/add2" method="post" id="myform1">
    <table border="1" cellspacing="0" cellpadding="5" align="center">
        <tr>
            <td>姓名:</td>
            <td><input type="text" name="name"><br></td>
        </tr>
        <tr>
            <td>年龄:</td>
            <td><input type="text" name="age"><br></td>
        </tr>
        <tr>
            <td>性别:</td>
            <td><input type="text" name="sex"><br></td>
        </tr>
        <tr>
            <td>工资:</td>
            <td><input type="text" name="salary"><br></td>
        </tr>
        <tr>
            <td>津贴:</td>
            <td><input type="text" name="bonus"><br></td>
        </tr>
        <tr>
            <td>生日:</td>
            <td><input type="date" name="birth" size="20"><br></td>
        </tr>
        <tr>
            <td>入职时间:</td>
            <td><input type="date" name="hiredate"><br></td>
        </tr>
        <tr>
            <td>领导:</td>
            <td><input type="text" name="leader"><br></td>
        </tr>
        <tr>
            <td>部门:</td>
            <td><select name="depid" id="">
                <option value="0">--请选择--</option>
                <c:forEach var="dep" items="${deps}">
                    <option value="${dep.depid}">${dep.depname}</option>
                </c:forEach>
            </select><br></td>
        </tr>
        <tr>
            <td>大头贴</td>
            <td>
                <img src="" alt="头像" id="img1" width="100px" height="100px"><br>
                <input type="file" name="bigHeadImg" onchange="upload1()"><br>
            </td>
        </tr>
        <tr align="center">
            <td colspan="2">
                <input type="submit" value="提交">
                <input type="reset" value="重置">
            </td>
        </tr>
    </table>
    <input type="hidden" name="url" id="url1" value=""><br>
</form>
</body>
<script>
    function upload1() {
        //1.ajax去 后台 上传 图片  2.回调函数中取出 相对路径
        var $form={//文件上传ajax
            type:'post',
            url:'/emp/upload',
            dataType:'json',//期待服务器返回json格式数据
            success:function (data) {
                $("#img1").attr("src",data.url);//回显
                $("#url1").val(data.url);//新增 url
            }
        };
        $("#myform1").ajaxSubmit($form);
    }
</script>
</html>
