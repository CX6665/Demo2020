<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="layui/css/layui.css">
</head>
<body>
<div class="layui-container">
    <blockquote class="layui-elem-quote layui-text">
        English Words
    </blockquote>
    <form class="layui-form" action="">
        <div class="layui-form-item">
            <div class="layui-inline">
                <label class="layui-form-label">Szm</label>
                <div class="layui-input-inline">
                    <input id="Szm" name="Szm" readonly class="layui-input">
                </div>
            </div>
            <div class="layui-inline">
                <label class="layui-form-label">Words</label>
                <div class="layui-input-inline">
                    <input id="Word" name="Word" readonly class="layui-input">
                </div>
            </div>
        </div>

        <div class="layui-form-item">
            <div class="layui-inline">
                <label class="layui-form-label">Meaning</label>
                <div class="layui-input-inline">
                    <textarea id="Meaning" name="Meaning" readonly class="layui-input"></textarea>
                </div>
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-inline">
                <label class="layui-form-label">Example</label>
                <div class="layui-input-inline">
                    <textarea id="Example" name="Example" readonly class="layui-input"></textarea>
                </div>
            </div>
        </div>
    </form>
</div>
<script src="layui/layui.all.js"></script>
</body>
</html>