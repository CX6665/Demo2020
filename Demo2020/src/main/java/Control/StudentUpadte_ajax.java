package Control;

import Dbo.Studentdbo;
import com.google.gson.Gson;
import com.mysql.cj.util.StringUtils;
import JDBC.RequestUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(urlPatterns = "/stu/update/plus")
public class StudentUpadte_ajax extends HttpServlet {


    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("utf-8");
        resp.setCharacterEncoding("utf-8");

        Gson gson=new Gson();
        String stuJson= RequestUtil.getRequestBody(req);

        // 修改时提交的数据
        student stuBody= gson.fromJson(stuJson, student.class);

        // 数据本地数据
        student students= Studentdbo.getStuByID(stuBody.getId());
        //验证字段是否为空。。。
        if(!StringUtils.isNullOrEmpty(stuBody.getName())){
            students.setName(stuBody.getName());
            students.setSex(stuBody.getSex());
            students.setAge(stuBody.getAge());
            students.setFoulor(stuBody.getFoulor());
            students.setId(stuBody.getId());
        }

        int rows=Studentdbo.updataStudent(students);
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
