
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<html>
<head>
    <title>fcount.jsp</title>
</head>
<body>
<%--记录访问次数--%>
    <%! int pageCount = 0;

        void addCount() {
            pageCount++;
        }
    %>
    <%
        addCount();
    %>
    <div style="text-align: center;">
            <a href="apple.jsp">Copyright © 2018 | 备案号：琼ICP备13001417号-3 |   访问次数：<%=pageCount%></a>
    </div>
</body>
</html>