<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="layui/css/layui.css">
</head>
<body>
<div class="layui-container">
    <blockquote class="layui-elem-quote layui-text">
        学生详情：
    </blockquote>

    <form class="layui-form" action="">

        <div class="layui-form-item">
            <div class="layui-inline">
                <label class="layui-form-label">姓名</label>
                <div class="layui-input-inline">
                    <input id="name" name="name" readonly class="layui-input">
                </div>
            </div>
            <div class="layui-inline">
                <label class="layui-form-label">性别</label>
                <div class="layui-input-inline">
                    <input id="sex" name="sex" readonly class="layui-input">
                </div>
            </div>
        </div>

        <div class="layui-form-item">
            <div class="layui-inline">
                <label class="layui-form-label">年龄</label>
                <div class="layui-input-inline">
                    <input id="age" name="age" readonly class="layui-input">
                </div>
            </div>
            <div class="layui-inline">
                <label class="layui-form-label">工资</label>
                <div class="layui-input-inline">
                    <input id="foulor" name="foulor" readonly class="layui-input">
                </div>
            </div>
        </div>

        <div class="layui-form-item">
            <div class="layui-inline">
                <label class="layui-form-label">id</label>
                <div class="layui-input-inline">
                    <input id="id" name="id" readonly class="layui-input">
                </div>
            </div>
        </div>
    </form>

</div>
<script src="layui/layui.all.js"></script>
</body>
</html>