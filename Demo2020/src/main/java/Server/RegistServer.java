package Server;
import Control.BaseResp;
import Control.Users;
import JDBC.DBUtil;
import JDBC.RequestUtil;
import com.google.gson.Gson;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

@WebServlet(urlPatterns = "/AddUsers")
public class RegistServer extends HttpServlet {
    public static int addusers(Users users){
        Connection connection= DBUtil.getConnection();
        String sql ="insert into userlogin (user_name,password) values(?,?)";
        int rows=0;
        try{
            PreparedStatement statement= connection.prepareCall(sql);
            statement.setString(1,users.getUserName());
            statement.setString(2,users.getPassword());

            rows=statement.executeUpdate();
            DBUtil.close(null, statement, connection);
        }catch(SQLException e){
            e.printStackTrace();
        }
        return rows;
    }
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("utf-8");
        resp.setCharacterEncoding("utf-8");
        Gson gson=new Gson();
        String userJson= RequestUtil.getRequestBody(req);

        // 修改时提交的数据
        Users usersBody= gson.fromJson(userJson, Users.class);
        int rows= addusers(usersBody);
        BaseResp<Integer> baseResp=new BaseResp<Integer>();
        if(rows>0){
            baseResp.setCode(200);
            baseResp.setMsg("操作成功");
        }
        else{
            baseResp.setCode(600);
            baseResp.setMsg("操作失败");
        }
        baseResp.setData(rows);
        String json = gson.toJson(baseResp);
        resp.setContentType("application/json;charset=utf-8");
        PrintWriter out = resp.getWriter();
        out.print(json);
        out.flush();
    }
}
