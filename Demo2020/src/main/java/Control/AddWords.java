package Control;
import Dbo.WordsDao;
import JDBC.RequestUtil;
import com.google.gson.Gson;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(urlPatterns = "/AddWords")
public class AddWords extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("utf-8");
        resp.setCharacterEncoding("utf-8");
        Gson gson=new Gson();
        String wordJson= RequestUtil.getRequestBody(req);

        // 修改时提交的数据
        Words wordsBody= gson.fromJson(wordJson, Words.class);
        int rows= WordsDao.addWords(wordsBody);
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
