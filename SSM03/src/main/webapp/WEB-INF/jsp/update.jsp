<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>修改</title>
    <script src="/js/jquery-3.3.1.min.js"></script>
    <script src="/js/jquery.form.js"></script>
</head>
<body>
<h1 align="center">修改员工信息</h1>
<form action="/emp/update2" method="post" id="myform1">
    <input type="hidden" name="id" value="${emp.id}">
    <table border="1" cellspacing="0" cellpadding="10" align="center">
        <tr>
            <td>姓名:</td>
            <td><input type="text" name="name" value="${emp.name}"><br></td>
        </tr>
        <tr>
            <td>年龄:</td>
            <td><input type="text" name="age" value="${emp.age}"><br></td>
        </tr>
        <tr>
            <td>性别:</td>
            <td><input type="text" name="sex" value="${emp.sex}"><br></td>
        </tr>
        <tr>
            <td>工资:</td>
            <td><input type="text" name="salary" value="${emp.salary}"><br></td>
        </tr>
        <tr>
            <td>津贴:</td>
            <td><input type="text" name="bonus" value="${emp.bonus}"><br></td>
        </tr>
        <tr>
            <td>生日:</td>
            <td><input type="date" name="birth" value="<fmt:formatDate value='${emp.birth}' pattern='yyyy-MM-dd'/>"><br></td>
        </tr>
        <tr>
            <td>入职时间:</td>
            <td><input type="date" name="hiredate" value="<fmt:formatDate value='${emp.hiredate}' pattern='yyyy-MM-dd'/>"><br></td>
        </tr>
        <tr>
            <td>领导:</td>
            <td><input type="text" name="leader" value="${emp.leader}"><br></td>
        </tr>
        <tr>
            <td>部门:</td>
            <td><select name="depid" id="">
                <option value="0">--请选择--</option>
                <c:forEach var="dep" items="${deps}">
                    <option value="${dep.depid}"
                        <c:if test="${dep.depid==emp.depid}">selected="selected"</c:if>
                    >${dep.depname}</option>
                </c:forEach>
            </select><br></td>
        </tr>
        <tr>
            <td>大头贴</td>
            <td>
                <img src="${emp.url}" alt="头像" id="img1" width="100px" height="100px"><br>
                <input type="file" name="bigHeadImg" onchange="upload1()"><br>
            </td>
        </tr>
        <tr align="center">
            <td colspan="2">
                <input type="submit" value="提交" id="submit">
                <input type="button" value="重置" id="reset">
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

    $("#reset").click(function (){
        $(":input").val("");
        $("#submit").val("提交");
        $("#reset").val("重置");

    });
</script>
</html>
