package Server;

import Control.BaseResp;
import Control.Words;
import Dbo.WordsDao;
import com.google.gson.Gson;
import com.mysql.cj.util.StringUtils;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet(urlPatterns = "/all_words")
public class WordsAllServer extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        request.setCharacterEncoding("utf-8");
        response.setCharacterEncoding("utf-8");
        String page=request.getParameter("page");
        String limit=request.getParameter("limit");

        List<Words> allWords= WordsDao.getWords(StringUtils.isNullOrEmpty(page)?1:Integer.parseInt(page),
                StringUtils.isNullOrEmpty(limit)?10:Integer.parseInt(limit));

        BaseResp<List<Words>> resp=new BaseResp<List<Words>>();
        int rows = WordsDao.getCount();
        resp.setCode(200);
        resp.setCount(rows);
        resp.setMsg("请求成功");
        resp.setData(allWords);

        Gson gson=new Gson();
        String json=gson.toJson(resp);
        System.out.printf(json);
        response.setContentType("application/json");
        PrintWriter out=response.getWriter();
        out.print(json);
        out.flush();
        out.close();
    }
}
