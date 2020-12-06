<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="layui/css/layui.css">
</head>
<body>
<div class="layui-container">
    <blockquote class="layui-elem-quote layui-text">
        English Words Change
    </blockquote>
    <form class="layui-form" action="upadateWords" method="post">
        <div class="layui-form-item">
            <div class="layui-inline">
                <label class="layui-form-label">Szm</label>
                <div class="layui-input-inline">
                    <input id="Szm" name="Szm" required class="layui-input">
                </div>
            </div>
            <div class="layui-inline">
                <label class="layui-form-label">Word</label>
                <div class="layui-input-inline">
                    <input id="Word" name="Word" required class="layui-input">
                </div>
            </div>
        </div>

        <div class="layui-form-item">
            <div class="layui-inline">
                <label class="layui-form-label">Meaning</label>
                <div class="layui-input-inline">
                    <textarea id="Meaning" name="Meaning" class="layui-input"></textarea>
                </div>
            </div>

        </div>
        <div class="layui-form-item">
            <div class="layui-inline">
                <label class="layui-form-label">Example</label>
                <div class="layui-input-inline">
                      <textarea id="Example" name="Example" class="layui-input"></textarea>
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