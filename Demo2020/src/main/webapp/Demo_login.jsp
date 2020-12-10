<%--
  Created by IntelliJ IDEA.
  User: lenovo
  Date: 2020/12/5
  Time: 13:53
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
<%--    <link rel="stylesheet" href="layui/css/layui.css">--%>
<%--    <meta name="viewport" content="width=device_width,initial-scale=1.0">--%>
    <link rel="stylesheet" href="Demo_css/DemoCss.css">
    <title>login</title>
    <table class="layui-hide" ></table>
</head>
<body style="background: url(Demo_img/bg_img1.jpg);background-size: 100%">
<div class="login-box">
    <div class="title">
        <h1>login</h1>
    </div>
    <form action="loginServer" method="post">
        <div class="input-box">
            <input type="text"  name="username" placeholder="Email or Username">
        </div>
        <div class="input-box">
            <input type="password" name="password" placeholder="password">
        </div>
        <a class="login-btn">
            <span></span>
            <span></span>
            <span></span>
            <span></span>
            <button type="submit" name="chkbtn"><h2>login</h2></button>
        </a>

    </form>
    <a class="login-btn" style="margin-left: 120px">
        <span></span>
        <span></span>
        <span></span>
        <span></span>
        <button id="regist"><h2>Register</h2></button>
    </a>
</div>
<script src="layui/layui.all.js"></script>
<script src="layui/layui.js"></script>
<script>
    layui.use(['layer','jquery'], function () {
        let $ = layui.$
        ,layer = layui.layer;
        $("#regist").on('click', function() {
            layer.open({
                type: 2,
                content: 'user_add.jsp',
                area: ['700px', '400px'],
                btn: ['YES', "CANSER"],
                yes: function (index, layero) {
                    const iframeWindow = window['layui-layer-iframe' + index]
                        , submitID = 'user-add-save'
                        , submit = layero.find('iframe').contents().find('#' + submitID);
                    //监听提交
                    iframeWindow.layui.form.on('submit(' + submitID + ')', function (data) {
                        const field = data.field; //获取提交的字段
                        $.ajax({
                            url: '/Demo2020/AddUsers',
                            type: 'POST',
                            data: JSON.stringify(field),
                            success: function (res) {
                                if (res.code === 200) {
                                    layer.close(index);
                                    layer.msg('Add Successfully');
                                } else {
                                    layer.msg('Add Failed');
                                }
                            },
                            error: function (error) {
                                layer.msg('Http error');
                            }
                        });
                    });
                    submit.trigger('click');
                }
            });
        });
    })
</script>
<%--<script>--%>
<%--    function checkFrom(){--%>
<%--        var userName=document.getElementById("username").value;--%>
<%--        var passWord=document.getElementById("password").value;--%>
<%--        if(userName==null || userName==" "){--%>
<%--            alert("用户名不能为空");--%>
<%--            location.reload();--%>
<%--        }--%>
<%--        if(passWord==null || passWord==" "){--%>
<%--            alert("密码不能为空");--%>
<%--            location.reload();--%>
<%--        }--%>
<%--    }--%>
<%--</script>--%>
<%--记录访问次数--%>
<%! int pageCount = 0;
    void addCount() {
        pageCount++;
    }
%>
<%
    addCount();
%>
<div style="text-align: center;margin-top: 650px">
    <a href="Demo_login.jsp" style="color: #1d7dff">JavaWeb @2020 | Course presentation |   login number：<%=pageCount%></a>
</div>
</body>
</html>
