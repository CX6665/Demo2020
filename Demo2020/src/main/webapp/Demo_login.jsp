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
    <meta name="viewport" content="width=device_width,initial-scale=1.0">
    <link rel="stylesheet" href="Demo_css/DemoCss.css">
    <title>login</title>
</head>
<body style="background: url(Demo_img/bg_img1.jpg);background-size: 100%">
<div class="login-box">
    <div class="title">
        <h1>login</h1>
    </div>
    <a class="login-btn">
        <span></span>
        <span></span>
        <span></span>
        <span></span>
        <button type="button" name="chkbtn" id="chkbtn"><h2>login</h2></button>
    </a>
    <div class="input-box">
        <input type="text"  id="username" valie="" placeholder="Email or Username">
    </div>
    <div class="input-box">
        <input type="password"  id="password" valie="" placeholder="password">
    </div>
    <script>
        document.getElementById('chkbtn').addEventListener('click',function(){
            var username=document.getElementById("username").value;
            var password=document.getElementById("password").value;
            if(username=='chenxin'&&password=='1839698CXcx'){
                window.location.href='words_table.jsp';
            }
            else{alert('Sorry Getinto defult!')}
        });
    </script>
    <div class="iconfonts">
        <i><img src="Demo_img/QQ.jpg"></i>
        <i><img src="Demo_img/Github.jpg"></i>
        <i><img src="Demo_img/Eamil.jpg"></i>
    </div>
</div>
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
