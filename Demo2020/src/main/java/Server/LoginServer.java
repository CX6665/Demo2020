package Server;

import JDBC.DBUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.*;

@WebServlet(urlPatterns = "/loginServer")
public class LoginServer extends HttpServlet{
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req,resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            Connection connection = DBUtil.getConnection();
            Statement statement = connection.createStatement();
            req.setCharacterEncoding("UTF-8");
            //获取login页面输入的用户名和密码
            String username = (String) req.getParameter("username");
            String password = (String) req.getParameter("password");
            String sql = "select * from userlogin where user_name=" + "'" + username + "'";
            ResultSet resultSet = statement.executeQuery(sql);
            if (resultSet.next()) {
                //将输入的密码与数据库密码相比对，执行相应操作
                if (password.equals(resultSet.getObject("password"))) {
                    resp.sendRedirect("success.jsp");
                }
                else {
                    resp.sendRedirect("failed.jsp");
                }
            } else {
                resp.sendRedirect("failed.jsp");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}

