package Control;

import Dbo.Studentdbo;
import com.google.gson.Gson;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

//Postman
@WebServlet(urlPatterns = "/stu/del")
public class student_del extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String id =req.getParameter("id");
        int rows= Studentdbo.delStudentByID(id);
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
////解析json数据之后存放数据的实体类  相同代码可封装
        Gson gson=new Gson();
        String json=gson.toJson(baseResp);
        System.out.printf(json);
        resp.setContentType("application/json");
        PrintWriter out=resp.getWriter();
        out.print(json);
        out.flush();
    }

}
