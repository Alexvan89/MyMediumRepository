<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>展示</title>
    <script src="/js/jquery-3.3.1.min.js"></script>
    <link href="/bootstrap/bootstrap.min.css" rel="stylesheet">
    <script src="/bootstrap/bootstrap.min.js"></script>
</head>
<body>
<h1 align="center" style="color: #df6092">员工信息管理</h1>
<%--查询--%>
<form action="/emp/search" method="post" id="form1" style="text-align: center">
    <div style="margin: 0 auto">
        <div  class="col-md-2">
            <div class="form-group">
                <label class="col-sm-2 control-label">姓名</label>
                <div class="col-sm-10">
                    <input type="text" name="name" value="${ec.name}" size="10" class="form-control">
                </div>
            </div>
        </div>
        <div  class="col-md-2">
            <div class="form-group">
                <label class="col-sm-2 control-label">工资</label>
                <div class="col-sm-10">
                    <input class="form-control" type="text" name="startSalary" value="${ec.startSalary}">-
                    <input class="form-control" type="text" name="endSalary" value="${ec.endSalary}" size="10">
                </div>
            </div>
        </div>
        <div  class="col-md-2">
            <div class="form-group">
                <label class="col-sm-2 control-label">生日</label>
                <div class="col-sm-10">
                    <input type="date" class="form-control" name="startBirth" value="<fmt:formatDate value='${ec.startBirth}' pattern='yyyy-MM-dd'/>">-
                    <input type="date" class="form-control" name="endBirth" value="<fmt:formatDate value='${ec.endBirth}' pattern='yyyy-MM-dd'/>">
                </div>
            </div>
        </div>
        <div  class="col-md-2">
            <div class="form-group">
                <label class="col-sm-2 control-label">部门</label>
                <div class="col-sm-10">
                    <select name="deptId" id="" class="form-control">
                        <option value="0">-全部-</option>
                        <c:forEach var="dep" items="${deps}">
                            <option value="${dep.depid}"
                                    <c:if test="${dep.depid==ec.deptId}">selected=true</c:if>
                            >${dep.depname}</option>
                        </c:forEach>
                    </select>
                </div>
            </div>
        </div>
        <div class="col-md-2">
            <div>
                <input type="hidden" name="pageNum" value="1" id="pageNum">
                <input type="submit" class="btn btn-info" value="查询">
                <input type="button" class="btn btn-success" onclick="toAdd()" value="新增">
                <input type="button" class="btn btn-danger" onclick="batchDelete()" value="批量删除">
            </div>
        </div>
    </div>
    <br>
    <br>

   <%-- 姓名:
    <input type="text" name="name" value="${ec.name}" size="10">
    工资:
    <input type="text" name="startSalary" value="${ec.startSalary}" size="10">-
    <input type="text" name="endSalary" value="${ec.endSalary}" size="10">
    生日:
    <input type="date" name="startBirth" value="<fmt:formatDate value='${ec.startBirth}' pattern='yyyy-MM-dd'/>">-
    <input type="date" name="endBirth" value="<fmt:formatDate value='${ec.endBirth}' pattern='yyyy-MM-dd'/>">
    部门:
    <select name="deptId" id="">
        <option value="0">-全部-</option>
        <c:forEach var="dep" items="${deps}">
            <option value="${dep.depid}"
                    <c:if test="${dep.depid==ec.deptId}">selected=true</c:if>
            >${dep.depname}</option>
        </c:forEach>
    </select>--%>
</form>

<hr>

<%--展示--%>
<table class="table table-striped table-bordered table-hover table-condensed" id="table1">
    <tr align="center">
        <td><input type="checkbox" id="checkAll"></td>
        <td>编号</td>
        <td>姓名</td>
        <td>年龄</td>
        <td>性别</td>
        <td>工资</td>
        <td>津贴</td>
        <td>生日</td>
        <td>入职时间</td>
        <td>领导</td>
        <td>部门</td>
        <td>头像</td>
        <td>修改</td>
        <td>删除</td>
    </tr>
    <c:if test="${not empty pageInfo.list}">
        <c:forEach var="emp" items="${pageInfo.list}">
            <tr align="center">
                <td><input type="checkbox" class="checkNow" checked="true" value="${emp.id}"></td>
                <td id="empid">${emp.id}</td>
                <td>${emp.name}</td>
                <td>${emp.age}</td>
                <td>${emp.sex}</td>
                <td>${emp.salary}</td>
                <td>${emp.bonus}</td>
                <td><fmt:formatDate value="${emp.birth}" pattern="yyyy-MM-dd" /></td>
                <td><fmt:formatDate value="${emp.hiredate}" pattern="yyyy-MM-dd" /></td>
                <td>${emp.leader}</td>
                <td>${emp.dep.depname}</td>
                <td>
                    <a href="/emp/download?url=${emp.url}&pageNum=${pageInfo.pageNum}"><img src="${emp.url}" alt="" width="100px" height="100px"></a>
                </td>
                <td><input type="button" class="btn btn-primary" value="修改"  onclick="location.href='update1?id=${emp.id}'"></td>
                <td><input type="button" class="btn btn-warning" value="删除"  onclick="toDelete(${emp.id})"></td>
                <%--<a href="/emp/delete?id=${emp.id}" onclick="return confirm('确定删除吗?')">删除</a>--%>
            </tr>
        </c:forEach>
    </c:if>
</table>
<hr>
<%--分页--%>
<div align="center">
    <ul class="pagination" style="margin: 0 auto">
        <li class="active"><a href="javascript:toPage(1)">&laquo;</a></li>
        <li><a href="javascript:toPage(${pageInfo.pageNum-1})">上一页</a></li>
        <c:forEach var="i" begin="1" end="${pageInfo.pages}">
            <li><a href="javascript:toPage(${i})">${i}</a></li>
        </c:forEach>
        <li><a href="javascript:toPage(${pageInfo.pageNum+1})">下一页</a></li>
        <li class="active"><a href="javascript:toPage(${pageInfo.pages})">&raquo;</a></li>
    </ul>
</div>

<%--<table class="pagination">
    <tr>
        <td><a href="javascript:toPage(1)">首页</a></td>
        <td><a href="javascript:toPage(${pageInfo.pageNum-1})">上一页</a></td>
        <c:forEach var="i" begin="1" end="${pageInfo.pages}">
            <td><a href="javascript:toPage(${i})">${i}</a></td>
        </c:forEach>
        <td><a href="javascript:toPage(${pageInfo.pageNum+1})">下一页</a></td>
        <td><a href="javascript:toPage(${pageInfo.pages})">尾页</a></td>
        <td>
            <a href="javascript:goPage()">跳转</a>
            到第 <input type="text" value="${pageInfo.pageNum}" id="go" size="2">页
        </td>
    </tr>
</table>--%>
</body>
<script>
    //上下页
    function toPage(page) {
        if (page<1){
            page=1;
        }
        var a=${pageInfo.pages};
        if (page>a) {
            page=a;
        }
        $("#pageNum").val(page);
        $("#form1").submit();
    }

    //跳转页
    function goPage() {
        var page = $("#go").val();
        toPage(page);
    }

    //去新增页面
    function toAdd() {
        location.href="/emp/add1";
    }

    //删除
    function toDelete(id){
        var a=confirm('确定删除吗?');
        if (a){
            location.href="/emp/delete?id="+id;
        }
    }

    //全选反选
    $("#checkAll").click(function (){
        var isCheck=$(this).prop("checked");
        if (isCheck){
            $(".checkNow").prop("checked",true);
        } else {
            $(".checkNow").prop("checked",false);
        }
    });

    //批量删除
    function batchDelete() {
        //创建一个数组,存选中的员工编号
        var ids=new Array();
        $(".checkNow:checked").each(function () {
           var id=$(this).val();
           ids.push(id);
        });
        console.log(ids);
        //使用ajax异步请求,将参数携带到后台
        if (ids.length>0){
            var a=confirm('确定删除吗?');
            if (a) {
                $.post("/emp/batchDelete",{ids:ids.toString()},function ()  {
                    //删除后,在回调函数中执行页面跳转,数据重查,并留在当前页
                    location.href="/emp/search?pageNum=${pageInfo.pageNum}";
                });
            }
        }
    }


  /*  //隔行变色
    $(function () {
        $("#table1 tr:even").css("background-color","#fed1e3");
        $("#table1 tr:odd").css("background-color","#fda2ab");
        $("#table2").css("background-color","#96be6b")
    })*/
</script>
</html>
