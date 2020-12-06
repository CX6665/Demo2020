package Server;
//2020/11/20
import Control.BaseResp;
import Control.student;
import Dbo.Studentdbo;
import com.google.gson.Gson;
import com.mysql.cj.util.StringUtils;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet(urlPatterns = "/stu/all")
public class StudentAllServert extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        //请求和应答中文
        response.setCharacterEncoding("UTF-8");
        String page=request.getParameter("page");
        String limit=request.getParameter("limit");

        List<student> students= Studentdbo.getStudents(StringUtils.isNullOrEmpty(page)?1:Integer.parseInt(page),
                StringUtils.isNullOrEmpty(limit)?10:Integer.parseInt(limit));

//2020/11/21
        BaseResp<List<student>> resp=new BaseResp<List<student>>();
        int rows =Studentdbo.getCount();
        resp.setCode(200);
        resp.setCount(rows);
        resp.setMsg("请求成功");
        resp.setData(students);


////解析json数据之后存放数据的实体类  相同代码可封装
        Gson gson=new Gson();
        String json=gson.toJson(resp);
        System.out.printf(json);
        response.setContentType("application/json");
        PrintWriter out=response.getWriter();
        out.print(json);
        out.flush();
        //out.close();

    }
}
