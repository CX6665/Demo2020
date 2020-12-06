package Control;

import Dbo.WordsDao;
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

@WebServlet(urlPatterns = "/upadateWords")
public class UpadateWords extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("utf-8");
        resp.setCharacterEncoding("utf-8");

        Gson gson=new Gson();
        String wordJson= RequestUtil.getRequestBody(req);

        // 修改时提交的数据
        Words wordsBody= gson.fromJson(wordJson, Words.class);
        // 数据本地数据
        Words words= WordsDao.getWBywords(wordsBody.getWord());
        //验证字段是否为空。。。
        if(!StringUtils.isNullOrEmpty(wordsBody.getWord())){
            words.setSzm(wordsBody.getSzm());
            words.setWord(wordsBody.getWord());
            words.setMeaning(wordsBody.getMeaning());
            words.setExample(wordsBody.getExample());
        }

        int rows=WordsDao.updataWords(words);
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
