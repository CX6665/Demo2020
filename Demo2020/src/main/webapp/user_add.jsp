<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="layui/css/layui.css">
</head>
<body>
<div class="layui-container">
    <blockquote class="layui-elem-quote layui-text">
        Add English Users
    </blockquote>
    <form class="layui-form" action="AddUsers" method="post">
        <div class="layui-form-item">
            <div class="layui-inline">
                <label class="layui-form-label">userName</label>
                <div class="layui-input-inline">
                    <input id="userName" name="userName" class="layui-input">
                </div>
            </div>
            <div class="layui-inline">
                <label class="layui-form-label">password</label>
                <div class="layui-input-inline">
                    <input id="password" name="password" class="layui-input">
                </div>
            </div>
        </div>
        <div class="layui-form-item layui-hide">
            <button type="button" lay-submit="" lay-filter="user-add-save" id="user-add-save" class="layui-btn">
                YES
            </button>
        </div>
    </form>
</div>
<script src="layui/layui.all.js"></script>
</body>
</html>