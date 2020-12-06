<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="layui/css/layui.css">
</head>
<body>
<div class="layui-container">
    <blockquote class="layui-elem-quote layui-text">
       <%
           int rows=Integer.parseInt(request.getParameter("s"));
       %>>
        <%=rows>0?"修改成功":"修改失败"%>
    </blockquote>

</div>
<script src="layui/layui.all.js"></script>
</body>
</html>