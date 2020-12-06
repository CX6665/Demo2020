<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="layui/css/layui.css">
</head>
<body>
<div class="layui-container">
    <blockquote class="layui-elem-quote layui-text">
        添加学生信息：
    </blockquote>

    <form class="layui-form" action="stu/add" method="post">

        <div class="layui-form-item">
            <div class="layui-inline">
                <label class="layui-form-label">姓名</label>
                <div class="layui-input-inline">
                    <input id="name" name="name" required class="layui-input">
                </div>
            </div>
            <div class="layui-inline">
                <label class="layui-form-label">性别</label>
                <div class="layui-input-inline">
<%--                    <input id="sex" name="sex" class="layui-input">--%>
                    <select id="sex" name="sex" class="layui-input">
                        <option value="">==请选择==</option>
                        <option value="男" <c:if test="${pBanner.type == 1}">selected</c:if> >男</option>
                        <option value="女" <c:if test="${pBanner.type == 2}">selected</c:if> >女</option>
                        <option value="人妖" <c:if test="${pBanner.type == 3}">selected</c:if> >人妖</option>
                    </select>
                </div>
                <%--                下拉弹窗--%>
            </div>
        </div>

        <div class="layui-form-item">
            <div class="layui-inline">
                <label class="layui-form-label">年龄</label>
                <div class="layui-input-inline">
                    <input id="age" name="age" class="layui-input">
                </div>
            </div>
            <div class="layui-inline">
                <label class="layui-form-label">工资</label>
                <div class="layui-input-inline">
                    <input id="foulor" name="foulor" class="layui-input">
                </div>
            </div>
        </div>

        <div class="layui-form-item">
            <div class="layui-inline">
                <label class="layui-form-label">id</label>
                <div class="layui-input-inline">
                    <input id="id" name="id"  class="layui-input">
                </div>
            </div>
        </div>
        <div class="layui-form-item layui-hide">
            <button type="button" lay-submit="" lay-filter="user-add-save" id="user-add-save" class="layui-btn">
                确认
            </button>
        </div>

    </form>

</div>
<script src="layui/layui.all.js"></script>
</body>
</html>